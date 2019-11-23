local f = string.format

local getDescriptionSize = function(difficulty)
    if difficulty == 1 then return "weak"
    elseif difficulty == 2 then return "small"
    elseif difficulty == 3 then return "serious"
    elseif difficulty == 4 then return "big"
    elseif difficulty == 5 then return "huge"
    else return ""
    end
end

My.Translator:register("en", {
    side_mission_pirate_base_station = function(sectorName)
        return f("Destroy enemy base in sector %s", sectorName)
    end,
    side_mission_pirate_base_jammer = function(sectorName)
        return f("Destroy Warp Jammer in sector %s", sectorName)
    end,
    side_mission_pirate_base_station_briefing = function(difficulty, sectorName, payment)
        local descriptionSize = getDescriptionSize(difficulty)
        return Util.random({
            f("Our scanners located a potential enemy station in sector %s.", sectorName),
            f("Our science department picked up suspicious enemy activities in sector %s. It looks like a new station.", sectorName),
            f("As it seems, the pirates are trying to take a hold on sector %s again by building a new station.", sectorName),
            f("We located a new construction site in sector %s. As it is not properly registered, we need to assume that our enemies are trying to construct a base in sector %s.", sectorName, sectorName),
        }) .. " " .. Util.random({
            "Of course, this is not acceptable for us.",
            "This threatens us.",
            "We need to stop their effort immediately.",
        }) .. " ".. Util.random({
            f("The station is defended by a %s fleet.", descriptionSize),
            f("A %s fleet is stationed close to the base.", descriptionSize),
            f("The enemy is guarding the station with a %s fleet.", descriptionSize),
        }) .. "\n\n" .. Util.random({
            f("For the destruction of the station and its accompanying force we are paying %0.2fRP of bounty.", payment),
            f("%0.2fRP are paid to which ever captain destroys the station and its fleet.", payment),
        })
    end,
    side_mission_pirate_base_jammer_briefing = function(difficulty, sectorName, payment)
        local descriptionSize = getDescriptionSize(difficulty)

        return Util.random({
            f("We have located an enemy Warp Jammer in sector %s.", sectorName),
            f("Our enemies installed a Warp Jammer in sector %s to disturb our trading routes.", sectorName),
        }) .. " " .. Util.random({
            "It has to be destroyed immediately.",
            "Of course, this is not acceptable for us.",
        }) .. " ".. Util.random({
            f("It is guarded by a %s fleet from our enemies.", descriptionSize),
            f("A %s fleet blocks us from destroying it.", descriptionSize),
        }) .. "\n\n" .. Util.random({
            f("If you eliminate the threat, we will reciprocate with %0.2fRP.", payment),
            f("The ship that destroys our enemies is rewarded with %0.2fRP as a bounty.", payment),
            f("If you help us make our trading routes secure again, we will pay you %0.2fRP as a reward.", payment),
        })
    end,
    side_mission_pirate_base_comms_too_close = "You are too close to the target region. We do not want to expose you to too many risks. Please keep your distance in order to accept the mission.",
    side_mission_pirate_base_station_description = "A construction site of the pirates. The station is not yet operational and little more than a shell construction.",
    side_mission_pirate_base_jammer_description = "A Warp Jammer that is used by pirates to disturb close trading routes.",

    side_mission_pirate_base_station_start_hint = function(sectorName)
        return f("Locate the station in sector %s", sectorName)
    end,
    side_mission_pirate_base_jammer_start_hint = function(sectorName)
        return f("Locate the Warp Jammer in sector %s", sectorName)
    end,
    side_mission_pirate_base_station_destruction_hint = function(numberOfShips, stationValid)
        if stationValid then
            if numberOfShips == 0 then
                return "Destroy the station"
            elseif numberOfShips == 1 then
                return "Destroy the last defender and the station"
            else
                return f("Destroy %d defenders and the station", numberOfShips)
            end
        else
            if numberOfShips == 1 then
                return "Destroy the last ship"
            else
                return f("Destroy %d more ships", numberOfShips)
            end
        end
    end,
    side_mission_pirate_base_jammer_destruction_hint = function(numberOfShips, stationValid)
        if stationValid then
            if numberOfShips == 0 then
                return "Destroy the Warp Jammer"
            elseif numberOfShips == 1 then
                return "Destroy the last defender and the Warp Jammer"
            else
                return f("Destroy %d defenders and the Warp Jammer", numberOfShips)
            end
        else
            if numberOfShips == 1 then
                return "Destroy the last ship"
            else
                return f("Destroy the remaining %d defenders", numberOfShips)
            end
        end
    end,

    side_mission_pirate_base_destruction_last_hint = "Destruction of the last defender confirmed",
    side_mission_pirate_base_destruction_ship_hint = "Destruction confirmed",
    side_mission_pirate_base_destruction_station_hint = "Destruction of the Space Station confirmed",
    side_mission_pirate_base_destruction_jammer_hint = "Destruction of the Warp Jammer confirmed",

    side_mission_pirate_base_success_comms = function(payment)
        return f("Your heroic bravery saved us from this enemy. You have earned your reward of %0.2fRP truly.", payment)
    end,
})