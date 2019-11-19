local t = My.Translator.translate

local shipHail = function(ship, player)
    if ship:hasTag("mute") then
        return t("generic_comms_ship_static")
    elseif ship:isFriendly(player) then
        return t("comms_generic_hail_friendly_ship", ship:getCaptain())
    elseif ship:isEnemy(player) then
        return t("comms_generic_hail_enemy_ship", ship:getCaptain())
    else
        return t("comms_generic_hail_neutral_ship", ship:getCaptain())
    end
end
local stationHail = function(station, player)
    if station:hasTag("mute") then
        return t("generic_comms_station_static")
    elseif player:isDocked(station) then
        if station:isFriendly(player) then
            return t("comms_generic_hail_friendly_station_docked", station:getCallSign())
        else
            return t("comms_generic_hail_neutral_station_docked", station:getCallSign())
        end
    else
        if station:isFriendly(player) then
            return t("comms_generic_hail_friendly_station", station:getCallSign())
        elseif station:isEnemy(player) then
            return t("comms_generic_hail_enemy_station", station:getCallSign())
        else
            return t("comms_generic_hail_neutral_station", station:getCallSign())
        end
    end
end

local setScannedDescription = function(self, description)
    self:setDescriptionForScanState("simple", description)
    self:setDescriptionForScanState("full", description)

    return self
end

function My.SpaceStation(templateName, factionName)
    local station = SpaceStation()
    station:setTemplate(templateName)
    if factionName ~= nil then station:setFaction(factionName) end

    Station:withUpgradeBroker(station)

    Station:withComms(station)
    station:setHailText(stationHail)
    station:addComms(My.Comms.Merchant)
    station:addComms(My.Comms.MissionBroker)
    station:addComms(My.Comms.UpgradeBroker)

    Station:withTags(station)

    station:setDescription(t("generic_unknown_station"))
    station.setScannedDescription = setScannedDescription
    station:setScanningParameters(1, 2)

    return station
end

function My.WarpJammer(factionName)
    local jammer = WarpJammer()
    if factionName ~= nil then jammer:setFaction(factionName) end

    Generic:withTags(jammer)

    jammer:setDescription(t("generic_unknown_object"))
    jammer.setScannedDescription = setScannedDescription
    jammer:setScanningParameters(1, 1)

    return jammer
end

function My.Artifact(modelName)
    local artifact = Artifact()
    artifact:setModel(modelName)

    Generic:withTags(artifact)

    artifact:setDescription(t("generic_unknown_object"))
    artifact.setScannedDescription = setScannedDescription
    artifact:setScanningParameters(1, 1)

    return artifact
end

function My.CpuShip(templateName, factionName)
    local ship = CpuShip()
    ship:setTemplate(templateName)
    if factionName ~= nil then ship:setFaction(factionName) end

    Ship:withCaptain(ship, Person:newHuman())

    Ship:withComms(ship)
    ship:setHailText(shipHail)
    ship:addComms(Comms.directions, "directions")
    ship:addComms(Comms.whoAreYou)

    Ship:withTags(ship)

    ship:setDescription(t("generic_unknown_ship"))
    ship.setScannedDescription = setScannedDescription

    Ship:withOrderQueue(ship)

    return ship
end

-- a ship that has been abandoned and serves as decoration
function My.WreckedCpuShip(templateName)
    local ship = SpaceStation() -- space stations are immovable
    ship:setTemplate(templateName)
    ship:setFaction("Abandoned")
    Ship:withComms(ship)

    ship:setShieldsMax() -- remove all shields
    ship:setHullMax(ship:getHullMax() * 0.1)
    ship:setHull(ship:getHullMax())
    ship:setHeading(math.random(0, 359))

    -- TODO: would be nice if player where not able to dock in the first place
    ship:setSharesEnergyWithDocked(false)
    ship:setRestocksScanProbes(false)
    ship:setRepairDocked(false)

    Ship:withTags(ship)
    ship:addTag("mute")

    ship:setDescription(t("generic_unknown_ship"))
    ship.setScannedDescription = setScannedDescription

    return ship
end

My.fleeToFortress = function(ship)
    ship:setHailText(t("comms_generic_flight_hail"))
    ship.whoAreYouResponse = t("comms_generic_flight_who_are_you")
    ship:removeComms("directions")
    ship:forceOrderNow(Order:dock(My.World.fortress, {
        onCompletion = function()
            ship:destroy()
        end,
    }))
end

-- isn't it super annoying, when wingmen crash into asteroids?
-- it does not stop them from triggering mines, but this is fine for the enemy and the players should be smart enough to navigate their fleet around.
My.asteroidRadar = function(ship, radius)
    radius = radius or 500
    Cron.regular(ship:getCallSign() .. "_asteroid_radar", function(self)
        if not ship:isValid() then
            Cron.abort(self)
        else
            for _, thing in pairs(ship:getObjectsInRange(radius)) do
                if isEeAsteroid(thing) and thing:isValid() then
                    local x, y = thing:getPosition()
                    ExplosionEffect():setPosition(x, y):setSize(300)
                    thing:destroy()
                end
            end
        end
    end, 1, math.random())
end
