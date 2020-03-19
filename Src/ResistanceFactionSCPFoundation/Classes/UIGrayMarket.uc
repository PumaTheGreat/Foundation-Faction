class UIGrayMarket extends UIScreen;

//const NUM_WELCOMES = 7;
//
//var public localized String m_strTitle;
//var public localized String m_strBuy;
//var public localized String m_strSell;
//var public localized String m_strImage;
//var public localized String m_strSupplyLineRaid;
//var public localized String m_strLandedUFOMission;
//var public localized String m_strWelcome[NUM_WELCOMES];
//var public localized String m_strInterests[3];
//var public localized String m_strSupplyPool;
//var public localized String m_strInterestTitle;
//var public localized String m_strEmptyThisMonth;
//var public localized string m_strEmptyInventory;
//var public localized string m_strGrayMarketLogoString;
//
//var localized string m_strNoInfluence;
//var localized string m_strMedInfluence;
//var localized string m_strHighInfluence;
//
//var UIPanel LibraryPanel;
//var UIButton Button1, Button2, Button3;
//var UIImage ImageTarget;
//
////----------------------------------------------------------------------------
//// MEMBERS
//
//simulated function InitScreen(XComPlayerController InitController, UIMovie InitMovie, optional name InitName)
//{
	//super.InitScreen(InitController, InitMovie, InitName);
	//BuildScreen();
//
	//`HQPRES.StrategyMap2D.Hide();
//}
//
//simulated function BuildScreen()
//{
	//local UIPanel ButtonGroup;
//
	//`XSTRATEGYSOUNDMGR.PlaySoundEvent("Black_Market_Enter");
//
	//LibraryPanel = Spawn(class'UIPanel', self);
	//LibraryPanel.bAnimateOnInit = false;
	//LibraryPanel.InitPanel('', 'BlackMarketMenu');
		//
	//ButtonGroup = Spawn(class'UIPanel', LibraryPanel);
	//ButtonGroup.InitPanel('ButtonGroup', '');
//
	//Button1 = Spawn(class'UIButton', ButtonGroup);
	//Button1.SetResizeToText(true); //bsg-jneal (5.19.17): resize to text for loc
	//Button1.InitButton('Button0', m_strBuy,, eUIButtonStyle_HOTLINK_BUTTON);
	//Button1.SetGamepadIcon(class'UIUtilities_Input'.static.GetAdvanceButtonIcon());
//
	//Button2 = Spawn(class'UIButton', ButtonGroup);
	//Button2.SetResizeToText(true); //bsg-jneal (5.19.17): resize to text for loc
	//Button2.InitButton('Button1', m_strSell,, eUIButtonStyle_HOTLINK_BUTTON);
	//Button2.SetGamepadIcon(class'UIUtilities_Input'.static.GetGamepadIconPrefix() $ class'UIUtilities_Input'.const.ICON_X_SQUARE);
	//
	//RefreshButtons();
	//
	//Button3 = Spawn(class'UIButton', ButtonGroup);
	//Button3.SetResizeToText(false);
	//Button3.InitButton('Button2', "",, eUIButtonStyle_HOTLINK_BUTTON);
//
	//ImageTarget = Spawn(class'UIImage', LibraryPanel).InitImage('MarketMenuImage');
	//ImageTarget.LoadImage(m_strImage);
//
	//Navigator.Clear();
//
	////-----------------------------------------------
//
	//LibraryPanel.MC.FunctionString("SetMenuQuote", m_strWelcome[Rand(NUM_WELCOMES)]);
//
	//LibraryPanel.MC.BeginFunctionOp("SetMenuInterest");
	//LibraryPanel.MC.QueueString(m_strInterestTitle);
	//LibraryPanel.MC.QueueString(GetInterestsString());
	//LibraryPanel.MC.EndOp();
//
	//Button1.OnClickedDelegate = OnBuyClicked;
	//Button2.OnClickedDelegate = OnSellClicked;
	//Button3.Hide();
//
	//LibraryPanel.MC.BeginFunctionOp("SetGreeble");
	//LibraryPanel.MC.QueueString(class'UIAlert'.default.m_strBlackMarketFooterLeft);
	//LibraryPanel.MC.QueueString(class'UIAlert'.default.m_strBlackMarketFooterRight);
	//LibraryPanel.MC.QueueString(default.m_strGrayMarketLogoString);
	//LibraryPanel.MC.EndOp();
//
	//LibraryPanel.MC.FunctionVoid("AnimateIn");
//
	//XComHQPresentationLayer(Movie.Pres).m_kAvengerHUD.NavHelp.ClearButtonHelp();
	//XComHQPresentationLayer(Movie.Pres).m_kAvengerHUD.NavHelp.AddBackButton(CloseScreen);
//}
//
//simulated function OnReceiveFocus()
//{
	//super.OnReceiveFocus();
	//
	//XComHQPresentationLayer(Movie.Pres).m_kAvengerHUD.NavHelp.ClearButtonHelp();
	//XComHQPresentationLayer(Movie.Pres).m_kAvengerHUD.NavHelp.AddBackButton(CloseScreen);
//
	//RefreshButtons();
//}
//
//simulated function RefreshButtons()
//{
//
	//Button1.SetText(m_strBuy);
	//Button1.SetDisabled(false, "");
//
	//Button2.SetGamepadIcon(class'UIUtilities_Input'.static.GetGamepadIconPrefix() $ class'UIUtilities_Input'.const.ICON_X_SQUARE); //bsg-crobinson (5.3.17): Switch icon back to X if items become available
	//Button2.SetDisabled(false);
	//Button2.SetText(m_strSell);
//
//}
//
////-------------- GAME DATA HOOKUP --------------------------------------------------------
//simulated function String GetInterestsString()
//{
	//local XComGameState_HeadquartersResistance ResHQ;
	//local XComGameState_ResistanceFaction FactionState;
//
	//ResHQ = XComGameState_HeadquartersResistance(`XCOMHistory.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersResistance'));
	//FactionState = ResHQ.GetFactionByTemplateName('Faction_Foundation');
	//if(FactionState != none)
	//{
		//if(FactionState.GetInfluence() == eFactionInfluence_Respected)
			//return m_strMedInfluence;
//
		//if(FactionState.GetInfluence() == eFactionInfluence_Influential)
			//return m_strHighInfluence;
	//}
//
	//return m_strNoInfluence;
//}
////-------------- EVENT HANDLING --------------------------------------------------------
//simulated function OnBuyClicked(UIButton button)
//{
	//local XComHQPresentationLayer HQPres;
	//local UIBlackmarketGoods_Extraspecices RecruitScreen;
//
//
	//HQPres = `HQPRES;
	//if(HQPres.ScreenStack.IsNotInStack(class'UIBlackMarketGoods_Extraspecices'))
	//{
	////RelationshipScreen = RM_UIArmory_RelationshipPopup(HQPres.ScreenStack.Push(HQPres.Spawn(class'RM_UIArmory_RelationshipPopup', HQPres)), HQPres.Get3DMovie());
	//RecruitScreen = HQPres.Spawn(class'UIBlackMarketGoods_Extraspecices', HQPres);
	//HQPres.ScreenStack.Push(RecruitScreen);
	//}
//}
//simulated function OnSellClicked(UIButton button)
//{
	//local XComHQPresentationLayer HQPres;
	//local UIResistanceGoods_Extraspecies RecruitScreen;
//
//
	//HQPres = `HQPRES;
	//if(HQPres.ScreenStack.IsNotInStack(class'UIResistanceGoods_Extraspecies'))
	//{
	////RelationshipScreen = RM_UIArmory_RelationshipPopup(HQPres.ScreenStack.Push(HQPres.Spawn(class'RM_UIArmory_RelationshipPopup', HQPres)), HQPres.Get3DMovie());
	//RecruitScreen = HQPres.Spawn(class'UIResistanceGoods_Extraspecies', HQPres);
	//HQPres.ScreenStack.Push(RecruitScreen);
	//}
//}
//
//simulated function CloseScreen()
//{
	//`XSTRATEGYSOUNDMGR.PlaySoundEvent("Black_Market_Ambience_Loop_Stop");
	//super.CloseScreen();
//}
//
//simulated function bool OnUnrealCommand(int cmd, int arg)
//{
	//local bool bHandled;
//
	//// Only pay attention to presses or repeats; ignoring other input types
	//// NOTE: Ensure repeats only occur with arrow keys
	//if( !CheckInputIsReleaseOrDirectionRepeat(cmd, arg) )
		//return false;
//
	//bHandled = true;
	//switch( cmd )
	//{
	//case class'UIUtilities_Input'.const.FXS_BUTTON_A:
		//OnBuyClicked(none);
		//break;
//
	//case class'UIUtilities_Input'.const.FXS_BUTTON_X:
		//OnSellClicked(none);
		//break;
	//case class'UIUtilities_Input'.const.FXS_BUTTON_B:
	//case class'UIUtilities_Input'.const.FXS_KEY_ESCAPE:
	//case class'UIUtilities_Input'.const.FXS_R_MOUSE_DOWN:
		//CloseScreen();
		//break;
	//case class'UIUtilities_Input'.const.FXS_BUTTON_START:
		//`HQPRES.UIPauseMenu(, true);
		//break;
	//default:
		//bHandled = false;
		//break;
	//}
//
	//return bHandled || super.OnUnrealCommand(cmd, arg);
//}
//
//
////==============================================================================
//
//defaultproperties
//{
	//InputState = eInputState_Consume;
	//Package = "/ package/gfxBlackMarket/BlackMarket";
	//bConsumeMouseEvents = true;
//}