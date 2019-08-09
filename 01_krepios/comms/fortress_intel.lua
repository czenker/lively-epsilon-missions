local t = My.Translator.translate

My = My or {}
My.Comms = My.Comms or {}

local f = string.format
local formatDistance = function(distance)
    return Util.round(distance / 1000, 5)
end

-- give the player intel depending on how many ships and fleets where scanned
My.Comms.FortressIntel = (function()
    local menu

    local detail = function(fleetId)
        return function(comms_target, comms_source)
            local screen = Comms:newScreen(t("fortress_intel_detail_button", fleetId) .. "\n\n")
            local fleet = My.EnemyFleet:getFleets()[fleetId]

            if fleet ~= nil and fleet:isValid() then
                local countShips = 0
                local countByType = {}
                local countFofIdentified = 0
                local countFullyScanned = 0
                local countWeapons = {}
                local countWeaponsMax = {}

                for _, ship in pairs(fleet:getShips()) do
                    countShips = countShips + 1
                    local type = ship:getTypeName()
                    if type == nil or not ship:isFriendOrFoeIdentifiedBy(comms_source) then
                        type = t("fortress_intel_detail_type_unknown")
                    end
                    countByType[type] = (countByType[type] or 0) + 1
                    if ship:isFriendOrFoeIdentifiedBy(comms_source) then
                        countFofIdentified = countFofIdentified + 1
                    end
                    if ship:isFullyScannedBy(comms_source) then
                        countFullyScanned = countFullyScanned + 1
                    end
                    for _, weapon in pairs({"hvli", "homing", "mine", "nuke", "emp"}) do
                        if ship:getWeaponStorageMax(weapon) > 0 then
                            countWeaponsMax[weapon] = (countWeaponsMax[weapon] or 0) + ship:getWeaponStorageMax(weapon)
                            countWeapons[weapon] = (countWeapons[weapon] or 0) + ship:getWeaponStorage(weapon)
                        end
                    end
                end

                if countFofIdentified == countShips then
                    local duration = math.floor((distance(comms_target, fleet:getLeader()) / fleet:getLeader():getImpulseMaxSpeed() + 30) / 60)
                    screen:addText(t("fortress_intel_detail_info_detailed", fleet:getLeader():getSectorName(), formatDistance(distance(comms_target, fleet:getLeader())), duration))
                else
                    screen:addText(t("fortress_intel_detail_info", fleet:getLeader():getSectorName(), formatDistance(distance(comms_target, fleet:getLeader()))))
                end
                screen:addText("\n\n")

                if countFofIdentified > 0 then
                    screen:addText(t("fortress_intel_detail_number_of_ships", countShips) .. "\n")
                    for type, c in pairs(countByType) do
                        screen:addText(f("  * %d x %s\n", c, type))
                    end
                    screen:addText("\n")

                    if countFofIdentified >= countShips/2 then

                        if countFullyScanned > countShips/2 then
                            screen:addText(t("fortress_intel_detail_weapons_detail") .. ":\n")
                            for _, weapon in pairs({"hvli", "homing", "mine", "nuke", "emp"}) do
                                if countWeaponsMax[weapon] ~= nil then
                                    screen:addText(f("  * %d x %s\n", countWeapons[weapon], weapon))
                                end
                            end
                            screen:addText("\n")
                        elseif countFullyScanned > 0 then
                            screen:addText(t("fortress_intel_detail_weapons") .. ":\n")
                            for _, weapon in pairs({"hvli", "homing", "mine", "nuke", "emp"}) do
                                if countWeaponsMax[weapon] ~= nil then
                                    local msg
                                    if countWeapons[weapon] == countWeaponsMax[weapon] then
                                        msg = t("fortress_intel_detail_weapons_full")
                                    elseif countWeapons[weapon] >= countWeaponsMax[weapon] * 0.75 then
                                        msg = t("fortress_intel_detail_weapons_high")
                                    elseif countWeapons[weapon] >= countWeaponsMax[weapon] * 0.4 then
                                        msg = t("fortress_intel_detail_weapons_half")
                                    elseif countWeapons[weapon] > 1 then
                                        msg = t("fortress_intel_detail_weapons_low")
                                    else
                                        msg = t("fortress_intel_detail_weapons_empty")
                                    end
                                    screen:addText(f("  * %s: %s\n", weapon, msg))
                                end
                            end
                            screen:addText("\n")
                        end
                    end
                end
                if countFullyScanned < countShips then
                    screen:addText(t("fortress_intel_detail_scan_hint"))
                end
            end

            screen:addReply(Comms:newReply(t("generic_button_back"), menu))
            return screen
        end
    end


    menu = function(comms_target, comms_source)
        local screen = Comms:newScreen()
        local fleets = My.EnemyFleet:getFleets()

        if Util.size(fleets) == 0 then
            screen:addText(t("fortress_intel_menu_no_known_fleets"))
        else
            local closestFleetDistance = 99999999
            local closestFleetId
            local validFleetCount = 0

            for i, fleet in pairs(fleets) do
                if fleet:isValid() then
                    validFleetCount = validFleetCount + 1
                    local leader = fleet:getLeader()
                    if leader ~= nil then
                        local d = distance(leader, comms_target)
                        if d < closestFleetDistance then
                            closestFleetDistance = d
                            closestFleetId = i
                        end
                    end
                end
            end

            if validFleetCount == 0 then
                screen:addText(t("fortress_intel_menu_no_valid_fleets"))
            else
                screen:addText(t("fortress_intel_menu_number_of_fleets", validFleetCount))
                screen:addText("\n\n")
                if closestFleetDistance < 5000 then
                    screen:addText(t("fortress_intel_distance_close", closestFleetId))
                else
                    screen:addText(t("fortress_intel_distance", formatDistance(closestFleetDistance), closestFleetId))
                end

                for i, fleet in pairs(fleets) do
                    if fleet:isValid() then
                        screen:addReply(Comms:newReply(t("fortress_intel_detail_button", i), detail(i)))
                    end
                end
            end
        end

        screen:addReply(Comms:newReply(t("generic_button_back")))
        return screen
    end

    return Comms:newReply(t("fortress_intel_label"), menu)
end)()