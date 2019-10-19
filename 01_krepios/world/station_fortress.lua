local t = My.Translator.translate

local isManned = false

local currentImprovement = nil
local improvementCronId = "fortress_improve"
local improvements = {
    Homing = (function()
        local amount = 6
        return {
            name = t("fortress_improvement_homing_name", amount),
            canBeChosen = function(station) return Station:hasStorage(station) and station:canStoreProduct("homing") and station:getEmptyProductStorage("homing") > 0 end,
            onCompletion = function(station)
                station:modifyProductStorage("homing", amount)
            end,
            confirmationMessage = t("fortress_improvement_homing_confirmation"),
            completionMessage = t("fortress_improvement_homing_completion"),
            duration = 180,
        }
    end)(),
    HVLI = (function()
        local amount = 6
        return {
            name = t("fortress_improvement_hvli_name", amount),
            canBeChosen = function(station) return Station:hasStorage(station) and station:canStoreProduct("hvli") and station:getEmptyProductStorage("hvli") > 0 end,
            onCompletion = function(station)
                station:modifyProductStorage("hvli", amount)
            end,
            confirmationMessage = t("fortress_improvement_hvli_confirmation"),
            completionMessage = t("fortress_improvement_hvli_completion"),
            duration = 210,
        }
    end)(),
    Mine = (function()
        local amount = 3
        return {
            name = t("fortress_improvement_mine_name", amount),
            canBeChosen = function(station) return Station:hasStorage(station) and station:canStoreProduct("mine") and station:getEmptyProductStorage("mine") > 0 end,
            onCompletion = function(station)
                station:modifyProductStorage("mine", amount)
            end,
            confirmationMessage = t("fortress_improvement_mine_confirmation"),
            completionMessage = t("fortress_improvement_mine_completion"),
            duration = 300,
        }
    end)(),
    Emp = (function()
        local amount = 2
        return {
            name = t("fortress_improvement_emp_name", amount),
            canBeChosen = function(station) return Station:hasStorage(station) and station:canStoreProduct("emp") and station:getEmptyProductStorage("emp") > 0 end,
            onCompletion = function(station)
                station:modifyProductStorage("emp", amount)
            end,
            confirmationMessage = t("fortress_improvement_emp_confirmation"),
            completionMessage = t("fortress_improvement_emp_completion"),
            duration = 600,
        }
    end)(),
    Nuke = (function()
        local amount = 1
        return {
            name = t("fortress_improvement_nuke_name"),
            canBeChosen = function(station) return Station:hasStorage(station) and station:canStoreProduct("nuke") and station:getEmptyProductStorage("nuke") > 0 end,
            onCompletion = function(station)
                station:modifyProductStorage("nuke", amount)
            end,
            confirmationMessage = t("fortress_improvement_nuke_confirmation"),
            completionMessage = t("fortress_improvement_nuke_completion"),
            duration = 600,
        }
    end)(),
    ScanProbe = (function()
        local amount = 12
        return {
            name = t("fortress_improvement_scanProbe_name", amount),
            canBeChosen = function(station)
                if not isFunction(station.getRestocksScanProbes) or station:getRestocksScanProbes() then return false end

                return Station:hasStorage(station) and station:canStoreProduct("scanProbe") and station:getEmptyProductStorage("scanProbe") > 0
             end,
            onCompletion = function(station)
                station:modifyProductStorage("scanProbe", amount)
            end,
            confirmationMessage = t("fortress_improvement_scanProbe_confirmation"),
            completionMessage = t("fortress_improvement_scanProbe_completion", amount),
            duration = 300,
        }
    end)(),
    Nanobot = (function()
        local amount = 4
        return {
            name = t("fortress_improvement_nanobot_name", amount),
            canBeChosen = function(station, player)
                return Station:hasStorage(station) and station:canStoreProduct("nanobot") and station:getEmptyProductStorage("nanobot") > 0 and player:hasUpgrade("nanobot")
             end,
            onCompletion = function(station)
                station:modifyProductStorage("nanobot", amount)
            end,
            confirmationMessage = t("fortress_improvement_nanobot_confirmation"),
            completionMessage = t("fortress_improvement_nanobot_completion", amount),
            duration = 300,
        }
    end)(),
    Repair = {
        name = t("fortress_improvement_repair_name"),
        canBeChosen = function(station) return isEeShipTemplateBased(station) and not station:getRepairDocked() end,
        onCompletion = function(station)
            station:setRepairDocked(true)
        end,
        confirmationMessage = t("fortress_improvement_repair_confirmation"),
        completionMessage = t("fortress_improvement_repair_completion"),
        duration = 300,
    },
    Shield = {
        name = t("fortress_improvement_shield_name"),
        canBeChosen = function(station) return isEeShipTemplateBased(station) and station:getShieldMax(0) == 0 end,
        onCompletion = function(station)
            station:setShieldsMax(station:getShieldMax(0) + 100)
            station:setShields(station:getShieldLevel(0) + 100)
        end,
        confirmationMessage = t("fortress_improvement_shield_confirmation"),
        completionMessage = t("fortress_improvement_shield_completion"),
        duration = 300,
    },
    Shield2 = {
        name = t("fortress_improvement_shield2_name"),
        canBeChosen = function(station) return isEeShipTemplateBased(station) and station:getShieldMax(0) > 0 and station:getShieldMax(0) < 700 end,
        onCompletion = function(station)
            station:setShieldsMax(station:getShieldMax(0) + 200)
            station:setShields(station:getShieldLevel(0) + 200)
        end,
        confirmationMessage = t("fortress_improvement_shield2_confirmation"),
        completionMessage = t("fortress_improvement_shield2_completion"),
        duration = 450,
    },
}

local hasSpawnedDefenders = false
My.EventHandler:register("onDefensePlanned", function(self, event)
    Cron.once(function()
        if event.spawnArtillery == false then
            improvements.Artillery = {
                name = t("fortress_improvement_artillery_name"),
                canBeChosen = function() return hasSpawnedDefenders == false end,
                onCompletion = function(station)
                    hasSpawnedDefenders = true
                    My.deployDefenseArtillery()
                end,
                confirmationMessage = t("fortress_improvement_artillery_confirmation"),
                completionMessage = t("fortress_improvement_artillery_completion"),
                duration = 600,
            }
        end
        if event.spawnGunships == false then
            improvements.Gunships = {
                name = t("fortress_improvement_gunships_name"),
                canBeChosen = function() return hasSpawnedDefenders == false end,
                onCompletion = function(station)
                    hasSpawnedDefenders = true
                    My.deployDefenseGunships()
                end,
                confirmationMessage = t("fortress_improvement_gunships_confirmation"),
                completionMessage = t("fortress_improvement_gunships_completion"),
                duration = 600,
            }
        end
    end, math.random(900, 1200))
end)

local StationTemplate = function()
    local s = My.SpaceStation("Large Station"):
        setShields(0):
        setShieldsMax(0):
        setRepairDocked(false):
        setSharesEnergyWithDocked(false)

    if isFunction(s.setRestocksScanProbes) then s:setRestocksScanProbes(false) end

    return s
end

My.EventHandler:register("onWorldCreation", function()
    local divAngle = 360 * 60000 / 2 / math.pi / My.Config.avgDistance

    local originX, originY = My.World.planet:getPosition()

    local randomPosition = function()
        local angle = My.Config.avgAngle - (1 + math.random()) * divAngle
        local distance = My.Config.avgDistance - My.Config.width * 0.6 + math.random() * My.Config.width * 1.2

        local x, y = vectorFromAngle(angle, distance)
        return originX + x, originY + y
    end

    local x, y = My.World.Helper.tryMinDistance(randomPosition, function(thing)
        return isEeStation(thing) or isEeArtifact(thing)
    end, 40000)
    My.World.Helper.eraseAsteroidsAround(x, y, 7000)

    local station = StationTemplate():
        setFaction("Abandoned"):
        setPosition(x, y):
        setCallSign("SMC Alpha"):
        setScannedDescription(t("fortress_station_initial_description"))

    Station:withTags(station)
    station:addTag("mute")

    station:setRadarSignatureInfo(station:getRadarSignatureGravity(), 0, 0)
    station.isManned = function() return isManned end
    station.isImproving = function() return currentImprovement ~= nil end
    station.getImprovementName = function() return (currentImprovement or {}).name end
    station.improve = function(_, improvement)
        Cron.once(improvementCronId, function()
            currentImprovement = nil
            logInfo("improvement " .. improvement.name .. " finished")
            if isFunction(improvement.onCompletion) then
                improvement.onCompletion(station)
            end
            station.improvementSuccessMessage = improvement.completionMessage
            Tools:ensureComms(station, My.World.player)
        end, improvement.duration * (math.random() * 0.2 + 0.9))
        currentImprovement = improvement
    end
    station.getImprovements = function(_)
        return improvements
    end

    My.World.fortress = station
end)

My.EventHandler:register("onFortressManned", function()
    isManned = true
    local fortress = My.World.fortress

    fortress:setRadarSignatureInfo(
        fortress:getRadarSignatureGravity(), 0.5, 0.5
    )

    fortress:removeTag("mute")
end, -90)

My.EventHandler:register("onStart", function()
    local station = My.World.fortress
    if station:isValid() then
        station:setHailText(My.Comms.FortressHail.initial)
    end
end)

My.EventHandler:register("onFortressManned", function()
    local station = My.World.fortress
    if station:isValid() then
        station:setScannedDescription(t("fortress_station_manned_description"))
        station:setHailText(My.Comms.FortressHail.manned)
    end
end)

My.EventHandler:register("onDefensePlanned", function()
    local station = My.World.fortress
    if station:isValid() then
        station:setHailText(My.Comms.FortressHail.defense)
    end
end)

My.EventHandler:register("onEnemiesDestroyed", function()
    local station = My.World.fortress
    if station:isValid() then
        station:setHailText(My.Comms.FortressHail.victory)
    end
end)


My.EventHandler:register("onFortressManned", function()
    local fortress = My.World.fortress

    fortress:setFaction("Human Navy")

    fortress:addComms(My.Comms.FortressIntel)
end)

My.EventHandler:register("onDefensePlanned", function()
    local fortress = My.World.fortress

    local nextId = 1
    local upgrades = Util.randomSort(My.Upgrades)

    Cron.regular(function(self)
        local upgrade = upgrades[nextId]
        nextId = nextId + 1
        if upgrade == nil then
            logInfo("Aborting Upgrade Fill, because there are no more upgrades")
            Cron.abort(self)
        elseif not fortress:isValid() then
            logInfo("Aborting Upgrade Fill, because station is dead")
            Cron.abort(self)
        else
            fortress:addUpgrade(upgrade)
            logInfo(fortress:getCallSign() .. " offers " .. upgrade:getName() .. " now")
            if upgrade:canBeInstalled(My.World.player) then
                Tools:ensureComms(fortress, My.World.player, t("fortress_upgrade_available", fortress:getCallSign(), upgrade:getName(), upgrade:getPrice()))
            end
        end
    end, 150, 150)
end)

My.EventHandler:register("onDefensePlanned", function()
    local fortress = My.World.fortress

    local merchantConfig = {}
    local storageConfig = {
        [products.homing] = 60,
        [products.hvli] = 60,
        [products.mine] = 10,
        [products.emp] = 15,
        [products.nuke] = 5,
        [products.scanProbe] = 20,
        [products.nanobot] = 20,
    }
    for id, product in pairs(products) do
        if id == "homing" or id == "hvli" or id == "mine" or id == "emp" or id == "nuke" or id == "scanProbe" or id == "nanobot" then
            merchantConfig[product] = { sellingPrice = 0 }
        else
            merchantConfig[product] = { buyingPrice = product.basePrice }
            storageConfig[product] = 9999
        end
    end
    Station:withStorageRooms(fortress, storageConfig)
    fortress:modifyProductStorage(products.hvli, math.random(1, 8))
    fortress:modifyProductStorage(products.homing, math.random(2, 6))
    fortress:modifyProductStorage(products.mine, math.random(2, 4))
    fortress:modifyProductStorage(products.emp, math.random(0, 2))
    fortress:modifyProductStorage(products.nuke, math.random(1, 2))
    fortress:modifyProductStorage(products.scanProbe, math.random(4, 6))
    fortress:modifyProductStorage(products.nanobot, math.random(2, 4))

    Station:withMerchant(fortress, merchantConfig)
end)

My.EventHandler:register("onDefensePlanned", function()
    local fortress = My.World.fortress

    fortress:addComms(My.Comms.FortressImprovement)
end)