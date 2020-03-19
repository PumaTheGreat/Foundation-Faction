class UIRecruitSoldiers_Extraspecies extends UIScreen;

//var UIList List;
//var array<XComGameState_Unit> m_arrRecruits;
//
//var public localized string m_strListTitle;
//var public localized string m_strNoRecruits;
//var public localized string m_strCost;
//var public localized string m_strTime;
//var public localized string m_strInstant;
//var public localized string m_strSupplies;
//var public localized string m_strNotEnoughSuppliesToRecruitDialogueTitle; 
//var public localized string m_strNotEnoughSuppliesToRecruitDialogueBody;
//var public localized string m_strSpecies;
//
//var int DeferredSoldierPictureListIndex; //The list index for the last selected soldier
//
////----------------------------------------------------------------------------
//// MEMBERS
//
//simulated function InitScreen(XComPlayerController InitController, UIMovie InitMovie, optional name InitName)
//{
	//local UIPanel BG;
//
	//super.InitScreen(InitController, InitMovie, InitName);
//
	//List = Spawn(class'UIList', self);
	//List.InitList('listMC');
	//List.itemPadding = 5;
	//List.OnSelectionChanged = OnRecruitChanged;
	//List.OnItemDoubleClicked = OnRecruitSelected;
//
	//BG = Spawn(class'UIPanel', self).InitPanel('InventoryListBG');
	//BG.ProcessMouseEvents(List.OnChildMouseEvent);
//
	//UpdateData();
	//UpdateNavHelp();
//}
//
//simulated function UpdateNavHelp()
//{
	//`HQPRES.m_kAvengerHUD.NavHelp.ClearButtonHelp();
	//`HQPRES.m_kAvengerHUD.NavHelp.AddBackButton(CloseScreen);
//}
//
//simulated function UpdateData()
//{
	//local int i, RecruitCost;
	//local XComGameState_Unit Recruit;
	//local XComGameStateHistory History;
	//local XComGameState_ExtraspeciesRecruits ExtraspeciesRecruits;
	//local AU_X2SpeciesTuple_Template	Template;
//
	//AS_SetTitle(m_strListTitle);
//
	//List.ClearItems();
	//m_arrRecruits.Length = 0;
//
	//History = `XCOMHISTORY;
	//ExtraspeciesRecruits = XComGameState_ExtraspeciesRecruits(History.GetSingleGameStateObjectForClass(class'XComGameState_ExtraspeciesRecruits'));
	//if(ExtraspeciesRecruits != none)
	//{
		//for(i = 0; i < ExtraspeciesRecruits.ExtraspeciesRecruits.Length; i++)
		//{
			//Recruit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(ExtraspeciesRecruits.ExtraspeciesRecruits[i].ObjectID));
			//Template = class'AU_X2SpeciesHelpers'.static.FindSpeciesTemplate(Recruit.GetMyTemplate().DataName);
			//m_arrRecruits.AddItem(Recruit);
			//RecruitCost = Template.RecruitCost;
			//UIRecruitmentListItem_Extraspecies(List.CreateItem(class'UIRecruitmentListItem_Extraspecies')).InitRecruitItem(Recruit, RecruitCost * ExtraspeciesRecruits.GetAvengerRecruitScalar());
		//}
	//}
//
	//if(m_arrRecruits.Length > 0)
	//{
		//List.SetSelectedIndex(0, true);
	//}
	//else
	//{
		//List.SetSelectedIndex(-1, true);
		//AS_SetEmpty(m_strNoRecruits);
	//}
//}
//
//simulated function bool OnUnrealCommand(int cmd, int arg)
//{
	//if ( !CheckInputIsReleaseOrDirectionRepeat(cmd, arg) )
		//return false;
//
	//switch( cmd )
	//{
		//case class'UIUtilities_Input'.const.FXS_BUTTON_A:
		//case class'UIUtilities_Input'.const.FXS_KEY_ENTER:
		//case class'UIUtilities_Input'.const.FXS_KEY_SPACEBAR:
			//if(List.SelectedIndex != INDEX_NONE)
				//OnRecruitSelected(List, List.SelectedIndex);
			//return true;
		//case class'UIUtilities_Input'.const.FXS_BUTTON_B:
		//case class'UIUtilities_Input'.const.FXS_KEY_ESCAPE:
		//case class'UIUtilities_Input'.const.FXS_R_MOUSE_DOWN:
			//CloseScreen();
			//return true;
	//}
//
	//return super.OnUnrealCommand(cmd, arg);
//}
//
//simulated function OnReceiveFocus()
//{
	//super.OnReceiveFocus();
	//UpdateData();
	//UpdateNavHelp();
//}
//
////------------------------------------------------------
//
//simulated function OnRecruitChanged( UIList kList, int itemIndex )
//{
	//local XGParamTag LocTag;
	//local StateObjectReference UnitRef;
	//local XComGameState_Unit Recruit;
	//local AU_X2SpeciesTuple_Template	Template;
	//local XComGameState_CampaignSettings SettingsState;	
	//local Texture2D StaffPicture;
	//local string DescriptionString;
	//local int RecruitCost;
	//local XComGameState_ExtraspeciesRecruits ExtraspeciesRecruits;
//
//
	//if(itemIndex == INDEX_NONE) return;
//
	//Recruit = m_arrRecruits[itemIndex];
	//UnitRef = Recruit.GetReference();
	//Template = class'AU_X2SpeciesHelpers'.static.FindSpeciesTemplate(Recruit.GetMyTemplate().DataName);
//
	//ExtraspeciesRecruits = XComGameState_ExtraspeciesRecruits(`XCOMHistory.GetSingleGameStateObjectForClass(class'XComGameState_ExtraspeciesRecruits'));
//
	//RecruitCost = Template.RecruitCost * ExtraspeciesRecruits.GetAvengerRecruitScalar();
	//
	////`log("Current Species Template has " $ RecruitCost $ " supply cost and " $ Template.SpeciesName $ "for a species name", ,'AlliesUnknown');
	//LocTag = XGParamTag(`XEXPANDCONTEXT.FindTag("XGParam"));
	//LocTag.IntValue0 = RecruitCost;
//
//
//
	//DescriptionString = (m_strSpecies $ " " $ Template.SpeciesName $ " - " $ Recruit.GetBackground());
//
	//AS_SetCost(m_strCost, `XEXPAND.ExpandString(m_strSupplies));
	//AS_SetDescription(DescriptionString);
	//AS_SetTime(m_strTime, m_strInstant);
	//AS_SetPicture(); // hide picture until character portrait is loaded
	//
	//SettingsState = XComGameState_CampaignSettings(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_CampaignSettings'));
	//StaffPicture = `XENGINE.m_kPhotoManager.GetHeadshotTexture(SettingsState.GameIndex, UnitRef.ObjectID, 512, 512);
	//
	//if(StaffPicture == none)
	//{
		//DeferredSoldierPictureListIndex = itemIndex;
		//ClearTimer(nameof(DeferredUpdateSoldierPicture));
		//SetTimer(0.1f, false, nameof(DeferredUpdateSoldierPicture));
	//}	
	//else
	//{
		//AS_SetPicture("img:///"$PathName(StaffPicture));
	//}
//}
//
//function DeferredUpdateSoldierPicture()
//{	
	//local StateObjectReference UnitRef;
	//local XComGameState_Unit Recruit;
//
	//Recruit = m_arrRecruits[DeferredSoldierPictureListIndex];
	//UnitRef = Recruit.GetReference();
//
	//`HQPRES.GetPhotoboothAutoGen().AddHeadShotRequest(UnitRef, 512, 512, OnSoldierHeadCaptureFinished, , , true);
	//`HQPRES.GetPhotoboothAutoGen().RequestPhotos();
//}
//
//
//function OnSoldierHeadCaptureFinished(StateObjectReference UnitRef)
//{
	//local XComGameState_CampaignSettings SettingsState;
	//local Texture2D SoldierPicture;
	//local StateObjectReference DeferredUnitRef;
	//local XComGameState_Unit Recruit;
//
	//Recruit = m_arrRecruits[DeferredSoldierPictureListIndex];
	//DeferredUnitRef = Recruit.GetReference();
//
	//SettingsState = XComGameState_CampaignSettings(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_CampaignSettings'));
	//SoldierPicture = `XENGINE.m_kPhotoManager.GetHeadshotTexture(SettingsState.GameIndex, UnitRef.ObjectID, 512, 512);
//
	//if (UnitRef == DeferredUnitRef)
		//AS_SetPicture(class'UIUtilities_Image'.static.ValidateImagePath(PathName(SoldierPicture)));
//}
//
//
//simulated function OnRecruitSelected( UIList kList, int itemIndex )
//{
	//local XComGameState_Unit Recruit;
	//local XComGameState_HeadquartersXCom XComHQ;
	//local AU_X2SpeciesTuple_Template	Template;
	//local XComGameState_ExtraspeciesRecruits ExtraRecruits;
	//local int RecruitCost;
//
	//XComHQ = class'UIUtilities_Strategy'.static.GetXComHQ();
	//Recruit = m_arrRecruits[itemIndex];
	//Template = class'AU_X2SpeciesHelpers'.static.FindSpeciesTemplate(Recruit.GetMyTemplate().DataName);
	//RecruitCost = Template.RecruitCost;
//
	//ExtraRecruits =  XComGameState_ExtraspeciesRecruits(class'XComGameStateHistory'.static.GetGameStateHistory().GetSingleGameStateObjectForClass(class' XComGameState_ExtraspeciesRecruits'));
//
	//RecruitCost = Template.RecruitCost * ExtraRecruits.GetAvengerRecruitScalar();
	//
	//`log("Current Species Template has " $ RecruitCost $ " supply cost and " $ Template.SpeciesName $ "for a species name", ,'AlliesUnknown');
//
	//if(XComHQ.GetSupplies() >= RecruitCost)
	//{	
		//`XSTRATEGYSOUNDMGR.PlaySoundEvent("StrategyUI_Recruit_Soldier");
		//ExtraRecruits.GiveRecruit(Recruit.GetReference(), Template);
		//UpdateData(); // Refresh the list
//
		//`HQPRES.m_kAvengerHUD.UpdateResources();
	//}
	//else
	//{
		//if( XComHQ.GetSupplies() < RecruitCost) 
			//NotEnoughSuppliesDialogue();
//
		////`HQPRES.SOUND().PlaySFX(`HQPRES.m_kSoundMgr.m_kSounds.SFX_UI_No);
	//}
//}
//
//simulated function NotEnoughSuppliesDialogue()
//{
	//local TDialogueBoxData kDialogData;
	//kDialogData.strTitle = m_strNotEnoughSuppliesToRecruitDialogueTitle; 
	//kDialogData.strText = m_strNotEnoughSuppliesToRecruitDialogueBody; 
	//Movie.Pres.UIRaiseDialog(kDialogData);
//}
//
////==============================================================================
//
//simulated function AS_SetTitle(string title)
//{
	//MC.FunctionString("setTitle", title);
//}
//
//simulated function AS_SetEmpty(string label)
//{
	//MC.FunctionString("setEmpty", label);
//}
//
//simulated function AS_SetCost(string label, string value)
//{
	//MC.BeginFunctionOp("setCost");
	//MC.QueueString(label);
	//MC.QueueString(value);
	//MC.EndOp();
//}
//
//simulated function AS_SetTime(string label, string value)
//{
	//MC.BeginFunctionOp("setTime");
	//MC.QueueString(label);
	//MC.QueueString(value);
	//MC.EndOp();
//}
//
//simulated function AS_SetDescription(string text)
//{
	//MC.FunctionString("setDescription", text);
//}
//
//simulated function AS_SetPicture(optional string path)
//{
	//local ASValue Data;
	//local array<ASValue> DataArray;
	//
	//Data.Type = AS_String;
	//Data.s = path;
	//DataArray.AddItem(Data);
//
	//Invoke("setPicture", DataArray);
//}
//
////==============================================================================
//
//defaultproperties
//{
	//Package = "/ package/gfxNewRecruit/NewRecruit";
	//bHideOnLoseFocus = false;
//}