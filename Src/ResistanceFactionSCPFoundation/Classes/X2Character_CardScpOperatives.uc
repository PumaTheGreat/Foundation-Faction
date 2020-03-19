class X2Character_CardSCPOperatives extends X2Character_DefaultCharacters config(GameData_CharacterStats);

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;


	Templates.AddItem(CreateTemplate_MTFXComRookie('MTFXComRookie_M1'));
	Templates.AddItem(CreateTemplate_MTFXComMachineGunner('MTFXComMachineGunner_M1'));

	Templates.AddItem(CreateTemplate_MTFXComRookie('MTFXComRookie_M2'));
	Templates.AddItem(CreateTemplate_MTFXComMachineGunner('MTFXComMachineGunner_M2'));
	
	Templates.AddItem(CreateTemplate_MTFXComRookie('MTFXComRookie_M3'));
	Templates.AddItem(CreateTemplate_MTFXComMachineGunner('MTFXComMachineGunner_M3'));

	return Templates;
}


static function X2CharacterTemplate CreateTemplate_MTFXComRookie(name templatename)
{
	local X2CharacterTemplate CharTemplate;
	local LootReference Loot;

	CharTemplate= new(None, string(templatename)) class'X2CharacterTemplate'; CharTemplate.SetTemplateName(templatename);;

	// Auto-Loot
	Loot.ForceLevel = 0;
	Loot.LootTableName = 'MTF_BaseLoot';
	CharTemplate.Loot.LootReferences.AddItem(Loot);

	// Timed Loot
	Loot.ForceLevel = 0;
	Loot.LootTableName = 'AdvTrooperM1_TimedLoot';
	CharTemplate.TimedLoot.LootReferences.AddItem(Loot);
	Loot.LootTableName = 'AdvTrooperM1_VultureLoot';
	CharTemplate.VultureLoot.LootReferences.AddItem(Loot);


	CharTemplate.UnitSize = 1;
	CharTemplate.CharacterGroupName = 'Raider_MTFXCom';
	CharTemplate.BehaviorClass = class'XGAIBehavior';
	CharTemplate.strBehaviorTree = "MTFXComRookieRoot";
	CharTemplate.bCanUse_eTraversal_Normal = true;
	CharTemplate.bCanUse_eTraversal_ClimbOver = true;
	CharTemplate.bCanUse_eTraversal_ClimbOnto = true;
	CharTemplate.bCanUse_eTraversal_ClimbLadder = true;
	CharTemplate.bCanUse_eTraversal_DropDown = true;
	CharTemplate.bCanUse_eTraversal_Grapple = false;
	CharTemplate.bCanUse_eTraversal_Landing = true;
	CharTemplate.bCanUse_eTraversal_BreakWindow = true;
	CharTemplate.bCanUse_eTraversal_KickDoor = true;
	CharTemplate.bCanUse_eTraversal_JumpUp = false;
	CharTemplate.bCanUse_eTraversal_WallClimb = false;
	CharTemplate.bCanUse_eTraversal_BreakWall = false;
	CharTemplate.bCanBeCriticallyWounded = false;
	CharTemplate.bCanBeTerrorist = false;
	CharTemplate.bDiesWhenCaptured = true;
	CharTemplate.bAppearanceDefinesPawn = true;
	CharTemplate.bIsAfraidOfFire = true;
	CharTemplate.bIsAlien = false;
	CharTemplate.bIsAdvent = false;
	CharTemplate.bIsCivilian = false;
	CharTemplate.bIsPsionic = false;
	CharTemplate.bIsRobotic = false;
	CharTemplate.bIsSoldier = false;
	CharTemplate.bCanTakeCover = true;
	CharTemplate.bCanBeCarried = false;
	CharTemplate.bCanBeRevived = true;
	//CharTemplate.AcquiredPhobiaTemplate = 'FearOfMOCX';

	//CharTemplate.bUsePoolSoldiers = true;
	//CharTemplate.bUsePoolDarkVIPs = true; //these two variables let us use character pool chars

	CharTemplate.bIsTooBigForArmory = false;
	CharTemplate.bStaffingAllowed = false;
	CharTemplate.bAppearInBase = false; // Do not appear as filler crew or in any regular staff slots throughout the base
	CharTemplate.bWearArmorInBase = false;
	
	CharTemplate.bAllowRushCam = true;
	CharTemplate.strMatineePackages.AddItem("CIN_Soldier");
	//CharTemplate.strIntroMatineeSlotPrefix = "Char";
	//CharTemplate.strLoadingMatineeSlotPrefix = "Soldier";
	CharTemplate.strMatineePackages.AddItem("CIN_Advent");
	CharTemplate.RevealMatineePrefix = "CIN_Advent_Trooper";
	CharTemplate.GetRevealMatineePrefixFn = GetAdventMatineePrefix;
	
	//CharTemplate.DefaultSoldierClass = 'Rookie';
	CharTemplate.DefaultLoadout = 'MTFRookie_M1';

	if(templatename == 'MTFXComRookie_M2')
	{
		CharTemplate.DefaultLoadout = 'MTFRookie_M2';
		CharTemplate.Abilities.Additem('ReturnFire');
	}
	
	if(templatename == 'MTFXComRookie_M3')
	{
		CharTemplate.DefaultLoadout = 'MTFRookie_M3';	
	}
    //CharTemplate.RequiredLoadout = 'RequiredSoldier';
	CharTemplate.BehaviorClass=class'XGAIBehavior';

	CharTemplate.Abilities.AddItem('CarryUnit');
	CharTemplate.Abilities.AddItem('PutDownUnit');
	//CharTemplate.Abilities.AddItem('Evac');
	CharTemplate.Abilities.AddItem('Knockout');
	CharTemplate.Abilities.AddItem('KnockoutSelf');
	CharTemplate.Abilities.AddItem('HunkerDown');

	CharTemplate.strTargetIconImage = "PTGTargetIconFO.target_SCPLOGO";

	//CharTemplate.CustomizationManagerClass = class'XComCharacterCustomization_Hybrid';
	//CharTemplate.UICustomizationMenuClass = class'UICustomize_HybridMenu';
	//CharTemplate.UICustomizationInfoClass = class'UICustomize_HybridInfo';
	//CharTemplate.UICustomizationPropsClass = class'UICustomize_HybridProps';
	CharTemplate.CharacterGeneratorClass = class'XGCharacterGenerator_SCPOperative';
	
	CharTemplate.PhotoboothPersonality = 'Personality_Normal';

	//CharTemplate.OnEndTacticalPlayFn = SparkEndTacticalPlay;
	//CharTemplate.GetPhotographerPawnNameFn = GetSparkPawnName;

	return CharTemplate;
}

static function X2CharacterTemplate CreateTemplate_MTFXComMachineGunner(name templatename)
{
	local X2CharacterTemplate CharTemplate;
	local LootReference Loot;

	CharTemplate= new(None, string(templatename)) class'X2CharacterTemplate'; CharTemplate.SetTemplateName(templatename);;

	// Auto-Loot
	Loot.ForceLevel = 0;
	Loot.LootTableName = 'MTF_BaseLoot';
	CharTemplate.Loot.LootReferences.AddItem(Loot);

	// Timed Loot
	Loot.ForceLevel = 0;
	Loot.LootTableName = 'AdvTrooperM1_TimedLoot';
	CharTemplate.TimedLoot.LootReferences.AddItem(Loot);
	Loot.LootTableName = 'AdvTrooperM1_VultureLoot';
	CharTemplate.VultureLoot.LootReferences.AddItem(Loot);


	CharTemplate.UnitSize = 1;
	CharTemplate.CharacterGroupName = 'Raider_MTFXCom';
	CharTemplate.BehaviorClass = class'XGAIBehavior';
	CharTemplate.strBehaviorTree = "MTFXComMachineGunnerRoot";
	CharTemplate.bCanUse_eTraversal_Normal = true;
	CharTemplate.bCanUse_eTraversal_ClimbOver = true;
	CharTemplate.bCanUse_eTraversal_ClimbOnto = true;
	CharTemplate.bCanUse_eTraversal_ClimbLadder = true;
	CharTemplate.bCanUse_eTraversal_DropDown = true;
	CharTemplate.bCanUse_eTraversal_Grapple = false;
	CharTemplate.bCanUse_eTraversal_Landing = true;
	CharTemplate.bCanUse_eTraversal_BreakWindow = true;
	CharTemplate.bCanUse_eTraversal_KickDoor = true;
	CharTemplate.bCanUse_eTraversal_JumpUp = false;
	CharTemplate.bCanUse_eTraversal_WallClimb = false;
	CharTemplate.bCanUse_eTraversal_BreakWall = false;
	CharTemplate.bCanBeCriticallyWounded = false;
	CharTemplate.bCanBeTerrorist = false;
	CharTemplate.bDiesWhenCaptured = true;
	CharTemplate.bAppearanceDefinesPawn = true;
	CharTemplate.bIsAfraidOfFire = true;
	CharTemplate.bIsAlien = false;
	CharTemplate.bIsAdvent = false;
	CharTemplate.bIsCivilian = false;
	CharTemplate.bIsPsionic = false;
	CharTemplate.bIsRobotic = false;
	CharTemplate.bIsSoldier = false;
	CharTemplate.bCanTakeCover = true;
	CharTemplate.bCanBeCarried = false;
	CharTemplate.bCanBeRevived = true;
	//CharTemplate.AcquiredPhobiaTemplate = 'FearOfMOCX';

	//CharTemplate.bUsePoolSoldiers = true;
	//CharTemplate.bUsePoolDarkVIPs = true; //these two variables let us use character pool chars

	CharTemplate.bIsTooBigForArmory = false;
	CharTemplate.bStaffingAllowed = false;
	CharTemplate.bAppearInBase = false; // Do not appear as filler crew or in any regular staff slots throughout the base
	CharTemplate.bWearArmorInBase = false;
	
	CharTemplate.bAllowRushCam = true;
	CharTemplate.strMatineePackages.AddItem("CIN_Soldier");
	//CharTemplate.strIntroMatineeSlotPrefix = "Char";
	//CharTemplate.strLoadingMatineeSlotPrefix = "Soldier";
	CharTemplate.strMatineePackages.AddItem("CIN_Advent");
	CharTemplate.RevealMatineePrefix = "CIN_Advent_Trooper";
	CharTemplate.GetRevealMatineePrefixFn = GetAdventMatineePrefix;
	
	//CharTemplate.DefaultSoldierClass = 'Rookie';
	CharTemplate.DefaultLoadout = 'MTFMachineGunner_M1';

	if(templatename == 'MTFXComMachineGunner_M2')
	{
		CharTemplate.DefaultLoadout = 'MTFMachineGunner_M2';
		CharTemplate.Abilities.AddItem('Shredder');
		CharTemplate.Abilities.AddItem('BlastPadding');
	}

	if(templatename == 'MTFXComMachineGunner_M3')
	{
		CharTemplate.DefaultLoadout = 'MTFXComMachineGunner_M3';
	}

	//CharTemplate.RequiredLoadout = 'RequiredSoldier';
	CharTemplate.BehaviorClass=class'XGAIBehavior';

	CharTemplate.Abilities.AddItem('CarryUnit');
	CharTemplate.Abilities.AddItem('PutDownUnit');
	//CharTemplate.Abilities.AddItem('Evac');
	CharTemplate.Abilities.AddItem('Knockout');
	CharTemplate.Abilities.AddItem('KnockoutSelf');
	CharTemplate.Abilities.AddItem('HunkerDown');

	CharTemplate.strTargetIconImage = "PTGTargetIconFO.target_SCPLOGO";

	//CharTemplate.CustomizationManagerClass = class'XComCharacterCustomization_Hybrid';
	//CharTemplate.UICustomizationMenuClass = class'UICustomize_HybridMenu';
	//CharTemplate.UICustomizationInfoClass = class'UICustomize_HybridInfo';
	//CharTemplate.UICustomizationPropsClass = class'UICustomize_HybridProps';
	CharTemplate.CharacterGeneratorClass = class'XGCharacterGenerator_SCPOperative';
	
	CharTemplate.PhotoboothPersonality = 'Personality_Normal';

	//CharTemplate.OnEndTacticalPlayFn = SparkEndTacticalPlay;
	//CharTemplate.GetPhotographerPawnNameFn = GetSparkPawnName;

	return CharTemplate;
}

