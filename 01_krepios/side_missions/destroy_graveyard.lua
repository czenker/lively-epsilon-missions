local t = My.Translator.translate

My = My or {}
My.SideMissions = My.SideMissions or {}

local updateHint = function(mission)
    local hint = t("side_mission_destroy_graveyard_hint", mission:countValidEnemies())
    mission:setHint(hint)
    mission:getPlayer():addToShipLog(hint, "255,127,0")
end

My.SideMissions.DestroyGraveyard = function(from, graveyard, player)
    local number = math.random(3, 5)

    local payment = My.SideMissions.paymentPerDistance(distance(from, graveyard)) * 2 * (math.random() * 0.4 + 0.8)

    local x, y = graveyard:getPosition()
    local sectorName = Util.sectorName(x, y)


    local mission

    mission = Missions:destroy(function()
        local ships = {}

        for i = 1, number do
            local ship = graveyard:spawnShip()
            ship:setFaction("Outlaw")
            ship:setCanBeDestroyed(true)
            ship:setHullMax(ship:getHullMax() * 2)
            ship:setHull(ship:getHullMax())

            table.insert(ships, ship)
        end

        return ships
    end, {
        acceptCondition = function(self, error)
            if distance(player, x, y) < 7500 then
                return t("side_mission_destroy_graveyard_too_close")
            end
            return true
        end,
        onStart = function(self)
            updateHint(self)
        end,
        onDestruction = function(self)
            updateHint(self)
        end,
        onSuccess = function(self)
            from:sendCommsMessage(self:getPlayer(), t("side_mission_destroy_graveyard_success_comms", payment))
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

    Mission:withBroker(mission, t("side_mission_destroy_graveyard", sectorName), {
        description = t("side_mission_destroy_graveyard_description", sectorName, number, payment),
        acceptMessage = nil,
    })

    return mission
end