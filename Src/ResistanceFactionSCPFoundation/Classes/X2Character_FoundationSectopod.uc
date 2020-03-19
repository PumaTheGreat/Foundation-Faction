 class X2Character_FoundationSectopod extends X2Character_DefaultCharacters config(GameData_CharacterStats);

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;


	Templates.AddItem(CreateTemplate_FoundationSectopod());

	return Templates;
}

static function X2CharacterTemplate CreateTemplate_FoundationSectopod()
{
	local X2CharacterTemplate CharTemplate;
	local LootReference Loot;

	`CREATE_X2CHARACTER_TEMPLATE(CharTemplate, 'FoundationSectopod');
	CharTemplate.CharacterGroupName = 'Sectopod';
	CharTemplate.DefaultLoadout='FoundationSectopod_Loadout';
	CharTemplate.BehaviorClass=class'XGAIBehavior';
	CharTemplate.strPawnArchetypes.AddItem("FoundationSectopod.ARC_GameUnit_FoundationSectopod");
	Loot.ForceLevel=0;
	Loot.LootTableName='FoundationSectopod_BaseLoot';
	CharTemplate.Loot.LootReferences.AddItem(Loot);

	// Timed Loot
	Loot.ForceLevel = 0;
	Loot.LootTableName = 'Sectopod_TimedLoot';
	CharTemplate.TimedLoot.LootReferences.AddItem(Loot);
	Loot.LootTableName = 'Sectopod_VultureLoot';
	CharTemplate.VultureLoot.LootReferences.AddItem(Loot);

	CharTemplate.strMatineePackages.AddItem("CIN_Sectopod");
	CharTemplate.strTargetingMatineePrefix = "CIN_Sectopod_FF_StartPos";

	CharTemplate.UnitSize = 2;
	CharTemplate.UnitHeight = 4;

	CharTemplate.KillContribution = 2.0;

	// Traversal Rules
	CharTemplate.bCanUse_eTraversal_Normal = true;
	CharTemplate.bCanUse_eTraversal_ClimbOver = false;
	CharTemplate.bCanUse_eTraversal_ClimbOnto = true;
	CharTemplate.bCanUse_eTraversal_ClimbLadder = false;
	CharTemplate.bCanUse_eTraversal_DropDown = true;
	CharTemplate.bCanUse_eTraversal_Grapple = false;
	CharTemplate.bCanUse_eTraversal_Landing = true;
	CharTemplate.bCanUse_eTraversal_BreakWindow = false;
	CharTemplate.bCanUse_eTraversal_KickDoor = false;
	CharTemplate.bCanUse_eTraversal_JumpUp = false;
	CharTemplate.bCanUse_eTraversal_WallClimb = false;
	CharTemplate.bCanUse_eTraversal_BreakWall = false;
	CharTemplate.bAppearanceDefinesPawn = false;    
	CharTemplate.bCanTakeCover = false;
	CharTemplate.bSkipDefaultAbilities = true;

	CharTemplate.bIsAlien = False;
	CharTemplate.bIsAdvent = false;
	CharTemplate.bIsCivilian = false;
	CharTemplate.bIsPsionic = false;
	CharTemplate.bIsRobotic = true;
	CharTemplate.bIsSoldier = false;
	CharTemplate.bAllowRushCam = false;

	CharTemplate.bCanBeTerrorist = false;
	CharTemplate.bCanBeCriticallyWounded = false;
	CharTemplate.bIsAfraidOfFire = false;
	//CharTemplate.AcquiredPhobiaTemplate = 'FearOfMecs';

	CharTemplate.bAllowSpawnFromATT = false;

	//CharTemplate.AddTemplateAvailablility(CharTemplate.BITFIELD_GAMEAREA_Multiplayer); // Allow in MP!
	//CharTemplate.MPPointValue = CharTemplate.XpKillscore * 10;

	CharTemplate.strScamperBT = "ScamperRoot_NoCover";

	//CharTemplate.SightedNarrativeMoments.AddItem(XComNarrativeMoment'X2NarrativeMoments.TACTICAL.AlienSitings.T_Shen_AlienSightings_Sectopod');

	CharTemplate.ImmuneTypes.AddItem('Fire');
	CharTemplate.ImmuneTypes.AddItem('Poison');

	CharTemplate.Abilities.AddItem('StandardMove');
	CharTemplate.Abilities.AddItem('SectopodHigh');
	CharTemplate.Abilities.AddItem('SectopodLow');
	//CharTemplate.Abilities.AddItem('SectopodLightningField');
	CharTemplate.Abilities.AddItem('ProxyTakeOverLightningField');
	CharTemplate.Abilities.AddItem('SectopodEnergyShieldMk3');
	CharTemplate.Abilities.AddItem('DeathExplosion');
	CharTemplate.Abilities.AddItem('SectopodInitialState');
	CharTemplate.Abilities.AddItem('SectopodNewTeamState');
	
	
	//CharTemplate.Abilities.AddItem('ObeyTheSCP');

	CharTemplate.strHackIconImage = "UILibrary_Common.TargetIcons.Hack_robot_icon";
	CharTemplate.strTargetIconImage = "PTGTargetIconFO.target_SCPLOGO";

	//CharTemplate.Abilities.AddItem('DarkEventAbility_Barrier');

	return CharTemplate;
}