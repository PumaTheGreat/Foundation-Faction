class XComGameState_SCPResistanceFaction extends XComGameState_ResistanceFaction;

//---------------------------------------------------------------------------------------
simulated function X2ResistanceFactionTemplate GetMyTemplate()
{ 
	if(m_Template == none)
	{
		m_Template = X2SCPResistanceFactionTemplate(GetMyTemplateManager().FindStrategyElementTemplate(m_TemplateName));
	}
	return m_Template;
}

//---------------------------------------------------------------------------------------
event OnCreation(optional X2DataTemplate Template)
{
	local int idx;

	super.OnCreation( Template );

	m_Template = X2ResistanceFactionTemplate(Template);
	m_TemplateName = Template.DataName;

	for(idx = 0; idx < default.StartingCardSlots; idx++)
	{
		// Add Slots with empty entries
		AddCardSlot();
	}
}
//---------------------------------------------------------------------------------------
private function AddFactionEquipmentToInventory(XComGameState NewGameState)
{
 //override so this does nothing
}
//---------------------------------------------------------------------------------------
private function DisplayResistancePlaque(XComGameState NewGameState)
{
 //override so this does nothing
}

//---------------------------------------------------------------------------------------
function bool IsFactionSoldierRewardAllowed(XComGameState NewGameState)
{
	// nope
	return false;
}

//---------------------------------------------------------------------------------------
function bool IsExtraFactionSoldierRewardAllowed(XComGameState NewGameState)
{
	//nope
	return false;
}

//function TryIncreaseInfluence()
//{
    //local XComGameState_ResistanceFaction FactionState;
	//local XComGameStateHistory History;
	//local name CompletedAction;
	//local XComGameState_CovertAction ActionState;
	//local StateObjectReference ActionRef;
	//local XComGameState NewGameState;
	//local X2RewardTemplate RewardTemplate;
	//local X2StrategyElementTemplateManager StratMgr;
	//local XComGameState_Reward RewardState;
	//local XComGameState_SCPResistanceFaction Foundation;
	//History = `XCOMHISTORY;
//
    //foreach FactionState.CompletedCovertActions(CompletedAction) //we look here to see if the covert action we're looking for has been completed
	//{
	//if(CompletedAction == 'CovertAction_LongerStay')
	 //{NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("ResistanceFactionScpFoundation: Increasing Influence");
		//Foundation = XComGameState_SCPResistanceFaction(NewGameState.ModifyStateObject(class'XComGameState_SCPResistanceFaction', self.ObjectID));
		//StratMgr = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();
		//
		//RewardTemplate = X2RewardTemplate(StratMgr.FindStrategyElementTemplate('Reward_FoundationFactionInfluence'));
		//
		//RewardState = RewardTemplate.CreateInstanceFromTemplate(NewGameState);
		//RewardState.GetMyTemplate().GenerateRewardFn(RewardState, NewGameState,,GetReference()); 
		//RewardState.GiveReward(NewGameState, GetReference());
		//
		//// This method creates and submits another new game state
		//RewardState.DisplayRewardPopup();
	 //}
	 //
	//}
//}

//#############################################################################################
//-----------------   COVERT ACTIONS  ---------------------------------------------------------
//#############################################################################################

//---------------------------------------------------------------------------------------
// Creates the Golden Path actions for the Faction, if they do not already exist
function CreateGoldenPathActions(XComGameState NewGameState)
{
	local X2StrategyElementTemplateManager StratMgr;
	local array<X2StrategyElementTemplate> AllActionTemplates;
	local X2StrategyElementTemplate DataTemplate;
	local X2CovertActionTemplate ActionTemplate;

	// Only perform this setup if there's no more GP actions remaining
	if (GoldenPathActions.Length == 0)
	{
		StratMgr = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();
		AllActionTemplates = StratMgr.GetAllTemplatesOfClass(class'X2CovertActionTemplate');

		foreach AllActionTemplates(DataTemplate)
		{
			ActionTemplate = X2CovertActionTemplate(DataTemplate);

			if(ActionTemplate.DataName == 'CovertAction_FindFaction')
				continue; //actively skip this one

			if (ActionTemplate != none && ActionTemplate.bGoldenPath) //we do this so we follow the requirements of Spectres' med to high requirement
			{
				GoldenPathActions.AddItem(CreateCovertAction(NewGameState, ActionTemplate, ActionTemplate.RequiredFactionInfluence));
			}
		}
	}
}


simulated function string GetUIButtonIcon()
{
	
	return GetFactionIcon().Images[0]; //we only have the one image
}
