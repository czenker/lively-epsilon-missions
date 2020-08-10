local t = My.Translator.translate

My = My or {}
My.SideMissions = My.SideMissions or {}

My.SideMissions.DriveTest = function(station, player)
    if not station:hasTag("shipyard") then return end

    local payment = My.SideMissions.paymentPerDistance(4000 * 7) * (math.random() * 0.8 + 1.6)
    local bonusPayment = My.SideMissions.paymentPerDistance(4000 * 7) * (math.random() * 0.4 + 0.8)
    local bonusTime = 7 * 4000 / 3600
    local startTime
    local targetScenarioTime

    local person = station:getCrewAtPosition("tinkerer")

    local mission

    local wayPointArtifacts = {}
    local cronIds = {}

    -- a list of complications that challenge the players
    local majorComplications = Util.randomSort({
        -- make ship drift to the left
        function(self)
            logDebug("Start complication where ship steers to the left")
            local lastX, lastY = self:getPlayer():getPosition()
            local cronId = Cron.regular(function()
                local currentX, currentY = self:getPlayer():getPosition()
                local d = distance(lastX, lastY, currentX, currentY)
                local rotDelta = d / 85 * self:getPlayer():getRotationMaxSpeed()

                self:getPlayer():setRotation(self:getPlayer():getRotation() - rotDelta)

                lastX, lastY = currentX, currentY
            end)

            Tools:ensureComms(self:getMissionBroker(), self:getPlayer(), t("side_mission_drive_test_complication1", person))
            return cronId
        end,

        -- generate heat on all systems
        function(self)
            logDebug("Start complication where ship generates heat on systems")
            local defaultHeat = 0.2
            local delay = 5
            local lastX, lastY = self:getPlayer():getPosition()

            local cronId = Cron.regular(function(_, delta)
                local currentX, currentY = self:getPlayer():getPosition()
                local speed = distance(lastX, lastY, currentX, currentY) / delta
                lastX, lastY = currentX, currentY

                local system = Util.random({
                    "reactor",
                    "beamweapons",
                    "missilesystem",
                    "maneuver",
                    "impulse",
                    "frontshield",
                    "rearshield",
                })

                local heatDelta = defaultHeat * speed / self:getPlayer():getImpulseMaxSpeed()
                local heat = self:getPlayer():getSystemHeat(system) + heatDelta
                local damage = 0
                if heat > 1 then
                    damage = heat - 1
                    heat = 1
                end
                self:getPlayer():setSystemHeat(system, heat)
                self:getPlayer():setSystemHealth(system, self:getPlayer():getSystemHealth(system) - damage)
            end, delay)

            Tools:ensureComms(self:getMissionBroker(), self:getPlayer(), t("side_mission_drive_test_complication2", person))
            return cronId
        end,

        -- damage systems regularly
        function(self)
            logDebug("Start complication where systems are damaged")
            local lastDisasterX, lastDisasterY = station:getPosition()
            local cronId = Cron.regular(function()
                local player = self:getPlayer()
                local x, y = player:getPosition()
                if distance(lastDisasterX, lastDisasterY, x, y) > 3000 then
                    for _=1,3 do
                        local system = Util.random({
                            "reactor",
                            "beamweapons",
                            "missilesystem",
                            "maneuver",
                            "frontshield",
                            "rearshield",
                        })
                        player:setSystemHealth(system, player:getSystemHealth(system) - 0.2)
                    end
                    player:setSystemHealth("impulse", player:getSystemHealth("impulse") - 0.4)
                    lastDisasterX, lastDisasterY = x, y
                    ElectricExplosionEffect():setPosition(x, y):setSize(100)
                end
            end, 3)

            Tools:ensureComms(self:getMissionBroker(), self:getPlayer(), t("side_mission_drive_test_complication3", person))
            return cronId
        end,
    })

    -- first: fly by all waypoints...
    local wayPointMission = Missions:wayPoints(nil, {
        onStart = function(self)
            local playerRotation = self:getParentMission():getPlayer():getRotation()
            for i=1,6 do
                -- using a hexagonal form with a radius of less than the short range scanner range should guarantee
                -- that helms can always spot the next waypoint
                local x, y = Util.addVector(station, playerRotation + (i-1) * 60, 4000)
                local artifact = Artifact():
                    setModel("does_not_exist"):
                    setPosition(x, y):
                    setCallSign(t("side_mission_drive_test_artifact_name", i)):
                    allowPickup(false)

                table.insert(wayPointArtifacts, artifact)

                self:addWayPoint(artifact)
            end
            self:getParentMission():setHint(
                t("side_mission_drive_test_hint", 1, station:getCallSign()) .. " " ..
                t("side_mission_drive_test_hint_bonus", targetScenarioTime)
            )
        end,
        onWayPoint = function(self, wayPoint)
            if wayPoint:isValid() then wayPoint:destroy() end
            local thisWaypoint = self:countVisitedWayPoints() + 1
            if thisWaypoint % 2 == 1 then
                local cronId = majorComplications[(thisWaypoint+1)/2](self:getParentMission())
                table.insert(cronIds, cronId)
            end
            self:getParentMission():getPlayer():addToShipLog(t("side_mission_drive_test_log", thisWaypoint), "255,127,0")
            self:getParentMission():setHint(
                t("side_mission_drive_test_hint", thisWaypoint + 1, station:getCallSign()) .. " " ..
                t("side_mission_drive_test_hint_bonus", targetScenarioTime)
            )
        end,
        minDistance = 500,

        onEnd = function(self)
            for _, artifact in pairs(wayPointArtifacts) do
                if artifact:isValid() then artifact:destroy() end
            end
        end,
    })

    -- second: dock with the station again
    local dockMission = Missions:visit(station, {
        onStart = function(self)
            self:getParentMission():setHint(
                t("side_mission_drive_test_hint_dock", station:getCallSign()) .. " " ..
                t("side_mission_drive_test_hint_bonus", targetScenarioTime)
            )
        end
    })

    -- make sure we can restore warp and jump drives
    local hadJumpDrive = nil
    local hadWarpDrive = nil

    mission = Mission:chain(wayPointMission, dockMission, {
        acceptCondition = function(self)
            if not player:isDocked(station) then
                return t("side_mission_drive_test_accept_dock")
            end
            return true
        end,
        onAccept = function(self)
            startTime = Cron.now()
            targetScenarioTime = getScenarioTime() + bonusTime * 60
        end,
        onStart = function(self)
            hadJumpDrive = self:getPlayer():hasJumpDrive()
            hadWarpDrive = self:getPlayer():hasWarpDrive()
            self:getPlayer():setWarpDrive(false)
            self:getPlayer():setJumpDrive(false)

        end,
        onSuccess = function(self)
            local thePayment = payment
            if Cron.now() - startTime <= bonusTime * 60 then
                thePayment = thePayment + bonusPayment
            end
            self:getMissionBroker():sendCommsMessage(self:getPlayer(), t("side_mission_drive_test_success", person, thePayment))
            self:getPlayer():addReputationPoints(thePayment)
            station:addFunding(thePayment / 2)
        end,
        onEnd = function(self)
            self:getPlayer():setWarpDrive(hadWarpDrive)
            self:getPlayer():setJumpDrive(hadJumpDrive)
            for _, cronId in pairs(cronIds) do
                Cron.abort(cronId)
            end
        end,
    })

    Mission:forPlayer(mission)
    Mission:withBroker(mission, t("side_mission_drive_test"), {
        description = t("side_mission_drive_test_description", person, payment, bonusTime, bonusPayment),
        acceptMessage = t("side_mission_drive_test_accept"),
    })

    return mission
end