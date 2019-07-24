local t = My.Translator.translate

local missions = {}

My.EventHandler:register("onStart", function()
    for _, station in pairs(My.World.stations) do
        if station == My.World.hq then
            My.World.player:addQuickDial(station)
        else
            local visitMission = Missions:visit(station, {
                onSuccess = function(self)
                    My.World.player:addReputationPoints(10)
                    My.World.player:addQuickDial(station)
                    logInfo("Mission " .. self:getTitle() .. " successful.")
                    self:getPlayer():addToShipLog(t("generic_mission_successful", self:getTitle()), "255,127,0")
                end,
                onFailure = function(self)
                    logInfo("Mission " .. self:getTitle() .. " failed.")
                    if self:getPlayer():isValid() then
                        self:getPlayer():addToShipLog(t("generic_mission_failed", self:getTitle()), "255,127,0")
                    end
                end,
            })
            visitMission:setPlayer(My.World.player)
            Mission:withBroker(visitMission, t("story_mission_visit", station:getCallSign()), {missionBroker = My.World.hq})
            visitMission:accept(); visitMission:start()
            My.World.player:addMission(visitMission)

            table.insert(missions, visitMission)
        end
    end
end, 99)

My.EventHandler:register("onAttackersDetection", function()
    for _, mission in pairs(missions) do
        if Mission:isMission(mission) and mission:getState() == "started" then
            mission:fail()
        end
    end
end)