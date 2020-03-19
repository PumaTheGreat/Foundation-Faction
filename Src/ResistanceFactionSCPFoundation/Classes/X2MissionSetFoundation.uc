class X2MissionSetFoundation extends X2MissionSet config(GameCore);

static function array<X2DataTemplate> CreateTemplates()
{
    local array<X2MissionTemplate> Templates;

            Templates.AddItem(AddMissionTemplate('GatherMTFSurvivors'));
            
    return Templates;
}