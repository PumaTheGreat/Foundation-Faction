class UIScreenListener_ResistanceHQ extends UIScreenListener config(Extraspecies);

var public localized string m_strPersonnel;
var public localized string  m_strRelationshipMenuOption;

var config int X_POSITION;
var config int Y_POSITION;


var UIButton RecruitButton;



event OnInit(UIScreen Screen)
{
	local PlayerController PlayerController;
	local name Key;

    if(UIResistanceGoods(screen) != none)
	{
		Key = 'XboxTypeS_LeftThumbstick';
		PlayerController = class'WorldInfo'.static.GetWorldInfo().GetALocalPlayerController();
		if (InStr(PlayerController.PlayerInput.GetBind(Key), "ScreenStickPress") == INDEX_NONE)
		{
			PlayerController.PlayerInput.SetBind(Key, PlayerController.PlayerInput.GetBind(Key) $ " | ScreenStickPress | onrelease Thumb_Left_Release");
		}
		RecruitButton = Screen.Spawn(class'UIButton', Screen).InitButton('RecruitSuppliesButton', m_strPersonnel , OnRecruitButtonCallback).SetDisabled(false, m_strRelationshipMenuOption);
		RecruitButton.bAnimateOnInit = false;
		RecruitButton.SetAnchor(class'UIUtilities'.const.ANCHOR_TOP_RIGHT);
		RecruitButton.SetPosition(X_POSITION, Y_POSITION);
	}
}


simulated function OnRecruitButtonCallback(UIButton kButton)
{
	//local XComHQPresentationLayer HQPres;
	//local UIResistanceGoods_Extraspecies RecruitScreen;


	//HQPres = `HQPRES;
	//if(HQPres.ScreenStack.IsNotInStack(class'UIResistanceGoods_Extraspecies'))
	//{
	////RelationshipScreen = RM_UIArmory_RelationshipPopup(HQPres.ScreenStack.Push(HQPres.Spawn(class'RM_UIArmory_RelationshipPopup', HQPres)), HQPres.Get3DMovie());
	//RecruitScreen = HQPres.Spawn(class'UIResistanceGoods_Extraspecies', HQPres);
	//HQPres.ScreenStack.Push(RecruitScreen);
	//}
}


defaultproperties
{
	ScreenClass=none
}