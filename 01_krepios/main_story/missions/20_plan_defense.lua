local t = My.Translator.translate

local mission

My.EventHandler:register("onAttackersDetection", function()
    mission = Mission:new({})
    Mission:withBroker(mission, t("story_mission_plan_defense", My.Commander:getPerson(), My.World.fortress:getCallSign()))
    Mission:forPlayer(mission)
    mission:setHint(t("story_mission_plan_defense_hint", My.World.fortress:getSectorName()))
    mission:setPlayer(My.World.player)
    mission:setMissionBroker(My.World.fortress)
    mission:accept()
    mission:start()
    My.World.player:addMission(mission)
end)

My.EventHandler:register("onFortressManned", function()
    if mission ~= nil then
        mission:setHint(t("story_mission_plan_defense_hint2", My.Commander:getPerson(), My.World.fortress:getSectorName()))
    end
end)

My.EventHandler:register("onDefensePlanned", function()
    if mission ~= nil and mission:getState() == "started" then
        mission:success()
    end
end)

My.EventHandler:register("onCommanderDead", function()
    if mission ~= nil and mission:getState() == "started" then
        mission:fail()
    end
end)
