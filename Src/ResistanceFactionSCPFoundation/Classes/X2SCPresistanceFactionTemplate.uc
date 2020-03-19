class X2SCPResistanceFactionTemplate extends X2ResistanceFactionTemplate;

//this just exists so it doesn't get auto built by the game and accidentally ruins how the Chosen and vanilla Factions are supposed to work

//---------------------------------------------------------------------------------------
function XComGameState_ResistanceFaction CreateInstanceFromTemplate(XComGameState NewGameState)
{
	local XComGameState_SCPResistanceFaction FactionState;
	FactionState = XComGameState_SCPResistanceFaction(NewGameState.CreateNewStateObject(class'XComGameState_SCPResistanceFaction', self));


	return FactionState;
}