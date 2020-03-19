class X2FoundationStrategyCardTemplate extends X2StrategyCardTemplate;

//---------------------------------------------------------------------------------------
function XComGameState_StrategyCard CreateInstanceFromTemplate(XComGameState NewGameState)
{
	local XComGameState_FoundationStrategyCard CardState;

	CardState = XComGameState_FoundationStrategyCard(NewGameState.CreateNewStateObject(class'XComGameState_FoundationStrategyCard', self));


	return CardState;
}
