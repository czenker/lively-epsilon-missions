local t = My.Translator.translate

My = My or {}
My.SideMissions = My.SideMissions or {}


local function ShipTemplate()
    local size = math.random(1,3)
    local ship = My.CpuShip("Goods Freighter " .. size, "Outlaw")
    ship:setCallSign(My.minerName())
    ship:setBeamWeapon(0, 30, 0, 2000, 10, 30) -- it is slow firing, but strong
    ship:addTag("mute")

    local description = t("side_mission_raging_miner_ship_description")
    ship:setDescriptionForScanState("simple", description .. " " .. t("side_mission_raging_miner_ship_description_simple"))
    ship:setDescriptionForScanState("full", description .. " " .. t("side_mission_raging_miner_ship_description_extended"))

    return ship
end

My.SideMissions.RagingMiner = function(station, x, y, player)
    local sectorName = Util.sectorName(x, y)

    local payment = My.SideMissions.paymentPerDistance(distance(station, x, y)) + 1.5 * My.SideMissions.paymentPerEnemy()

    local mission = Missions:destroyRagingMiner(function()
        local ship = ShipTemplate()
        ship:setPosition(x, y):orderDefendLocation(x, y)

        return ship
    end, {
        acceptCondition = function(self, error)
            if distance(player, x, y) < 15000 then
                return t("side_mission_raging_miner_too_close")
            end
            return true
        end,
        onApproach = function(self)
            station:sendCommsMessage(self:getPlayer(), t("side_mission_raging_miner_approach_comms"))
        end,
        onSuccess = function(self)
            station:sendCommsMessage(self:getPlayer(), t("side_mission_raging_miner_success_comms", payment))
            self:getPlayer():addReputationPoints(payment)
        end,
        onEnd = function(self)
            for _, enemy in pairs(self:getEnemies() or {}) do
                if isEeObject(enemy) and enemy:isValid() then
                    enemy:destroy()
                end
            end
        end,
    })

    Mission:withBroker(mission, t("side_mission_raging_miner", sectorName), {
        description = t("side_mission_raging_miner_description", payment),
        acceptMessage = t("side_mission_raging_miner_accept"),
    })

    return mission
end