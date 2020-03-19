class UIRecruitmentListItem_Extraspecies extends UIListItemString;

//var localized string RecruitConfirmLabel; 
//
//simulated function InitRecruitItem(XComGameState_Unit Recruit, int RecruitCost)
//{
	//local string ColoredName;
	//local XComGameState_HeadquartersXCom XComHQ;
	//InitPanel(); // must do this before adding children or setting data
//
	//XComHQ = class'UIUtilities_Strategy'.static.GetXComHQ();
//
	//if(XComHQ.GetSupplies() < RecruitCost )
		//SetDisabled(true);
//
	//ColoredName = class'UIUtilities_Text'.static.GetColoredText(Recruit.GetName(eNameType_Full), bDisabled ? eUIState_Disabled : eUIState_Normal);
	//AS_PopulateData(Recruit.GetCountryTemplate().FlagImage, ColoredName);
//
	//SetConfirmButtonStyle(eUIConfirmButtonStyle_Default, RecruitConfirmLabel, 5, 4);
//
	//// HAX: Undo the height override set by UIListItemString
	//MC.ChildSetNum("theButton", "_height", 40);
//}		
//
//simulated function OnClickedConfirmButton(UIButton Button)
//{
	//local UIRecruitSoldiers_Extraspecies RecruitScreen;
	//RecruitScreen = UIRecruitSoldiers_Extraspecies(Screen);
	//RecruitScreen.OnRecruitSelected(RecruitScreen.List, RecruitScreen.List.GetItemIndex(self));
//}
//
//simulated function AS_PopulateData( string flagIcon, string recruitName )
//{
	//MC.BeginFunctionOp("populateData");
	//MC.QueueString(flagIcon);
	//MC.QueueString(recruitName);
	//MC.EndOp();
//}
//
//defaultproperties
//{
	//width = 540;
	//height = 40;
	//LibID = "NewRecruitItem";
//}