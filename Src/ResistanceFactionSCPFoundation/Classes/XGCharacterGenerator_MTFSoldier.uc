class XGCharacterGenerator_MTFSoldier extends XGCharacterGenerator;

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

//function bool IsSoldier(name CharacterTemplateName)
//{
	//return true;
//}

 function TSoldier CreateTSoldier( optional name CharacterTemplateName, optional EGender eForceGender, optional name nmCountry = '', optional int iRace = -1, optional name ArmorName )
//  Function SetUp_MTFAppearance( optional name CharacterTemplateName, optional EGender eForceGender, optional name nmCountry = '', optional int iRace = -1, optional name ArmorName )
{
    local XComLinearColorPalette HairPalette;
	local X2SimpleBodyPartFilter BodyPartFilter;
	local X2CharacterTemplate CharacterTemplate;
	local TAppearance DefaultAppearance;

	kSoldier.kAppearance = DefaultAppearance;	
	
	CharacterTemplate = SetCharacterTemplate(CharacterTemplateName, ArmorName);

	if (nmCountry == '')
		nmCountry = PickOriginCountry();

	//BodyPartFilter = `XCOMGAME.SharedBodyPartFilter;

	//When generating new characters, consider the DLC pack filters.
	//Use the player's settings from Options->Game Options to pick which DLC / Mod packs this generated soldier should draw from
	UpdateDLCPackFilters();
	`LOG("custom generator is called",, 'PumaGen');
	
	   


	SetCountry(nmCountry);
	SetRace(iRace);
	SetGender(eForceGender);
	//SetArmorTints(CharacterTemplate);	
	//BodyPartFilter.Set(EGender(kSoldier.kAppearance.iGender), ECharacterRace(kSoldier.kAppearance.iRace), kSoldier.kAppearance.nmTorso, !IsSoldier(CharacterTemplateName), , DLCNames);
	 if (kSoldier.kAppearance.iGender == eGender_Male)
	{
		kSoldier.kAppearance.nmArms = default.MaleArms[`SYNC_RAND(default.MaleArms.Length)];
	}
	else
	{
		kSoldier.kAppearance.nmArms = default.FemaleArms[`SYNC_RAND(default.FemaleArms.Length)];
	}
	
	if (kSoldier.kAppearance.iGender == eGender_Male)
	{
		kSoldier.kAppearance.nmTorso = default.MaleTorsos[`SYNC_RAND(default.MaleTorsos.Length)];
	}
	else
	{
		kSoldier.kAppearance.nmTorso = default.FemaleTorsos[`SYNC_RAND(default.FemaleTorsos.Length)];
	}

    if (kSoldier.kAppearance.iGender == eGender_Male)
	{
		kSoldier.kAppearance.nmLegs = default.MaleLegs[`SYNC_RAND(default.MaleLegs.Length)];
	}
	else
	{
		kSoldier.kAppearance.nmLegs = default.FemaleLegs[`SYNC_RAND(default.FemaleLegs.Length)];
	}



	HairPalette = `CONTENT.GetColorPalette(ePalette_HairColor);
	kSoldier.kAppearance.iHairColor = ChooseHairColor(kSoldier.kAppearance, HairPalette.BaseOptions); // Only generate with base options
	kSoldier.kAppearance.iEyeColor = Rand(5); 
	kSoldier.kAppearance.iWeaponTint = 5; //should make it gun metal grey
	kSoldier.kAppearance.iSkinColor = Rand(5);
	
	kSoldier.kAppearance.iArmorTint = default.PrimaryArmorColors[`SYNC_RAND(default.PrimaryArmorColors.Length)];
	kSoldier.kAppearance.iArmorTintSecondary = default.SecondaryArmorColors[`SYNC_RAND(default.SecondaryArmorColors.Length)];

	kSoldier.KAppearance.nmPatterns = 'Pat_Nothing';
	kSoldier.KAppearance.nmWeaponPattern = 'Pat_Nothing';

	SetMTFVoice(CharacterTemplateName, nmCountry);

	SetAttitude();
	//GenerateName( kSoldier.kAppearance.iGender, kSoldier.nmCountry, kSoldier.strFirstName, kSoldier.strLastName, kSoldier.kAppearance.iRace );

	
	//BioCountryName = kSoldier.nmCountry;
	return kSoldier;
}

function SetMTFVoice(name CharacterTemplateName, name CountryName)
{
	local bool UseAlternate;

	UseAlternate = `SYNC_RAND(100) > 50;
	if (kSoldier.kAppearance.iGender == eGender_Male)
	{
		kSoldier.kAppearance.nmVoice = (UseAlternate) ? 'TVP_GHOST2' : 'TVP_GHOST3';
	}
	else
	{
		kSoldier.kAppearance.nmVoice = (UseAlternate) ? 'TVP_GHOST4' : 'TVP_GHOST4';
	}

}
	function SetAccessories(X2SimpleBodyPartFilter BodyPartFilter, name CharacterTemplateName)
{
	local X2BodyPartTemplateManager PartTemplateManager;

	PartTemplateManager = class'X2BodyPartTemplateManager'.static.GetBodyPartTemplateManager();

	
	if (kSoldier.kAppearance.iGender == eGender_Male)
	{
		kSoldier.kAppearance.nmHelmet = default.MaleHelmets[`SYNC_RAND(default.MaleHelmets.Length)];
	}
	else
	{
		kSoldier.kAppearance.nmHelmet = default.FemaleHelmets[`SYNC_RAND(default.FemaleHelmets.Length)];
	}
}

//function SetArmorTints(X2CharacterTemplate CharacterTemplate)
//{
	//super.SetArmorTints(CharacterTemplate);
//
	//kSoldier.kAppearance.iArmorTint = default.PrimaryArmorColors[`SYNC_RAND(default.PrimaryArmorColors.Length)];
	//kSoldier.kAppearance.iArmorTintSecondary = default.SecondaryArmorColors[`SYNC_RAND(default.SecondaryArmorColors.Length)];
//}