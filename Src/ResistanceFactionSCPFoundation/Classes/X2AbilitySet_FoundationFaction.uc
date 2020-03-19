class X2AbilitySet_FoundationFaction extends X2Ability config(GameData_SoldierSkills);

var config array<int> XenoMedicalIBonus; //first level of smart macrophages, organic units only
var config array<int> XenoMedicalIIBonus; //second level of smart macrophages, organic units only
var config array<int> RoboMacroPhages; //tier two XenoEngineering, for non-SPARK robotic units units

var config int VetTraining_HEALTHBONUS; 
var config int VetTraining_DEFENSEBONUS;
var config int VetTraining_DODGEBONUS;
var config int VetTraining_MOBILITYBONUS;
var config int VetTraining_AIMBONUS;

var config int OneDamnTile_MOBILITYBONUS;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;
	
	//Templates.AddItem(CreateSMAbility('XenoMedicineI'));
	//Templates.AddItem(CreateSMAbility('XenoMedicineII'));
	//Templates.AddItem(CreateSMAbility('XenoEngineeringII'));
	Templates.Additem(CreateVetTrainingAbility());
	Templates.Additem(CreateOneDamnTileAbility());
	return Templates;
}


//static function X2AbilityTemplate CreateSMAbility(name TemplateName)
//{
	//local X2AbilityTemplate             Template;
	//local X2Effect_AU_SmartMacrophages	InjuryEffect;
	//Template = PurePassive(TemplateName, "img:///UILibrary_PerkIcons.UIPerk_combatstims",,, true);
	//
//
	////`CREATE_X2ABILITY_TEMPLATE(Template, 'ExperimentalStims');
//
	////Template.AbilityCosts.AddItem(default.FreeActionCost);
////	Template.AbilityCosts.AddItem(new class'X2AbilityCost_ConsumeItem');
////
	////Template.AbilityToHitCalc = default.DeadEye;
	////Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	////Template.AbilityTargetStyle = default.SelfTarget;
	////Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);
////
	//Template.Hostility = eHostility_Defensive;
	//Template.AbilitySourceName = 'eAbilitySource_Item';
	////Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_combatstims";
	////Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_ShowIfAvailable;
	////Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.COMBAT_STIMS_PRIORITY;
	////Template.ActivationSpeech = 'CombatStim';
	//Template.bShowActivation = true;
	//Template.bSkipFireAction = true;
	////Template.CustomSelfFireAnim = 'FF_FireMedkitSelf';
//
	//Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	//Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
//
	//InjuryEffect = new class'X2Effect_AU_SmartMacrophages';
	//InjuryEffect.HPtoHeal = GetAmount(TemplateName);
	//InjuryEffect.BuildPersistentEffect(1, true, true, true);
	//Template.AddTargetEffect(InjuryEffect);
//
	//return Template;
//}

//static function int GetAmount(name TemplateName)
//{
	//
	//if(TemplateName == 'XenoMedicineI')
		//return `ScaleStrategyArrayInt(default.XenoMedicalIBonus);
//
	//if(TemplateName == 'XenoMedicineII')
		//return `ScaleStrategyArrayInt(default.XenoMedicalIIBonus);
//
	//if(TemplateName == 'XenoEngineeringII')
		//return `ScaleStrategyArrayInt(default.RoboMacrophages);
//
//
	//return 1; //fall through case
//}


static function X2AbilityTemplate CreateVetTrainingAbility()
{
    local X2AbilityTemplate                 Template;	
	local X2AbilityTrigger					Trigger;
	local X2AbilityTarget_Self				TargetStyle;
	local X2Effect_PersistentStatChange		PersistentStatChangeEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'VetTrainingAbility');

	Template= new(None, string('VetTrainingAbility')) class'X2AbilityTemplate'; Template.SetTemplateName('VetTrainingAbility');

	Template.AbilitySourceName = 'eAbilitySource_Standard';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.IconImage = "img:///UILibrary_FoundationFaction.UIPerk_SCPLogo"; //I've made my own perk Icon
	

	Template.AbilityToHitCalc = default.DeadEye; //Always gets applied to unit
	Template.AbilityTargetStyle = default.SelfTarget; 
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger); //Ability is activated at the start of every mission
//Adds Health
PersistentStatChangeEffect = new class'X2Effect_PersistentStatChange';
	PersistentStatChangeEffect.BuildPersistentEffect(1, true, false, false);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_HP, default.VetTraining_HEALTHBONUS);
	Template.AddTargetEffect(PersistentStatChangeEffect);
//Adds Aim
PersistentStatChangeEffect = new class'X2Effect_PersistentStatChange';
	PersistentStatChangeEffect.BuildPersistentEffect(1, true, false, false);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_Offense, default.VetTraining_AIMBONUS);
	Template.AddTargetEffect(PersistentStatChangeEffect);
//Adds Dodge
PersistentStatChangeEffect = new class'X2Effect_PersistentStatChange';
	PersistentStatChangeEffect.BuildPersistentEffect(1, true, false, false);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_Dodge, default.VetTraining_DODGEBONUS);
	Template.AddTargetEffect(PersistentStatChangeEffect);
//Adds Defense
PersistentStatChangeEffect = new class'X2Effect_PersistentStatChange';
	PersistentStatChangeEffect.BuildPersistentEffect(1, true, false, false);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_Defense, default.VetTraining_DEFENSEBONUS);
	Template.AddTargetEffect(PersistentStatChangeEffect);
		Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
//Adds Mobility
PersistentStatChangeEffect = new class'X2Effect_PersistentStatChange';
	PersistentStatChangeEffect.BuildPersistentEffect(1, true, false, false);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_Mobility, default.VetTraining_MOBILITYBONUS);
	Template.AddTargetEffect(PersistentStatChangeEffect);
	return Template;
}

static function X2AbilityTemplate CreateOneDamnTileAbility()
{
    local X2AbilityTemplate                 Template;	
	local X2AbilityTrigger					Trigger;
	local X2AbilityTarget_Self				TargetStyle;
	local X2Effect_PersistentStatChange		PersistentStatChangeEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'OneDamnTileAbility');

	Template= new(None, string('OneDamnTileAbility')) class'X2AbilityTemplate'; Template.SetTemplateName('OneDamnTileAbility');

	Template.AbilitySourceName = 'eAbilitySource_Standard';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.IconImage = "img:///UILibrary_FoundationFaction.UIPerk_SCPLogo"; //I've made my own perk Icon
	

	Template.AbilityToHitCalc = default.DeadEye; //Always gets applied to unit
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger); //Ability is activated at the start of every mission
//Adds 1 Mobility
PersistentStatChangeEffect = new class'X2Effect_PersistentStatChange';
	PersistentStatChangeEffect.BuildPersistentEffect(1, true, false, false);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_Mobility, default.OneDamnTile_MOBILITYBONUS);
	Template.AddTargetEffect(PersistentStatChangeEffect);
	return Template;
}