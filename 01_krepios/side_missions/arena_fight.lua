local t = My.Translator.translate

My = My or {}
My.SideMissions = My.SideMissions or {}

local newDroidShip = function(templateName)
    local ship = My.CpuShip(templateName, "Outlaw")
    Ship:withCaptain(ship, nil)

    ship:setCallSign(My.droidName())
    Ship:withTags(ship)
    ship:addTag("mute")

    return ship
end

local difficulty = 20

My.SideMissions.ArenaFight = function(station)
    if not isFunction(station.isInArena) then return nil end
    local tinkerer = station:getCrewAtPosition("tinkerer")
    local payment = difficulty * (math.random() * 0.4 + 0.8) * 7

    local mission

    local goToArenaMission = Mission:new({
        onStart = function(self)
            Cron.regular(function(cronId)
                local arenaX, arenaY = station:getArenaLocation()
                local d = distance(arenaX, arenaY, self:getPlayer())
                if d < 4800 then
                    Cron.abort(cronId)
                    self:success()
                end
            end, 1)
            mission:setHint(t("side_mission_arena_goto_hint", station:getArenaSectorName()))
        end,
    })
    Mission:forPlayer(goToArenaMission)

    local cronId
    local wasInvincibleAtStart
    local needsArenaWarning
    local shipTemplateNames = My.generateEncounter(difficulty)

    local onDestruction = function(enemy)
        logInfo(string.format("%s destroyed", enemy:getCallSign()))
    end

    local fightMission = Missions:destroy(function(self)
        local ships = {}

        for _, templateName in pairs(shipTemplateNames) do
            table.insert(ships, newDroidShip(templateName))
        end
        return Util.randomSort(ships)
    end, {
        onStart = function(self)
            wasInvincibleAtStart = not self:getPlayer():getCanBeDestroyed()
            -- if no position is filled that can see zones...
            needsArenaWarning = not self:getPlayer():hasPlayerAtPosition("science") and not self:getPlayer():hasPlayerAtPosition("relay") and not self:getPlayer():hasPlayerAtPosition("operations")
            self:getPlayer():setCanBeDestroyed(false) -- players can not be destroyed during arena fights

            local arenaX, arenaY = station:getArenaLocation()
            local playerX, playerY = self:getPlayer():getPosition()

            local dx, dy = arenaX - playerX, arenaY - playerY

            local enemies = self:getEnemies()
            local number = Util.size(enemies)
            local angle = Util.angleFromVector(dx, dy)
            local diffAngle = 240 / (number + 1)
            local initAngle = angle - 120 + diffAngle / 2
            for i, enemy in ipairs(enemies) do
                local x, y = Util.addVector(arenaX, arenaY, initAngle + (i-1) * diffAngle, 4000)
                enemy:setPosition(x, y)
                enemy:orderAttack(self:getPlayer())
                enemy:onDestruction(onDestruction)
            end

            local outOfAreaWarningShown = false

            cronId = Cron.regular(function()
                if self:getPlayer():getHull() / self:getPlayer():getHullMax() < 0.1 then
                    logInfo("Arena mission failed, because hull was damaged too much")
                    self:fail()
                end
                -- make sure the player is not leaving the arena
                local arenaX, arenaY = station:getArenaLocation()
                local d = distance(arenaX, arenaY, self:getPlayer())
                if d > 5200 then
                    logInfo("Arena mission failed, because players left the arena")
                    self:fail()
                elseif not outOfAreaWarningShown and d > 4900 then
                    outOfAreaWarningShown = true
                    if needsArenaWarning then
                        self:getPlayer():commandSetAlertLevel("yellow")
                    end
                    self:getPlayer():addToShipLog(t("side_mission_arena_fight_warning"), "255,127,0")
                elseif outOfAreaWarningShown and d < 4500 then
                    if needsArenaWarning then
                        self:getPlayer():commandSetAlertLevel("normal")
                    end
                    outOfAreaWarningShown = false
                end
            end, 1)

            mission:setHint(t("side_mission_arena_fight_hint"))
        end,
        onEnd = function(self)
            if cronId then Cron.abort(cronId) end

            Cron.once(function()
                -- delay it, because there might be rockets flying around still
                if not wasInvincibleAtStart then
                    self:getPlayer():setCanBeDestroyed(true)
                end
            end, 10)

            for _, enemy in pairs(self:getValidEnemies()) do
                enemy:destroy()
            end
        end,
    })

    mission = Mission:chain(goToArenaMission, fightMission, {
        onSuccess = function(self)
            self:getPlayer():addReputationPoints(payment)
            self:getMissionBroker():sendCommsMessage(self:getPlayer(), t("side_mission_arena_success", self:getMissionBroker():getCallSign(), payment))
            -- make the next fight more difficult
            difficulty = difficulty + 10
        end,
        onFailure = function(self)
            self:getMissionBroker():sendCommsMessage(self:getPlayer(), t("side_mission_arena_failure", tinkerer))
            -- tinkerer gets money for the win to invest in their research :D
            station:addFunding(payment * 0.2)
        end,
    })
    Mission:forPlayer(mission)

    Mission:withBroker(mission, t("side_mission_arena"), {
        description = t("side_mission_arena_description", tinkerer, payment),
        acceptMessage = t("side_mission_arena_accept", station:getArenaSectorName()),
    })

    return mission
end