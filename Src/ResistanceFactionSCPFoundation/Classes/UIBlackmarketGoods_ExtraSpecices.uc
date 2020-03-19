class UIBlackmarketGoods_Extraspecices extends UISimpleCommodityScreen;

//simulated function InitScreen(XComPlayerController InitController, UIMovie InitMovie, optional name InitName)
//{
	////local XComGameState NewGameState;
	//
	//super.InitScreen(InitController, InitMovie, InitName);
	//
//}
//
////-------------- EVENT HANDLING --------------------------------------------------------
//simulated function OnPurchaseClicked(UIList kList, int itemIndex)
//{
	////local XComGameStateHistory History;
	//local XComGameState_ExtraspeciesRecruits ExtraspeciesRecruits;
//
	////History = `XCOMHISTORY;
	//ExtraspeciesRecruits = XComGameState_ExtraspeciesRecruits(History.GetSingleGameStateObjectForClass(class'XComGameState_ExtraspeciesRecruits'));
	//if (itemIndex != iSelectedItem)
	//{
		//iSelectedItem = itemIndex;
	//}
//
	//if( CanAffordItem(iSelectedItem) )
	//{
		//PlaySFX("BuildItem");
		//ExtraspeciesRecruits.BuyIntelItem(arrItems[iSelectedItem].RewardRef);
		//GetItems();
		//PopulateData();
//
		//// Queue new staff popups to give an alert if a Sci or Eng was received
		//`HQPRES.DisplayNewStaffPopupIfNeeded();
	//}
	//else
	//{
		//class'UIUtilities_Sound'.static.PlayNegativeSound();
	//}
//}
//
////-------------- GAME DATA HOOKUP --------------------------------------------------------
//
//
//simulated function GetItems()
//{
	//local XComGameState_ExtraspeciesRecruits ExtraRecruits;
//
	//ExtraRecruits = XComGameState_ExtraspeciesRecruits(`XCOMHistory.GetSingleGameStateObjectForClass(class'XComGameState_ExtraspeciesRecruits'));
	//arrItems = ExtraRecruits.IntelItems;
//}
//
//simulated function String GetButtonString(int ItemIndex)
//{
	//local StateObjectReference RewardRef;
	//local XComGameState_Reward RewardState;
	//local XComGameState_Unit UnitState;
//
	//RewardRef = arrItems[ItemIndex].RewardRef;
//
	//RewardState = XComGameState_Reward(History.GetGameStateForObjectID(RewardRef.ObjectID));
	//UnitState = XComGameState_Unit(History.GetGameStateForObjectID(RewardState.RewardObjectReference.ObjectID));
//
	//if( UnitState != none )
	//{
		//return class'UIRecruitmentListItem'.default.RecruitConfirmLabel;
	//}
	//else
	//{
		//return m_strBuy;
	//}
//}
//
//defaultproperties
//{
	//m_eStyle = eUIConfirmButtonStyle_Default; //word button
	//bIsIn3D = false;
	//bConsumeMouseEvents = true;
//}