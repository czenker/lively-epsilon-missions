local t = My.Translator.translate

My = My or {}
My.Comms = My.Comms or {}

My.Comms.commandFighter = (function()
    local commandMenu, attackMenu, defendMenu, moveMenu, dockMenu, attackFleet, attackShip, defend, move, dock, strategyMenu, frequencyMenu, frequency, enableWarp, disableWarp
    commandMenu = function(comms_target, comms_source)
        local screen = Comms:newScreen()

        if Ship:hasFleet(comms_target) and not comms_target:isFleetLeader() then
            local fleetLeaderPerson = comms_target:getFleetLeader():getCaptain()
            screen:addText(t("defense_squadron_command_not_leader", fleetLeaderPerson, comms_target:getFleetLeader():getCallSign()))
        else
            local captain = comms_target:getCaptain()
            screen:addText(t("defense_squadron_command_leader", captain))

            screen:addReply(Comms:newReply(t("defense_squadron_command_move_label"), moveMenu))
            screen:addReply(Comms:newReply(t("defense_squadron_command_defend_label"), defendMenu))
            screen:addReply(Comms:newReply(t("defense_squadron_command_attack_label"), attackMenu))
            screen:addReply(Comms:newReply(t("defense_squadron_command_dock_label"), dockMenu))
            screen:addReply(Comms:newReply(t("defense_squadron_command_strategy_label"), strategyMenu))
            screen:addReply(Comms:newReply(t("generic_button_back")))
        end
        return screen
    end

    attackMenu = function(comms_target, comms_source)
        local screen = Comms:newScreen(t("defense_squadron_command_attack_hail"))

        for _, thing in pairs(comms_target:getObjectsInRange(20000)) do
            if isEeShipTemplateBased(thing) and thing:isValid() and comms_target:isEnemy(thing) then
                screen:addReply(Comms:newReply(thing:getCallSign(), attackShip(thing)))
            end
        end

        for i, fleet in pairs(My.EnemyFleet:getFleets() or {}) do
            if fleet:isValid() then
                screen:addReply(Comms:newReply(t("defense_squadron_command_attack_fleet_label", i), attackFleet(i)))
            end
        end

        screen:addReply(Comms:newReply(t("generic_button_back"), commandMenu))
        return screen
    end

    attackFleet = function(fleetId)
        local enemyFleet = My.EnemyFleet:getFleets()[fleetId]
        return function(comms_target, comms_source)
            local screen = Comms:newScreen()
            if Fleet:isFleet(enemyFleet) and enemyFleet:isValid() then
                local attacker = comms_target
                if Ship:hasFleet(comms_target) then
                    attacker = comms_target:getFleet()
                end

                local target = enemyFleet:getLeader()
                attacker:forceOrderNow(Order:attack(target))
                screen:addText(t("defense_squadron_command_attack_fleet_ok", fleetId))
                screen:addReply(Comms:newReply(t("generic_button_back")))

            else
                screen:addText(t("defense_squadron_command_attack_fleet_nok"))
                screen:addReply(Comms:newReply(t("generic_button_back"), attackMenu))
            end
            return screen
        end
    end

    attackShip = function(ship)
        return function(comms_target, comms_source)
            local screen = Comms:newScreen()
            if ship:isValid() then
                local attacker = comms_target
                if Ship:hasFleet(comms_target) then
                    attacker = comms_target:getFleet()
                end
                attacker:forceOrderNow(Order:attack(ship, {
                    onCompletion = function(_, thing)
                        local ship = thing
                        if Fleet:isFleet(thing) then
                            ship = thing:getLeader()
                        end

                        if comms_source:isValid() and ship ~= nil and ship:isValid() then
                            comms_source:addToShipLog(ship:getCallSign() .. ": " .. t("defense_squadron_command_attack_success"), "154,255,154")
                        end
                    end
                }))
                screen:addText(t("defense_squadron_command_attack_ship_ok", ship:getCallSign()))
                screen:addReply(Comms:newReply(t("generic_button_back")))
            else
                screen:addText(t("defense_squadron_command_attack_ship_nok"))
                screen:addReply(Comms:newReply(t("generic_button_back"), attackMenu))
            end
            return screen
        end
    end

    moveMenu = function(comms_target, comms_source)
        local screen = Comms:newScreen()
        if comms_source:getWaypointCount() > 0 then
            screen:addText(t("defense_squadron_command_move_hail"))

            for i=1,comms_source:getWaypointCount() do
                local x, y = comms_source:getWaypoint(i)
                screen:addReply(Comms:newReply(t("defense_squadron_command_move_waypoint_label", i, Util.sectorName(comms_source:getWaypoint(i))), move(x, y)))
            end
        else
            screen:addText(t("defense_squadron_command_move_hail_no_waypoint"))
        end
        screen:addReply(Comms:newReply(t("generic_button_back"), commandMenu))
        return screen
    end

    move = function(x, y)
        return function(comms_target, comms_source)
            local screen = Comms:newScreen()
            local target = comms_target
            if Ship:hasFleet(comms_target) then
                target = comms_target:getFleet()
            end

            target:forceOrderNow(Order:flyTo(x, y, {
                onCompletion = function(_, thing)
                    local ship = thing
                    if Fleet:isFleet(thing) then
                        ship = thing:getLeader()
                    end

                    if comms_source:isValid() and ship ~= nil and ship:isValid() then
                        comms_source:addToShipLog(ship:getCallSign() .. ": " .. t("defense_squadron_command_move_success"), "154,255,154")
                    end
                end
            }))

            screen:addText(t("defense_squadron_command_move_ok"))
            screen:addReply(Comms:newReply(t("generic_button_back"), commandMenu))
            return screen
        end
    end

    defendMenu = function(comms_target, comms_source)
        local screen = Comms:newScreen(t("defense_squadron_command_defend_hail"))

        for _, target in pairs({
            My.World.player,
            My.World.fortress,
        }) do
            if target ~= nil and target:isValid() then
                screen:addReply(Comms:newReply(target:getCallSign(), defend(target)))
            end
        end
        screen:addReply(Comms:newReply(t("generic_button_back"), commandMenu))
        return screen
    end

    defend = function(target)
        return function(comms_target, comms_source)
            local screen = Comms:newScreen()
            if target:isValid() then
                local defender = comms_target
                if Ship:hasFleet(comms_target) then
                    defender = comms_target:getFleet()
                end
                defender:forceOrderNow(Order:defend(target, {
                    minDefendTime = 9999,
                }))
                screen:addText(t("defense_squadron_command_defend_ok", target:getCallSign()))
                screen:addReply(Comms:newReply(t("generic_button_back")))
            else
                screen:addText(t("defense_squadron_command_defend_nok"))
                screen:addReply(Comms:newReply(t("generic_button_back"), defendMenu))
            end
            return screen
        end
    end

    dockMenu = function(comms_target, comms_source)
        local screen = Comms:newScreen(t("defense_squadron_command_dock_hail"))

        for _, target in pairs({
            My.World.fortress,
        }) do
            if target ~= nil and target:isValid() then
                screen:addReply(Comms:newReply(target:getCallSign(), dock(target)))
            end
        end
        screen:addReply(Comms:newReply(t("generic_button_back"), commandMenu))
        return screen
    end

    dock = function(target)
        return function(comms_target, comms_source)
            local screen = Comms:newScreen()
            if target:isValid() then
                local docker = comms_target
                if Ship:hasFleet(comms_target) then
                    docker = comms_target:getFleet()
                end
                docker:forceOrderNow(Order:dock(target, {
                    onCompletion = function(_, thing)
                        local ship = thing
                        if Fleet:isFleet(thing) then
                            ship = thing:getLeader()
                        end

                        if comms_source:isValid() and ship ~= nil and ship:isValid() then
                            comms_source:addToShipLog(ship:getCallSign() .. ": " .. t("defense_squadron_command_dock_success"), "154,255,154")
                        end
                    end
                }))
                screen:addText(t("defense_squadron_command_dock_ok", target:getCallSign()))
                screen:addReply(Comms:newReply(t("generic_button_back")))
            else
                screen:addText(t("defense_squadron_command_dock_nok"))
                screen:addReply(Comms:newReply(t("generic_button_back"), dockMenu))
            end
            return screen
        end
    end

    strategyMenu = function(comms_target, comms_source)
        local screen = Comms:newScreen(t("defense_squadron_command_strategy_hail"))

        screen:addReply(Comms:newReply(t("defense_squadron_command_frequency_label"), frequencyMenu))
        screen:addReply(Comms:newReply(t("defense_squadron_command_enable_warp_label"), enableWarp, function(comms_target) return comms_target.warpDisabled == true end))
        screen:addReply(Comms:newReply(t("defense_squadron_command_disable_warp_label"), disableWarp, function(comms_target) return comms_target:hasWarpDrive() end))
        screen:addReply(Comms:newReply(t("generic_button_back"), commandMenu))
        return screen
    end

    local calibrateLasers = function(ship, factor)
        if not ship:isValid() then return end

        ship.laserBackup = ship.laserBackup or {}

        for i=0,15 do
            if ship.laserBackup[i] == nil or ship.laserBackup[i] == 0 then
                ship.laserBackup[i] = ship:getBeamWeaponDamage(i)
            end
            ship:setBeamWeapon(
                i,
                ship:getBeamWeaponArc(i),
                ship:getBeamWeaponDirection(i),
                ship:getBeamWeaponRange(i),
                ship:getBeamWeaponCycleTime(i),
                ship.laserBackup[i] * factor
            )
        end
    end

    frequencyMenu = function(comms_target, comms_source)
        local screen = Comms:newScreen(t("defense_squadron_command_frequency_hail"))
        for i=0,20,1 do
            local freq = 400 + 20 * i
            screen:addReply(Comms:newReply(t("defense_squadron_command_frequency_detail_label", freq), frequency(i)))
        end
        screen:addReply(Comms:newReply(t("generic_button_back"), strategyMenu))
        return screen
    end

    frequency = function(frequencyBand)
        local frequency = 400 + 20 * frequencyBand
        return function(comms_target, comms_source)
            local factor = 1
            if math.abs(frequencyBand - My.EnemyFleet:getShieldFrequencyBand()) < 2 then
                factor = 0.5
            elseif math.abs((frequencyBand+10)%20 - My.EnemyFleet:getShieldFrequencyBand()) < 2 then
                factor = 1.5
            end
            if Ship:hasFleet(comms_target) then
                for _,ship in pairs(comms_target:getFleet():getShips()) do
                    calibrateLasers(ship, factor)
                end
            else
                calibrateLasers(comms_target, factor)
            end

            local screen = Comms:newScreen(t("defense_squadron_command_frequency_detail_ok", frequency))
            screen:addReply(Comms:newReply(t("generic_button_back"), strategyMenu))
            return screen
        end
    end

    local doEnableWarp = function(ship)
        if ship.warpDisabled == true then
            ship:setWarpDrive(true)
            ship.warpDisabled = false
        end
    end
    local doDisableWarp = function(ship)
        if ship:hasWarpDrive() then
            ship:setWarpDrive(false)
            ship.warpDisabled = true
        end
    end
    enableWarp = function(comms_target, comms_source)
        local screen = Comms:newScreen()

        if Ship:hasFleet(comms_target) then
            for _, ship in pairs(comms_target:getFleet():getShips()) do
                doEnableWarp(ship)
            end
        else
            doEnableWarp(comms_target)
        end
        screen:addText(t("defense_squadron_command_enable_warp_ok"))
        screen:addReply(Comms:newReply(t("generic_button_back"), strategyMenu))

        return screen
    end

    disableWarp = function(comms_target, comms_source)
        local screen = Comms:newScreen()

        if Ship:hasFleet(comms_target) then
            for _, ship in pairs(comms_target:getFleet():getShips()) do
                doDisableWarp(ship)
            end
        else
            doDisableWarp(comms_target)
        end
        screen:addText(t("defense_squadron_command_disable_warp_ok"))
        screen:addReply(Comms:newReply(t("generic_button_back"), strategyMenu))

        return screen
    end

    return Comms:newReply(t("defense_squadron_command_label"), commandMenu)
end)()
