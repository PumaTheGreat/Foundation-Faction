class X2EventListener_MTFs extends X2EventListener Config(NameList);

// this event listener will trigger once during the Duke's mission start. 
// it will find the secondary Soldier VIPs that need to be rescued, and change their names and apperance to that of Duke's escort babes

var config array<int> PrimaryArmorColors;
var config array<int> SecondaryArmorColors;
var config array<name> MaleHelmets;
var config array<name> FemaleHelmets;
var config array<name> MaleArms;
var config array<name> FemaleArms;
var config array<name> MaleTorsos;
var config array<name> FemaleTorsos;
var config array<name> MaleLegs;
var config array<name> FemaleLegs;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem(CreateTacticalListeners());

	return Templates;
}


static function CHEventListenerTemplate CreateTacticalListeners()
{
	local CHEventListenerTemplate Template;

	`CREATE_X2TEMPLATE(class'CHEventListenerTemplate', Template, 'MTFAppearanceChanger');

	//	triggered by Highlander event
	//Template.AddCHEvent('PostAliensSpawned', ChangeMTFAppearance, ELD_Immediate);	
	//Template.RegisterInTactical = true;

	return Template; 
}

//	This event triggers in X2TacticalGameRuleset right after Alien Pods (all pods?) spawn. 
//	It passes the StartState for the mission, so any changes we make to GameState here will persist throughout the mission.
//static protected function EventListenerReturn ChangeMTFAppearance(Object EventData, Object EventSource, XComGameState GameState, Name EventID, Object CallbackData)
//{
	//local XComTacticalMissionManager	MissionManager;
	//local XComGameState_Unit			UnitState;
	//local XComGameState_AIGroup			GroupState;
	////local XComGameStateHistory			History;
	////local int i;
//
	////`LOG("Iridar UI Screen listener is triggered!",, 'IRIDARBABE');
//
	//MissionManager = `TACTICALMISSIONMGR;
//
	//if (MissionManager.ActiveMission.sType == "DukeMission")
	//{
		////History = `XCOMHISTORY;
//
		////	go through Group States, which are basically Game States for pods
		//foreach GameState.IterateByClassType(class'XComGameState_AIGroup', GroupState)
		//{
			////	check the pod for correct markings
			//if (GroupState.EncounterID == 'ResistanceTeamMember_VIP' && GroupState.PrePlacedEncounterTag == 'ResistanceTeamMember_01')
			//{
				////	we assume the pod contains only one unit, so we grab the unit state for it.
				//UnitState = XComGameState_Unit(GameState.GetGameStateForObjectID(GroupState.m_arrMembers[0].ObjectID));
//
				//if (UnitState != none)
				//{
					////`LOG("Found babe #1: " @ UnitState.GetFullName(),, 'IRIDARBABE');
//
					//SetUp_BabeAppearance(UnitState, 1, GameState);
				//}
			//}
//
			//if (GroupState.EncounterID == 'ResistanceTeamMember_VIP' && GroupState.PrePlacedEncounterTag == 'ResistanceTeamMember_02')
			//{
				//UnitState = XComGameState_Unit(GameState.GetGameStateForObjectID(GroupState.m_arrMembers[0].ObjectID));
//
				//if (UnitState != none)
				//{
					////`LOG("Found babe #2: " @ UnitState.GetFullName(),, 'IRIDARBABE');
							//
					//SetUp_BabeAppearance(UnitState, 2, GameState);
				//}
			//}
		//}
	//}
	//return ELR_NoInterrupt;
//}

static function SetUp_MTFAppearance(out XComGameState_Unit UnitState, int iTwin, optional XComGameState GameState)
{	
	local XComUnitPawn			UnitPawn;
	local XGUnit				Unit;
	local XComGameState_Item	WeaponState;

	//if (nmCountry == '')
		//nmCountry = PickOriginCountry();

	//UnitState.SetCountry(PickOriginCountry());
	//UnitState.SetGender(eForceGender);
	//if(UnitState.Kappearance.iGender = eGender_Male)
	//{
	//UnitState.kAppearance.nmPawn = 'XCom_Soldier_M';
	//}
	////UnitState.kAppearance.iGender = eGender_Male; //1;
	//UnitState.kAppearance.iRace = Rand(4); 
	//UnitState.kAppearance.iSkinColor = Rand(5);
	//UnitState.kAppearance.iEyeColor = Rand(5);	//	random'ish
	//UnitState.kAppearance.iHairColor = Rand(5); // random'ish
	//UnitState.kAppearance.iAttitude = Rand(7);	//	random'ish
	//UnitState.kAppearance.nmBeard = '';
	//UnitState.kAppearance.nmArms = default.MaleArms[`SYNC_RAND(default.MaleArms.Length)];
	UnitState.kAppearance.nmLeftArmDeco = '';
	UnitState.kAppearance.nmRightArmDeco = '';
	UnitState.kAppearance.nmTorsoDeco = '';
	UnitState.kAppearance.nmEye = 'DefaultEyes';
	UnitState.kAppearance.nmFacePropUpper = 'Earring_F';
	UnitState.kAppearance.nmFacePropLower = '';
	UnitState.kAppearance.nmPatterns = 'Pat_Nothing';
	UnitState.kAppearance.nmHelmet = '';
	UnitState.kAppearance.nmLeftForearm = '';
	UnitState.kAppearance.nmRightForearm = '';
	UnitState.kAppearance.nmThighs = '';
	UnitState.kAppearance.nmShins = '';
	UnitState.kAppearance.nmTattoo_LeftArm = 'Tattoo_Arms_BLANK';
	UnitState.kAppearance.nmTattoo_RightArm = 'Tattoo_Arms_BLANK';
	UnitState.kAppearance.nmTeeth = 'DefaultTeeth';
	UnitState.kAppearance.iWeaponTint = 5;
	UnitState.kAppearance.nmWeaponPattern = 'Pat_Nothing';
	UnitState.kAppearance.nmVoice = 'FemaleVoice10_English_US';

	
	
	UnitPawn = Unit.GetPawn();

	if (UnitPawn != None && Unit != none && GameState != none)	//	if there's a game state passed, it means we're patching babe appearance right during the mission
	{															//	so we need to re-Init their pawn and weapon.
		//`LOG ("Refreshing unit pawn for: " @ UnitState.GetFullName(),, 'IRIDAR');

		Unit.Uninit();
		
		UnitPawn.SetAppearance(UnitState.kAppearance);
		
		Unit.Init(Unit.GetPlayer(), Unit.GetSquad(), UnitState);

		WeaponState = UnitState.GetItemInSlot(eInvSlot_PrimaryWeapon);
		XGWeapon(WeaponState.FindOrCreateVisualizer(GameState)).Init(WeaponState);
	}
	else	//	if there's no Game State, it means we're calling this during generation of soldier rewards
	{
		UnitState.StoreAppearance(); //	in which case we're saving babe's appereance to prevent it from being reset whenever player re-equips their armor.
	}
}