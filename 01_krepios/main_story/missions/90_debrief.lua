local t = My.Translator.translate
local mission

My.EventHandler:register("onEnemiesDestroyed", function()
    mission = Mission:new({})
    Mission:withBroker(mission, t("story_mission_debrief"))
    mission:setHint(t("story_mission_debrief_hint", My.Wormhole:getSectorName()))
    Mission:forPlayer(mission)
    mission:setPlayer(My.World.player)
    mission:setMissionBroker(My.World.colonel)
    mission:accept()
    mission:start()
    My.World.player:addMission(mission)
end)

