class X2FoundationRewards extends X2StrategyElement_DefaultRewards dependson(X2RewardTemplate) config(GameData);

var config array<int> PrimaryArmorColors; //not needed, couldn't get that to work
var config array<int> SecondaryArmorColors; 
var config array<name> MaleHelmets;
var config array<name> FemaleHelmets;
var config array<name> MaleArms;
var config array<name> FemaleArms;
var config array<name> MaleTorsos;
var config array<name> FemaleTorsos;
var config array<name> MaleLegs;
var config array<name> FemaleLegs;
var config array<name> Gender;
var config array<int>					ScrambleGearBaseReward;
var config array<int>					ScrambleGearInterval;
var config array<int>					ScrambleGearRewardIncrease;
var config int							ScrambleGearRangePercent;


static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Rewards;

	//Rewards.AddItem(CreateAUSoldierRewardTemplate());
	//Rewards.AddItem(CreateAUMarketRewardTemplate());
	//Rewards.AddItem(CreateAURookiesRewardTemplate());

	//covert actions
	Rewards.AddItem(CreateSpectreRescue());
	Rewards.AddItem(CreateFindFoundation());
	Rewards.AddItem(CreateFactionInfluenceRewardTemplate());
	
	Rewards.AddItem(CreateNewCardSlots());
	Rewards.Additem(CreateFoundationGear());
	Rewards.AddItem(CreateMTFRewardTemplate());
	//Rewards.Additem(CreateFoundationResistanceCard());
	return Rewards;
}

//static function X2DataTemplate CreateFoundationResistanceCard()
//{
	//local X2RewardTemplate Template;
//
	//`CREATE_X2Reward_TEMPLATE(Template, 'Reward_FoundationCard');
//
    //Template.rewardObjectTemplateName = 'ScrambleGear';
	//Template.RewardImage = "img:///UILibrary_FoundationFaction.CovertOp_Recover_X_Supplies_Foundation";
	//Template.bResourceReward = true;
//
	//Template.GenerateRewardFn = GenerateResourceReward;
	//Template.SetRewardFn = SetResourceReward;
	//Template.GiveRewardFn = GiveResourceReward;
	//Template.GetRewardStringFn = GetResourceRewardString;
	//Template.GetRewardPreviewStringFn = GetResourceRewardString;
	//Template.GetRewardImageFn = GetResourceRewardImage;
	//Template.GetRewardIconFn = GetGenericRewardIcon;
//
	//return Template;
//}

static function X2DataTemplate CreateFoundationGear()
{
	local X2RewardTemplate Template;

	`CREATE_X2Reward_TEMPLATE(Template, 'Reward_FoundationGear');
	Template.rewardObjectTemplateName = 'ScrambleGear';

	Template.IsRewardAvailableFn = IsFoundationGearRewardAvailable;
	Template.GenerateRewardFn = GenerateScrambleGearReward; //GenerateItemReward;
	Template.SetRewardFn = SetItemReward;
	Template.GiveRewardFn = GiveItemReward;
	Template.GetRewardStringFn = GetItemRewardString;
	Template.GetRewardImageFn = GetItemRewardImage;
	Template.GetBlackMarketStringFn = GetItemBlackMarketString;
	Template.GetRewardIconFn = GetGenericRewardIcon;
	Template.RewardPopupFn = ItemRewardPopup;
	
	return Template;
}

static function GenerateScrambleGearReward(XComGameState_Reward RewardState, XComGameState NewGameState, optional float RewardScalar = 1.0, optional StateObjectReference RegionRef)
{
	local XComGameState_Item ItemState;
	local X2ItemTemplate ItemTemplate;

	ItemTemplate = class'X2ItemTemplateManager'.static.GetItemTemplateManager().FindItemTemplate(RewardState.GetMyTemplate().rewardObjectTemplateName);
	ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);

	RewardState.RewardObjectReference = ItemState.GetReference();
	//RewardState.Quantity = 2;  //RewardState.RewardObjectReference = ItemState.GetReference();
}
//static function X2DataTemplate CreateFoundationGear()
//{
	//local X2RewardTemplate Template;
//
	//`CREATE_X2Reward_TEMPLATE(Template, 'Reward_FoundationGear');
//
    //Template.rewardObjectTemplateName = 'ScrambleGear';
	//Template.RewardImage = "img:///UILibrary_FoundationFaction.CovertOp_Recover_X_Supplies_Foundation";
	//Template.bResourceReward = true;
//
	//Template.IsRewardAvailableFn = IsFoundationGearRewardAvailable;
	//Template.GenerateRewardFn = GenerateResourceReward;
	//Template.SetRewardFn = SetResourceReward;
	//Template.GiveRewardFn = GiveResourceReward;
	//Template.GetRewardStringFn = GetResourceRewardString;
	//Template.GetRewardPreviewStringFn = GetResourceRewardString;
	//Template.GetRewardImageFn = GetResourceRewardImage;
	//Template.GetRewardIconFn = GetGenericRewardIcon;
//
	//return Template;
//}

static function bool IsFoundationGearRewardAvailable(optional XComGameState NewGameState, optional StateObjectReference AuxRef)
{
	local XComGameState_ResistanceFaction FactionState;

	FactionState = GetFactionState(NewGameState, AuxRef); //return false if this is a covert action and is not from the Foundation. Else, return true.
	if (FactionState != none)
	{
		if ( FactionState.GetMyTemplateName() != 'Faction_Foundation')
		{
			return false; // only for Foundation
		}

		return FactionState.bMetXCom;
	}

	return true;
}

static function X2DataTemplate CreateNewCardSlots()
{
	local X2RewardTemplate Template;

	`CREATE_X2Reward_TEMPLATE(Template, 'Reward_CardSlots');

	Template.IsRewardAvailableFn = IsHighFoundationInfluenceRewardAvailable;
	//Template.GenerateRewardFn = GenerateFoundationFactionInfluenceReward;
	Template.GiveRewardFn = GiveCardSlotsReward;
	//Template.GetRewardImageFn = GetFactionInfluenceRewardImage;
	//Template.GetRewardStringFn = GetFactionInfluenceRewardString;
	//Template.CleanUpRewardFn = CleanUpRewardWithoutRemoval;
	Template.RewardPopupFn = FoundationInfluenceRewardPopup;

	return Template;
}

static function FoundationInfluenceRewardPopup(XComGameState_Reward RewardState)
{
	local DynamicPropertySet PropertySet; //need to delay it when the player can see it
	local XComGameState_CovertAction ActionState;
	local XComGameState_ResistanceFaction FactionState;

	ActionState = XComGameState_CovertAction(`XCOMHISTORY.GetGameStateForObjectID(RewardState.RewardObjectReference.ObjectID));
	FactionState = ActionState.GetFaction();
	
	class'X2StrategyGameRulesetDataStructures'.static.BuildDynamicPropertySet(PropertySet, 'UIAlert_FoundationLevelup', 'UIFactionPopup', none, false, false, true, false);
	class'XComPresentationLayerBase'.static.QueueDynamicPopup(PropertySet);
}

//static function FoundationInfluenceRewardPopup(XComGameState_Reward RewardState) //i brought it here to compare this and above
//{
	//local DynamicPropertySet PropertySet; //need to delay it when the player can see it
	//
	//class'X2StrategyGameRulesetDataStructures'.static.BuildDynamicPropertySet(PropertySet, 'UIAlert_ProgramLevelup', 'UIFactionPopup', none, false, false, true, false);
	//class'XComPresentationLayerBase'.static.QueueDynamicPopup(PropertySet);
//}
//
static function GiveCardSlotsReward(XComGameState NewGameState, XComGameState_Reward RewardState, optional StateObjectReference AuxRef, optional bool bOrder = false, optional int OrderHours = -1)
{
	local XComGameState_ResistanceFaction FactionState, RandomFactionState;
	local array<XComGameState_ResistanceFaction> ArrayOfStates;
	local XComGameStateHistory History;
	local XComGameState_CovertAction ActionState;

	History = `XCOMHISTORY;
	
	foreach History.IterateByClassType(class'XComGameState_ResistanceFaction', RandomFactionState)
	{
		if (RandomFactionState.bMetXCom)
		{
		ArrayoFStates.AddItem(RandomFactionState);
		}
	}

	RandomFactionState = ArrayOfStates[`SYNC_RAND_STATIC(ArrayOfStates.Length)];

	if(RandomFactionState != none)
	{
		RandomFactionState = XComGameState_ResistanceFaction(NewGameState.ModifyStateObject(class'XComGameState_ResistanceFaction', RandomFactionState.GetReference().ObjectID));
		RandomFactionState.AddCardSlot();
	}

	ActionState = XComGameState_CovertAction(`XCOMHISTORY.GetGameStateForObjectID(AuxRef.ObjectID));
	FactionState = XComGameState_ResistanceFaction(NewGameState.ModifyStateObject(class'XComGameState_ResistanceFaction', ActionState.Faction.ObjectID));
	FactionState.IncreaseInfluenceLevel(NewGameState); //increase Spectre faction influence //bs does not work kill me please

}
static function bool IsHighFoundationInfluenceRewardAvailable(optional XComGameState NewGameState, optional StateObjectReference AuxRef)
{
	local XComGameState_ResistanceFaction FactionState;

	FactionState = GetFactionState(NewGameState, AuxRef); //return false if this is a covert action and is not from the Spectres. Else, return true.
	if (FactionState != none)
	{
		if ( FactionState.GetMyTemplateName() != 'Faction_Foundation')
		{
			return false; // only for Spectres
		}
	}

	if(class'XComGameState_HeadquartersXCom'.static.IsObjectiveCompleted('T1_M6_KillAvatar') || class'XComGameState_HeadquartersXCom'.static.IsObjectiveCompleted('T2_M3_CompleteForgeMission')  || class'XComGameState_HeadquartersXCom'.static.IsObjectiveCompleted('T4_M1_CompleteStargateMission'))
	{
		return true;
	}


	return false;
}

//static function X2DataTemplate CreateAUSoldierRewardTemplate()
//{
	//local X2RewardTemplate Template;
//
//
	//`CREATE_X2Reward_TEMPLATE(Template, 'Reward_AU_Soldier');
//
	//Template.rewardObjectTemplateName = 'RewardAUSoldier';
//
	//Template.IsRewardAvailableFn = IsAURewardAvailable;
	//Template.GenerateRewardFn = GenerateAUPersonnelReward;
	//Template.SetRewardFn = SetPersonnelReward;
	//Template.GiveRewardFn = GivePersonnelReward;
	//Template.GetRewardStringFn = GetPersonnelRewardString;
	//Template.GetRewardImageFn = GetPersonnelRewardImage;
	//Template.GetBlackMarketStringFn = GetSoldierBlackMarketString;
	//Template.GetRewardIconFn = GetGenericRewardIcon;
	//Template.CleanUpRewardFn = CleanUpUnitReward;
	//Template.RewardPopupFn = PersonnelRewardPopup;
	//return Template;
//}
static function bool IsAURewardAvailable(optional XComGameState NewGameState, optional StateObjectReference AuxRef)
{
	local XComGameState_ResistanceFaction FactionState;

	FactionState = GetFactionState(NewGameState, AuxRef); //return false if this is a covert action and is not from the Spectres. Else, return true.
	if (FactionState != none)
	{
		if ( FactionState.GetMyTemplateName() != 'Faction_Foundation')
		{
			return false; // only for Spectres
		}

		return FactionState.bMetXCom;
	}

	return true;
}

//static function X2DataTemplate CreateAUMarketRewardTemplate()
//{
	//local X2RewardTemplate Template;
//
	//`CREATE_X2Reward_TEMPLATE(Template, 'Reward_AU_Market');
//
//
	//Template.rewardObjectTemplateName = 'MarketAUSoldier'; //this is to prevent missions and rumours from spawning no reward
	//
//
//
	//Template.GenerateRewardFn = GenerateAUPersonnelReward;
	//Template.SetRewardFn = SetPersonnelReward;
	//Template.GiveRewardFn = GivePersonnelReward;
	//Template.GetRewardStringFn = GetPersonnelRewardString;
	//Template.GetRewardImageFn = GetPersonnelRewardImage;
	//Template.GetBlackMarketStringFn = GetSoldierBlackMarketString;
	//Template.GetRewardIconFn = GetGenericRewardIcon;
	//Template.CleanUpRewardFn = CleanUpUnitReward;
	//Template.RewardPopupFn = PersonnelRewardPopup;
	//return Template;
//}

//static function X2DataTemplate CreateAURookiesRewardTemplate()
//{
	//local X2RewardTemplate Template;
//
	//`CREATE_X2Reward_TEMPLATE(Template, 'Reward_AU_Rookies');
//
	//Template.rewardObjectTemplateName = 'RewardAURookies'; //this is to prevent missions and rumours from spawning no reward
	//
//
//
	//Template.GenerateRewardFn = GenerateAUPersonnelReward;
	//Template.SetRewardFn = SetPersonnelReward;
	//Template.GiveRewardFn = GivePersonnelReward;
	//Template.GetRewardStringFn = GetPersonnelRewardString;
	//Template.GetRewardImageFn = GetPersonnelRewardImage;
	//Template.GetBlackMarketStringFn = GetSoldierBlackMarketString;
	//Template.GetRewardIconFn = GetGenericRewardIcon;
	//Template.CleanUpRewardFn = CleanUpUnitReward;
	//Template.RewardPopupFn = PersonnelRewardPopup;
	//return Template;
//}
//

// #######################################################################################
// --------------------- FACTION REWARDS ---------------------------------------------
// #######################################################################################
static function X2RewardTemplate CreateFindFoundation()
{
	local X2RewardTemplate Template;

	`CREATE_X2Reward_TEMPLATE(Template, 'Reward_FindFoundation');
	Template.rewardObjectTemplateName = 'Soldier'; //this is to prevent missions and rumours from spawning no reward
	

	Template.IsRewardAvailableFn = IsFindFactionRewardAvailable;
	Template.GenerateRewardFn = GenerateMTFPersonnelReward;
	Template.GiveRewardFn = GiveSpectrePersonnelReward;
	Template.CleanUpRewardFn = CleanUpUnitReward;
	Template.RewardPopupFn = PersonnelRewardPopup;
	return Template;
}

static function bool IsFindFactionRewardAvailable(optional XComGameState NewGameState, optional StateObjectReference AuxRef)
{
	local XComGameState_ResistanceFaction FactionState;

	FactionState = GetFactionState(NewGameState, AuxRef);
	if (FactionState != none)
	{
		if ( FactionState.GetMyTemplateName() != 'Faction_Foundation')
		{
			return false; // only for Spectres
		}

		return !FactionState.bMetXCom;
	}

	return false;
}

static function X2DataTemplate CreateMTFRewardTemplate()
{
	local X2RewardTemplate Template;

	`CREATE_X2Reward_TEMPLATE(Template, 'Reward_MTF');
	Template.rewardObjectTemplateName = 'Soldier';

	Template.GenerateRewardFn = GenerateMTFPersonnelReward;
	Template.SetRewardFn = SetPersonnelReward;
	Template.GiveRewardFn = GiveSpectrePersonnelReward;
	Template.GetRewardStringFn = GetPersonnelRewardString;
	Template.GetRewardImageFn = GetPersonnelRewardImage;
	Template.GetBlackMarketStringFn = GetSoldierBlackMarketString;
	Template.GetRewardIconFn = GetGenericRewardIcon;
	Template.RewardPopupFn = PersonnelRewardPopup;

	return Template;
}

static function X2DataTemplate CreateSpectreRescue()
{
	local X2RewardTemplate Template;

	`CREATE_X2Reward_TEMPLATE(Template, 'Reward_SpectreRescue');

	Template.IsRewardAvailableFn = IsAURescueRewardAvailable;
	Template.GiveRewardFn = GiveSpectreRescueReward;
	Template.GetRewardStringFn = GetMissionRewardString;
	Template.RewardPopupFn = MissionRewardPopup;

	return Template;
}

static function bool IsAURescueRewardAvailable(optional XComGameState NewGameState, optional StateObjectReference AuxRef)
{
	local XComGameState_ResistanceFaction FactionState;

	FactionState = GetFactionState(NewGameState, AuxRef); //return false if this is a covert action and is not from the Spectres. Else, return true.
	if (FactionState != none)
	{
		if ( FactionState.GetMyTemplateName() != 'Faction_Foundation')
		{
			return false; // only for Foundation
		}

		return (FactionState.bMetXCom && (FactionState.GetInfluence() < eFactionInfluence_Respected));
	}

	return true;
}

static function GiveSpectreRescueReward(XComGameState NewGameState, XComGameState_Reward RewardState, optional StateObjectReference AuxRef, optional bool bOrder = false, optional int OrderHours = -1)
{
	local XComGameState_MissionSite MissionState;
	local XComGameState_WorldRegion RegionState;
	local XComGameState_Reward MissionRewardState;
	local XComGameState_CovertAction ActionState;
	local X2RewardTemplate RewardTemplate;
	local X2StrategyElementTemplateManager StratMgr;
	local X2MissionSourceTemplate MissionSource;
	local array<XComGameState_Reward> MissionRewards;
	local float MissionDuration;
	local bool bExpire;
	local XComGameState_HeadquartersResistance ResHQ;

	StratMgr = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();
	ActionState = XComGameState_CovertAction(`XCOMHISTORY.GetGameStateForObjectID(AuxRef.ObjectID));
	RegionState = ActionState.GetWorldRegion();
	ResHQ = class'UIUtilities_Strategy'.static.GetResistanceHQ();

	MissionRewards.Length = 0;
	RewardTemplate = X2RewardTemplate(StratMgr.FindStrategyElementTemplate('Reward_MTF'));
	MissionRewardState = RewardTemplate.CreateInstanceFromTemplate(NewGameState);
	MissionRewardState.GenerateReward(NewGameState, ResHQ.GetMissionResourceRewardScalar(MissionRewardState), RegionState.GetReference());
	MissionRewards.AddItem(MissionRewardState);

	RewardTemplate = X2RewardTemplate(StratMgr.FindStrategyElementTemplate('Reward_FoundationFactionInfluence'));
	MissionRewardState = RewardTemplate.CreateInstanceFromTemplate(NewGameState);
	MissionRewardState.GenerateReward(NewGameState, ResHQ.GetMissionResourceRewardScalar(MissionRewardState), ActionState.Faction);
	MissionRewards.AddItem(MissionRewardState);

	MissionDuration = float((default.MissionMinDuration + `SYNC_RAND_STATIC(default.MissionMaxDuration - default.MissionMinDuration + 1)) * 3600);
	
	bExpire = false;
	MissionSource = X2MissionSourceTemplate(StratMgr.FindStrategyElementTemplate('MissionSource_ResistanceFoundationOp')); //I'll try this 
	//MissionSource = X2MissionSourceTemplate(StratMgr.FindStrategyElementTemplate('MissionSource_ResistanceOp')); //it works, but not the way I intended. I still need to make it better.
	//MissionSource = X2MissionSourceTemplate(StratMgr.FindStrategyElementTemplate('MissionSource_Council')); //Literally Allies unknown wannabe mission. It won't please anybody.
	MissionState = XComGameState_MissionSite(NewGameState.CreateNewStateObject(class'XComGameState_MissionSite'));
	MissionState.BuildMission(MissionSource, RegionState.GetRandom2DLocationInRegion(), RegionState.GetReference(), MissionRewards, true, bExpire, , MissionDuration);

	// Set this mission as associated with the Faction whose Covert Action spawned it
	MissionState.ResistanceFaction = ActionState.Faction;

	// Then overwrite the reward reference so the mission is properly awarded when the Action completes
	RewardState.RewardObjectReference = MissionState.GetReference();
}
                                     
function GenerateMTFPersonnelReward(XComGameState_Reward RewardState, XComGameState NewGameState, optional float RewardScalar = 1.0, optional StateObjectReference RegionRef)
{   
    local XComGameState_HeadquartersResistance ResistanceHQ;
    local XComGameStateHistory History;
    local XComGameState_Unit NewUnitState;
	local XComGameState_WorldRegion RegionState;
	local int idx, NewRank, StartingRank;
	local name nmCountry;
	local name nmCharacter;
	local name nmlegs;
	local name iGender;
	local name iWeaponTint;
	local bool UseAlternate;
	local bool PairOne;
	local bool PairTwo;
	local bool PairThree;
	local bool PairFour;
	local bool PairFive;
	local bool PairSix;
	
	History = `XCOMHISTORY;

	//nmCharacter = 'Soldier'; //not needed
	
	nmCountry = ''; 
	RegionState = XComGameState_WorldRegion(`XCOMHISTORY.GetGameStateForObjectID(RegionRef.ObjectID));

	

	if(RegionState != none)
	{
		nmCountry = RegionState.GetMyTemplate().GetRandomCountryInRegion();
	}

	NewUnitState = CreateMTFPersonnelUnit(NewGameState, RewardState.GetMyTemplate().rewardObjectTemplateName, nmCountry, (RewardState.GetMyTemplateName() == 'Reward_MTF'));
	NewUnitState.RandomizeStats();                                                                                                   
	
	UseAlternate = `SYNC_RAND(100) > 12.5; //Stolen from reality, because he is good at this shit
	PairOne = `SYNC_RAND(100) > 50; //Definig my own randomizers, to make the MTF looks more random, as using the same operator more than once in the same line does not seem to work.
	PairTwo = `SYNC_RAND(100) > 50;
	PairThree = `SYNC_RAND(100) > 50;
	PairFour = `SYNC_RAND(100) > 50;
	PairFive = `SYNC_RAND(100) > 50;
	PairSix = `SYNC_RAND(100) > 50;
	//NewUnitState.kAppearance.iGender = (UseAlternate) ? eGender_Female : eGender_Male; //Already defined in NewUnitState, so not needed here
	
	if(NewUnitState.kAppearance.iGender == eGender_Male) //Here we check if newly generated unit is a male
	{
	NewUnitState.kAppearance.nmarms = 'MTFgign_arms2'; //Arms with XCom badge on them
	}

	else //If they're not male, we use Female body parts
	{
	NewUnitState.kAppearance.nmarms = 'MTFgign_arms2_f';
	}

	if(NewUnitState.kAppearance.iGender == eGender_Male) //we check if newly generated unit is a male
	{
	//NewUnitState.kAppearance.nmlegs = (UseAlternate) ? 'MTFgign_Legs3' : 'MTFgign_Legs2'); //Less random set of body parts, not using my own randomizers
	NewUnitState.kAppearance.nmlegs = (UseAlternate) ? ((PairOne) ? 'MTFgign_Legs3' : 'MTFgign_Legs3') : ((PairTwo) ? 'MTFgign_Legs' : 'MTFgign_Legs2'); //legs
	}

	else //If they're not male, we use Female body parts
	{
	//NewUnitState.kAppearance.nmlegs = (UseAlternate) ? 'MTFgign_Legs3_F' : 'MTFgign_Legs2_F'); //Less random set of body parts, not using my own randomizers
	NewUnitState.kAppearance.nmlegs = (UseAlternate) ? ((PairOne) ? 'MTFgign_Legs3_F' : 'MTFgign_Legs3_F') : ((PairTwo) ? 'MTFgign_Legs_F' : 'MTFgign_Legs2_F'); //Arms
	}

	if(NewUnitState.kAppearance.iGender == eGender_Male) 
	{
	//NewUnitState.kAppearance.nmtorso = (UseAlternate) ? 'MTFgign_Torso3' : 'MTFgign_Torso4'; //Less random set of body parts, not using my own randomizers
	NewUnitState.kAppearance.nmtorso = (UseAlternate) ? ((PairOne) ? 'MTFgign_Torso3' : 'MTFgign_Torso4') : ((PairTwo) ? 'MTFgign_Torso' : 'MTFgign_Torso2'); //Torsos
	}

	else 
	{
	//NewUnitState.kAppearance.nmtorso = (UseAlternate) ? 'MTFgign_Torso3_F' : 'MTFgign_Torso4_F'; //Less random set of body parts, not using my own randomizers
	NewUnitState.kAppearance.nmtorso = (UseAlternate) ? ((PairOne) ? 'MTFgign_Torso3_F' : 'MTFgign_Torso4_F') : ((PairTwo) ? 'MTFgign_Torso_F' : 'MTFgign_Torso2_F');
	}

	if (NewUnitState.kAppearance.iGender == eGender_Male) 
	{
		NewUnitState.kAppearance.nmHelmet =  (UseAlternate) ? 'MTFgign_helm3' : 'MTFgign_helm'; //Helmets
	}

	else 
	{
		NewUnitState.kAppearance.nmHelmet = (UseAlternate) ? 'MTFALL_WotC_MGSV_PMC_Heavy_Helmet_Opaque_F' : 'MTFALL_WotC_MGSV_PMC_Heavy_Helmet_Translucent_F';
	}

	
	if (NewUnitState.kAppearance.iGender == eGender_Male) 
	{
		NewUnitState.kAppearance.nmVoice = (UseAlternate) ? ((PairOne) ? ((PairTwo) ? 'TVP_GHOST2' : 'TVP_GHOST3') : ((PairThree) ? 'TVP_GHOST1' : 'R6_VoicePack_TST')) : ((UseAlternate) ? ((PairFour) ? 'TVP_GHOST2' : 'TVP_GHOST3') : ((PairFive) ? 'TVP_GHOST1' : 'R6_VoicePack_TST')) ;
	}
	else 
	{
		NewUnitState.kAppearance.nmVoice = (UseAlternate) ? 'TVP_GHOST4' : 'TVP_GHOST4'; //I don't have any more female voices for the operative. Randomizer not needed, but I'll keep it in here 
	}

	NewUnitState.KAppearance.nmPatterns = 'Pat_Nothing'; 
	NewUnitState.kAppearance.iArmorTint = (UseAlternate) ? ((PairOne) ? 94 : 95) : ((PairTwo) ? 91 : 56);
	NewUnitState.kAppearance.iArmorTintSecondary = 70; 
    NewUnitState.kAppearance.iWeaponTint = 94; //no gun metal grey bullshit, JUST BLACK https://www.youtube.com/watch?v=pAgnJDJN4VA 
	NewGameState.AddStateObject(NewUnitState);


	if(!NewGameState.GetContext().IsStartState())
		{
			ResistanceHQ = XComGameState_HeadquartersResistance(NewGameState.CreateStateObject(class'XComGameState_HeadquartersResistance', ResistanceHQ.ObjectID));
			NewGameState.AddStateObject(ResistanceHQ);
		}


 	    ResistanceHQ = XComGameState_HeadquartersResistance(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersResistance'));
	    NewUnitState.ApplyInventoryLoadout(NewGameState);
		StartingRank = NewUnitState.GetRank(); //this is so in case we get an unit that already starts off with a class
		NewRank = GetPersonnelRewardRank(true, (RewardState.GetMyTemplateName() == 'Reward_MTF')); 
		NewUnitState.SetXPForRank(NewRank);
		NewUnitState.StartingRank = NewRank;
		NewUnitState.RankUpSoldier(NewGameState, 'MTFChief'); //||NO MATTER WHATEVER THE FUCK HAPPENS, THIS FUCKING GUY'S CLASS HAS TO BE THE CHIEF||
		for(idx = StartingRank; idx < NewRank; idx++)
		{
			// Rank up to squaddie if this is an unit that starts off as a rookie
			if(idx == 0)
			{   
				NewUnitState.RankUpSoldier(NewGameState, 'MTFChief'); //||NO MATTER WHATEVER THE FUCK HAPPENS, THIS FUCKING GUY'S CLASS HAS TO BE THE CHIEF||
				NewUnitState.ApplySquaddieLoadout(NewGameState);
				NewUnitState.bNeedsNewClassPopup = true;
			}
			else
			{
				NewUnitState.RankUpSoldier(NewGameState, 'MTFChief'); //||NO MATTER WHATEVER THE FUCK HAPPENS, THIS FUCKING GUY'S CLASS HAS TO BE THE CHIEF||
			}
		}
		//class'XGCharacterGenerator_MTFSoldier'.static.TSoldier_CreateTSoldier(KSoldier);

		RewardState.RewardObjectReference = NewUnitState.GetReference();
}

static function XComGameState_Unit CreateMTFPersonnelUnit(XComGameState NewGameState, name nmCharacter, name nmCountry, optional bool bIsRookie) //That's my bootleg version of CreatePersonnelUnit function, that is set to give the soldier class of mtf chief no matter what
{
	local XComGameStateHistory History;
	local XComGameState_Unit NewUnitState;
	local XComGameState_HeadquartersXCom XComHQ;
	local XComGameState_HeadquartersResistance ResistanceHQ;
	local int idx, NewRank, StartingIdx;
	//local bool UseAlternate;

	History = `XCOMHISTORY;

	
	//Use the character pool's creation method to retrieve a unit
	NewUnitState = `CHARACTERPOOLMGR.CreateCharacter(NewGameState, `XPROFILESETTINGS.Data.m_eCharPoolUsage, nmCharacter, nmCountry);
	NewUnitState.RandomizeStats();

	//UseAlternate = `SYNC_RAND(100) > 50;

	if (NewUnitState.IsSoldier())
	{
		XComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
		ResistanceHQ = XComGameState_HeadquartersResistance(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersResistance'));

		if (!NewGameState.GetContext().IsStartState())
		{
			ResistanceHQ = XComGameState_HeadquartersResistance(NewGameState.ModifyStateObject(class'XComGameState_HeadquartersResistance', ResistanceHQ.ObjectID));
		}

		NewUnitState.ApplyInventoryLoadout(NewGameState);
		NewRank = GetPersonnelRewardRank(true, bIsRookie);
		NewUnitState.SetXPForRank(NewRank);
		NewUnitState.StartingRank = NewRank;
		StartingIdx = 0;

		if(NewUnitState.GetMyTemplate().DefaultSoldierClass != '' && NewUnitState.GetMyTemplate().DefaultSoldierClass != class'X2SoldierClassTemplateManager'.default.DefaultSoldierClass)
		{
			// Some character classes start at squaddie on creation
			StartingIdx = 1;
		}

		for (idx = StartingIdx; idx < NewRank; idx++)
		{
			// Rank up to squaddie
			if (idx == 0)
			{
				NewUnitState.RankUpSoldier(NewGameState, 'MTFChief'); //Make sure the soldier is MTF Chief
				NewUnitState.ApplySquaddieLoadout(NewGameState);
				NewUnitState.bNeedsNewClassPopup = false;
			}
			else
			{
				NewUnitState.RankUpSoldier(NewGameState, 'MTFChief'); //(UseAlternate) ? 'MTFChief' : 'Ranger' ); //Make sure the soldier is MTF Chief
			}
		}

		// Set an appropriate fame score for the unit
		NewUnitState.StartingFame = XComHQ.AverageSoldierFame;
		NewUnitState.bIsFamous = true;
		`XEVENTMGR.TriggerEvent('RewardUnitGenerated', NewUnitState, NewUnitState); //issue #185 - fires off event with unit after they've been promoted to their reward rank
	}
	else
	{
		NewUnitState.SetSkillLevel(GetPersonnelRewardRank(false));
	}

	return NewUnitState;
}

//function GenerateAUPersonnelReward(XComGameState_Reward RewardState, XComGameState NewGameState, optional float RewardScalar = 1.0, optional StateObjectReference RegionRef)
//{
	//local XComGameState_HeadquartersResistance ResistanceHQ;
	//local XComGameStateHistory History;
	//local XComGameState_Unit NewUnitState;
	//local XComGameState_WorldRegion RegionState;
	//local int idx, NewRank, StartingRank;
	//local name nmCountry;
	//local AU_X2SpeciesTuple_Template SpeciesTemplate;
//

	//if(RewardState.GetMyTemplate().rewardObjectTemplateName == 'RewardAURookies' || RewardState.GetMyTemplate().rewardObjectTemplateName == 'RewardAUSoldier')
	//{ 
		//SpeciesTemplate = class'AU_X2SpeciesHelpers'.static.GetRewardSpecies();
	//}
	//if(RewardState.GetMyTemplate().rewardObjectTemplateName == 'MarketAUSoldier')
	//{
		//SpeciesTemplate = class'AU_X2SpeciesHelpers'.static.GetMarketSpecies();
	//}
//
	//if(SpeciesTemplate == none) //just in case neither of the above didn't proc
	//{
		//SpeciesTemplate = class'AU_X2SpeciesHelpers'.static.GetRewardSpecies(true);
	//}

	//if(SpeciesTemplate == none) //and if THAT didn't work...
	//{
		//SpeciesTemplate.TemplateName = 'MTFSoldier'; //just use a Foundation soldier instead
	//}

//
	//History = `XCOMHISTORY;
//
	//// Grab the region and pick a random country
	//nmCountry = '';
	//RegionState = XComGameState_WorldRegion(History.GetGameStateForObjectID(RegionRef.ObjectID));
//
	//if(RegionState != none)
	//{
		//nmCountry = RegionState.GetMyTemplate().GetRandomCountryInRegion();
	//}
//
	////Use the character pool's creation method to retrieve a unit
	//NewUnitState = `CHARACTERPOOLMGR.CreateCharacter(NewGameState, `XPROFILESETTINGS.Data.m_eCharPoolUsage, SpeciesTemplate.TemplateName, nmCountry);
	//NewUnitState.RandomizeStats();
	//NewGameState.AddStateObject(NewUnitState);
//
//
		//ResistanceHQ = XComGameState_HeadquartersResistance(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersResistance'));
//
		//if(!NewGameState.GetContext().IsStartState())
		//{
			//ResistanceHQ = XComGameState_HeadquartersResistance(NewGameState.CreateStateObject(class'XComGameState_HeadquartersResistance', ResistanceHQ.ObjectID));
			//NewGameState.AddStateObject(ResistanceHQ);
		//}
		//
		//NewUnitState.ApplyInventoryLoadout(NewGameState);
		//StartingRank = NewUnitState.GetRank(); //this is so in case we get an alien that already starts off with a class
		//NewRank = GetPersonnelRewardRank(true, (RewardState.GetMyTemplateName() == 'Reward_AU_Soldier'));
		//NewUnitState.SetXPForRank(NewRank);
		//NewUnitState.StartingRank = NewRank;
		//NewUnitState.RankUpSoldier(NewGameState, 'MTFChief');
		//for(idx = StartingRank; idx < NewRank; idx++)
		//{
			//// Rank up to squaddie if this is an alien that starts off as a rookie
			//if(idx == 0)
			//{   
				//NewUnitState.RankUpSoldier(NewGameState, 'MTFChief');
				//NewUnitState.ApplySquaddieLoadout(NewGameState);
				//NewUnitState.bNeedsNewClassPopup = false;
			//}
			//else
			//{
				//NewUnitState.RankUpSoldier(NewGameState, 'MTFChief');
			//}
		//}
	//
//
//
	//RewardState.RewardObjectReference = NewUnitState.GetReference();
//}

static function GiveSpectrePersonnelReward(XComGameState NewGameState, XComGameState_Reward RewardState, optional StateObjectReference AuxRef, optional bool bOrder = false, optional int OrderHours = -1)
{
	local XComGameState_CovertAction ActionState;
	local XComGameState_ResistanceFaction FactionState;

	GivePersonnelReward(NewGameState, RewardState, AuxRef, bOrder, OrderHours);
	
	ActionState = XComGameState_CovertAction(`XCOMHISTORY.GetGameStateForObjectID(AuxRef.ObjectID));
	FactionState = XComGameState_ResistanceFaction(`XCOMHistory.GetGameStateForObjectID(ActionState.Faction.ObjectID));

	// If the player is rewarded a soldier for an non-met faction, meet them. This is the code path for the "Find Faction" covert action
	// Late game Covert Actions which reward faction soldiers will only be for previously met factions
	if (FactionState != none && !FactionState.bMetXCom)
	{
		FactionState = XComGameState_ResistanceFaction(NewGameState.ModifyStateObject(class'XComGameState_ResistanceFaction', FactionState.ObjectID));
		FactionState.MeetXCom(NewGameState); // Don't give a Faction soldier since we were just rewarded one
	}
}

static function X2DataTemplate CreateFactionInfluenceRewardTemplate()
{
	local X2RewardTemplate Template;

	`CREATE_X2Reward_TEMPLATE(Template, 'Reward_FoundationFactionInfluence');

	Template.IsRewardAvailableFn = IsFactionInfluenceRewardAvailable;
	Template.GenerateRewardFn = GenerateFoundationFactionInfluenceReward;
	Template.GiveRewardFn = GiveFoundationFactionInfluenceReward;
	//Template.GetRewardImageFn = GetFactionInfluenceRewardImage;
	//Template.GetRewardStringFn = GetFactionInfluenceRewardString;
	Template.CleanUpRewardFn = CleanUpRewardWithoutRemoval;
	Template.RewardPopupFn = FoundationInfluenceRewardPopup;

	return Template;
}

static function bool IsFactionInfluenceRewardAvailable(optional XComGameState NewGameState, optional StateObjectReference AuxRef)
{
    local XComGameState_ResistanceFaction       FactionState;
    local XComGameStateHistory                  History;
    local XComGameState_SCPResistanceFaction	FoundationState;
    FoundationState = class'Foundation_X2Helpers'.static.GetNewFoundationState(NewGameState);
	History = `XCOMHISTORY;

	FactionState = GetFactionState(NewGameState, AuxRef);
	if(FactionState != none)
	{      
	    if ( FactionState.GetMyTemplateName() == 'Faction_Foundation')
		{   
		    foreach History.IterateByClassType(class'XComGameState_SCPResistanceFaction', FoundationState)
	        {
	           if(FoundationState.Influence != eFactionInfluence_Influential)
	           {
	                     return true;
	           } 
	           else
	           {
	                     return false;   //this shouldn't be used by the game at all //yeah whatever reality you're not my dad
               }
            }
        }
    }
}

//static function bool IsFoundationGearRewardAvailable(optional XComGameState NewGameState, optional StateObjectReference AuxRef)
//{
	//local XComGameState_ResistanceFaction FactionState;
//
	//FactionState = GetFactionState(NewGameState, AuxRef); //return false if this is a covert action and is not from the Foundation. Else, return true.
	//if (FactionState != none)
	//{
		//if ( FactionState.GetMyTemplateName() != 'Faction_Foundation')
		//{
			//return false; // only for Foundation
		//}
//
		//return FactionState.bMetXCom;
	//}
//
	//return true;
//}

static function GenerateFoundationFactionInfluenceReward(XComGameState_Reward RewardState, XComGameState NewGameState, optional float RewardScalar = 1.0, optional StateObjectReference AuxRef)
{
	RewardState.RewardObjectReference = AuxRef; //hold the faction state here
}

static function GiveFoundationFactionInfluenceReward(XComGameState NewGameState, XComGameState_Reward RewardState, optional StateObjectReference AuxRef, optional bool bOrder = false, optional int OrderHours = -1)
{
    local XComGameState_SCPResistanceFaction FoundationState;
	local XComGameState_ResistanceFaction FactionState;
	
	FactionState = XComGameState_ResistanceFaction(NewGameState.ModifyStateObject(class'XComGameState_ResistanceFaction', RewardState.RewardObjectReference.ObjectID));
	FactionState.IncreaseInfluenceLevel(NewGameState);
}

static function string GetFactionInfluenceRewardString(XComGameState_Reward RewardState)
{
	local XComGameState_ResistanceFaction FactionState;
	local XGParamTag kTag;

	FactionState = XComGameState_ResistanceFaction(`XCOMHistory.GetGameStateForObjectID(RewardState.RewardObjectReference.ObjectID));

	kTag = XGParamTag(`XEXPANDCONTEXT.FindTag("XGParam"));
	kTag.StrValue0 = FactionState.GetFactionName();
	kTag.IntValue0 = RewardState.Quantity;

	return `XEXPAND.ExpandString(class'X2StrategyElement_XpackRewards'.default.RewardFactionInfluence);
}


//---------------------------------------------------------------------------------------
static function XComGameState_HeadquartersXCom GetNewXComHQState(XComGameState NewGameState)
{
	local XComGameState_HeadquartersXCom NewXComHQ;

	foreach NewGameState.IterateByClassType(class'XComGameState_HeadquartersXCom', NewXComHQ)
	{
		break;
	}

	if(NewXComHQ == none)
	{
		NewXComHQ = XComGameState_HeadquartersXCom(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
		NewXComHQ = XComGameState_HeadquartersXCom(NewGameState.ModifyStateObject(class'XComGameState_HeadquartersXCom', NewXComHQ.ObjectID));
	}

	return NewXComHQ;
}