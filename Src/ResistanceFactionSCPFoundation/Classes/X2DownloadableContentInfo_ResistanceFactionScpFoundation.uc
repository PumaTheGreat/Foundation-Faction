//---------------------------------------------------------------------------------------
//  FILE:   XComDownloadableContentInfo_ResistanceFactionScpFoundation.uc                                    
//           
//	Use the X2DownloadableContentInfo class to specify unique mod behavior when the 
//  player creates a new campaign or loads a saved game.
//  
//---------------------------------------------------------------------------------------
//  Copyright (c) 2016 Firaxis Games, Inc. All rights reserved.
//---------------------------------------------------------------------------------------

class X2DownloadableContentInfo_ResistanceFactionScpFoundation extends X2DownloadableContentInfo config(Extraspecies);

var config array<name> SpeciesNames;

var config bool FreeRecruit;

/// <summary>
/// This method is run if the player loads a saved game that was created prior to this DLC / Mod being installed, and allows the 
/// DLC / Mod to perform custom processing in response. This will only be called once the first time a player loads a save that was
/// create without the content installed. Subsequent saves will record that the content was installed.
/// </summary>
static event OnLoadedSavedGame()
{
	//InitializeManager();
	//AddTracker();
	InitFaction();
}

/// <summary>
/// This method is run when the player loads a saved game directly into Strategy while this DLC is installed
/// </summary>
static event OnLoadedSavedGameToStrategy()
{

	//InitializeManager(); // Make sure manager classes are initialized
	//AddTracker();
	InitFaction();
}

static function InitFaction()
{
	local XComGameStateHistory History;
	local XComGameState NewGameState;
	local X2SCPResistanceFactionTemplate FactionTemplate;
	local X2StrategyElementTemplateManager StratMgr;
	local X2StrategyElementTemplate DataTemplate;
	local XComGameState_ResistanceFaction FactionState;
	local array<StateObjectReference> AllHavens;
	local XComGameState_Haven HavenState;
	local XComGameState_HeadquartersResistance ResHQ;

	History = class'XComGameStateHistory'.static.GetGameStateHistory();
	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Adding Allies Unknown State Objects");
	ResHQ = XComGameState_HeadquartersResistance(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersResistance'));
	StratMgr = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();


	if(ResHQ.GetFactionByTemplateName('Faction_Foundation') == none) //no faction, add it ourselves
	{
		ResHQ = XComGameState_HeadquartersResistance(NewGameState.ModifyStateObject(class'XComGameState_HeadquartersResistance', ResHQ.ObjectID)); 
		DataTemplate = StratMgr.FindStrategyElementTemplate('Faction_Foundation');
		if(DataTemplate != none)
		{
			FactionTemplate = X2SCPResistanceFactionTemplate(DataTemplate);
			FactionState = FactionTemplate.CreateInstanceFromTemplate(NewGameState);
			ResHQ.Factions.AddItem(FactionState.GetReference());

			FactionState.FactionName = FactionTemplate.GenerateFactionName();
			FactionState.FactionIconData = FactionTemplate.GenerateFactionIcon();

		}


		foreach History.IterateByClassType(class'XComGameState_Haven', HavenState)
		{
			if(!HavenState.IsFactionHQ())
				AllHavens.AddItem(HavenState.GetReference());
		}

		HavenState = XComGameState_Haven(NewGameState.ModifyStateObject(class'XComGameState_Haven', AllHavens[`SYNC_RAND_STATIC(AllHavens.Length)].ObjectID));

		FactionState.HomeRegion = HavenState.Region;
		FactionState.Region = FactionState.HomeRegion;
		FactionState.Continent = FactionState.GetWorldRegion().Continent;
		HavenState.FactionRef = FactionState.GetReference();
		HavenState.SetScanHoursRemaining(`ScaleStrategyArrayInt(HavenState.MinScanDays), `ScaleStrategyArrayInt(HavenState.MaxScanDays));
		HavenState.MakeScanRepeatable();
	
		FactionState.FactionHQ = HavenState.GetReference();

		class'XComGameState_FoundationStrategyCard'.static.SetUpStrategyCards(NewGameState);
		FactionState.CreateGoldenPathActions(NewGameState);
	}

	if(NewGameState.GetNumGameStateObjects() > 0)
	{
		`XCOMGAME.GameRuleset.SubmitGameState(NewGameState);
	}
	else
	{
		History.CleanupPendingGameState(NewGameState);
	}

}

/// <summary>
/// Called when the player starts a new campaign while this DLC / Mod is installed
/// </summary>
static event InstallNewCampaign(XComGameState StartState)
{
	//local XComGameState_ExtraspeciesRecruits RecruitMgr;
	local XComGameState_HeadquartersResistance ResHQ;
	local XComGameStateHistory History;
	//local RM_XComGameState_AUTriggerObj AchievementObject;
	local XComGameState_HeadquartersXCom XComHQ;
	local X2SCPResistanceFactionTemplate FactionTemplate;
	local X2StrategyElementTemplateManager StratMgr;
	local X2StrategyElementTemplate DataTemplate;
	local XComGameState_ResistanceFaction FactionState;
	local array<StateObjectReference> AllHavens;
	local XComGameState_Haven HavenState;


	XComHQ = XComGameState_HeadquartersXCom(class'XComGameStateHistory'.static.GetGameStateHistory().GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));

	StratMgr = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();
	History = class'XComGameStateHistory'.static.GetGameStateHistory();
	//RecruitMgr = XComGameState_ExtraspeciesRecruits(StartState.CreateStateObject(class'XComGameState_ExtraspeciesRecruits'));
	//StartState.AddStateObject(RecruitMgr);

	//AchievementObject = RM_XComGameState_AUTriggerObj(StartState.CreateStateObject(class'RM_XComGameState_AUTriggerObj'));
	//StartState.AddStateObject(AchievementObject);
	//AddAchievementTriggers(AchievementObject);

	ResHQ = XComGameState_HeadquartersResistance(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersResistance'));


	//if(RecruitMgr.CanRecruit())
	//{
//
		//if(ResHQ.NumMonths == 0 && RecruitMgr.ExtraspeciesRecruits.Length == 0 && !RecruitMgr.AlreadyRun)
		//{
			//RecruitMgr.CreateRecruits(StartState);
			//RecruitMgr.CleanupResistanceGoods(StartState);
			//RecruitMgr.SetUpResistanceGoods(StartState);
			//RecruitMgr.CleanUpIntelItems(StartState);
			//RecruitMgr.SetUpIntelItems(StartState);
		//
			//RecruitMgr.AlreadyRun = true;
		//}
//
//
	//}
	if(ResHQ.GetFactionByTemplateName('Faction_Foundation') == none) //no faction, add it ourselves
	{
		ResHQ = XComGameState_HeadquartersResistance(StartState.ModifyStateObject(class'XComGameState_HeadquartersResistance', ResHQ.ObjectID)); 
		DataTemplate = StratMgr.FindStrategyElementTemplate('Faction_Foundation');
		if(DataTemplate != none)
		{
			FactionTemplate = X2SCPResistanceFactionTemplate(DataTemplate);
			FactionState = FactionTemplate.CreateInstanceFromTemplate(StartState);
			ResHQ.Factions.AddItem(FactionState.GetReference());

			FactionState.FactionName = FactionTemplate.GenerateFactionName();
			FactionState.FactionIconData = FactionTemplate.GenerateFactionIcon();

		}


		foreach History.IterateByClassType(class'XComGameState_Haven', HavenState)
		{
			if(!HavenState.IsFactionHQ())
				AllHavens.AddItem(HavenState.GetReference());
		}

		HavenState = XComGameState_Haven(StartState.ModifyStateObject(class'XComGameState_Haven', AllHavens[`SYNC_RAND_STATIC(AllHavens.Length)].ObjectID));

		FactionState.HomeRegion = HavenState.Region;
		FactionState.Region = FactionState.HomeRegion;
		FactionState.Continent = FactionState.GetWorldRegion().Continent;
		HavenState.FactionRef = FactionState.GetReference();
		HavenState.SetScanHoursRemaining(`ScaleStrategyArrayInt(HavenState.MinScanDays), `ScaleStrategyArrayInt(HavenState.MaxScanDays));
		HavenState.MakeScanRepeatable();
	
		FactionState.FactionHQ = HavenState.GetReference();

		//class'XComGameState_FoundationStrategyCard'.static.SetUpStrategyCards(StartState);
	}
	//if(default.FreeRecruit && RecruitMgr.CanRecruit())
	//{
	//CreateAlienStarter(StartState, XComHQ);
	//}

}

//static function CreateAlienStarter(XComGameState NewGameState, XComGameState_HeadquartersXCom XComHQ)
//{
	//local XComGameState_Unit NewSoldierState;
	//local XComOnlineProfileSettings ProfileSettings;
	//local AU_X2SpeciesTuple_Template Template;
	//local X2CharacterTemplate CharTemplate;
	//local X2CharacterTemplateManager    CharTemplateMgr;
	//local XComGameState_GameTime TimeState;
	//local XComGameStateHistory History;
	//History = class'XComGameStateHistory'.static.GetGameStateHistory();
		////assert(NewGameState != none);
	//ProfileSettings = `XPROFILESETTINGS;
//
	//CharTemplateMgr = class'X2CharacterTemplateManager'.static.GetCharacterTemplateManager();
		////Tuple = TupleMgr.GetRandomTuple();
//
	//Template = class'AU_X2SpeciesHelpers'.static.GetRandomSpecies();
	//CharTemplate = CharTemplateMgr.FindCharacterTemplate(Template.TemplateName);
	//if(CharTemplate == none)
	//{
		//return; //if we don't get any valid templates, that means the user has yet to install any species mods
	//}
//
	//NewSoldierState = `CHARACTERPOOLMGR.CreateCharacter(NewGameState, ProfileSettings.Data.m_eCharPoolUsage, Template.TemplateName);
	//
	//if(!NewSoldierState.HasBackground())
		//NewSoldierState.GenerateBackground();
//
	//NewSoldierState.GiveRandomPersonality();
	//NewSoldierState.ApplyInventoryLoadout(NewGameState);
	//XComHQ.AddToCrew(NewGameState, NewSoldierState);
//
	//TimeState = XComGameState_GameTime(History.GetSingleGameStateObjectForClass(class'XComGameState_GameTime'));
	//NewSoldierState.m_RecruitDate = TimeState.CurrentTime;
//
//
//}

//exec function AddRandomAlienRecruit()
//{
	//local XComGameState_Unit NewSoldierState;
	//local XComOnlineProfileSettings ProfileSettings;
	//local AU_X2SpeciesTuple_Template Template;
	//local X2CharacterTemplate CharTemplate;
	//local X2CharacterTemplateManager    CharTemplateMgr;
	//local XComGameState NewGameState;
	//local XComGameState_HeadquartersXCom XComHQ;
	//NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Adding Allies Unknown State Objects");
//
	//XComHQ = XComGameState_HeadquartersXCom(class'XComGameStateHistory'.static.GetGameStateHistory().GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
//
//
		////assert(NewGameState != none);
		//ProfileSettings = `XPROFILESETTINGS;
//
		//CharTemplateMgr = class'X2CharacterTemplateManager'.static.GetCharacterTemplateManager();
		////Tuple = TupleMgr.GetRandomTuple();
//
		//Template = class'AU_X2SpeciesHelpers'.static.GetRandomSpecies();
		//CharTemplate = CharTemplateMgr.FindCharacterTemplate(Template.TemplateName);
		//if(CharTemplate == none)
		//{
			//return; //if we don't get any valid templates, that means the user has yet to install any species mods
		//}
//
		//NewSoldierState = `CHARACTERPOOLMGR.CreateCharacter(NewGameState, ProfileSettings.Data.m_eCharPoolUsage, Template.TemplateName);
		//if(!NewSoldierState.HasBackground())
			//NewSoldierState.GenerateBackground();
		//NewSoldierState.GiveRandomPersonality();
		//NewSoldierState.ApplyInventoryLoadout(NewGameState);
		//NewSoldierState.SetHQLocation(eSoldierLoc_Barracks);
		//XComHQ = XComGameState_HeadquartersXCom(NewGameState.ModifyStateObject(class'XComGameState_HeadquartersXCom', XComHQ.ObjectID));
		//XComHQ.AddToCrew(NewGameState, NewSoldierState);
//
	//if(NewGameState.GetNumGameStateObjects() > 0)
	//{
		//`XCOMGAME.GameRuleset.SubmitGameState(NewGameState);
	//}
	//else
	//{
		//`XCOMHistory.CleanupPendingGameState(NewGameState);
	//}
//}

/// <summary>
/// Called after the player exits the post-mission sequence while this DLC / Mod is installed.
/// </summary>
static event OnExitPostMissionSequence()
{
	//local XComGameState_ExtraspeciesRecruits RecruitMgr;
	local XComGameStateHistory History;
	local XComGameState NewGameState;
	//local XComGameState_HeadquartersResistance ResHQ;
	//local XComGameState_GrayMarket	GrayMarket;

	History = class'XComGameStateHistory'.static.GetGameStateHistory();
	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Adding Extraspecies Recruits State Objects");

	//RecruitMgr = XComGameState_ExtraspeciesRecruits(History.GetSingleGameStateObjectForClass(class'XComGameState_ExtraspeciesRecruits'));
	//GrayMarket = XComGameState_GrayMarket(History.GetSingleGameStateObjectForClass(class'XComGameState_GrayMarket'));
	//if(RecruitMgr == none) //ensure we have both gamestates active first
	//{
		//InitializeManager();
		//RecruitMgr = XComGameState_ExtraspeciesRecruits(NewGameState.CreateNewStateObject(class'XComGameState_ExtraspeciesRecruits'));
	//}

	//if(GrayMarket == none)
	//{
	//	GrayMarket = XComGameState_GrayMarket(NewGameState.CreateNewStateObject(class'XComGameState_GrayMarket'));
	//}

	//if(RecruitMgr.CanRecruit())
	//{
		//ResHQ = XComGameState_HeadquartersResistance(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersResistance'));
//
//
		//if(ResHQ.NumMonths == 0 && RecruitMgr.ExtraspeciesRecruits.Length == 0 && !RecruitMgr.AlreadyRun)
		//{
		//RecruitMgr = XComGameState_ExtraspeciesRecruits(NewGameState.CreateStateObject(class'XComGameState_ExtraspeciesRecruits'));
		//NewGameState.AddStateObject(RecruitMgr);
		//RecruitMgr.CreateRecruits(NewGameState);
		//RecruitMgr.CleanupResistanceGoods(NewGameState);
		//RecruitMgr.SetUpResistanceGoods(NewGameState);
		//RecruitMgr.CleanUpIntelItems(NewGameState);
		//RecruitMgr.SetUpIntelItems(NewGameState);
		//RecruitMgr.AlreadyRun = true;
		//}
//
//
	//}

	//if(!GrayMarket.bIsOpen)
	//{
		//GrayMarket = XComGameState_GrayMarket(NewGameState.ModifyStateObject(class'XComGameState_GrayMarket', GrayMarket.ObjectID));
		//GrayMarket.ShowGrayMarket(NewGameState);
	//}

	//if (NewGameState.GetNumGameStateObjects() > 0)
	//{
		//History.AddGameStateToHistory(NewGameState);
	//}
	//else
	//{
		//History.CleanupPendingGameState(NewGameState);
	//}
}

//exec function SpawnGrayMarket()
//{
	//local XComGameStateHistory History;
	//local XComGameState NewGameState;
	//local XComGameState_GrayMarket GrayMarket;

	//History = `XCOMHISTORY;
	//GrayMarket = XComGameState_GrayMarket(History.GetSingleGameStateObjectForClass(class'XComGameState_GrayMarket'));
	//NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("CHEAT: Spawn Black Market");

	//if(GrayMarket == none)
	//{
	//	GrayMarket = XComGameState_GrayMarket(NewGameState.CreateNewStateObject(class'XComGameState_GrayMarket'));
	//}

	//if(!GrayMarket.bIsOpen)
	//{
	//	GrayMarket = XComGameState_GrayMarket(NewGameState.ModifyStateObject(class'XComGameState_GrayMarket', GrayMarket.ObjectID));
	//	GrayMarket.ShowGrayMarket(NewGameState);
	//}

	//`XCOMGAME.GameRuleset.SubmitGameState(NewGameState);
//}


 static event OnPostTemplatesCreated()
{
	//EditQuestItemTemplates();
	EditMissionSourceTemplates();
	//EditAliensTemplate();
	EditCovertActionTemplates();
	EditResistanceCardTemplate();
}

static function EditResistanceCardTemplate()
{
	local X2StrategyElementTemplateManager StratMgr;
	local X2StrategyElementTemplate DataTemplate;
	local X2FoundationStrategyCardTemplate CardTemplate;
	StratMgr = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();
	DataTemplate = StratMgr.FindStrategyElementTemplate('ResCard_XenoEngineeringII');

	CardTemplate = X2FoundationStrategyCardTemplate(DataTemplate);

	if(CardTemplate != none && class'Foundation_X2Helpers'.static.IsUsingDLC3())
	{
		CardTemplate.OnActivatedFn = ActivateXenoEngineeringII;
		CardTemplate.OnDeactivatedFn = DeactivateXenoEngineeringII;
		CardTemplate.GetMutatorValueFn = GetValueXenoEngineeringII;
	}

}

static function ActivateXenoEngineeringII(XComGameState NewGameState, StateObjectReference InRef, optional bool bReactivate = false)
{
	local XComGameState_SparkManager SparkMgr;

	SparkMgr = XComGameState_SparkManager(`XCOMHistory.GetSingleGameStateObjectForClass(class'XComGameState_SparkManager'));
	SparkMgr = XComGameState_SparkManager(NewGameState.ModifyStateObject(class'XComGameState_SparkManager', SparkMgr.ObjectID));

	if(SparkMgr.SparkHealingRate < SparkMgr.default.BaseSparkHealRate) //something went wrong, fix SparkMgr
	{
		SparkMgr.SparkHealingRate  = SparkMgr.default.BaseSparkHealRate;
	}

	SparkMgr.SparkHealingRate += GetValueXenoEngineeringII();
}


static function DeactivateXenoEngineeringII(XComGameState NewGameState, StateObjectReference InRef)
{
	local XComGameState_SparkManager SparkMgr;

	SparkMgr = XComGameState_SparkManager(`XCOMHistory.GetSingleGameStateObjectForClass(class'XComGameState_SparkManager'));
	SparkMgr = XComGameState_SparkManager(NewGameState.ModifyStateObject(class'XComGameState_SparkManager', SparkMgr.ObjectID));

	SparkMgr.SparkHealingRate -= GetValueXenoEngineeringII();


	if(SparkMgr.SparkHealingRate < SparkMgr.default.BaseSparkHealRate) //something went wrong, fix SparkMgr
	{
		SparkMgr.SparkHealingRate  = SparkMgr.default.BaseSparkHealRate;
	}

}
//---------------------------------------------------------------------------------------
static function int GetValueXenoEngineeringII()
{
	return `ScaleStrategyArrayInt(class'X2StrategyElement_AUResistanceActions'.default.SparkHealBonus);
}

static function EditCovertActionTemplates()
{
	local X2StrategyElementTemplateManager StratMgr;
	local array<X2StrategyElementTemplate> AllActionTemplates;
	local X2StrategyElementTemplate DataTemplate;
	local X2CovertActionTemplate ActionTemplate;
	StratMgr = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();
	AllActionTemplates = StratMgr.GetAllTemplatesOfClass(class'X2CovertActionTemplate');

	foreach AllActionTemplates(DataTemplate)
	{
		ActionTemplate = X2CovertActionTemplate(DataTemplate);
		if (ActionTemplate != none) //valid template, so we start  adding our narratives
		{
			if(ActionTemplate.DataName == 'CovertAction_RecruitScientist')
				ActionTemplate.Narratives.AddItem('CovertActionNarrative_RecruitScientist_Foundation');

			if(ActionTemplate.DataName == 'CovertAction_RecruitEngineer')
				ActionTemplate.Narratives.AddItem('CovertActionNarrative_RecruitEngineer_Spectres');

			if(ActionTemplate.DataName == 'CovertAction_GatherSupplies')
				ActionTemplate.Narratives.AddItem('CovertActionNarrative_GatherSupplies_Spectres');

			if(ActionTemplate.DataName == 'CovertAction_GatherIntel')
				ActionTemplate.Narratives.AddItem('CovertActionNarrative_GatherIntel_Spectres');

			if(ActionTemplate.DataName == 'CovertAction_IncreaseIncome')
				ActionTemplate.Narratives.AddItem('CovertActionNarrative_IncreaseIncome_Spectres');

			if(ActionTemplate.DataName == 'CovertAction_RemoveDoom')
				ActionTemplate.Narratives.AddItem('CovertActionNarrative_RemoveDoom_Spectres');

			if(ActionTemplate.DataName == 'CovertAction_ImproveComInt')
				ActionTemplate.Narratives.AddItem('CovertActionNarrative_ImproveComInt_Spectres');

			if(ActionTemplate.DataName == 'CovertAction_FormSoldierBond')
				ActionTemplate.Narratives.AddItem('CovertActionNarrative_FormSoldierBond_Spectres');

			if(ActionTemplate.DataName == 'CovertAction_ResistanceContact')
				ActionTemplate.Narratives.AddItem('CovertActionNarrative_ResistanceContact_Spectres');

			if(ActionTemplate.DataName == 'CovertAction_SharedAbilityPoints')
				ActionTemplate.Narratives.AddItem('CovertActionNarrative_SharedAbilityPoints_Spectres');

			if(ActionTemplate.DataName == 'CovertAction_BreakthroughTech')
				ActionTemplate.Narratives.AddItem('CovertActionNarrative_BreakthroughTech_Spectres');

			if(ActionTemplate.DataName == 'CovertAction_SuperiorWeaponUpgrade')
				ActionTemplate.Narratives.AddItem('CovertActionNarrative_SuperiorWeaponUpgrade_Spectres');

			if(ActionTemplate.DataName == 'CovertAction_SuperiorPCS')
				ActionTemplate.Narratives.AddItem('CovertActionNarrative_SuperiorPCS_Spectres');

			if(ActionTemplate.DataName == 'CovertAction_AlienLoot')
				ActionTemplate.Narratives.AddItem('CovertActionNarrative_AlienLoot_Spectres');

			if(ActionTemplate.DataName == 'CovertAction_FacilityLead')
				ActionTemplate.Narratives.AddItem('CovertActionNarrative_FacilityLead_Spectres');

			if(ActionTemplate.DataName == 'CovertAction_ResistanceCard')
				ActionTemplate.Narratives.AddItem('CovertActionNarrative_ResistanceCard_Spectres');

			//if(ActionTemplate.DataName == 'CovertAction_FoundationGear')
				//ActionTemplate.Narratives.AddItem('CovertActionNarrative_FoundationGear_Foundation');
		}
	}

}

static function EditMissionSourceTemplates()
{
	HandleTemplate('MissionSource_GuerillaOp');
	HandleTemplate('MissionSource_Council');
	HandleTemplate('MissionSource_ResistanceOp');
}

static function HandleTemplate(name templateName){
	local X2MissionSourceTemplate Template;
	local RewardDeckEntry DeckEntry;
	local X2StrategyElementTemplateManager Manager;

	Manager =class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();

	Template = X2MissionSourceTemplate(Manager.FindStrategyElementTemplate(templateName));

	if (Template == none)
	{
		`log("Could not find template:"@string(templateName));
		return;
	}

	if (templatename == 'MissionSource_GuerillaOp')
	{
	DeckEntry.RewardName = 'Reward_AU_Soldier';
	DeckEntry.Quantity = 1;
	Template.RewardDeck.AddItem(DeckEntry);
	}
}

//static function EditQuestItemTemplates()
//{
	//local X2ItemTemplateManager ItemTemplateManager;
//
	//ItemTemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
//
	//UpdateQuestItemTemplate(ItemTemplateManager, 'PatrolRoutes', 'Reward_AU_Soldier');
	//UpdateQuestItemTemplate(ItemTemplateManager, 'SecurityWatchlist', 'Reward_AU_Soldier');
	//UpdateQuestItemTemplate(ItemTemplateManager, 'OperationsList', 'Reward_AU_Soldier');
	//UpdateQuestItemTemplate(ItemTemplateManager, 'SecurityBriefing', 'Reward_AU_Soldier');
	//UpdateQuestItemTemplate(ItemTemplateManager, 'AlienDeployments', 'Reward_AU_Soldier');
	//UpdateQuestItemTemplate(ItemTemplateManager, 'GeneticTestingResults', 'Reward_AU_Soldier');
	//UpdateQuestItemTemplate(ItemTemplateManager, 'WeaponsSchematics', 'Reward_AU_Soldier');
	//UpdateQuestItemTemplate(ItemTemplateManager, 'ReconnaissanceFootage', 'Reward_AU_Soldier');
	//UpdateQuestItemTemplate(ItemTemplateManager, 'RelayTranscripts', 'Reward_AU_Soldier');
	//UpdateQuestItemTemplate(ItemTemplateManager, 'InterrogationReports', 'Reward_AU_Soldier');
	//UpdateQuestItemTemplate(ItemTemplateManager, 'StructuralAnalysis', 'Reward_AU_Soldier');
	//UpdateQuestItemTemplate(ItemTemplateManager, 'MissingPersonsReport', 'Reward_AU_Soldier');
	//UpdateQuestItemTemplate(ItemTemplateManager, 'AccessCodes', 'Reward_AU_Soldier');
	//UpdateQuestItemTemplate(ItemTemplateManager, 'CollaboratorDatabase', 'Reward_AU_Soldier');
	//UpdateQuestItemTemplate(ItemTemplateManager, 'EquipmentAllocations', 'Reward_AU_Soldier');
	//UpdateQuestItemTemplate(ItemTemplateManager, 'TroopMovements', 'Reward_AU_Soldier');
	//UpdateQuestItemTemplate(ItemTemplateManager, 'CivilianPositioningData', 'Reward_AU_Soldier');
	//UpdateQuestItemTemplate(ItemTemplateManager, 'ThermalImagingScan', 'Reward_AU_Soldier');
//
//}


//static function UpdateQuestItemTemplate(X2ItemTemplateManager ItemTemplateMgr, name QuestItem, name BaseItem)
//{
	//local array<X2ItemTemplate> ItemTemplates;
	//local X2QuestItemTemplate QuestTemplate;
	//local X2ItemTemplate ItemTemplate;
//
	//FindItemTemplateAllDifficulties(QuestItem, ItemTemplates, ItemTemplateMgr);
//
	//foreach ItemTemplates(ItemTemplate)
	//{
		//QuestTemplate = X2QuestItemTemplate(ItemTemplate);
		//if(QuestTemplate != none)
		//{
			//QuestTemplate.RewardType.AddItem(BaseItem);
		//}
	//}
//
//
//}

//static function InitializeManager()
//{
	//local XComGameStateHistory History;
	//local XComGameState NewGameState;
	//local XComGameState_ExtraspeciesRecruits RecruitMgr;

	//History = class'XComGameStateHistory'.static.GetGameStateHistory();
	//NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Adding Allies Unknown State Objects");

	//RecruitMgr = XComGameState_ExtraspeciesRecruits(class'XComGameStateHistory'.static.GetGameStateHistory().GetSingleGameStateObjectForClass(class'XComGameState_ExtraspeciesRecruits', true));
//
	//if (RecruitMgr == none) //prevent duplicate Extraspecies templates
	//{
		//RecruitMgr = XComGameState_ExtraspeciesRecruits(NewGameState.CreateStateObject(class'XComGameState_ExtraspeciesRecruits'));
		//NewGameState.AddStateObject(RecruitMgr);
	//}
//
	//if (NewGameState.GetNumGameStateObjects() > 0)
	//{
		//History.AddGameStateToHistory(NewGameState);
	//}
	//else
	//{
		//History.CleanupPendingGameState(NewGameState);
	//}
//}


//static function EditAliensTemplate()
//{
	//local X2CharacterTemplateManager	CharManager;
	//local X2CharacterTemplate			CharTemplate;
	//local name						AlienName;
	//local array<X2DataTemplate>		DifficultyTemplates;
	//local array<AU_X2SpeciesTuple_Template> SpeciesTemplates;
	//local X2DataTemplate			DifficultyTemplate;
	//local int i;
	//CharManager = class'X2CharacterTemplateManager'.static.GetCharacterTemplateManager();
//
	//class'AU_X2SpeciesHelpers'.static.DebugAllSpeciesTemplates(SpeciesTemplates);
//
	//if(class'AU_X2SpeciesHelpers'.static.IsUsingLW2())
	//{
		//for(i = 0; i < default.SpeciesNames.Length; i++)
		//{
//
			//AlienName = SpeciesTemplates[i].TemplateName;
			//CharManager.FindDataTemplateAllDifficulties(AlienName ,DifficultyTemplates);
			//`log("Current Species Template is "$ AlienName, ,'AlliesUnknown');
			//foreach DifficultyTemplates(DifficultyTemplate) 
			//{
				//CharTemplate = X2CharacterTemplate(DifficultyTemplate);
				//if ( CharTemplate != none ) 
				//{	
			////		`log("Current Species Template Being Modified is "$ CharTemplate.DataName, ,'AlliesUnknown');
						//CharTemplate.CharacterBaseStats[eStat_UtilityItems] = 3; //this is for LW2 and its new balance of 3 utility slots
						//CharTemplate.CharacterBaseStats[eStat_Mobility] += 3; //this is due to LW2 adding +3 mobility to base soldiers, so we copy that.
						//CharTemplate.CharacterBaseStats[eStat_PsiOffense] += 20; //this for LW2 adding +20 psi offense to human soldiers
				//}
			//}
		//}
	//}
//}


static event UpdateDLC()
{
	local XComGameState_ResistanceFaction FactionState;
	local XComGameStateHistory History;
	local name CompletedAction;
	local XComGameState_CovertAction ActionState;
	local StateObjectReference ActionRef;
	local XComGameState NewGameState; //this is a dummy state so the covert action just submits its own state when removing itself

	History = `XCOMHISTORY;

	foreach History.IterateByClassType(class'XComGameState_ResistanceFaction', FactionState)
	{
		if(FactionState.GetInfluence() > eFactionInfluence_Minimal && FactionState.GetMyTemplateName() == 'Faction_Foundation') //no need to check if we're alerady past influence stage one
			return;

		if (FactionState.GetMyTemplateName() == 'Faction_Foundation') //if we didn't trip the first check, then we found our faction and it hasn't been found yet.
				break;
	}

	foreach FactionState.CompletedCovertActions(CompletedAction) //we look here to see if the covert action we're looking for has been completed
	{
		if(CompletedAction == 'CovertAction_FindFoundation')
			break;

	}

	if(CompletedAction != 'CovertAction_FindFoundation')
		return; //covert action was not done, no need to do this last check.

	foreach FactionState.GoldenPathActions(ActionRef)
	{
		ActionState = XComGameState_CovertAction(History.GetGameStateForObjectID(ActionRef.ObjectID));

		if(ActionState.GetMyTemplateName() == CompletedAction)//alright, found our action, now let's see if we need to kick close it
		{
			if(ActionState.bCompleted && !ActionState.bNeedsActionCompletePopup) //we are completed but we do not require the completion popup. Since we're somehow still in here, remove the entity.
			{
				ActionState.RemoveEntity(NewGameState);
				break;
			}
		}

	}

}

/// <summary>
/// Calls DLC specific popup handlers to route messages to correct display functions
/// </summary>
static function bool DisplayQueuedDynamicPopup(DynamicPropertySet PropertySet)
{
	if (PropertySet.PrimaryRoutingKey == 'UIAlert_FoundationLevelup')
	{
		CallUIFactionPopup(PropertySet);
		return true;
	}

	return false;
}

static function CallUIFactionPopup(const out DynamicPropertySet PropertySet)
{
	local XComGameState_ResistanceFaction FactionState;
	local XComGameStateHistory History;

	History = `XCOMHISTORY;
	foreach History.IterateByClassType(class'XComGameState_ResistanceFaction', FactionState)
	{
		if (FactionState.GetMyTemplateName() == 'Faction_Foundation')
		{
				`HQPRES.UIFactionPopup(FactionState, true);	
				break;
		}
	}


}

//=================================================================================
//================= UTILITY CLASSES ===============================================
//=================================================================================


//static function AddTracker()
//{
	//local XComGameStateHistory History;
	//local XComGameState NewGameState;
	////local RM_XComGameState_AUTriggerObj AchievementObject;
//
	//History = class'XComGameStateHistory'.static.GetGameStateHistory();
	//NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Allies Unknown -- Adding Mod Achievement State");

	// Add Achievement Object
	//AchievementObject = RM_XComGameState_AUTriggerObj(History.GetSingleGameStateObjectForClass(class'RM_XComGameState_AUTriggerObj', true));
	//if (AchievementObject == none) // Prevent duplicate Achievement Objects
	//{
	//	AchievementObject = RM_XComGameState_AUTriggerObj(NewGameState.CreateStateObject(class'RM_XComGameState_AUTriggerObj'));
	//	NewGameState.AddStateObject(AchievementObject);
	//}
	

	//if (NewGameState.GetNumGameStateObjects() > 0)
	//{
		////AddAchievementTriggers(AchievementObject);
	//	History.AddGameStateToHistory(NewGameState);
	//}
	//else
	//{
	//	History.CleanupPendingGameState(NewGameState);
//	}

//}

//static function AddAchievementTriggers(Object TriggerObj)
//{
	//local X2EventManager EventManager;
//
	//// Set up triggers for achievements
	//EventManager = class'X2EventManager'.static.GetEventManager();
	//
	//EventManager.RegisterForEvent(TriggerObj, 'TacticalGameEnd', class'PTG_X2AchievementTracker_SCP'.static.OnTacticalGameEnd, ELD_OnStateSubmitted, 50, , true);
	//EventManager.RegisterForEvent(TriggerObj, 'KillMail', class'PTG_X2AchievementTracker_SCP'.static.OnKillMail, ELD_OnStateSubmitted, 50, , true);
//}
//

//retrieves all difficulty variants of a given item template
static function FindItemTemplateAllDifficulties(name DataName, out array<X2ItemTemplate> ItemTemplates, optional X2ItemTemplateManager ItemTemplateMgr)
{
	local array<X2DataTemplate> DataTemplates;
	local X2DataTemplate DataTemplate;
	local X2ItemTemplate ItemTemplate;

	if(ItemTemplateMgr == none)
		ItemTemplateMgr = class'X2ItemTemplateManager'.static.GetItemTemplateManager();

	ItemTemplateMgr.FindDataTemplateAllDifficulties(DataName, DataTemplates);
	ItemTemplates.Length = 0;
	foreach DataTemplates(DataTemplate)
	{
		ItemTemplate = X2ItemTemplate(DataTemplate);
		if( ItemTemplate != none )
		{
			ItemTemplates.AddItem(ItemTemplate);
		}
	}
}


//exec function ScreenStickPress()
//{
	//local XComHQPresentationLayer HQPres;
	//local UIRecruitSoldiers_Extraspecies RecruitScreen;
	//local UIBlackmarketGoods_Extraspecices MarketScreen;
	//local UIResistanceGoods_Extraspecies GoodsScreen;

	//HQPres = `HQPRES;
	//if(HQPres.ScreenStack.IsNotInStack(class'UIRecruitSoldiers_Extraspecies') && UIRecruitSoldiers(HQPres.ScreenStack.GetCurrentScreen()) != none)
	//{
	////RelationshipScreen = RM_UIArmory_RelationshipPopup(HQPres.ScreenStack.Push(HQPres.Spawn(class'RM_UIArmory_RelationshipPopup', HQPres)), HQPres.Get3DMovie());
	//RecruitScreen = HQPres.Spawn(class'UIRecruitSoldiers_Extraspecies', HQPres);
	//HQPres.ScreenStack.Push(RecruitScreen);
	//}

	//if(HQPres.ScreenStack.IsNotInStack(class'UIBlackMarketGoods_Extraspecices') && UIBlackMarket(HQPres.ScreenStack.GetCurrentScreen()) != none )
	//{
	//RelationshipScreen = RM_UIArmory_RelationshipPopup(HQPres.ScreenStack.Push(HQPres.Spawn(class'RM_UIArmory_RelationshipPopup', HQPres)), HQPres.Get3DMovie());
	//MarketScreen = HQPres.Spawn(class'UIBlackMarketGoods_Extraspecices', HQPres);
	//HQPres.ScreenStack.Push(MarketScreen);
//	}

	//if(HQPres.ScreenStack.IsNotInStack(class'UIResistanceGoods_Extraspecies') && UIResistanceGoods(HQPres.ScreenStack.GetCurrentScreen()) != none)
	//{
	//RelationshipScreen = RM_UIArmory_RelationshipPopup(HQPres.ScreenStack.Push(HQPres.Spawn(class'RM_UIArmory_RelationshipPopup', HQPres)), HQPres.Get3DMovie());
	//GoodsScreen = HQPres.Spawn(class'UIResistanceGoods_Extraspecies', HQPres);
	//HQPres.ScreenStack.Push(GoodsScreen);
	//}
//}


exec function ChosenCaptureSpecificSoldier(string UnitName)
{
	local XComGameStateHistory History;
	local XComGameState NewGameState;
	local XComGameState_HeadquartersXCom XComHQ;
	local XComGameState_HeadquartersAlien AlienHQ;
	local array<XComGameState_AdventChosen> AllChosen;
	local XComGameState_AdventChosen ChosenState;
	local XComGameState_Unit UnitState, CapturedUnit;
	local array<XComGameState_Unit> AllSoldiers;
	local StateObjectReference EmptyRef;
	local int idx, i;

	History = `XCOMHISTORY;
	XComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
	AllSoldiers = XComHQ.GetSoldiers();
	AlienHQ = XComGameState_HeadquartersAlien(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersAlien'));
	AllChosen = AlienHQ.GetAllChosen();

	for (i = 0; i < AllSoldiers.Length; i++)
	{
		UnitState = XComGameState_Unit(History.GetGameStateForObjectID(AllSoldiers[i].ObjectID));
				
		if (UnitState != none && UnitState.IsSoldier() && UnitState.GetFullName() == UnitName)
		{
			NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("CHEAT: ChosenCaptureSoldier");
			CapturedUnit = XComGameState_Unit(NewGameState.ModifyStateObject(class'XComGameState_Unit', UnitState.ObjectID));
			break;
		}
	}

	if(AllSoldiers.Length > 0 && AllChosen.Length > 0)
	{
		
		XComHQ = XComGameState_HeadquartersXCom(NewGameState.ModifyStateObject(class'XComGameState_HeadquartersXCom', XComHQ.ObjectID));
		//UnitState = XComGameState_Unit(NewGameState.ModifyStateObject(class'XComGameState_Unit', AllSoldiers[0].ObjectID));
		ChosenState = XComGameState_AdventChosen(NewGameState.ModifyStateObject(class'XComGameState_AdventChosen', AllChosen[0].ObjectID));
		ChosenState.CaptureSoldier(NewGameState, CapturedUnit.GetReference());
		XComHQ.RemoveFromCrew(CapturedUnit.GetReference());

		for(idx = 0; idx < XComHQ.Squad.Length; idx++)
		{
			if(XComHQ.Squad[idx] == CapturedUnit.GetReference())
			{
				XComHQ.Squad[idx] = EmptyRef;
				break;
			}
		}

		`XCOMGAME.GameRuleset.SubmitGameState(NewGameState);
		`HQPRES.UISoldierCaptured(ChosenState, CapturedUnit.GetReference());
	}

}


exec function RefreshAlienRecruits()
{
	//local XComGameState_ExtraspeciesRecruits RecruitMgr, NewRecruitMgr;
	//local XComGameStateHistory History;
	//local XComGameState NewGameState;
//
//
	//History = class'XComGameStateHistory'.static.GetGameStateHistory();
	//NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Adding Extraspecies Recruits State Objects");
	//RecruitMgr = XComGameState_ExtraspeciesRecruits(History.GetSingleGameStateObjectForClass(class'XComGameState_ExtraspeciesRecruits'));
//
	//if(RecruitMgr != none && RecruitMgr.CanRecruit())
	//{
		//NewRecruitMgr = XComGameState_ExtraspeciesRecruits(NewGameState.CreateStateObject(class'XComGameState_ExtraspeciesRecruits', RecruitMgr.ObjectID));
		//NewGameState.AddStateObject(NewRecruitMgr);
		//NewRecruitMgr.RefillRecruits(NewGameState, RecruitMgr);
		//NewRecruitMgr.CleanupResistanceGoods(NewGameState);
		//NewRecruitMgr.SetUpResistanceGoods(NewGameState);
		//NewRecruitMgr.CleanUpIntelItems(NewGameState);
		//NewRecruitMgr.SetUpIntelItems(NewGameState);
	//}
//
//
	//if (NewGameState.GetNumGameStateObjects() > 0)
	//{
		//History.AddGameStateToHistory(NewGameState);
	//}
	//else
	//{
		//History.CleanupPendingGameState(NewGameState);
	//}
	//
//
//
//
}

exec function AddCardSlots()
{
	local XComGameState_ResistanceFaction FactionState;
	local XComGameStateHistory History;
	local XComGameState NewGameState;

	History = `XCOMHISTORY;
	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Adding Card Slots");
	foreach History.IterateByClassType(class'XComGameState_ResistanceFaction', FactionState)
	{
		if (FactionState.bMetXCom)
		{
			FactionState = XComGameState_ResistanceFaction(NewGameState.ModifyStateObject(class'XComGameState_ResistanceFaction', FactionState.ObjectID));
			FactionState.AddCardSlot();
						
		}
	}

	if(NewGameState.GetNumGameStateObjects() > 0)
	{
		`XCOMGAME.GameRuleset.SubmitGameState(NewGameState);
	}
	else
	{
		`XCOMHistory.CleanupPendingGameState(NewGameState);
	}


}
 