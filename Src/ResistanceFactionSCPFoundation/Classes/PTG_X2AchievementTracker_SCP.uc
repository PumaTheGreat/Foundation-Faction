class PTG_X2AchievementTracker_SCP extends Object;

//// Singleton creation / access of XComGameState_DLC_Day90AchievementData.
//static function RM_XComGameState_AchievementData GetAchievementData(XComGameState NewGameState)
//{
	//local RM_XComGameState_AchievementData AchievementData;
//
	//AchievementData = RM_XComGameState_AchievementData(class'XComGameStateHistory'.static.GetGameStateHistory().GetSingleGameStateObjectForClass(class'RM_XComGameState_AchievementData', true));
	//if (AchievementData == none)
	//{
		//AchievementData = RM_XComGameState_AchievementData(NewGameState.CreateStateObject(class'RM_XComGameState_AchievementData'));
	//}
	//else
	//{
		//AchievementData = RM_XComGameState_AchievementData(NewGameState.CreateStateObject(class'RM_XComGameState_AchievementData', AchievementData.ObjectID));
	//}
	//NewGameState.AddStateObject(AchievementData);
//
	//return AchievementData;
//}
//
//
//
//static function EventListenerReturn OnKillMail(Object EventData, Object EventSource, XComGameState NewGameState, Name EventID, Object CallbackData)
//{
	//local XComGameState_Unit SourceUnit, KilledUnit;
	//local LWTuple AchTuple;
	//local LWTValue Value;
//
	//if (NewGameState.GetContext().InterruptionStatus == eInterruptionStatus_Interrupt)
	//{
		//return ELR_NoInterrupt;
	//}
//
//
	//SourceUnit = XComGameState_Unit(EventSource);
	//KilledUnit = XComGameState_Unit(EventData);
	//
	//if (SourceUnit != none && KilledUnit != none)	
	//{
		//if (KilledUnit.IsAlien() && KilledUnit.IsSoldier() || KilledUnit.IsAdvent() && KilledUnit.IsSoldier())
		//{
			//AchTuple = new class'LWTuple';
			//AchTuple.Id = 'AchievementData';
//
			//Value.kind = LWTVName;
			//Value.n = 'AlliesUnknown_LoseTen';
			//AchTuple.Data.AddItem(Value);
//
			//Value.kind = LWTVName;
			//Value.n = 'ProgressByNumber';
			//AchTuple.Data.AddItem(Value);
//
			//Value.kind = LWTVInt;
			//Value.i = 1;
			//AchTuple.Data.AddItem(Value);
//
			//`XEVENTMGR.TriggerEvent('UnlockAchievement', AchTuple, , );
		//}
	//}
	//
//
//
	//return ELR_NoInterrupt;
//}
//
//
//// Catches the end of a mission
//static function EventListenerReturn OnTacticalGameEnd(Object EventData, Object EventSource, XComGameState GameState, Name EventID, Object CallbackData)
//{
	//local XComGameState_Unit Unit;
	//local XComGameState_HeadquartersXCom XComHQ;
	//local int i;
	//local bool AllAlien;
	//local XComGameState_BattleData BattleData;	
	////local XComGameStateHistory History;
	//local LWTuple AchTuple;
	//local LWTValue Value;
//
	////History = `XCOMHISTORY;
//
	//BattleData = XComGameState_BattleData(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_BattleData'));
//
	//XComHQ = class'UIUtilities_Strategy'.static.GetXComHQ();
//
	//AllAlien = true;
//
	//for (i = 0; i < XComHQ.Squad.Length; ++i) 
	//{
	//Unit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectId(XComHQ.Squad[i].ObjectID));
//
		//if(!Unit.IsAlien() && !Unit.IsAdvent())
		//{
		//AllAlien = false;
		//break;
		//}
//
	//}
//
	//if(AllAlien && BattleData.bLocalPlayerWon)
	//{
		//AchTuple = new class'LWTuple'; 
		//AchTuple.Id = 'AchievementData'; // Must be this name
//
		//// First entry: Achievement Name.
		//Value.kind = LWTVName;
		//Value.n = 'AlliesUnknown_AlienSquad';
		//AchTuple.Data.AddItem(Value);
//
		//// Second Entry: Command
		//Value.kind = LWTVName;
		//Value.n = 'UnlockAchievement';
		//AchTuple.Data.AddItem(Value);
//
		//`XEVENTMGR.TriggerEvent('UnlockAchievement', AchTuple, , );
	//}
//
	//return ELR_NoInterrupt;
//}