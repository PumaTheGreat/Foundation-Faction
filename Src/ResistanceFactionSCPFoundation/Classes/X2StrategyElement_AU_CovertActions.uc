
class X2StrategyElement_AU_CovertActions extends X2StrategyElement;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> CovertActions;

	CovertActions.AddItem(CreateFindFoundation());
	CovertActions.AddItem(CreateRecruitSpectreSoldier());
//	CovertActions.AddItem(CreateGetFoundationStrategyCard());
	CovertActions.AddItem(CreateRescueSpectreOperative());
	CovertActions.AddItem(CreateGetNewCardSlots());
	CovertActions.AddItem(CreateFoundationGear());
//	CovertActions.AddItem(CreateLongerStay());
	return CovertActions;
}

//---------------------------------------------------------------------------------------
// Contact The Foundation
//---------------------------------------------------------------------------------------
static function X2DataTemplate CreateFindFoundation()
{
	local X2CovertActionTemplate Template;

	`CREATE_X2TEMPLATE(class'X2CovertActionTemplate', Template, 'CovertAction_FindFoundation');

	Template.ChooseLocationFn = ChooseFactionRegion;
	Template.OverworldMeshPath = "UI_3D.Overwold_Final.CovertAction";
	Template.bGoldenPath = true;

	Template.Narratives.AddItem('CovertActionNarrative_FindFaction_Foundation');


	Template.Slots.AddItem(CreateDefaultSoldierSlot('CovertActionSoldierStaffSlot'));
	Template.Slots.AddItem(CreateDefaultSoldierSlot('CovertActionSoldierStaffSlot'));

	Template.Risks.AddItem('CovertActionRisk_SoldierWounded');

	Template.Rewards.AddItem('Reward_FindFoundation');

	return Template;
}


//---------------------------------------------------------------------------------------
// RESISTANCE CARD
//---------------------------------------------------------------------------------------
//static function X2DataTemplate CreateGetFoundationStrategyCard()
//{
	//local X2CovertActionTemplate Template;
//
	//`CREATE_X2TEMPLATE(class'X2CovertActionTemplate', Template, 'CovertAction_FoundationResistanceCard');
//
	//Template.ChooseLocationFn = ChooseRandomRegion;
	//Template.OverworldMeshPath = "UI_3D.Overwold_Final.CovertAction";
	////Template.bMultiplesAllowed = true;
	//Template.bUseRewardImage = true;
//
	//Template.Narratives.AddItem('CovertActionNarrative_ResistanceCard_Spectres');
//
	//Template.Slots.AddItem(CreateDefaultSoldierSlot('CovertActionSoldierStaffSlot'));
	//Template.Slots.AddItem(CreateDefaultSoldierSlot('CovertActionSoldierStaffSlot'));
	//Template.OptionalCosts.AddItem(CreateOptionalCostSlot('Intel', 25));
//
	//Template.Risks.AddItem('CovertActionRisk_SoldierWounded');
	//Template.Risks.AddItem('CovertActionRisk_Ambush');
//
	//Template.Rewards.AddItem('Reward_FoundationResistanceCard');
//
	//return Template;
//}

//---------------------------------------------------------------------------------------
// Foundation Loot
//---------------------------------------------------------------------------------------
static function X2DataTemplate CreateFoundationGear()
{
	local X2CovertActionTemplate Template;

	`CREATE_X2TEMPLATE(class'X2CovertActionTemplate', Template, 'CovertAction_FoundationGear');

	Template.ChooseLocationFn = ChooseRandomRegion;
	Template.OverworldMeshPath = "UI_3D.Overwold_Final.CovertAction";
	Template.bGoldenPath = False;
	Template.bUseRewardImage = false;
	//Template.bDisplayIgnoresInfluence = true;

	Template.bDisplayRequiresAvailable = true;

	Template.Narratives.AddItem('CovertActionNarrative_FoundationGear_Foundation');

	Template.Slots.AddItem(CreateDefaultSoldierSlot('CovertActionSoldierStaffSlot'));
	Template.Slots.AddItem(CreateDefaultSoldierSlot('CovertActionSoldierStaffSlot'));
	Template.Slots.AddItem(CreateDefaultOptionalSlot('CovertActionEngineerStaffSlot'));

	Template.Risks.AddItem('CovertActionRisk_SoldierWounded');
	//Template.Risks.AddItem('CovertActionRisk_Ambush');

	Template.Rewards.AddItem('Reward_FoundationGear');

	return Template;
}


//---------------------------------------------------------------------------------------
// RECRUIT SPECTRE
//---------------------------------------------------------------------------------------
static function X2DataTemplate CreateRecruitSpectreSoldier()
{
	local X2CovertActionTemplate Template;
	
	`CREATE_X2TEMPLATE(class'X2CovertActionTemplate', Template, 'CovertAction_RecruitSpectreSoldier');

	Template.ChooseLocationFn = ChooseRandomRegion;
	Template.OverworldMeshPath = "UI_3D.Overwold_Final.CovertAction";
	Template.RequiredFactionInfluence = eFactionInfluence_Minimal;
	Template.bDisplayIgnoresInfluence = true;
	Template.bDisplayRequiresAvailable = true;
	Template.bUseRewardImage = false;
	Template.Narratives.AddItem('CovertActionNarrative_RecruitFactionSoldier_Spectres');

	Template.Slots.AddItem(CreateDefaultSoldierSlot('CovertActionSoldierStaffSlot', 3));
	Template.Slots.AddItem(CreateDefaultOptionalSlot('CovertActionSoldierStaffSlot'));

	Template.Risks.AddItem('CovertActionRisk_SoldierWounded');
	Template.Risks.AddItem('CovertActionRisk_SoldierCaptured');

	Template.Rewards.AddItem('Reward_FactionSoldier');


	return Template;
}

//---------------------------------------------------------------------------------------
// LONGER STAY AT THE FOUNDATION
//---------------------------------------------------------------------------------------
//static function X2DataTemplate CreateLongerStay()
//{
	//local X2CovertActionTemplate Template;
//
	//`CREATE_X2TEMPLATE(class'X2CovertActionTemplate', Template, 'CovertAction_LongerStay');
//
	//Template.ChooseLocationFn = ChooseFactionRegion;
	//Template.OverworldMeshPath = "UI_3D.Overwold_Final.CovertAction";
	//Template.RequiredFactionInfluence = eFactionInfluence_Minimal;
	//Template.bDisplayIgnoresInfluence = true;
	//Template.bDisplayRequiresAvailable = true;
	////Template.bUseRewardImage = true;
//
	//Template.Narratives.AddItem('CovertActionNarrative_LongerStay_Foundation');
//
//
	//Template.Slots.AddItem(CreateDefaultSoldierSlot('CovertActionSoldierStaffSlot', 3));
	//Template.Slots.AddItem(CreateDefaultSoldierSlot('CovertActionSoldierStaffSlot'));
	//Template.Slots.AddItem(CreateDefaultSoldierSlot('CovertActionSoldierStaffSlot'));
	//Template.Slots.AddItem(CreateDefaultOptionalSlot('CovertActionSoldierStaffSlot'));
//
	//Template.Risks.AddItem('CovertActionRisk_SoldierWounded');
	//Template.Risks.AddItem('CovertActionRisk_SoldierCaptured');
	////Template.Risks.AddItem('CovertActionRisk_Ambush');
//
	////Template.Rewards.AddItem('Reward_FactionInfluence');
	//Template.Rewards.AddItem('Reward_FoundationFactionInfluence');
//
	//return Template;
//}

//---------------------------------------------------------------------------------------
// Aiding The Foundation
//---------------------------------------------------------------------------------------
static function X2DataTemplate CreateRescueSpectreOperative()
{
	local X2CovertActionTemplate Template;

	`CREATE_X2TEMPLATE(class'X2CovertActionTemplate', Template, 'CovertAction_RescueSpectre');

	Template.ChooseLocationFn = ChooseRandomRegion;
	Template.OverworldMeshPath = "UI_3D.Overwold_Final.CovertAction";
	Template.RequiredFactionInfluence = eFactionInfluence_Minimal;
	//Template.bGoldenPath = true;
	Template.bDisplayIgnoresInfluence = true;
	//Template.bUseRewardImage = true;

	Template.Narratives.AddItem('CovertActionNarrative_RescueOperative_Spectres');


	Template.Slots.AddItem(CreateDefaultSoldierSlot('CovertActionSoldierStaffSlot', 3));
	Template.Slots.AddItem(CreateDefaultSoldierSlot('CovertActionSoldierStaffSlot'));
	Template.Slots.AddItem(CreateDefaultOptionalSlot('CovertActionSoldierStaffSlot'));

	Template.Risks.AddItem('CovertActionRisk_SoldierWounded');
	Template.Risks.AddItem('CovertActionRisk_Ambush');

	Template.Rewards.AddItem('Reward_SpectreRescue');

	return Template;
}

//---------------------------------------------------------------------------------------
// REVEAL CHOSEN STRENGTHS
//---------------------------------------------------------------------------------------
static function X2DataTemplate CreateGetNewCardSlots()
{
	local X2CovertActionTemplate Template;

	`CREATE_X2TEMPLATE(class'X2CovertActionTemplate', Template, 'CovertAction_NewCardSlots');

	Template.ChooseLocationFn = ChooseRandomRegion;
	Template.OverworldMeshPath = "UI_3D.Overwold_Final.CovertAction";
	Template.RequiredFactionInfluence = eFactionInfluence_Respected;
	Template.bGoldenPath = true;

	Template.Narratives.AddItem('CovertActionNarrative_CardSlots_Spectres');

	Template.Slots.AddItem(CreateDefaultSoldierSlot('CovertActionSoldierStaffSlot', 4));
	Template.Slots.AddItem(CreateDefaultSoldierSlot('CovertActionSoldierStaffSlot'));
	Template.Slots.AddItem(CreateDefaultOptionalSlot('CovertActionSoldierStaffSlot', 3));

	Template.Risks.AddItem('CovertActionRisk_SoldierWounded');
	Template.Risks.AddItem('CovertActionRisk_SoldierCaptured');
	Template.Risks.AddItem('CovertActionRisk_Ambush');

	Template.Rewards.AddItem('Reward_CardSlots');

	return Template;
}

//---------------------------------------------------------------------------------------
// DEFAULT SLOTS
//---------------------------------------------------------------------------------------

private static function CovertActionSlot CreateDefaultSoldierSlot(name SlotName, optional int iMinRank, optional bool bRandomClass, optional bool bFactionClass)
{
	local CovertActionSlot SoldierSlot;

	SoldierSlot.StaffSlot = SlotName;
	SoldierSlot.Rewards.AddItem('Reward_StatBoostHP');
	SoldierSlot.Rewards.AddItem('Reward_StatBoostAim');
	SoldierSlot.Rewards.AddItem('Reward_StatBoostMobility');
	SoldierSlot.Rewards.AddItem('Reward_StatBoostDodge');
	SoldierSlot.Rewards.AddItem('Reward_StatBoostWill');
	SoldierSlot.Rewards.AddItem('Reward_StatBoostHacking');
	SoldierSlot.Rewards.AddItem('Reward_RankUp');
	SoldierSlot.iMinRank = iMinRank;
	SoldierSlot.bChanceFame = false;
	SoldierSlot.bRandomClass = bRandomClass;
	SoldierSlot.bFactionClass = bFactionClass;

	if (SlotName == 'CovertActionRookieStaffSlot')
	{
		SoldierSlot.bChanceFame = false;
	}

	return SoldierSlot;
}

private static function CovertActionSlot CreateDefaultStaffSlot(name SlotName)
{
	local CovertActionSlot StaffSlot;
	
	// Same as Soldier Slot, but no rewards
	StaffSlot.StaffSlot = SlotName;
	StaffSlot.bReduceRisk = false;
	
	return StaffSlot;
}

private static function CovertActionSlot CreateDefaultOptionalSlot(name SlotName, optional int iMinRank, optional bool bFactionClass)
{
	local CovertActionSlot OptionalSlot;

	OptionalSlot.StaffSlot = SlotName;
	OptionalSlot.bChanceFame = false;
	OptionalSlot.bReduceRisk = true;
	OptionalSlot.iMinRank = iMinRank;
	OptionalSlot.bFactionClass = bFactionClass;

	return OptionalSlot;
}

private static function StrategyCostReward CreateOptionalCostSlot(name ResourceName, int Quantity)
{
	local StrategyCostReward ActionCost;
	local ArtifactCost Resources;

	Resources.ItemTemplateName = ResourceName;
	Resources.Quantity = Quantity;
	ActionCost.Cost.ResourceCosts.AddItem(Resources);
	ActionCost.Reward = 'Reward_DecreaseRisk';
	
	return ActionCost;
}

//---------------------------------------------------------------------------------------
// GENERIC DELEGATES
//---------------------------------------------------------------------------------------

static function ChooseRandomRegion(XComGameState NewGameState, XComGameState_CovertAction ActionState, out array<StateObjectReference> ExcludeLocations)
{
	local XComGameStateHistory History;
	local XComGameState_WorldRegion RegionState;
	local array<StateObjectReference> RegionRefs;

	History = `XCOMHISTORY;

	foreach History.IterateByClassType(class'XComGameState_WorldRegion', RegionState)
	{
		if (ExcludeLocations.Find('ObjectID', RegionState.GetReference().ObjectID) == INDEX_NONE)
		{
			RegionRefs.AddItem(RegionState.GetReference());
		}		
	}

	ActionState.LocationEntity = RegionRefs[`SYNC_RAND_STATIC(RegionRefs.Length)];
}

static function ChooseRandomContactedRegion(XComGameState NewGameState, XComGameState_CovertAction ActionState, out array<StateObjectReference> ExcludeLocations)
{
	local XComGameStateHistory History;
	local XComGameState_WorldRegion RegionState;
	local array<StateObjectReference> RegionRefs;

	History = `XCOMHISTORY;

	foreach History.IterateByClassType(class'XComGameState_WorldRegion', RegionState)
	{
		if (ExcludeLocations.Find('ObjectID', RegionState.GetReference().ObjectID) == INDEX_NONE && RegionState.HaveMadeContact())
		{
			RegionRefs.AddItem(RegionState.GetReference());
		}
	}

	ActionState.LocationEntity = RegionRefs[`SYNC_RAND_STATIC(RegionRefs.Length)];
}

static function ChooseAdventFacilityRegion(XComGameState NewGameState, XComGameState_CovertAction ActionState, out array<StateObjectReference> ExcludeLocations)
{
	local XComGameStateHistory History;
	local XComGameState_WorldRegion RegionState;
	local array<StateObjectReference> RegionRefs;

	History = `XCOMHISTORY;

	foreach History.IterateByClassType(class'XComGameState_WorldRegion', RegionState)
	{
		if (ExcludeLocations.Find('ObjectID', RegionState.GetReference().ObjectID) == INDEX_NONE && RegionState.AlienFacility.ObjectID != 0)
		{
			RegionRefs.AddItem(RegionState.GetReference());
		}
	}

	ActionState.LocationEntity = RegionRefs[`SYNC_RAND_STATIC(RegionRefs.Length)];
}

static function ChooseFactionRegion(XComGameState NewGameState, XComGameState_CovertAction ActionState, out array<StateObjectReference> ExcludeLocations)
{
	ActionState.LocationEntity = ActionState.GetFaction().HomeRegion;
}

static function ChooseRivalChosenHomeRegion(XComGameState NewGameState, XComGameState_CovertAction ActionState, out array<StateObjectReference> ExcludeLocations)
{
	ActionState.LocationEntity = ActionState.GetFaction().GetRivalChosen().HomeRegion;
}

static function ChooseRivalChosenHomeContinentRegion(XComGameState NewGameState, XComGameState_CovertAction ActionState, out array<StateObjectReference> ExcludeLocations)
{
	local XComGameState_Continent ContinentState;
	local XComGameState_WorldRegion RegionState;
	local XComGameState_AdventChosen ChosenState;
	local array<StateObjectReference> ValidRegionRefs;
	local StateObjectReference RegionRef;
	
	ChosenState = ActionState.GetFaction().GetRivalChosen();
	RegionState = ChosenState.GetHomeRegion();

	if (RegionState != none)
	{
		ContinentState = RegionState.GetContinent();
		ValidRegionRefs.Length = 0;

		foreach ContinentState.Regions(RegionRef)
		{
			if(ChosenState.TerritoryRegions.Find('ObjectID', RegionRef.ObjectID) != INDEX_NONE)
			{
				ValidRegionRefs.AddItem(RegionRef);
			}
		}

		if(ValidRegionRefs.Length > 0)
		{
			ActionState.LocationEntity = ValidRegionRefs[`SYNC_RAND_STATIC(ValidRegionRefs.Length)];
		}
		else
		{
		ActionState.LocationEntity = ContinentState.Regions[`SYNC_RAND_STATIC(ContinentState.Regions.Length)];
	}
	}
	else
	{
		ActionState.LocationEntity = ChosenState.HomeRegion;
	}
}

static function ChooseRandomRivalChosenRegion(XComGameState NewGameState, XComGameState_CovertAction ActionState, out array<StateObjectReference> ExcludeLocations)
{
	local XComGameState_AdventChosen ChosenState;

	ChosenState = ActionState.GetFaction().GetRivalChosen();
	ActionState.LocationEntity = ChosenState.TerritoryRegions[`SYNC_RAND_STATIC(ChosenState.TerritoryRegions.Length)];
}

 //static event OnPostTemplatesCreated()
//{
	////EditQuestItemTemplates();
	////EditMissionSourceTemplates();
	////EditAliensTemplate();
	//EditCovertActionTemplates();
	////EditResistanceCardTemplate();
//}
//
//static function EditCovertActionTemplates()
//{
	//local X2StrategyElementTemplateManager StratMgr;
	//local array<X2StrategyElementTemplate> AllActionTemplates;
	//local X2StrategyElementTemplate DataTemplate;
	//local X2CovertActionTemplate ActionTemplate;
	//StratMgr = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();
	//AllActionTemplates = StratMgr.GetAllTemplatesOfClass(class'X2CovertActionTemplate');
//
	//foreach AllActionTemplates(DataTemplate)
	//{
		//ActionTemplate = X2CovertActionTemplate(DataTemplate);
		//if (ActionTemplate != none) //valid template, so we start  adding our narratives
		//{
			//if(ActionTemplate.DataName == 'CovertAction_RecruitScientist')
				//ActionTemplate.Narratives.AddItem('CovertActionNarrative_RecruitScientist_Foundation');
//
			//if(ActionTemplate.DataName == 'CovertAction_RecruitEngineer')
				//ActionTemplate.Narratives.AddItem('CovertActionNarrative_RecruitEngineer_Spectres');
//
			//if(ActionTemplate.DataName == 'CovertAction_GatherSupplies')
				//ActionTemplate.Narratives.AddItem('CovertActionNarrative_GatherSupplies_Spectres');
//
			//if(ActionTemplate.DataName == 'CovertAction_GatherIntel')
				//ActionTemplate.Narratives.AddItem('CovertActionNarrative_GatherIntel_Spectres');
//
			//if(ActionTemplate.DataName == 'CovertAction_IncreaseIncome')
				//ActionTemplate.Narratives.AddItem('CovertActionNarrative_IncreaseIncome_Spectres');
//
			//if(ActionTemplate.DataName == 'CovertAction_RemoveDoom')
				//ActionTemplate.Narratives.AddItem('CovertActionNarrative_RemoveDoom_Spectres');
//
			//if(ActionTemplate.DataName == 'CovertAction_ImproveComInt')
				//ActionTemplate.Narratives.AddItem('CovertActionNarrative_ImproveComInt_Spectres');
//
			//if(ActionTemplate.DataName == 'CovertAction_FormSoldierBond')
				//ActionTemplate.Narratives.AddItem('CovertActionNarrative_FormSoldierBond_Spectres');
//
			//if(ActionTemplate.DataName == 'CovertAction_ResistanceContact')
				//ActionTemplate.Narratives.AddItem('CovertActionNarrative_ResistanceContact_Spectres');
//
			//if(ActionTemplate.DataName == 'CovertAction_SharedAbilityPoints')
				//ActionTemplate.Narratives.AddItem('CovertActionNarrative_SharedAbilityPoints_Spectres');
//
			//if(ActionTemplate.DataName == 'CovertAction_BreakthroughTech')
				//ActionTemplate.Narratives.AddItem('CovertActionNarrative_BreakthroughTech_Spectres');
//
			//if(ActionTemplate.DataName == 'CovertAction_SuperiorWeaponUpgrade')
				//ActionTemplate.Narratives.AddItem('CovertActionNarrative_SuperiorWeaponUpgrade_Spectres');
//
			//if(ActionTemplate.DataName == 'CovertAction_SuperiorPCS')
				//ActionTemplate.Narratives.AddItem('CovertActionNarrative_SuperiorPCS_Spectres');
//
			//if(ActionTemplate.DataName == 'CovertAction_AlienLoot')
				//ActionTemplate.Narratives.AddItem('CovertActionNarrative_AlienLoot_Spectres');
//
			//if(ActionTemplate.DataName == 'CovertAction_FacilityLead')
				//ActionTemplate.Narratives.AddItem('CovertActionNarrative_FacilityLead_Spectres');
//
			//if(ActionTemplate.DataName == 'CovertAction_ResistanceCard')
				//ActionTemplate.Narratives.AddItem('CovertActionNarrative_ResistanceCard_Spectres');
//
			////if(ActionTemplate.DataName == 'CovertAction_FoundationGear')
				////ActionTemplate.Narratives.AddItem('CovertActionNarrative_FoundationGear_Foundation');
		//}
	//}
//
//}
//
//static function AddFactionToGeneratedTemplates() {
	////local array<name> CovertActionNames;
	//local X2StrategyElementTemplateManager Manager;
	////local array<X2CovertActionTemplate> CovertActionTemplates;
	////local array<X2DataTemplate>			DataTemplates;
	////local X2DataTemplate				IteratorTemplate;
	////local X2CovertActionTemplate		TestTemplate;
	//local array<X2StrategyElementTemplate> AllActionTemplates;
	//local X2StrategyElementTemplate DataTemplate;
	//local X2CovertActionTemplate ActionTemplate;
//
	//Manager = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();
	//AllActionTemplates = Manager.GetAllTemplatesOfClass(class'X2CovertActionTemplate');
//
	//foreach AllActionTemplates(DataTemplate)
	//{
		//ActionTemplate = X2CovertActionTemplate(DataTemplate);
		//if (ActionTemplate != none) //valid template, so we start  adding our narratives
		//{
			//if(ActionTemplate.DataName == 'CovertAction_RecruitScientist')
				//ActionTemplate.Narratives.AddItem('CovertActionNarrative_RecruitScientist_Foundation');
//
			//if(ActionTemplate.DataName == 'CovertAction_RecruitEngineer')
				//ActionTemplate.Narratives.AddItem('CovertActionNarrative_RecruitEngineer_spectres');
//
			//if(ActionTemplate.DataName == 'CovertAction_GatherSupplies')
				//ActionTemplate.Narratives.AddItem('CovertActionNarrative_GatherSupplies_spectres');
//
			//if(ActionTemplate.DataName == 'CovertAction_GatherIntel')
				//ActionTemplate.Narratives.AddItem('CovertActionNarrative_GatherIntel_spectres');
//
			//if(ActionTemplate.DataName == 'CovertAction_IncreaseIncome')
				//ActionTemplate.Narratives.AddItem('CovertActionNarrative_IncreaseIncome_spectres');
//
			//if(ActionTemplate.DataName == 'CovertAction_RemoveDoom')
				//ActionTemplate.Narratives.AddItem('CovertActionNarrative_RemoveDoom_spectres');
//
			//if(ActionTemplate.DataName == 'CovertAction_ImproveComInt')
				//ActionTemplate.Narratives.AddItem('CovertActionNarrative_ImproveComInt_spectres');
//
			//if(ActionTemplate.DataName == 'CovertAction_FormSoldierBond')
				//ActionTemplate.Narratives.AddItem('CovertActionNarrative_FormSoldierBond_spectres');
//
			//if(ActionTemplate.DataName == 'CovertAction_ResistanceContact')
				//ActionTemplate.Narratives.AddItem('CovertActionNarrative_ResistanceContact_spectres');
//
			//if(ActionTemplate.DataName == 'CovertAction_SharedAbilityPoints')
				//ActionTemplate.Narratives.AddItem('CovertActionNarrative_SharedAbilityPoints_spectres');
//
			//if(ActionTemplate.DataName == 'CovertAction_BreakthroughTech')
				//ActionTemplate.Narratives.AddItem('CovertActionNarrative_BreakthroughTech_spectres');
//
			//if(ActionTemplate.DataName == 'CovertAction_SuperiorWeaponUpgrade')
				//ActionTemplate.Narratives.AddItem('CovertActionNarrative_SuperiorWeaponUpgrade_spectres');
//
			//if(ActionTemplate.DataName == 'CovertAction_SuperiorPCS')
				//ActionTemplate.Narratives.AddItem('CovertActionNarrative_SuperiorPCS_spectres');
//
			//if(ActionTemplate.DataName == 'CovertAction_AlienLoot')
				//ActionTemplate.Narratives.AddItem('CovertActionNarrative_AlienLoot_spectres');
//
			//if(ActionTemplate.DataName == 'CovertAction_FacilityLead')
				//ActionTemplate.Narratives.AddItem('CovertActionNarrative_FacilityLead_spectres');
//
			//if(ActionTemplate.DataName == 'CovertAction_ResistanceCard')
				//ActionTemplate.Narratives.AddItem('CovertActionNarrative_ResistanceCard_spectres');
//
			//if(ActionTemplate.DataName == 'CovertAction_RevealChosenMovements')
				//ActionTemplate.Narratives.AddItem('CovertActionNarrative_RevealChosenMovements_spectres');
//
			//if(ActionTemplate.DataName == 'CovertAction_RevealChosenStrengths')
				//ActionTemplate.Narratives.AddItem('CovertActionNarrative_RevealChosenStrengths_spectres');
//
			//if(ActionTemplate.DataName == 'CovertAction_RevealChosenStronghold')
				//ActionTemplate.Narratives.AddItem('CovertActionNarrative_RevealChosenStronghold_spectres');
		//}
	//}
//}
//
//private static function AddFactionToCovertActionNarratives(array<X2DataTemplate> DataTemplates, name CovertActionNarrativeName) {
	//local X2DataTemplate				IteratorTemplate;
	//local X2CovertActionTemplate		TestTemplate;
//
	//if(DataTemplates.Length > 0) {
		//foreach DataTemplates(IteratorTemplate) {
			//TestTemplate = X2CovertActionTemplate(IteratorTemplate);
			//if(TestTemplate != none) {
				//X2CovertActionTemplate(IteratorTemplate).Narratives.AddItem(CovertActionNarrativeName);
			//}
		//}
		//DataTemplates.Length = 0;
	//}
//}