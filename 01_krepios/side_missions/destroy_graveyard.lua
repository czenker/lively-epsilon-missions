local t = My.Translator.translate

My = My or {}
My.SideMissions = My.SideMissions or {}

local updateHint = function(mission)
    local hint = t("side_mission_destroy_graveyard_hint", mission:countValidEnemies())
    mission:setHint(hint)
    mission:getPlayer():addToShipLog(hint, "255,127,0")
end

local randomDropContent = function()
    local rnd = math.random(1,4)
    if rnd == 1 then
        return {
            energy = Util.round(50 + 30 * math.random(), 10),
            reputation = 10 + math.random() * 30,
        }
    elseif rnd == 2 then
        -- weapon drop
        return {
            [products.homing] = math.random(1, 3),
            [products.hvli] = math.random(1, 3),
        }
    elseif rnd == 3 then
        -- machinery drop
        return {
            [products.miningMachinery] = math.random(1, 3),
            energy = Util.round(50 + 30 * math.random(), 10),
        }
    else
        -- ore drop
        return {
            [products.ore] = math.random(4, 10),
            [products.plutoniumOre] = math.random(1, 4),
        }
    end
end

local startRaid = function(destroyedShip)
    local x, y = destroyedShip.originalX, destroyedShip.originalY
    local drop = My.SupplyDrop(x, y, randomDropContent())

    local fleet = My.pirateRaid(drop, 2)
    local leader = fleet:getLeader()
    Tools:ensureComms(leader, My.World.player, t("side_mission_destroy_graveyard_raid_comms", leader:getCaptain()))

    fleet:orderDefendLocation(x, y)

    Cron.regular(function(self)
        if not fleet:isValid() then
            Cron.abort(self)
        else
            local isEscaped = true
            for _, ship in pairs(fleet:getShips()) do
                if distance(ship, My.World.player) <= getLongRangeRadarRange() * 1.1 then
                    isEscaped = false
                end
            end

            if isEscaped then
                for _, ship in pairs(fleet:getShips()) do
                    if ship:isValid() then ship:destroy() end
                end
                if drop:isValid() then drop:destroy() end
                Cron.abort(self)
            elseif drop:isValid() then
                fleet:orderDefendLocation(x, y)
            else
                fleet:orderAttack(My.World.player)
            end
        end
    end)
end


My.SideMissions.DestroyGraveyard = function(from, graveyard, player)
    local number = math.random(3, 5)
    local raidOnNumber
    if math.random(0, 1) == 0 then
        raidOnNumber = math.random(1, number - 1)
    end

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
            ship.originalX, ship.originalY = ship:getPosition()

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
        onDestruction = function(self, enemy)
            updateHint(self)
            if raidOnNumber ~= nil and self:countInvalidEnemies() == raidOnNumber then
                startRaid(enemy)
            end
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

local startRaid