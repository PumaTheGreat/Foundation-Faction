class X2StrategyElement_AUResistanceActions extends X2StrategyElement_XpackResistanceActions config(AlliesUnknown);

var config array<DoubleAgentData>	FoundationBackupCharacterTemplates;
var config int						FoundationBackupChance;


var config array<float> XenoIntelBonus; //flat bonus for Xenointelligence
var config array<float> XenoIntelSciBonus; //bonus per scientist XCOM has

var config array<float> ToSaveMankindIBonus; //first level discount for Avenger recruits
var config array<float> ToSaveMankindIIBonus; //second level discount for Avenger recruits



var config array<float> RebateBonus; //rebate from resources used on research, projects, and items built

var config array<float> RebateIIBonus; //rebate from tier two XenoEngineering
var config array<int> SparkHealBonus; //tier two XenoEngineering, bonus to repair rate for SPARK units



//---------------------------------------------------------------------------------------
static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Cards;

	// Spectres Cards
	Cards.AddItem(CreateFoundationBackup());

	Cards.AddItem(CreateXenointelligence());

	//Cards.AddItem(CreateToSaveMankindI());
	//Cards.AddItem(CreateToSaveMankindII());

	//Cards.AddItem(CreateToSaveMankindI());
	//Cards.AddItem(CreateToSaveMankindII());

	Cards.AddItem(CreateXenoMedicineI());
	Cards.AddItem(CreateXenoMedicineII());

	Cards.AddItem(CreateXenoEngineeringI());
	Cards.AddItem(CreateXenoEngineeringII());
	Cards.AddItem(CreateSameTeam());
	Cards.AddItem(CreateVeteranTraining());
	Cards.AddItem(CreateOneDamnTile());

	return Cards;
}
//---------------------------------------------------------------------------------------
////#################################################################################################################################
////############ Veteran Training ###################################################################################################
////#################################################################################################################################

static function X2DataTemplate CreateVeteranTraining() //an event listener shall listen to this being active
{
	local X2StrategyCardTemplate Template;

	`CREATE_X2TEMPLATE(class'X2FoundationStrategyCardTemplate', Template, 'ResCard_VetTraining');
	Template.Category = "ResistanceCard";
	Template.GetAbilitiesToGrantFn = GrantVetTraining;

	return Template;
}

static function GrantVetTraining(XComGameState_Unit UnitState, out array<name> AbilitiesToGrant)
{
	if (UnitState.GetTeam() == eTeam_Resistance)
	{
		AbilitiesToGrant.AddItem( 'VetTrainingAbility' );
	}
}

//---------------------------------------------------------------------------------------
////#################################################################################################################################
////############ Quick Acquisition ##################################################################################################
////#################################################################################################################################

static function X2DataTemplate CreateOneDamnTile() //an event listener shall listen to this being active
{
	local X2StrategyCardTemplate Template;

	`CREATE_X2TEMPLATE(class'X2FoundationStrategyCardTemplate', Template, 'ResCard_OneDamnTile');
	Template.Category = "ResistanceCard";
	Template.GetAbilitiesToGrantFn = GrantQuickAcquisition;

	return Template;
}

static function GrantQuickAcquisition(XComGameState_Unit UnitState, out array<name> AbilitiesToGrant)
{
	if (UnitState.GetTeam() == eTeam_XCom)
	{
		AbilitiesToGrant.AddItem( 'OneDamnTileAbility' );
	}
}

////##################################################################################################################################
////##################################################################################################################################
////##################################################################################################################################
static function X2DataTemplate CreateSameTeam()
{
	local X2StrategyCardTemplate Template;

	`CREATE_X2TEMPLATE(class'X2FoundationStrategyCardTemplate', Template, 'ResCard_SameTeam');
	Template.Category = "ResistanceCard";


	Template.OnActivatedFn = ActivateSameTeam;
	Template.OnDeactivatedFn = DeactivateSameTeam;
	
	return Template;
}

static function ActivateSameTeam(XComGameState NewGameState, StateObjectReference InRef, optional bool bReactivate = false)
{
 
}


static function DeactivateSameTeam(XComGameState NewGameState, StateObjectReference InRef)
{
	
}


static function X2DataTemplate CreateXenoEngineeringII() //this has functions since we need to alter healing stuff
{
	local X2StrategyCardTemplate Template;

	`CREATE_X2TEMPLATE(class'X2FoundationStrategyCardTemplate', Template, 'ResCard_XenoEngineeringII');
	Template.Category = "ResistanceCard";
	//Template.OnActivatedFn = ActivateXenoEngineeringII;
	//Template.OnDeactivatedFn = DeactivateXenoEngineeringII;
	//Template.GetMutatorValueFn = GetValueTXenoEngineeringII;
	//we add the above through X2PostTemplatesCreated so we don't crash the game for people who don't have SPARKs
	Template.GetAbilitiesToGrantFn = GrantXenoEngineeringII;
	return Template;
}



//---------------------------------------------------------------------------------------
static function GrantXenoEngineeringII(XComGameState_Unit UnitState, out array<name> AbilitiesToGrant)
{
	if (UnitState.GetTeam() == eTeam_XCom && UnitState.IsRobotic() && UnitState.GetMyTemplateName() != 'SparkSoldier') //sparks get an alternative method of healing
	{
		AbilitiesToGrant.AddItem( 'XenoEngineeringII' );
	}
}


//---------------------------------------------------------------------------------------
static function X2DataTemplate CreateXenoEngineeringI() //an event listener shall listen to this being active since it's a rebate only
{
	local X2StrategyCardTemplate Template;

	`CREATE_X2TEMPLATE(class'X2FoundationStrategyCardTemplate', Template, 'ResCard_XenoEngineeringI');
	Template.Category = "ResistanceCard";

	return Template;
}


//---------------------------------------------------------------------------------------
static function X2DataTemplate CreateXenoMedicineII() //an event listener shall listen to this being active
{
	local X2StrategyCardTemplate Template;

	`CREATE_X2TEMPLATE(class'X2FoundationStrategyCardTemplate', Template, 'ResCard_XenoMedicineII');
	Template.Category = "ResistanceCard";
	Template.GetAbilitiesToGrantFn = GrantXenoMedicineII;

	return Template;
}
//---------------------------------------------------------------------------------------
static function GrantXenoMedicineII(XComGameState_Unit UnitState, out array<name> AbilitiesToGrant)
{
	if (UnitState.GetTeam() == eTeam_XCom && !UnitState.IsRobotic())
	{
		AbilitiesToGrant.AddItem( 'XenoMedicineII' );
	}
}

//---------------------------------------------------------------------------------------




//---------------------------------------------------------------------------------------
static function X2DataTemplate CreateXenoMedicineI() //an event listener shall listen to this being active
{
	local X2StrategyCardTemplate Template;

	`CREATE_X2TEMPLATE(class'X2FoundationStrategyCardTemplate', Template, 'ResCard_XenoMedicineI');
	Template.Category = "ResistanceCard";
	Template.GetAbilitiesToGrantFn = GrantXenoMedicineI;

	return Template;
}
//---------------------------------------------------------------------------------------
static function GrantXenoMedicineI(XComGameState_Unit UnitState, out array<name> AbilitiesToGrant)
{
	if (UnitState.GetTeam() == eTeam_XCom && !UnitState.IsRobotic())
	{
		AbilitiesToGrant.AddItem( 'XenoMedicineI' );
	}
}

//---------------------------------------------------------------------------------------




//---------------------------------------------------------------------------------------
//static function X2DataTemplate CreateToSaveMankindII() //an event listener shall listen to this being active
//{
	//local X2StrategyCardTemplate Template;
//
	//`CREATE_X2TEMPLATE(class'X2FoundationStrategyCardTemplate', Template, 'ResCard_ToSaveMankindII');
	//Template.Category = "ResistanceCard";
	//Template.OnActivatedFn = ActivateToSaveMankindII;
	//Template.OnDeactivatedFn = DeactivateToSaveMankindII;
	////Template.GetMutatorValueFn = GetValueToSaveMankindII;
	//return Template;
//}
//---------------------------------------------------------------------------------------
//static function ActivateToSaveMankindII(XComGameState NewGameState, StateObjectReference InRef, optional bool bReactivate = false)
//{
	//local XComGameState_ExtraspeciesRecruits GreyMarket;
//
	//GreyMarket = GetNewGreyMarketState(NewGameState);
//
	//if(GreyMarket.GetAvengerRecruitScalar() < 0) //safety check: should never go below 0
	//{
		//GreyMarket.AvengerRecruitScalar = 0;
	//}
//
	//GreyMarket.AvengerRecruitScalar += GetValueToSaveMankindII();
//
//}
//---------------------------------------------------------------------------------------
//static function DeactivateToSaveMankindII(XComGameState NewGameState, StateObjectReference InRef)
//{
	//local XComGameState_ExtraspeciesRecruits GreyMarket;
//
	//GreyMarket = GetNewGreyMarketState(NewGameState);
//
	//GreyMarket.AvengerRecruitScalar -= GetValueToSaveMankindII();
//
	//if(GreyMarket.GetAvengerRecruitScalar() < 0) //safety check: should never go below 0
	//{
		//GreyMarket.AvengerRecruitScalar = 0;
	//}
//}
//---------------------------------------------------------------------------------------
//static function float GetValueToSaveMankindII()
//{
	//return `ScaleStrategyArrayFloat(default.ToSaveMankindIIBonus);
//}
//---------------------------------------------------------------------------------------

//---------------------------------------------------------------------------------------
//static function X2DataTemplate CreateToSaveMankindI() //an event listener shall listen to this being active
//{
	//local X2StrategyCardTemplate Template;
//
	//`CREATE_X2TEMPLATE(class'X2FoundationStrategyCardTemplate', Template, 'ResCard_ToSaveMankindI');
	//Template.Category = "ResistanceCard";
	////Template.OnActivatedFn = ActivateToSaveMankindI;
	////Template.OnDeactivatedFn = DeactivateToSaveMankindI;
	////Template.GetMutatorValueFn = GetValueToSaveMankindI;
	//return Template;
//}
//---------------------------------------------------------------------------------------
//static function ActivateToSaveMankindI(XComGameState NewGameState, StateObjectReference InRef, optional bool bReactivate = false)
//{
	//local XComGameState_ExtraspeciesRecruits GreyMarket;
//
	//GreyMarket = GetNewGreyMarketState(NewGameState);
//
	//if(GreyMarket.GetAvengerRecruitScalar() < 0) //safety check: should never go below 0
	//{
		//GreyMarket.AvengerRecruitScalar = 0;
	//}
//
	//GreyMarket.AvengerRecruitScalar += GetValueToSaveMankindI();
//
//}
//---------------------------------------------------------------------------------------
//static function DeactivateToSaveMankindI(XComGameState NewGameState, StateObjectReference InRef)
//{
	//local XComGameState_ExtraspeciesRecruits GreyMarket;
//
	//GreyMarket = GetNewGreyMarketState(NewGameState);
	//GreyMarket.AvengerRecruitScalar -= GetValueToSaveMankindI();
	//if(GreyMarket.GetAvengerRecruitScalar() < 0) //safety check: should never go below 0
	//{
		//GreyMarket.AvengerRecruitScalar = 0;
	//}
//}
////---------------------------------------------------------------------------------------
static function float GetValueToSaveMankindI()
{
	return `ScaleStrategyArrayFloat(default.ToSaveMankindIBonus);
}
//---------------------------------------------------------------------------------------
static function X2DataTemplate CreateXenointelligence() //an event listener shall listen to this being active
{
	local X2StrategyCardTemplate Template;

	`CREATE_X2TEMPLATE(class'X2FoundationStrategyCardTemplate', Template, 'ResCard_XenoIntelligence');
	Template.Category = "ResistanceCard";

	return Template;
}

//---------------------------------------------------------------------------------------
static function X2DataTemplate CreateFoundationBackup()
{
	local X2StrategyCardTemplate Template;

	`CREATE_X2TEMPLATE(class'X2FoundationStrategyCardTemplate', Template, 'ResCard_Secure');
	Template.Category = "ResistanceCard";
	Template.ModifyTacticalStartStateFn = FoundationBackupTacticalStartModifier;
	Template.GetAbilitiesToGrantFn = GrantFoundationBackupEvac;

	return Template;
}
//---------------------------------------------------------------------------------------
static function FoundationBackupTacticalStartModifier(XComGameState StartState)
{
	local XComGameState_BattleData BattleData;
	local XComGameState_HeadquartersXCom XComHQ;
	local DoubleAgentData DoubleAgent;
	local int CurrentForceLevel, Rand;
	local array<name> PossibleTemplates;
	local X2CharacterTemplateManager CharTemplateMgr;
	local X2CharacterTemplate CharacterTemplate;

	if (IsSplitMission( StartState ))
		return;

	if (default.FoundationBackupChance < `SYNC_RAND_STATIC(100))
		return;

	foreach StartState.IterateByClassType( class'XComGameState_HeadquartersXCom', XComHQ )
		break;
	`assert( XComHQ != none );

	if (XComHQ.TacticalGameplayTags.Find( 'NoDoubleAgent' ) != INDEX_NONE)
		return;

	foreach StartState.IterateByClassType( class'XComGameState_BattleData', BattleData )
	{
		break;
	}
	`assert( BattleData != none );

	CurrentForceLevel = BattleData.GetForceLevel( );
	foreach default.FoundationBackupCharacterTemplates( DoubleAgent )
	{
		if ((CurrentForceLevel < DoubleAgent.MinForceLevel) ||
			(CurrentForceLevel > DoubleAgent.MaxForceLevel))
		{
			continue;
		}
		CharTemplateMgr = class'X2CharacterTemplateManager'.static.GetCharacterTemplateManager();
		CharacterTemplate = CharTemplateMgr.FindCharacterTemplate(DoubleAgent.TemplateName);
		if(CharacterTemplate != none)
		{
			PossibleTemplates.AddItem( DoubleAgent.TemplateName );
		}
	}


	if (PossibleTemplates.Length > 0)
	{
		Rand = `SYNC_RAND_STATIC( PossibleTemplates.Length );
		XComTeamSoldierSpawnTacticalStartModifier( PossibleTemplates[ Rand ], StartState );
	}
	else
	{
		`redscreen("Alien Defector Policy unable to find any potential templates for Force Level " @ CurrentForceLevel );
	}
}
//---------------------------------------------------------------------------------------
static function GrantFoundationBackupEvac(XComGameState_Unit UnitState, out array<name> AbilitiesToGrant)
{
	if ((UnitState.GetTeam() == eTeam_XCom) && !UnitState.IsSoldier() && !UnitState.GetMyTemplate().bNeverSelectable)
	{
		AbilitiesToGrant.AddItem( 'Evac' );
		AbilitiesToGrant.AddItem('PlaceEvacZone');
		AbilitiesToGrant.AddItem('LiftOffAvenger');

		AbilitiesToGrant.AddItem('Loot');
		AbilitiesToGrant.AddItem('CarryUnit');
		AbilitiesToGrant.AddItem('PutDownUnit');

		AbilitiesToGrant.AddItem('Interact_PlantBomb');
		AbilitiesToGrant.AddItem('Interact_TakeVial');
		AbilitiesToGrant.AddItem('Interact_StasisTube');
		AbilitiesToGrant.AddItem('Interact_MarkSupplyCrate');
		AbilitiesToGrant.AddItem('Interact_ActivateAscensionGate');

		AbilitiesToGrant.AddItem('DisableConsumeAllPoints');

		AbilitiesToGrant.AddItem('Revive');
		AbilitiesToGrant.AddItem('Panicked');
		AbilitiesToGrant.AddItem('Berserk');
		AbilitiesToGrant.AddItem('Obsessed');
		AbilitiesToGrant.AddItem('Shattered');
	}
}


//---------------------------------------------------------------------------------------
//static function XComGameState_ExtraspeciesRecruits GetNewGreyMarketState(XComGameState NewGameState)
//{
	//local XComGameState_ExtraspeciesRecruits NewGreyMarket;
//
	//foreach NewGameState.IterateByClassType(class'XComGameState_ExtraspeciesRecruits', NewGreyMarket)
	//{
		//break;
	//}
//
	//if(NewGreyMarket == none)
	//{
		//NewGreyMarket = XComGameState_ExtraspeciesRecruits(`XCOMHistory.GetSingleGameStateObjectForClass(class'XComGameState_ExtraspeciesRecruits'));
		//NewGreyMarket = XComGameState_ExtraspeciesRecruits(NewGameState.ModifyStateObject(class'XComGameState_ExtraspeciesRecruits', NewGreyMarket.ObjectID));
	//}
//
	//return NewGreyMarket;
//}