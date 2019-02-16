local t = My.Translator.translate

My = My or {}
My.SideMissions = My.SideMissions or {}

local function ShipTemplate()
    local ship = My.CpuShip(Util.random({
        "MU52 Hornet",
        "MT52 Hornet",
        "Adder MK4",
        "Adder MK5",
        "Adder MK6",
    }),"Outlaw")

    ship:addTag("local")
    ship:setImpulseMaxSpeed(ship:getImpulseMaxSpeed() * 1.5)

    return ship
end

My.SideMissions.DisableShip = function(station, x, y, player)
    local sectorName = Util.sectorName(x, y)
    local minPayment = My.SideMissions.paymentPerDistance(distance(station, x, y)) + My.SideMissions.paymentPerEnemy() * 0.25
    local maxBonus = My.SideMissions.paymentPerEnemy() * 0.75
    local shipCallSign = My.civilianShipName()
    local cronId = "disable_ship_" .. Util.randomUuid()
    local clientPerson = Person.newHuman()
    local thiefPerson = Person.newHuman()

    local isEscaping = false
    local mission

    local escapePosition = function(player, ship)
        local px, py = player:getPosition()
        local sx, sy = ship:getPosition()
        local angle = Util.angleFromVector(sx - px, sy - py)

        local dx, dy = Util.vectorFromAngle(angle, 10000)

        return sx + dx, sy + dy
    end
    local escape = function()
        if isEscaping then return end
        local target, player = mission:getTarget(), mission:getPlayer()
        isEscaping = true
        local hint = t("side_mission_disable_ship_approach_hint", shipCallSign, sectorName)
        mission:setHint(hint)
        player:addToShipLog(hint, "255,127,0")

        target:setHailText(t("side_mission_disable_ship_taunt_hail2"))

        Cron.regular(cronId, function()
            -- flight pattern of the ship
            if mission:getTarget() == nil then
                Cron.abort(cronId)
            elseif distance(mission:getTarget(), mission:getPlayer()) < 4000 then
                mission:getTarget():orderFlyTowardsBlind(escapePosition(mission:getPlayer(), mission:getTarget()))
            elseif distance(mission:getTarget(), x, y) < 500 then
                mission:getTarget():orderIdle()
            elseif distance(mission:getTarget(), mission:getPlayer()) > 6000 then
                mission:getTarget():orderFlyTowardsBlind(x, y)
            end
        end, 1, 1)
    end

    mission = Missions:disable(function()
        local target = ShipTemplate()
        target:setCallSign(shipCallSign)
        target:setPosition(x, y)
        target:setScannedDescription(t("side_mission_disable_ship_description", target:getCallSign()))
        target:setHailText(t("side_mission_disable_ship_taunt_hail1"))

        target:addComms(Comms:newReply(
            t("side_mission_disable_ship_taunt_player_says"),
            function()
                escape()
                return Comms:newScreen(t("side_mission_disable_ship_taunt_response"))
            end,
            function() return not isEscaping end
        ))

        return target
    end, {
        acceptCondition = function(self, error)
            if distance(player, x, y) < 15000 then
                return t("side_mission_disable_ship_comms_too_close")
            end
            return true
        end,
        onStart = function(self)
            local hint = t("side_mission_disable_ship_start_hint", shipCallSign, sectorName)
            self:setHint(hint)
            self:getPlayer():addToShipLog(hint, "255,127,0")

        end,
        approachDistance = 3500,
        onApproach = function(self)
            if not isEscaping then
                Tools:ensureComms(self:getTarget(), self:getPlayer(), t("side_mission_disable_ship_approach_comms", thiefPerson, shipCallSign))
            end
            escape(self)
        end,
        damageThreshold = 0,
        distanceToFinish = 2000,
        onSurrender = function(self)
            local target = self:getTarget()
            target:setFaction("SMC")
            target:addOrder(Order:dock(station, {
                delayAfter = 30,
                onCompletion = function(_, ship)
                    ship:destroy()
                end,
            }))
            Tools:ensureComms(self:getTarget(), self:getPlayer(), t("side_mission_disable_ship_surrender_comms", shipCallSign, self:getPlayer():getCallSign(), thiefPerson, station:getCallSign()))
        end,
        onDestruction = function(self)
            Tools:ensureComms(station, self:getPlayer(), t("side_mission_disable_ship_destruction_comms", shipCallSign, clientPerson))
        end,
        onSuccess = function(self)
            local health = self:getTarget():getHull() / self:getTarget():getHullMax()
            local payment = minPayment + health * maxBonus

            logInfo("Mission " .. self:getTitle() .. " successful.")
            self:getPlayer():addToShipLog(t("generic_mission_successful", self:getTitle()), "255,127,0")

            Tools:ensureComms(station, self:getPlayer(), t("side_mission_disable_ship_success_comms", shipCallSign, clientPerson, payment))
            self:getPlayer():addReputationPoints(payment)

            self:getTarget():setHailText(t("side_mission_disable_ship_taunt_hail1"))
        end,
        onFailure = function(self)
            logInfo("Mission " .. self:getTitle() .. " failed.")
            if self:getPlayer():isValid() then
                self:getPlayer():addToShipLog(t("generic_mission_failed", self:getTitle()), "255,127,0")
            end
        end,
        onEnd = function(self)
            Cron.abort(cronId)
        end,
    })

    Mission:withBroker(mission, t("side_mission_disable_ship", sectorName), {
        description = t("side_mission_disable_ship_briefing", sectorName, minPayment, maxBonus, shipCallSign, clientPerson, thiefPerson),
        acceptMessage = t("side_mission_disable_ship_accept"),
    })

    Mission:withTags(mission, "fighting")

    return mission
end