local t = My.Translator.translate
local f = string.format

local refitCostPower = 20
local refitTime = 30

local beamToObject = function(player, idx)
    idx = idx - 1
    if player:getBeamWeaponDamage(idx) > 0 and player:getBeamWeaponRange(idx) > 0 then
        -- TODO: move to Lively Epsilon
        return {
            arc = player:getBeamWeaponArc(idx),
            direction = player:getBeamWeaponDirection(idx),
            range = player:getBeamWeaponRange(idx),
            cycleTime = player:getBeamWeaponCycleTime(idx),
            damage = player:getBeamWeaponDamage(idx),
            energyPerFire = player:getBeamWeaponEnergyPerFire(idx),
            heatPerFire = player:getBeamWeaponHeatPerFire(idx),
            getMinAngle = function(self)
                return (self.direction - self.arc / 2) % 360
            end,
            getMaxAngle = function(self)
                return (self.direction + self.arc / 2) % 360
            end,
            getShotsPerMinute = function(self)
                return 60 / self.cycleTime
            end,
            getDamagePerMinute = function(self)
                return self.damage  * 60 / self.cycleTime
            end,
            getHeatPerMinute = function(self)
                return self.heatPerFire * 60 / self.cycleTime
            end,
            getMinutesToOverHeat = function(self)
                return 1 / self:getHeatPerMinute()
            end,
            getEnergyPerMinute = function(self)
                return self.energyPerFire * 60 / self.cycleTime
            end,
        }
    else
        return nil
    end
    return {}
end

local configurations = {
    calculateDefaultConfiguration = function(defaultConfiguration)
        local config = Util.deepCopy(defaultConfiguration)
        return config
    end,
    calculateRangeConfiguration = function(defaultConfiguration)
        local config = Util.deepCopy(defaultConfiguration)

        config.arc = config.arc / 1.3
        config.range = config.range * 1.3
        config.energyPerFire = config.energyPerFire * 1.3
        config.heatPerFire = config.heatPerFire * 1.3
        config.cycleTime = config.cycleTime * 1.2

        return config
    end,
    calculatePowerConfiguration = function(defaultConfiguration)
        local config = Util.deepCopy(defaultConfiguration)

        config.arc = config.arc * 1.2
        config.damage = config.damage * 1.7
        config.range = config.range / 1.2
        config.energyPerFire = config.energyPerFire * 2
        config.heatPerFire = config.heatPerFire * 2
        config.cycleTime = config.cycleTime * 1.2

        return config
    end,
    calculateSpeedConfiguration = function(defaultConfiguration)
        local config = Util.deepCopy(defaultConfiguration)

        config.arc = config.arc * 1.2
        config.damage = config.damage / 1.5
        config.cycleTime = config.cycleTime / 1.5

        config.energyPerFire = config.energyPerFire / 1.4
        config.heatPerFire = config.heatPerFire / 1.4

        return config
    end,
}


-- button to refit lasers
My.installLaserRefit = function()
    local player = My.World.player
    local defaultValues = {}
    local currentConfiguration = {}
    local isRefitting = {}
    local cronIds = {}

    local mainMenu

    local startRefit = function(i, targetConfiguration, name)
        local startConfiguration = beamToObject(player, i)
        local elapsed = 0
        cronIds[i] = cronIds[i] or "refit_" .. i .. "_" .. Util.randomUuid()
        isRefitting[i] = true
        currentConfiguration[i] = name
        player:drawWeaponsMenu(mainMenu())

        Cron.regular(cronIds[i], function(_, delta)
            delta = delta * player:getSystemPower("beamweapons")
            elapsed = elapsed + delta
            local energyLoss = refitCostPower * delta / refitTime
            player:setEnergy(math.max(player:getEnergy() - energyLoss, 0))

            if elapsed >= refitTime then
                isRefitting[i] = false
                Cron.abort(cronIds[i])
                elapsed = refitTime
            end

            local progress = elapsed / refitTime

            player:setBeamWeapon(
                    i - 1,
                    progress * targetConfiguration.arc + (1 - progress) * startConfiguration.arc,
                    progress * targetConfiguration.direction + (1 - progress) * startConfiguration.direction,
                    progress * targetConfiguration.range + (1 - progress) * startConfiguration.range,
                    progress * targetConfiguration.cycleTime + (1 - progress) * startConfiguration.cycleTime,
                    progress * targetConfiguration.damage + (1 - progress) * startConfiguration.damage
            )
            player:setBeamWeaponEnergyPerFire(
                    i - 1,
                    progress * targetConfiguration.energyPerFire + (1 - progress) * startConfiguration.energyPerFire
            )
            player:setBeamWeaponHeatPerFire(
                    i - 1,
                    progress * targetConfiguration.heatPerFire + (1 - progress) * startConfiguration.heatPerFire
            )
        end)
    end

    local mainInfoScreen = function()
        local text = t("upgrade_laserRefit_info_title") .. "\n-------------\n" .. t("upgrade_laserRefit_info_intro", refitCostPower, refitTime) .. "\n\n"
        for _, configName in ipairs({"default", "range", "power", "speed"}) do
            text = text .. t("upgrade_laserRefit_beam_info_" .. configName .. "_button") .. "\n-------------\n" .. t("upgrade_laserRefit_beam_info_" .. configName .. "_description") .. "\n\n"
        end
        return text
    end

    local createBeamInfoScreen = function(i)
        return function()
            local text = t("upgrade_laserRefit_beam_button", i) .. "\n-------------\n"
            local beam = beamToObject(player, i)

            text = text .. t("upgrade_laserRefit_beam_info_range", beam.range / 1000, beam:getMinAngle(), beam:getMaxAngle()) .. " "
            text = text .. t("upgrade_laserRefit_beam_info_damage", beam.damage, beam:getShotsPerMinute(), beam:getDamagePerMinute()) .. " "
            text = text .. t("upgrade_laserRefit_beam_info_heat", beam:getMinutesToOverHeat()) .. " "
            text = text .. t("upgrade_laserRefit_beam_info_energy", beam:getEnergyPerMinute())
            text = text .. "\n\n" .. t("upgrade_laserRefit_beam_info_disclaimer")

            return text
        end
    end

    local createReconfigureMenu = function(i)
        return function()
            local menu = Menu:new()
            menu:addItem("header", Menu:newItem(t("upgrade_laserRefit_beam_button", i), 0))
            if isRefitting[i] then
                menu:addItem("note", Menu:newItem(t("upgrade_laserRefit_beam_info_is_refitting"), 1))
            else
                menu:addItem("info", Menu:newItem(t("upgrade_laserRefit_beam_info_button"), createBeamInfoScreen(i), 1))
            end
            for j, configName in ipairs({"default", "range", "power", "speed"}) do
                local funcName = "calculate" .. configName:sub(1,1):upper() .. configName:sub(2) .. "Configuration"
                local label = t("upgrade_laserRefit_beam_info_" .. configName .. "_button")
                if configName == currentConfiguration[i] then
                    label = "<" .. label .. ">"
                end

                menu:addItem(configName, Menu:newItem(label, function()
                    local config = configurations[funcName](defaultValues[i])
                    startRefit(i, config, configName)
                end, j + 1))
            end

            return menu
        end
    end

    mainMenu = function()
        local menu = Menu:new()

        menu:addItem("header", Menu:newItem(t("upgrade_laserRefit_button"), 0))
        menu:addItem("info", Menu:newItem(t("upgrade_laserRefit_info_button"), mainInfoScreen, 1))

        for i=1,10 do
            if beamToObject(player, i) ~= nil then
                defaultValues[i] = defaultValues[i] or beamToObject(player, i)
                currentConfiguration[i]  = currentConfiguration[i] or "default"
                isRefitting[i] = isRefitting[i] or false

                menu:addItem("beam_" .. i, Menu:newItem(t("upgrade_laserRefit_beam_button", i), createReconfigureMenu(i), i+1))
            end
        end

        return menu
    end

    player:addWeaponsMenuItem("laser", Menu:newItem(t("upgrade_laserRefit_button"), mainMenu))
end