class UIScreenListener_RewardsRecap extends UIScreenListener;

//event OnInit(UIScreen Screen)
//{
	//local XComGameState_ExtraspeciesRecruits RecruitMgr, NewRecruitMgr;
	//local XComGameStateHistory History;
	//local XComGameState NewGameState;

    //if(UIResistanceReport(screen) != none)
	//{
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
	//}
//
//}
//
//
//defaultproperties
//{
	//ScreenClass=none
//}