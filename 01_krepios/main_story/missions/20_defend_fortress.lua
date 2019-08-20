local t = My.Translator.translate

local mission

My.EventHandler:register("onDefensePlanned", function()
    mission = Mission:new({})
    Mission:withBroker(mission, t("story_mission_defend_fortress", My.World.fortress:getCallSign()))
    Mission:forPlayer(mission)
    mission:setPlayer(My.World.player)
    mission:setMissionBroker(My.World.fortress)
    mission:accept()
    mission:start()
    My.World.player:addMission(mission)
end)

My.EventHandler:register("onCommanderDead", function()
    if mission ~= nil and mission:getState() == "started" then
        mission:fail()
    end
end)

My.EventHandler:register("onEnemiesDestroyed", function()
    if mission ~= nil and mission:getState() == "started" then
        mission:success()
    end
end)

