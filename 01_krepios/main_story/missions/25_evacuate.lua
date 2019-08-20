local t = My.Translator.translate
local mission

My.EventHandler:register("onClosingInToFortress", function()
    mission = Mission:new({})
    Mission:withBroker(mission, t("story_mission_evacuate"))
    mission:setHint(t("story_mission_evacuate_hint", My.Wormhole:getSectorName()))
    Mission:forPlayer(mission)
    mission:setPlayer(My.World.player)
    mission:setMissionBroker(My.World.colonel)
    mission:accept()
    mission:start()
    My.World.player:addMission(mission)
end)

My.EventHandler:register("onEnemiesDestroyed", function()
    if mission ~= nil and mission:getState() == "started" then
        mission:success()
    end
end)

My.EventHandler:register("onEvacComplete", function()
    if mission ~= nil and mission:getState() == "started" then
        mission:success()
    end
end)
