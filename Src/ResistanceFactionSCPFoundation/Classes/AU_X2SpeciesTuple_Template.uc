class AU_X2SpeciesTuple_Template extends X2StrategyElementTemplate config(AlliesUnknown);

var config name TemplateName; //name of the character template of species, ie TurianSoldier, KroganSoldier, QunariSoldier, MutonSoldier, etc

var config int RecruitCost; //supplies to recruit a particular recruit of a species

var config int MonthsRequired; //is there a minimum amount of time to wait? (0 = March)

var config int ForceLevelRequired; //are you using a X2 alien and don't want them to show up too early?

var config bool CanBeReward; //can this unit be a reward from missions, rumours of the resistance, etc?

var config bool CanBeMarket; //can this unit be bought at Resistance HQ or at the Black Market?

var config bool NoRecruit; //can this unit NOT be recruited in the Avenger?

var config int MarketCost; //how much does this unit cost at the black market?
var localized string SpeciesName;
