class X2Item_FoundationSectopodWeapons extends X2Item_DefaultWeapons config(GameData_WeaponData);

//var config array<int> FLAT_BEAM_RANGE;
var config WeaponDamageValue FoundationSectopod_Wpn_BaseDamage;
var config WeaponDamageValue FoundationSECTOPOD_LIGHTINGFIELD_BASEDAMAGE;
var config WeaponDamageValue SECTOPOD_WRATHCANNON_BASEDAMAGE;
//var config int ASSAULTRIFLE_MAGNETIC_ICLIPSIZE;
//var config int ASSAULTRIFLE_MAGNETIC_ISOUNDRANGE;
//var config int ASSAULTRIFLE_MAGNETIC_IENVIRONMENTDAMAGE;
//var config int SECTOPOD_IDEALRANGE;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Weapons;

	Weapons.AddItem(CreateTemplate_FoundationSectopod_WPN());
	//Weapons.AddItem(CreateTemplate_FoundationSectopod_WrathCannon_WPN());

	return Weapons;

}

static function X2DataTemplate CreateTemplate_FoundationSectopod_WPN()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'FoundationSectopod_WPN');
	
	Template.WeaponPanelImage = "_BeamSniperRifle";                       // used by the UI. Probably determines iconview of the weapon.
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'rifle';
	Template.WeaponTech = 'magnetic';
	Template.strImage = "img:///UILibrary_Common.AlienWeapons.AdventTurret";
	Template.RemoveTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer); //invalidates multiplayer availability

	Template.RangeAccuracy = default.FLAT_BEAM_RANGE;
	Template.BaseDamage = default.FoundationSECTOPOD_WPN_BASEDAMAGE;
	Template.iClipSize = default.ASSAULTRIFLE_MAGNETIC_ICLIPSIZE;
	Template.iSoundRange = default.ASSAULTRIFLE_MAGNETIC_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.ASSAULTRIFLE_MAGNETIC_IENVIRONMENTDAMAGE;
	Template.iIdealRange = default.SECTOPOD_IDEALRANGE;

	Template.DamageTypeTemplateName = 'Heavy';
	
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('Blaster');
	Template.Abilities.AddItem('BlasterDuringCannon');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');
	
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "FoundationSectopod.WP_FoundationSectopod_Turret";

	Template.iPhysicsImpulse = 5;

	Template.CanBeBuilt = false;
	Template.TradingPostValue = 30;

	return Template;
}

//static function X2DataTemplate CreateTemplate_FoundationSectopod_WrathCannon_WPN()
//{
	//local X2WeaponTemplate Template;
//
	//`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'Sectopod_FoundationWrathcannon_WPN');
//
	//Template.WeaponPanelImage = "_BeamCannon";                       // used by the UI. Probably determines iconview of the weapon.
	//Template.ItemCat = 'weapon';
	//Template.WeaponCat = 'rifle';
	//Template.WeaponTech = 'magnetic';
	//Template.strImage = "img:///UILibrary_Common.AlienWeapons.AdventAssaultRifle";
	//Template.RemoveTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer); //invalidates multiplayer availability
//
	//Template.RangeAccuracy = default.FLAT_BEAM_RANGE;
	//Template.BaseDamage = default.SECTOPOD_WRATHCANNON_BASEDAMAGE;
	//Template.iClipSize = default.ASSAULTRIFLE_MAGNETIC_ICLIPSIZE;
	//Template.iSoundRange = default.ASSAULTRIFLE_MAGNETIC_ISOUNDRANGE;
	//Template.iEnvironmentDamage = default.ASSAULTRIFLE_MAGNETIC_IENVIRONMENTDAMAGE;
	//Template.iIdealRange = default.SECTOPOD_IDEALRANGE;
	//Template.iRange = 25;
	//Template.iRadius = 12;
//
	//Template.DamageTypeTemplateName = 'Heavy';
//
	//Template.InventorySlot = eInvSlot_SecondaryWeapon;
	//Template.Abilities.AddItem('FoundationWrathCannonStage1');
//
	//// This all the resources; sounds, animations, models, physics, the works.
	//Template.GameArchetype = "WP_Sectopod_Turret.WP_Sectopod_WrathCannon";
//
	//Template.iPhysicsImpulse = 5;
//
	//Template.CanBeBuilt = false;
	//Template.TradingPostValue = 30;
//
	//return Template;
//}
//

