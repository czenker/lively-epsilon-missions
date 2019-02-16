local t = My.Translator.translate

My = My or {}
My.SideMissions = My.SideMissions or {}

local ShipTemplate = function()
    local ship = My.CpuShip(Util.random({
        "Phobos M3",
        "Phobos T3",
        "Piranha F8",
    }), "Outlaw")

    ship:addTag("local")

    return ship
end

local WingmanTemplate = function()
    local ship = My.CpuShip(Util.random({
        "WX-Lindworm",
        "Adder MK4",
        "Adder MK5",
        "Adder MK6",
        "Ranus U",
    }), "Outlaw")
    ship:addTag("local")

    return ship
end

My.SideMissions.Capture = function(station, x, y, player)
    local sectorName = Util.sectorName(x, y)
    local person = Person:newHuman()
    local product = Product:new(person:getFormalName(), {size = 4})
    local companionsNr = math.random(0, 2)
    local companions = {}

    local payment = My.SideMissions.paymentPerDistance(distance(station, x, y)) * 2 + (1 + companionsNr * 0.5) * My.SideMissions.paymentPerEnemy()

    local mission = Missions:capture(function()
        local target = ShipTemplate():
        setCallSign(My.civilianShipName()):
        setPosition(x, y):
        orderDefendLocation(x, y):
        setScannedDescription(t("side_mission_capture_ship_description", person))

        Ship:withCaptain(target, person)

        for i=1, companionsNr do
            local ship = WingmanTemplate():
            setCallSign(My.civilianShipName())
            Util.spawnAtStation(target, ship)

            ship:setScannedDescription(t("side_mission_capture_companion_description", ship:getCaptain(), person))
            ship:orderDefendTarget(target)

            table.insert(companions, ship)
        end
        return target
    end, {
        acceptCondition = function(self, error)
            if distance(player, x, y) < 15000 then
                return t("side_mission_capture_too_close")
            end
            return true
        end,
        onStart = function(self)
            local hint = t("side_mission_capture_start_hint", person, sectorName)
            self:setHint(hint)
            self:getPlayer():addToShipLog(hint, "255,127,0")
        end,
        onApproach = function(self)
            station:sendCommsMessage(self:getPlayer(), t("side_mission_capture_approach_comms", person, companionsNr))

            local hint = t("side_mission_capture_approach_hint", self:getBearer():getCallSign(), person)
            self:setHint(hint)
            self:getPlayer():addToShipLog(hint, "255,127,0")
        end,
        onBearerDestruction = function(self, x, y)
            local isFirst = true
            if isTable(companions) then
                for _, companion in pairs(companions) do
                    if isFirst then
                        companion:sendCommsMessage(self:getPlayer(), t("side_mission_capture_bearer_destruction_comms"))
                    end
                    companion:orderAttack(self:getPlayer())
                end
            end

            local pod = My.Artifact("ammo_box"):allowPickup(true):setPosition(x, y)
            pod:setScannedDescription(t("side_mission_capture_pod_description", person))

            local hint = t("side_mission_capture_bearer_destruction_hint", person, pod:getSectorName())
            self:setHint(hint)
            self:getPlayer():addToShipLog(hint, "255,127,0")

            return pod
        end,
        onItemDestruction = function(self)
            station:sendCommsMessage(self:getPlayer(), t("side_mission_capture_item_destruction_comms", person))
        end,
        onPickup = function(self)
            if Player:hasStorage(self:getPlayer()) then
                self:getPlayer():modifyProductStorage(product, 1)
            end

            local hint = t("side_mission_capture_pickup_hint", station:getCallSign())
            self:setHint(hint)
            self:getPlayer():addToShipLog(hint, "255,127,0")
        end,
        dropOffTarget = station,
        onSuccess = function(self)
            logInfo("Mission " .. self:getTitle() .. " successful.")
            self:getPlayer():addToShipLog(t("generic_mission_successful", self:getTitle()), "255,127,0")
            station:sendCommsMessage(self:getPlayer(), t("side_mission_capture_success_comms", person, payment))
            self:getPlayer():addReputationPoints(payment)
        end,
        onFailure = function(self)
            logInfo("Mission " .. self:getTitle() .. " failed.")
            if self:getPlayer():isValid() then
                self:getPlayer():addToShipLog(t("generic_mission_failed", self:getTitle()), "255,127,0")
            end
        end,
        onEnd = function(self)
            if Player:hasStorage(self:getPlayer()) then
                self:getPlayer():modifyProductStorage(product, -9999)
            end
        end,
    })

    Mission:withBroker(mission, t("side_mission_capture", person), {
        description = t("side_mission_capture_description", person, companionsNr, sectorName, payment),
        acceptMessage = t("side_mission_capture_accept"),
    })

    Mission:withTags(mission, "fighting")

    return mission
end