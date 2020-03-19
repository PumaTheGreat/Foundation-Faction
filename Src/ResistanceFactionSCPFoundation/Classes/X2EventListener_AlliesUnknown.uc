class X2EventListener_AlliesUnknown extends X2EventListener config(AlliesUnknown);

var localized string IntelRebateTitle;
var localized string IntelRebate;

var localized string EngineerRebateTitle;
var localized string EngineerRebate;

var config array<float> MediumInfluenceBonus; //first level discount for gray market
var config array<float> HighInfluenceBonus; //second level discount for gray market


static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem(AlliesUnknownIntelRebate());
	Templates.AddItem(AlliesUnknownEngiRebate());
	Templates.AddItem(ContinueFactionHQReveal());
	//Templates.AddItem(UpgradeGrayMarketDiscount());

	Templates.AddItem(ShortcutMenuAdd());

	return Templates;
}


// covert action check
static function CHEventListenerTemplate ShortcutMenuAdd()
{
	local CHEventListenerTemplate Template;

	`CREATE_X2TEMPLATE(class'CHEventListenerTemplate', Template, 'Foundation_ShortcutMenuAdd');
	//explanation: vanilla X2EvenetLIstenerTemplates do not specify deferrals, instead always being on ELD_OnStateSubmitted.
	//PCSes need to engage as soon as possible, so we use the CH highlander instead.

	Template.RegisterInStrategy = true;
	Template.AddCHEvent('UpdateResources', FoundationShortcutMenuAddListener, ELD_Immediate); // we can use this to alter the avenger menu shortcuts

	return Template;
}
static protected function EventListenerReturn FoundationShortcutMenuAddListener(Object EventData, Object EventSource, XComGameState GameState, Name Event, Object CallbackData)
{
	//class'XComGameState_ExtraspeciesRecruits'.static.GetRecruitManager().EnableRecruitMenu();

	return ELR_NoInterrupt;
}
//static function X2EventListenerTemplate UpgradeGrayMarketDiscount()
//{
	//local X2EventListenerTemplate Template;
//
	//`CREATE_X2TEMPLATE(class'X2EventListenerTemplate', Template, 'AU_UpgradeGrayMarketDiscount');
	//Template.RegisterInStrategy = true;
	//Template.AddEvent('FactionInfluenceIncreased', DoGrayMarketDiscount);
//
	//return Template;
//}

//static protected function EventListenerReturn DoGrayMarketDiscount(Object EventData, Object EventSource, XComGameState GameState, Name Event, Object CallbackData)
//{
	//local XComGameState_ResistanceFaction FactionState;
	//local XComGameState_ExtraspeciesRecruits RecruitMgr;
	//local XComGameState NewGameState;
	//local XComGameStateHistory History;
	//local int i, j, ItemCost;
	//History = `XCOMHistory;
	//FactionState = XComGameState_ResistanceFaction(EventData);
	//RecruitMgr = XComGameState_ExtraspeciesRecruits(History.GetSingleGameStateObjectForClass(class'XComGameState_ExtraspeciesRecruits'));
//
	//if(FactionState == none || RecruitMgr == none || History == none) //bad data
		//return ELR_NoInterrupt;
//
	//if(FactionState.GetMyTemplateName() != 'Faction_Foundation')
		//return ELR_NoInterrupt;
//
	//if(FactionState.GetInfluence() == eFactionInfluence_Respected)
	//{
		//NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Adding Influence Upgrade");
		//RecruitMgr = XComGameState_ExtraspeciesRecruits(NewGameState.ModifyStateObject(class'XComGameState_ExtraspeciesRecruits', RecruitMgr.ObjectID));
//
		//if(RecruitMgr.GetGrayMarketScalar()  != 1.0) //zero it out for safety reasons
		//{
			//RecruitMgr.GreyMarketScalar = 0;
		//}
//
		//RecruitMgr.GreyMarketScalar = `ScaleStrategyArrayFloat(default.MediumInfluenceBonus);
//
		//for(i = 0; i < RecruitMgr.IntelItems.Length; i++)
		//{
			//ItemCost = RecruitMgr.IntelItems[i].Cost.ResourceCosts[0].Quantity; //we know there's only the one quantity to worry about
//
			//ItemCost *= RecruitMgr.GetGrayMarketScalar();
//
			//if(ItemCost > 0)
				//RecruitMgr.IntelItems[i].Cost.ResourceCosts[0].Quantity = ItemCost;
		//}
//
		//for(i = 0; i < RecruitMgr.ResistanceGoods.Length; i++)
		//{
			//ItemCost = RecruitMgr.ResistanceGoods[i].Cost.ResourceCosts[0].Quantity; //we know there's only the one quantity to worry about
//
			//ItemCost *= RecruitMgr.GetGrayMarketScalar();
//
			//if(ItemCost > 0)
				//RecruitMgr.ResistanceGoods[i].Cost.ResourceCosts[0].Quantity = ItemCost;
		//}
	//}


	//if(FactionState.GetInfluence() == eFactionInfluence_Influential)
	//{
		//NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Adding Influence Upgrade");
		//RecruitMgr = XComGameState_ExtraspeciesRecruits(NewGameState.ModifyStateObject(class'XComGameState_ExtraspeciesRecruits', RecruitMgr.ObjectID));
//
		//if(RecruitMgr.GetGrayMarketScalar() != 1.0) //zero it out for safety reasons
		//{
			//RecruitMgr.GreyMarketScalar = 0;
		//}
//
		//RecruitMgr.GreyMarketScalar = `ScaleStrategyArrayFloat(default.HighInfluenceBonus);
//
//
		//for(j = 0; j < RecruitMgr.IntelItems.Length; j++)
		//{
			//ItemCost = RecruitMgr.IntelItems[j].Cost.ResourceCosts[0].Quantity;
//
			//ItemCost *= RecruitMgr.GetGrayMarketScalar();
//
			//if(ItemCost > 0)
				//RecruitMgr.IntelItems[j].Cost.ResourceCosts[0].Quantity = ItemCost;
		//}
//
//
		//for(j = 0; j < RecruitMgr.ResistanceGoods.Length; j++)
		//{
			//ItemCost = RecruitMgr.ResistanceGoods[j].Cost.ResourceCosts[0].Quantity;
//
			//ItemCost *= RecruitMgr.GetGrayMarketScalar();
//
			//if(ItemCost > 0)
				//RecruitMgr.ResistanceGoods[j].Cost.ResourceCosts[0].Quantity = ItemCost;
		//}
//
	//}
//
	//if(NewGameState != none)
	//{
		//`XCOMGAME.GameRuleset.SubmitGameState(NewGameState);
	//}
//
	//return ELR_NoInterrupt;
//}
//
static function X2EventListenerTemplate ContinueFactionHQReveal()
{
	local X2EventListenerTemplate Template;

	`CREATE_X2TEMPLATE(class'X2EventListenerTemplate', Template, 'Foundation_FactionHQReveal');
	Template.RegisterInStrategy = true;
	Template.AddEvent('RevealHQ_Foundation', ResumeFactionHQReveal);

	return Template;
}

static function X2EventListenerTemplate AlliesUnknownEngiRebate()
{
	local X2EventListenerTemplate Template;

	`CREATE_X2TEMPLATE(class'X2EventListenerTemplate', Template, 'AU_EngiRebate');
	Template.RegisterInStrategy = true;
	Template.AddEvent('ResearchCompleted', GiveEngineerRebate);
	Template.AddEvent('ItemConstructionCompleted', GiveEngineerRebate);

	return Template;
}

static function X2EventListenerTemplate AlliesUnknownIntelRebate()
{
	local X2EventListenerTemplate Template;

	`CREATE_X2TEMPLATE(class'X2EventListenerTemplate', Template, 'AU_IntelRebate');
	Template.RegisterInStrategy = true;
	Template.AddEvent('ResearchCompleted', GiveIntelRebate);

	return Template;
}


static protected function EventListenerReturn GiveIntelRebate(Object EventData, Object EventSource, XComGameState GameState, Name Event, Object CallbackData)
{
	local XComGameState_Tech TechState;
	local XComGameState NewGameState;
	local XComGameStateHistory History;
	local XComGameState_HeadquartersResistance ResHQ;
	local array<StateObjectReference> ListCards;
	local StateObjectReference PolicyRef;
	local XComGameState_StrategyCard PolicyState;
	local bool HasResCard;
	local int IntelAmount;
	local XGParamTag kTag;
	local XComGameState_HeadquartersXCom XComHQ;

	TechState = XComGameState_Tech(EventData);
	ResHQ = class'UIUtilities_Strategy'.static.GetResistanceHQ();
	HasResCard = false;

	if(ResHQ == none || TechState == none ) //bad data, ignore
		return ELR_NoInterrupt;

	if(TechState.IntelReward <= 0) //ignore if not tech decryption
		return ELR_NoInterrupt;


	ListCards = ResHQ.GetAllPlayedCards(false);
	History = `XCOMHISTORY;

	foreach ListCards( PolicyRef )
	{
		if (PolicyRef.ObjectID == 0)
			continue;

		PolicyState = XComGameState_StrategyCard(History.GetGameStateForObjectID( PolicyRef.ObjectID ) );

		if(PolicyState.GetMyTemplateName() == 'ResCard_XenoIntelligence')
		{
			HasResCard = true;
			break;
		}
	}

	if(!HasResCard)
		return ELR_NoInterrupt;

	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Adding Intel Rebate");


	foreach NewGameState.IterateByClassType(class'XComGameState_HeadquartersXCom', XComHQ)
	{
		break;
	}

	if(XComHQ == none)
	{
		XComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
		XComHQ = XComGameState_HeadquartersXCom(NewGameState.ModifyStateObject(class'XComGameState_HeadquartersXCom', XComHQ.ObjectID));
	}

	kTag = XGParamTag(`XEXPANDCONTEXT.FindTag("XGParam"));
	if(TechState != none && TechState.IntelReward > 0)
	{
		IntelAmount = TechState.IntelReward * GetXenoIntelBonus(XComHQ);

		if(IntelAmount <= 0)
			IntelAmount = 1; //safety check;


		kTag.IntValue0 = IntelAmount;
		XComHQ.AddResource(NewGameState, 'Intel', IntelAmount);
	}


	`HQPRES.NotifyBanner(default.IntelRebateTitle, "img:///UILibrary_XPACK_Common.WorldMessage", default.IntelRebateTitle, `XEXPAND.ExpandString(default.IntelRebate),  eUIState_Good);
	`XCOMGAME.GameRuleset.SubmitGameState(NewGameState);

	return ELR_NoInterrupt;
}

static function float GetXenoIntelBonus(XComGameState_HeadquartersXCom XComHQ)
{
	local float InitBonus, SciBonus;

	InitBonus = `ScaleStrategyArrayFloat(class'X2StrategyElement_AUResistanceActions'.default.XenoIntelBonus);

	SciBonus = XComHQ.GetNumberOfScientists() * `ScaleStrategyArrayFloat(class'X2StrategyElement_AUResistanceActions'.default.XenoIntelSciBonus);

	return InitBonus + SciBonus;
}

static protected function EventListenerReturn GiveEngineerRebate(Object EventData, Object EventSource, XComGameState GameState, Name Event, Object CallbackData)
{
	local XComGameState_Tech TechState;
	local XComGameState NewGameState;
	local XComGameState_Item ItemState;
	local XComGameStateHistory History;
	local XComGameState_HeadquartersResistance ResHQ;
	local array<StateObjectReference> ListCards;
	local StateObjectReference PolicyRef;
	local XComGameState_StrategyCard PolicyState;
	local bool HasResCard, HasUpgradedVariant;
	local X2ItemTemplate ItemTemplate;
	local X2TechTemplate TechTemplate;
	local ArtifactCost Resources;
	local array<ArtifactCost> AllResources;
	local XGParamTag kTag;
	local XComGameState_HeadquartersXCom XComHQ;

	TechState = XComGameState_Tech(EventData);
	ItemState = XComGameState_Item(EventSource);
	ResHQ = class'UIUtilities_Strategy'.static.GetResistanceHQ();
	HasResCard = false;
	HasUpgradedVariant = false;
	if(ResHQ == none || (TechState == none && ItemState == none)) //bad data, ignore
		return ELR_NoInterrupt;

	ListCards = ResHQ.GetAllPlayedCards(false);
	History = `XCOMHISTORY;

	foreach ListCards( PolicyRef )
	{
		if (PolicyRef.ObjectID == 0)
			continue;

		PolicyState = XComGameState_StrategyCard(History.GetGameStateForObjectID( PolicyRef.ObjectID ) );

		if(PolicyState.GetMyTemplateName() == 'ResCard_XenoEngineeringI')
		{
			HasResCard = true;
			break;
		}
		if(PolicyState.GetMyTemplateName() == 'ResCard_XenoEngineeringII' )
		{
			HasUpgradedVariant = true;
			HasResCard = true;
			break;
		}
	}

	if(!HasResCard)
		return ELR_NoInterrupt;

	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Adding Engineer Rebate");


	foreach NewGameState.IterateByClassType(class'XComGameState_HeadquartersXCom', XComHQ)
	{
		break;
	}

	if(XComHQ == none)
	{
		XComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
		XComHQ = XComGameState_HeadquartersXCom(NewGameState.ModifyStateObject(class'XComGameState_HeadquartersXCom', XComHQ.ObjectID));
	}

	kTag = XGParamTag(`XEXPANDCONTEXT.FindTag("XGParam"));
	kTag.IntValue0 = 0;
	kTag.IntValue1 = 0;
	kTag.IntValue2 = 0;
	if(TechState != none)
	{
		TechTemplate = TechState.GetMyTemplate();
		
		AllResources = TechTemplate.Cost.ResourceCosts;

		foreach AllResources(Resources)
		{
			if(HasUpgradedVariant && IsValid(Resources))
			{
				XComHQ.AddResource(NewGameState, Resources.ItemTemplateName, Resources.Quantity * GetValueXenoEngineeringII());
				
				if(Resources.ItemTemplateName == 'AlienAlloy')
					kTag.IntValue0 = (Resources.Quantity * GetValueXenoEngineeringII());

				if(Resources.ItemTemplateName == 'EleriumDust')
					kTag.IntValue1 = (Resources.Quantity * GetValueXenoEngineeringII());

				if(Resources.ItemTemplateName == 'Supplies')
					kTag.IntValue2 = (Resources.Quantity * GetValueXenoEngineeringII());
			}

			if(!HasUpgradedVariant && IsValid(Resources))
			{
				XComHQ.AddResource(NewGameState, Resources.ItemTemplateName, Resources.Quantity * GetValueXenoEngineeringI());

				if(Resources.ItemTemplateName == 'AlienAlloy')
					kTag.IntValue0 = (Resources.Quantity * GetValueXenoEngineeringI());

				if(Resources.ItemTemplateName == 'EleriumDust')
					kTag.IntValue1 = (Resources.Quantity * GetValueXenoEngineeringI());

				if(Resources.ItemTemplateName == 'Supplies')
					kTag.IntValue2 = (Resources.Quantity * GetValueXenoEngineeringI());
			}

		}
	}

	if(ItemState != none)
	{
		ItemTemplate = ItemState.GetMyTemplate();

		AllResources = ItemTemplate.Cost.ResourceCosts;

		foreach AllResources(Resources)
		{
			if(HasUpgradedVariant && IsValid(Resources))
			{
				XComHQ.AddResource(NewGameState, Resources.ItemTemplateName, Resources.Quantity * GetValueXenoEngineeringII());

				if(Resources.ItemTemplateName == 'AlienAlloy')
					kTag.IntValue0 = (Resources.Quantity * GetValueXenoEngineeringII());

				if(Resources.ItemTemplateName == 'EleriumDust')
					kTag.IntValue1 = (Resources.Quantity * GetValueXenoEngineeringII());

				if(Resources.ItemTemplateName == 'Supplies')
					kTag.IntValue2 = (Resources.Quantity * GetValueXenoEngineeringII());
			}

			if(!HasUpgradedVariant && IsValid(Resources))
			{
				XComHQ.AddResource(NewGameState, Resources.ItemTemplateName, Resources.Quantity * GetValueXenoEngineeringI());

				if(Resources.ItemTemplateName == 'AlienAlloy')
					kTag.IntValue0 = (Resources.Quantity * GetValueXenoEngineeringI());

				if(Resources.ItemTemplateName == 'EleriumDust')
					kTag.IntValue1 = (Resources.Quantity * GetValueXenoEngineeringI());

				if(Resources.ItemTemplateName == 'Supplies')
					kTag.IntValue2 = (Resources.Quantity * GetValueXenoEngineeringI());
			}

		}
	}


	if(kTag.IntValue0 > 0 || kTag.IntValue0 > 0 || kTag.IntValue2 > 0 )
	{ 
		`HQPRES.NotifyBanner(default.EngineerRebateTitle, "img:///UILibrary_XPACK_Common.WorldMessage", default.EngineerRebateTitle, `XEXPAND.ExpandString(default.EngineerRebate),  eUIState_Good);
	}
	`XCOMGAME.GameRuleset.SubmitGameState(NewGameState);

	return ELR_NoInterrupt;
}

static function bool IsValid(ArtifactCost Resources)
{
	if(Resources.ItemTemplateName == 'Supplies')
		return true;

	if(Resources.ItemTemplateName == 'EleriumDust')
		return true;

	if(Resources.ItemTemplateName == 'AlienAlloy')
		return true;

	return false;

}

//---------------------------------------------------------------------------------------
static function float GetValueXenoEngineeringI()
{
	return `ScaleStrategyArrayFloat(class'X2StrategyElement_AUResistanceActions'.default.RebateBonus);
}

//---------------------------------------------------------------------------------------
static function float GetValueXenoEngineeringII()
{
	return `ScaleStrategyArrayFloat(class'X2StrategyElement_AUResistanceActions'.default.RebateIIBonus);
}

static protected function EventListenerReturn ResumeFactionHQReveal(Object EventData, Object EventSource, XComGameState GameState, Name Event, Object CallbackData)
{
	`HQPRES.FactionRevealPlayClassIntroMovie();

	return ELR_NoInterrupt;
}

