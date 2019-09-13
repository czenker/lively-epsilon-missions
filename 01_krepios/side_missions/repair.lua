local t = My.Translator.translate

My = My or {}
My.SideMissions = My.SideMissions or {}

local ShipTemplate = function()
    local rnd = math.random(1, 5)
    local ship = My.CpuShip(Util.random({
        "Personnel Freighter " .. rnd,
        "Goods Freighter " .. rnd,
        "Garbage Freighter " .. rnd,
        "Equipment Freighter " .. rnd,
        "Fuel Freighter " .. rnd,
        "MT52 Hornet",
        "MU52 Hornet",
        "Adder MK4",
        "Adder MK5",
        "Adder MK6",
    }), "Civilian")
    ship:setCallSign(My.civilianShipName())

    ship:addTag("merchant")
    ship:addTag("local")

    return ship
end

My.SideMissions.Repair = function(station, from, player)

    local crewCount = math.random(
            math.max(player:getRepairCrewCount() - 2, 2),
            math.max(player:getRepairCrewCount(), 4)
    )

    local duration = math.random(300, 600)
    local x, y = Util.onVector(from, station, math.random() * 0.6 + 0.1)

    local captain = Person:newHuman()
    local payment = My.SideMissions.paymentPerDistance(distance(station, x, y)) * 1.5 + crewCount * duration / 30

    local mission

    local comms = function(comms_target, comms_source)
        local screen = Comms:newScreen()
        local workLeft = mission:getTimeToReady() / duration

        if workLeft > 0.95 then
            screen:addText(t("side_mission_repair_comms_1"))
        elseif workLeft > 0.85 then
            screen:addText(t("side_mission_repair_comms_2"))
        elseif workLeft > 0.6 then
            screen:addText(t("side_mission_repair_comms_3"))
        elseif workLeft > 0.4 then
            screen:addText(t("side_mission_repair_comms_4"))
        elseif workLeft > 0.2 then
            screen:addText(t("side_mission_repair_comms_5"))
        elseif workLeft > 0.1 then
            screen:addText(t("side_mission_repair_comms_6"))
        elseif workLeft > 0 then
            screen:addText(t("side_mission_repair_comms_7"))
        else
            screen:addText(t("side_mission_repair_comms_completed", station:getCallSign()))
        end

        screen:addReply(Comms:newReply(t("generic_button_back")))

        return screen
    end
    local commsId

    local description = t("side_mission_repair_ship_description")
    local descriptionBroken = t("side_mission_repair_ship_description_broken")

    mission = Missions:crewForRent(function()
        local ship = ShipTemplate():
        setPosition(x, y):
        orderIdle()
        ship.original_speed = ship:getImpulseMaxSpeed()

        ship:setImpulseMaxSpeed(0):setJumpDrive(false):setWarpDrive(false)
        Ship:withCaptain(ship, captain)

        ship:setHailText(function(ship, player)
            return t("side_mission_repair_hail")
        end)
        commsId = ship:addComms(Comms:newReply(t("side_mission_repair_comms_label"), comms, function() return mission:getRepairCrewCount() > 0 end))

        ship:setDescriptionForScanState("simple", description .. " " .. descriptionBroken)
        ship:setDescriptionForScanState("full", description .. " " .. descriptionBroken .. " " .. t("side_mission_repair_ship_description_extended"))

        return ship
    end, {
        acceptCondition = function()
            if player:getRepairCrewCount() < crewCount then
                return t("side_mission_repair_small_crew")
            end
            return true
        end,
        onStart = function(self)
            self:getPlayer():addQuickDial(self:getNeedy())
            local hint = t("side_mission_repair_start_hint", self:getNeedy():getCallSign(), self:getNeedy():getSectorName())
            self:setHint(hint)
            self:getPlayer():addToShipLog(hint, "255,127,0")
        end,
        crewCount = crewCount,
        duration = duration,
        sendCrewLabel = t("side_mission_repair_send_crew_label", crewCount),
        sendCrewFailed = function(self)
            self:getPlayer():addCustomMessage("engineering", self:getId() .. "info", t("side_mission_repair_send_crew_failure", crewCount))
        end,
        onCrewArrived = function(self)
            self:getNeedy():setHailText(t("comms_generic_hail_friendly_ship", self:getNeedy():getCaptain()))
            self:getNeedy():sendCommsMessage(player, t("side_mission_repair_crew_arrived_comms"))

            local hint = t("side_mission_repair_crew_arrived_hint", self:getNeedy():getCallSign())
            self:setHint(hint)
            self:getPlayer():addToShipLog(hint, "255,127,0")

            self:getNeedy():setDescriptionForScanState("full", description .. " " .. descriptionBroken .. " " .. t("side_mission_repair_ship_description_crew"))
        end,
        onCrewReady = function(self)
            Tools:ensureComms(self:getNeedy(), self:getPlayer(), t("side_mission_repair_crew_ready_comms", captain, station:getCallSign()))
            self:getNeedy():setImpulseMaxSpeed(self:getNeedy().original_speed or 60)
            if station:isValid() then self:getNeedy():orderDock(station) end

            local hint = t("side_mission_repair_crew_ready_hint", self:getNeedy():getCallSign(), station:getCallSign())
            self:setHint(hint)
            self:getPlayer():addToShipLog(hint, "255,127,0")

            self:getNeedy():setDescriptionForScanState("simple", description)
            self:getNeedy():setDescriptionForScanState("full", description .. " " .. t("side_mission_repair_ship_description_repaired"))
        end,
        returnCrewLabel = t("side_mission_repair_return_crew_label", crewCount),
        onCrewReturned = function(self)
            self:getNeedy():setHailText(t("side_mission_repair_crew_returned_hail"))

            self:getPlayer():addReputationPoints(payment)

            self:getNeedy():sendCommsMessage(self:getPlayer(), t("side_mission_repair_crew_returned_comms", payment))
            if isString(commsId) then self:getNeedy():removeComms(commsId) end
        end,
        onSuccess = function(self)
            if station:isValid() then self:getNeedy():orderDock(station) end

            -- despawn ship a certain time after it reached its destination
            local cronId = Util.randomUuid()
            Cron.regular(cronId, function()
                if not station:isValid() or not self:getNeedy():isValid() or self:getNeedy():isDocked(station) then
                    Cron.once(cronId, function()
                        if self:getNeedy():isValid() then self:getNeedy():destroy() end
                    end, 60)
                end
            end, 5)
        end,
        onDestruction = function(self)
            local text
            if self:getRepairCrewCount() > 0 then
                text = t("side_mission_repair_failure_comms_crew_lost")
            else
                text = t("side_mission_repair_failure_comms")
            end
            Tools:ensureComms(station, self:getPlayer(), text)
        end,
        onEnd = function(self)
            local needy = self:getNeedy()
            if needy ~= nil and needy:isValid() then
                player:removeQuickDial(needy)
            end
        end,
    })

    Mission:withBroker(mission, t("side_mission_repair"), {
        description = t("side_mission_repair_description", captain, from:getCallSign(), station:getCallSign(), crewCount, payment),
        acceptMessage = t("side_mission_repair_accept"),
    })

    return mission
end