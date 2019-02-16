local t = My.Translator.translate

My.EventHandler:register("onDrivesAvailable", function()
    local player = My.World.player
    local hq = My.World.hq

    local cronId = "wait_till_drive"
    local mission = Mission:new({
        onStart = function(self)
            Cron.regular(cronId, function()
                if player:hasJumpDrive() or player:hasWarpDrive() then
                    self:success()
                end
            end, 2)
        end,
        onSuccess = function(self)
            logInfo("Mission " .. self:getTitle() .. " successful.")
            self:getPlayer():addToShipLog(t("generic_mission_successful", self:getTitle()), "255,127,0")
        end,
        onFailure = function(self)
            logInfo("Mission " .. self:getTitle() .. " failed.")
            if self:getPlayer():isValid() then
                self:getPlayer():addToShipLog(t("generic_mission_failed", self:getTitle()), "255,127,0")
            end
        end,
        onEnd = function(self) Cron.abort(cronId) end
    })
    Mission:withBroker(mission, t("story_drives_available_mission", hq:getCallSign()))
    Mission:forPlayer(mission, player)
    mission:setMissionBroker(hq)
    mission:accept()
    mission:start()
    player:addMission(mission)
end)