local t = My.Translator.translate

-- This is the squadron that supports the player in the defense of the fortress
local callSign = function(fleetNr, shipNr)
    local name = ""
    if fleetNr == 1 then name = name .. "Red"
    elseif fleetNr == 2 then name = name .. "Blue"
    end
    name = name .. " "

    if shipNr == 1 then name = name .. "One"
    elseif shipNr == 2 then name = name .. "Two"
    elseif shipNr == 3 then name = name .. "Three"
    elseif shipNr == 4 then name = name .. "Four"
    elseif shipNr == 5 then name = name .. "Five"
    elseif shipNr == 6 then name = name .. "Six"
    elseif shipNr == 7 then name = name .. "Seven"
    elseif shipNr == 8 then name = name .. "Eight"
    elseif shipNr == 9 then name = name .. "Nine"
    elseif shipNr == 10 then name = name .. "Ten"
    end

    return name
end

local function ShipTemplate(templateName)
    local ship = My.CpuShip(templateName, "Human Navy"):
    setJumpDrive(false):
    setWarpDrive(true)

    ship:addComms(My.Comms.commandFighter)
    ship:addComms(My.Comms.shipReport)

    ship:addTag("military")
    ship:setScannedDescription(t("defense_squadron_description"))

    My.asteroidRadar(ship)

    return ship
end

local function GunshipTemplate()
    return ShipTemplate("Gunship")
end

local function FighterTemplate()
    return ShipTemplate("Adder MK5")
end

local function ArtilleryTemplate()
    return ShipTemplate("Storm")
end

My.deployDefenseArtillery = function()

    local fortress = My.World.fortress

    local fleet = Fleet:new({
        ArtilleryTemplate():setCallSign(callSign(2, 1)),
        FighterTemplate():setCallSign(callSign(2, 2)),
        FighterTemplate():setCallSign(callSign(2, 3)),
    })
    for _,ship in pairs(fleet:getShips()) do
        Util.spawnAtStation(fortress, ship)
    end
    fleet:orderDefendTarget(fortress)

    Fleet:withOrderQueue(fleet)

    My.World.player:addQuickDial(fleet)
end
My.deployDefenseGunships = function()
    local fortress = My.World.fortress

    local fleet = Fleet:new({
        GunshipTemplate():setCallSign(callSign(1, 1)),
        GunshipTemplate():setCallSign(callSign(1, 2)),
        GunshipTemplate():setCallSign(callSign(1, 3)),
    })
    for _,ship in pairs(fleet:getShips()) do
        Util.spawnAtStation(fortress, ship)
    end
    fleet:orderDefendTarget(fortress)

    Fleet:withOrderQueue(fleet)

    My.World.player:addQuickDial(fleet)
end

My.EventHandler:register("onDefensePlanned", function(self, event)
    if event.spawnArtillery == true then
        My.deployDefenseArtillery()
    end
    if event.spawnGunships == true then
        My.deployDefenseGunships()
    end
end)