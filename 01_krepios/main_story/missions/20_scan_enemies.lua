local t = My.Translator.translate
local mission

My.EventHandler:register("onAttackersDetection", function()
    local ships = {}
    for _, fleet in pairs(My.EnemyFleet:getFleets()) do
        for _, ship in pairs(fleet:getShips()) do
            table.insert(ships, ship)
        end
    end

    local mission = Missions:scan(ships, {
        scan = "full",
        onStart = function(self) self:setHint(t("story_mission_scan_enemies", self:countUnscannedTargets())) end,
        onDestruction = function(self) self:setHint(t("story_mission_scan_enemies", self:countUnscannedTargets())) end,
        onScan = function(self, ship)
            self:getPlayer():addReputationPoints(10)
            self:setHint(t("story_mission_scan_enemies", self:countUnscannedTargets()))
        end,
    })
    Mission:withBroker(mission, t("story_mission_scan_enemies"))
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