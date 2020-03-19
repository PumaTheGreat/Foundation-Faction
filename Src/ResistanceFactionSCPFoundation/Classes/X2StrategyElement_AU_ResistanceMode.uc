//---------------------------------------------------------------------------------------
//  FILE:    X2StrategyElement_DefaultResistanceModes.uc
//  AUTHOR:  Joe Weinhoffer
//           
//---------------------------------------------------------------------------------------
//  Copyright (c) 2016 Firaxis Games, Inc. All rights reserved.
//---------------------------------------------------------------------------------------
class X2StrategyElement_AU_ResistanceMode extends X2StrategyElement_DefaultResistanceModes
	config(GameData);
//
////var config array<float>					WillRecoveryModeRateScalar;
////var config array<float>					ResearchCostModeRateScalar;
var config array<float>					ProvingGroundModeRateScalar;
//
////---------------------------------------------------------------------------------------
//static function array<X2DataTemplate> CreateTemplates()
//{
	//local array<X2DataTemplate> Modes;
//
	//Modes.AddItem(CreateWillRecoveryModeTemplate());
//
	//return Modes;
//}
//
////---------------------------------------------------------------------------------------
//static function X2DataTemplate CreateWillRecoveryModeTemplate()
//{
	//local X2ResistanceModeTemplate Template;
//
	//`CREATE_X2TEMPLATE(class'X2ResistanceModeTemplate', Template, 'ResistanceMode_ResearchSpeed');
	//Template.Category = "ResistanceMode";
	//Template.ImagePath = "img:///UILibrary_StrategyImages.X2StrategyMap.ResHQ_Medical";
	//Template.OnActivatedFn = ActivateWillMode;
	//Template.OnDeactivatedFn = DeactivateWillMode;
	//Template.OnXCOMArrivesFn = OnXCOMArrivesWillMode;
	//Template.OnXCOMLeavesFn = OnXCOMLeavesWillMode;
//
	//return Template;
//}
////---------------------------------------------------------------------------------------
//static function ActivateWillMode(XComGameState NewGameState, StateObjectReference InRef, optional bool bReactivate = false)
//{
	//// The Avenger is already at ResHQ, so activate it immediately
	//OnXCOMArrivesWillMode(NewGameState, InRef);
//}
////---------------------------------------------------------------------------------------
//static function DeactivateWillMode(XComGameState NewGameState, StateObjectReference InRef)
//{
	//// The Avenger is already at ResHQ, so deactivate it immediately
	//OnXCOMLeavesWillMode(NewGameState, InRef);
//}
////---------------------------------------------------------------------------------------
//static function OnXCOMArrivesWillMode(XComGameState NewGameState, StateObjectReference InRef)
//{
	//local XComGameState_HeadquartersXCom XComHQ;
	//local XComGameState_HeadquartersResistance ResistanceHQ;
//
	//XComHQ = GetNewXComHQState(NewGameState);
	//if (XComHQ.ProvingGroundRate < class'XComGameState_HeadquartersXCom'default.XComHeadquarters_DefaultProvingGroundWorkPerHour) //safety check: the base rate should always be 1.0f, zero it out if it's somehow less than that.
	//{
	//
		//XComHQ.ProvingGroundRate =  class'XComGameState_HeadquartersXCom'default.XComHeadquarters_DefaultProvingGroundWorkPerHour);
	//}
	//XComHQ.ProvingGroundRate += class'XComGameState_HeadquartersXCom'.default.XComHeadquarters_DefaultProvingGroundWorkPerHour * `ScaleStrategyArrayFloat(default.ProvingGroundModeRateScalar); 
//
	////if(XComHQ.ProvingGroundRate() < 1.0f) //second safety check: if we're still less than 1, then the player is not using noble cause and we need to add 1.0f ourselves.
	////{
		////XComHQ.ProvingGroundRate += 1.0f;
	////}
	//XComHQ = GetNewXComHQState(NewGameState);
	//XComHQ.HandlePowerOrStaffingChange(NewGameState); //this is so the change in will recovery takes effect immediately
//}
////---------------------------------------------------------------------------------------
//static function OnXCOMLeavesWillMode(XComGameState NewGameState, StateObjectReference InRef)
//{
	//local XComGameState_HeadquartersXCom XComHQ;
	//local XComGameState_HeadquartersResistance ResistanceHQ;
//
	//XComHQ = GetNewXComHQState(NewGameState);
	//XComHQ.ProvingGroundRate -= class'XComGameState_HeadquartersXCom'.default.XComHeadquarters_DefaultProvingGroundWorkPerHour * `ScaleStrategyArrayFloat(default.ProvingGroundModeRateScalar); 
	//if (XComHQ.ProvingGroundRate < class'XComGameState_HeadquartersXCom'default.XComHeadquarters_DefaultProvingGroundWorkPerHour) //safety check: the base rate should always be 1.0f, zero it out if it's somehow less than that.
	//{
		//XComHQ.ProvingGroundRate = class'XComGameState_HeadquartersXCom'default.XComHeadquarters_DefaultProvingGroundWorkPerHour;
	//}
	//XComHQ = GetNewXComHQState(NewGameState);
	//XComHQ.HandlePowerOrStaffingChange(NewGameState);
//}
//
//
////#############################################################################################
////----------------   HELPER FUNCTIONS  --------------------------------------------------------
////#############################################################################################
//
////static function UpdateScanLabel(XComGameState NewGameState)
////{
////	local XComGameState_HeadquartersResistance ResistanceHQ;
////	local XComGameState_HeadquartersXCom XComHQ;
////	local XComGameState_Haven HavenState;
////	local X2ResistanceModeTemplate ResistanceModeTemplate;
////
////	ResistanceHQ = GetNewResHQState(NewGameState);
////	XComHQ = GetNewXComHQState(NewGameState);
////	ResistanceModeTemplate = ResistanceHQ.GetResistanceMode();
////
////	// Update the Res HQ Haven to give the correct scanning label
////	HavenState = XComGameState_Haven(XComHQ.GetCurrentScanningSite());
////	HavenState = XComGameState_Haven(NewGameState.ModifyStateObject(class'XComGameState_Haven', HavenState.ObjectID));
////	HavenState.m_strScanButtonLabel = ResistanceModeTemplate.ScanLabel;
////}
//
//static function XComGameState_HeadquartersResistance GetNewResHQState(XComGameState NewGameState)
//{
	//local XComGameState_HeadquartersResistance NewResHQ;
//
	//foreach NewGameState.IterateByClassType(class'XComGameState_HeadquartersResistance', NewResHQ)
	//{
		//break;
	//}
//
	//if (NewResHQ == none)
	//{
		//NewResHQ = XComGameState_HeadquartersResistance(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersResistance'));
		//NewResHQ = XComGameState_HeadquartersResistance(NewGameState.ModifyStateObject(class'XComGameState_HeadquartersResistance', NewResHQ.ObjectID));
	//}
//
	//return NewResHQ;
//}

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Modes;

	Modes.AddItem(CreateProvingGroundModeTemplate());

	return Modes;
}

//---------------------------------------------------------------------------------------
static function X2DataTemplate CreateProvingGroundModeTemplate()
{
	local X2ResistanceModeTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ResistanceModeTemplate', Template, 'ResistanceMode_ProvingGroundSpeed');
	Template.Category = "ResistanceMode";
	Template.ImagePath = "img:///UILibrary_StrategyImages.X2StrategyMap.ResHQ_Intel";
	Template.OnActivatedFn = ActivateProvingGround;
	Template.OnDeactivatedFn = DeactivateProvingGround;
	Template.OnXCOMArrivesFn = OnXCOMArrivesProvingGround;
	Template.OnXCOMLeavesFn = OnXCOMLeavesProvingGround;

	return Template;
}

static function ActivateProvingGround(XComGameState NewGameState, StateObjectReference InRef, optional bool bReactivate = false)
{
	// The Avenger is already at ResHQ, so activate it immediately
	OnXCOMArrivesProvingGround(NewGameState, InRef);
}
//---------------------------------------------------------------------------------------
static function DeactivateProvingGround(XComGameState NewGameState, StateObjectReference InRef)
{
	// The Avenger is already at ResHQ, so deactivate it immediately
	OnXCOMLeavesProvingGround(NewGameState, InRef);
}
//---------------------------------------------------------------------------------------
static function OnXCOMArrivesProvingGround(XComGameState NewGameState, StateObjectReference InRef)
{
	local XComGameState_HeadquartersXCom XComHQ;


	XComHQ = GetNewXComHQState(NewGameState);
	if (XComHQ.ProvingGroundRate < class'XComGameState_HeadquartersXCom'.default.XComHeadquarters_DefaultProvingGroundWorkPerHour) // safety check: ensure Proving Ground rate is never below default
	{
		XComHQ.ProvingGroundRate = class'XComGameState_HeadquartersXCom'.default.XComHeadquarters_DefaultProvingGroundWorkPerHour;
	}                              
	XComHQ.ProvingGroundRate += class'XComGameState_HeadquartersXCom'.default.XComHeadquarters_DefaultProvingGroundWorkPerHour * `ScaleStrategyArrayFloat(default.ProvingGroundModeRateScalar);
	XComHQ.HandlePowerOrStaffingChange(NewGameState);
}
//---------------------------------------------------------------------------------------
static function OnXCOMLeavesProvingGround(XComGameState NewGameState, StateObjectReference InRef)
{
	local XComGameState_HeadquartersXCom XComHQ;

	XComHQ = GetNewXComHQState(NewGameState);
	XComHQ.ProvingGroundRate -= class'XComGameState_HeadquartersXCom'.default.XComHeadquarters_DefaultProvingGroundWorkPerHour * `ScaleStrategyArrayFloat(default.ProvingGroundModeRateScalar);
	if (XComHQ.ProvingGroundRate < class'XComGameState_HeadquartersXCom'.default.XComHeadquarters_DefaultProvingGroundWorkPerHour) // safety check: ensure Proving Ground rate is never below default
	{
		XComHQ.ProvingGroundRate = class'XComGameState_HeadquartersXCom'.default.XComHeadquarters_DefaultProvingGroundWorkPerHour;
	}
	XComHQ.HandlePowerOrStaffingChange(NewGameState);
}

static function XComGameState_HeadquartersXCom GetNewXComHQState(XComGameState NewGameState)
{
	local XComGameState_HeadquartersXCom NewXComHQ;

	foreach NewGameState.IterateByClassType(class'XComGameState_HeadquartersXCom', NewXComHQ)
	{
		break;
	}

	if (NewXComHQ == none)
	{
		NewXComHQ = XComGameState_HeadquartersXCom(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
		NewXComHQ = XComGameState_HeadquartersXCom(NewGameState.ModifyStateObject(class'XComGameState_HeadquartersXCom', NewXComHQ.ObjectID));
	}

	return NewXComHQ;
}