class Foundation_X2Helpers extends Object;

static function bool IsUsingLW2()
{
	return IsLW2Installed();
}

static function bool IsUsingDLC3()
{

	return IsDLC3Installed();
}

//static function AU_X2SpeciesTuple_Template GetMarketSpecies(optional bool IsStart)
//{
	//local X2StrategyElementTemplateManager TemplateManager;
	//local X2DataTemplate Template;
	//local AU_X2SpeciesTuple_Template SpeciesTemplate;
	//local array<AU_X2SpeciesTuple_Template> Species;
	//local XComGameState_HeadquartersResistance ResHQ;
	//local XComGameState_HeadquartersAlien AlienHQ;
	//local int i;
//
	//TemplateManager = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();
	//ResHQ = class'UIUtilities_Strategy'.static.GetResistanceHQ();
	//AlienHQ = class'UIUtilities_Strategy'.static.GetAlienHQ();
//
	//foreach TemplateManager.IterateTemplates(Template, none)
	//{
		//SpeciesTemplate = AU_X2SpeciesTuple_Template(Template);
//
		//if(SpeciesTemplate != none && SpeciesTemplate.MonthsRequired <= ResHQ.NumMonths && SpeciesTemplate.ForceLevelRequired <= AlienHQ.GetForceLevel() && SpeciesTemplate.CanBeMarket == true && !IsStart)
		//{
		//Species.AddItem(SpeciesTemplate);
		//}
//
		//if(IsStart && SpeciesTemplate != none && SpeciesTemplate.CanBeMarket == true)
		//{
		//Species.AddItem(SpeciesTemplate);
		//}		
//
	//}
		//i = `SYNC_RAND_STATIC(Species.Length);
//
	//return Species[i];
//
//}
//
//
//
//static function AU_X2SpeciesTuple_Template GetRewardSpecies(optional bool IsStart)
//{
	//local X2StrategyElementTemplateManager TemplateManager;
	//local X2DataTemplate Template;
	//local AU_X2SpeciesTuple_Template SpeciesTemplate;
	//local array<AU_X2SpeciesTuple_Template> Species;
	//local XComGameState_HeadquartersResistance ResHQ;
	//local XComGameState_HeadquartersAlien AlienHQ;
	//local int i;
//
	//TemplateManager = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();
	//ResHQ = class'UIUtilities_Strategy'.static.GetResistanceHQ();
	//AlienHQ = class'UIUtilities_Strategy'.static.GetAlienHQ();
//
	//foreach TemplateManager.IterateTemplates(Template, none)
	//{
		//SpeciesTemplate = AU_X2SpeciesTuple_Template(Template);
//
		//if(SpeciesTemplate != none && SpeciesTemplate.MonthsRequired <= ResHQ.NumMonths && SpeciesTemplate.ForceLevelRequired <= AlienHQ.GetForceLevel() && SpeciesTemplate.CanBeReward == true && !IsStart)
		//{
		//Species.AddItem(SpeciesTemplate);
		//}
//
		//if(IsStart && SpeciesTemplate != none && SpeciesTemplate.CanBeReward == true)
		//{
		//Species.AddItem(SpeciesTemplate);
		//}
//
	//}
//
	//i = `SYNC_RAND_STATIC(Species.Length);
//
	//return Species[i];
//
//}
//
//
//static function AU_X2SpeciesTuple_Template GetRandomSpecies(optional bool IsStart)
//{
	//local X2StrategyElementTemplateManager TemplateManager;
	//local X2DataTemplate Template;
	//local AU_X2SpeciesTuple_Template SpeciesTemplate;
	//local array<AU_X2SpeciesTuple_Template> Species;
	//local XComGameState_HeadquartersResistance ResHQ;
	//local XComGameState_HeadquartersAlien AlienHQ;
	//local int i;
//
	//TemplateManager = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();
	//ResHQ = class'UIUtilities_Strategy'.static.GetResistanceHQ();
	//AlienHQ = class'UIUtilities_Strategy'.static.GetAlienHQ();
//
	//foreach TemplateManager.IterateTemplates(Template, none)
	//{
		//SpeciesTemplate = AU_X2SpeciesTuple_Template(Template);
//
		//if(SpeciesTemplate != none && SpeciesTemplate.MonthsRequired <= ResHQ.NumMonths && SpeciesTemplate.ForceLevelRequired <= AlienHQ.GetForceLevel() && !SpeciesTemplate.NoRecruit && !IsStart)
		//{
		//Species.AddItem(SpeciesTemplate);
		//}
//
		//if(IsStart && SpeciesTemplate != none)
		//{
		//Species.AddItem(SpeciesTemplate);
		//}
//
		//i = `SYNC_RAND_STATIC(Species.Length);
	//}
//
	//return Species[i];
//
//}
//
//static function AU_X2SpeciesTuple_Template FindSpeciesTemplate(Name DataName)
//{
	//local AU_X2SpeciesTuple_Template SpeciesTemplate;
	//local X2StrategyElementTemplateManager TemplateManager;
	//local X2DataTemplate Template;
//
	//TemplateManager = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();
//
	//foreach TemplateManager.IterateTemplates(Template, none)
	//{
		//SpeciesTemplate = AU_X2SpeciesTuple_Template(Template);
//
		//if(SpeciesTemplate != none && DataName == SpeciesTemplate.TemplateName)
		//{
			//return SpeciesTemplate;
		//}
	//}
//}
//
//static function GetAllSpeciesTemplates(out array<AU_X2SpeciesTuple_Template> Species)
//{
	//local X2StrategyElementTemplateManager TemplateManager;
	//local X2DataTemplate Template;
	//local AU_X2SpeciesTuple_Template SpeciesTemplate;
	//local XComGameState_HeadquartersResistance ResHQ;
	//local XComGameState_HeadquartersAlien AlienHQ;
	//TemplateManager = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();
//
	//ResHQ = class'UIUtilities_Strategy'.static.GetResistanceHQ();
	//AlienHQ = class'UIUtilities_Strategy'.static.GetAlienHQ();
//
	//foreach TemplateManager.IterateTemplates(Template, none)
	//{
		//SpeciesTemplate = AU_X2SpeciesTuple_Template(Template);
//
		//if(SpeciesTemplate != none && SpeciesTemplate.MonthsRequired <= ResHQ.NumMonths && SpeciesTemplate.ForceLevelRequired <= AlienHQ.GetForceLevel())
		//{
			//Species.AddItem(SpeciesTemplate);
		//}
	//}
//
//}
//
//
//static function DebugAllSpeciesTemplates(out array<AU_X2SpeciesTuple_Template> Species)
//{
	//local X2StrategyElementTemplateManager TemplateManager;
	//local X2DataTemplate Template;
	//local AU_X2SpeciesTuple_Template SpeciesTemplate;
//
	//TemplateManager = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();
//
	//foreach TemplateManager.IterateTemplates(Template, none)
	//{
		//SpeciesTemplate = AU_X2SpeciesTuple_Template(Template);
//
		//if(SpeciesTemplate != none)
		//{
			//Species.AddItem(SpeciesTemplate);
		//}
	//}
//
//}
//
static function bool IsLW2Installed() { 
	local X2DownloadableContentInfo Mod;
	
	foreach `ONLINEEVENTMGR.m_cachedDLCInfos(Mod) {
        if (Mod.Class.Name == 'X2DownloadableContentInfo_LW_Overhaul') {
			return true;
		}
	}
	return false;
}


static function bool IsDLC3Installed() { 
	local X2DownloadableContentInfo Mod;
	
	foreach `ONLINEEVENTMGR.m_cachedDLCInfos(Mod) {
        if (Mod.Class.Name == 'X2DownloadableContentInfo_DLC_Day90') {
			return true;
		}
	}
	return false;
}

static function XComGameState_SCPResistanceFaction GetFoundationState(optional XComGameState NewGameState) {
	local XComGameState_SCPResistanceFaction Foundation;

	if(NewGameState != none) {
		foreach NewGameState.IterateByClassType(class'XComGameState_SCPResistanceFaction', Foundation) {
			break;
		}
	}

	if(Foundation == none) {
		foreach `XCOMHISTORY.IterateByClassType(class'XComGameState_SCPResistanceFaction', Foundation) {
			break;
		}
	}

	if(Foundation == none) {
		Foundation = XComGameState_SCPResistanceFaction(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_SCPResistanceFaction'));
	}

	return Foundation;
}

static function XComGameState_SCPResistanceFaction GetNewFoundationState(XComGameState NewGameState) {
	local XComGameState_SCPResistanceFaction Foundation;

	Foundation = GetFoundationState(NewGameState);
	Foundation = XComGameState_SCPResistanceFaction(NewGameState.ModifyStateObject(class'XComGameState_SCPResistanceFaction', Foundation.ObjectID));
	return Foundation;
}
