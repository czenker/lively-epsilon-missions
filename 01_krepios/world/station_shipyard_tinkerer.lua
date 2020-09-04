local t = My.Translator.translate
local f = string.format

local upgrades = {}
local maxUpgradePoints = 200
-- without players interfering we want to have about 3-4 upgrades available during normal gameplay
local researchPerSecond = maxUpgradePoints * 3.5 / 3600
-- key: upgrade id, value: number of remaining research points
local remainingUpgradeProgress = {}
local upgradePrice = {}

-- funding contributed by the players -> this will result in faster research and a discount
local funding = 0
-- how much of the contributed funding is used to discount the upgrade for the players
local discountRatio = 0.7
-- how many research points are added per contributed funding
local researchRatio = 1


My.EventHandler:register("onStart", function()
    local station = My.World.shipyard
    local isCurrentUpgradeDiscounted = false

    local tinkererPerson = My.Config.tinkerer

    Station:withCrew(station, {
        tinkerer = tinkererPerson,
    })

    local onUpgradeAvailable = function()
        local upgrade = table.remove(upgrades, 1)
        if upgrade then
            station:addUpgrade(upgrade)
            logInfo(f("Station \"%s\" researched \"%s\" and sells it now.", station:getCallSign(), upgrade:getName()))

            if isCurrentUpgradeDiscounted then
                station:sendCommsMessage(My.World.player, t("shipyard_workshop_comms_upgrade_available", tinkererPerson, upgrade:getName(), station:getCallSign(), upgrade:getPrice()))
            end

            isCurrentUpgradeDiscounted = false
            My.Database:addOrUpdateUpgrade(upgrade)
        end
    end

    local workshopName = t("shipyard_workshop_name", tinkererPerson)
    station.getWorkshopName = function(self) return workshopName end
    station.getCurrentUpgrade = function(self)
        return upgrades[1]
    end
    station.getUpgrades = function(self)
        return upgrades
    end
    station.getUpgradeOptions = function(self)
        local options = {}
        if not isNil(upgrades[2]) then table.insert(options, upgrades[2]) end
        if not isNil(upgrades[3]) then table.insert(options, upgrades[3]) end

        return options
    end
    station.prioritizeUpgrade = function(self, upgrade)
        local idx = nil
        for i, theUpgrade in pairs(upgrades) do
            if upgrade:getId() == theUpgrade:getId() then
                idx = i
            end
        end
        if not isNumber(idx) then
            error("Could not find upgrade " .. upgrade:getId() .. " in upgrade list.", 2)
        end
        upgrades[idx] = upgrades[1]
        upgrades[1] = upgrade
        logInfo(f("Changed research from %s to %s.", station:getCallSign(), upgrade:getId()))
    end
    station.getCurrentUpgradeProgress = function(self)
        local upgrade = station:getCurrentUpgrade()

        if upgrade then
            return 1 - (remainingUpgradeProgress[upgrade:getId()] / maxUpgradePoints)
        else
            return nil
        end
    end
    station.getCurrentFunding = function(self)
        return funding
    end
    station.addFunding = function(self, amount)
        if not isNumber(amount) or amount < 0 then error("Expected added funding to be a positive number, but got " .. typeInspect(amount), 2) end
        funding = funding + amount
    end
    station.addUpgradeProgress = function(self, percent)
        local upgrade = station:getCurrentUpgrade()
        if upgrade then
            remainingUpgradeProgress[upgrade:getId()] = remainingUpgradeProgress[upgrade:getId()] - percent * maxUpgradePoints
        end
    end

    station:addComms(My.Comms.ShipyardTinkerer)

    local possibleUpgrades = {}
    for id, upgrade in pairs(My.Upgrades) do
        if Generic:hasTags(upgrade) and upgrade:hasTag("researchable") then
            table.insert(possibleUpgrades, upgrade)
            remainingUpgradeProgress[id] = maxUpgradePoints
            upgradePrice[id] = upgrade:getPrice()
            upgrade.getPrice = function() return upgradePrice[upgrade:getId()] end
        end
    end
    upgrades = Util.randomSort(possibleUpgrades)

    local cronResearch = Cron.regular("shipyard-research", function(self, delta)
        local upgrade = station:getCurrentUpgrade()
        if isNil(upgrade) then
            Cron.abort(self)
        else
            local researchPoints = researchPerSecond * delta
            -- research will go on even without player contribution
            remainingUpgradeProgress[upgrade:getId()] = remainingUpgradeProgress[upgrade:getId()] - researchPoints
            -- if there are funds: speed up research
            if funding > 0 then
                local factor = 1
                if funding > 50 then factor = 2 end
                remainingUpgradeProgress[upgrade:getId()] = remainingUpgradeProgress[upgrade:getId()] - factor * researchPoints
                funding = math.max(funding - factor * researchPoints / researchRatio, 0)
                local discount = factor * researchPoints / researchRatio * discountRatio
                if discount > 0 then isCurrentUpgradeDiscounted = true end
                upgradePrice[upgrade:getId()] = math.max(upgradePrice[upgrade:getId()] - discount, 0)
            end

            if remainingUpgradeProgress[upgrade:getId()] <= 0 then onUpgradeAvailable() end
        end
    end, 1)

    My.EventHandler:register("onAttackersDetection", function()
        Cron.abort(cronResearch)
    end)
end)

local ShipTemplate = function()
    local ship = My.CpuShip("Stalker Q7", "SMC"):
    setBeamWeapon(0, 0, 0, 0, 9999, 0):
    setBeamWeapon(1, 0, 0, 0, 9999, 0):
    setWeaponTubeCount(0):
    setImpulseMaxSpeed(140)

    return ship
end

My.EventHandler:register("onAttackersDetection", function()
    local ship = ShipTemplate()
    local tinkererPerson = My.Config.tinkerer

    Ship:withCaptain(ship, tinkererPerson)
    ship:setCallSign(tinkererPerson:getNickName())
    ship:setCanBeDestroyed(false)
    Util.spawnAtStation(My.World.shipyard, ship)

    ship:setHailText(t("comms_generic_flight_hail"))
    ship:setScannedDescription(t("mines_miner_description", ship:getCallSign(), ship:getCaptain()))

    ship:addOrder(Order:dock(My.World.fortress, {
        onCompletion = function(_, ship)
            if ship:isValid() then ship:destroy() end
        end
    }))
end)
