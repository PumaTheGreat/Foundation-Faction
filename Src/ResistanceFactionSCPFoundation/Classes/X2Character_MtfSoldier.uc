class X2Character_MTFSoldier extends X2Character_DefaultCharacters;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;


	Templates.AddItem(CreateTemplate_MTFSoldier());

	return Templates;
}
static function X2CharacterTemplate CreateTemplate_MTFSoldier()
{
	local X2CharacterTemplate CharTemplate;

	CharTemplate = CreateSoldierTemplate('MTFSoldier');

	CharTemplate.bIsResistanceHero = true;
	CharTemplate.DefaultSoldierClass = 'MTFChief';
	CharTemplate.DefaultLoadout = 'SquaddieMTFChief';
	                                             
	CharTemplate.CharacterGeneratorClass = class'XGCharacterGenerator_MTFSoldier';
	CharTemplate.CustomizationManagerClass = class'XComCharacterCustomization_Soldier';
	CharTemplate.GetPawnNameFn = GetReaperPawnName;

	return CharTemplate;
}