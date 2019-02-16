local t = My.Translator.translate

My = My or {}
My.Comms = My.Comms or {}

local f = string.format

local shipReport = function(screen, ship)
    -- TODO: could be Text
    screen:addText(f("%s: %d/%d (%.2f%%)\n", t("defense_squadron_report_hull"), ship:getHull(), ship:getHullMax(), ship:getHull() / ship:getHullMax() * 100))

    for i=0,ship:getShieldCount()-1 do
        screen:addText(f("%s %d: %d/%d (%.2f%%)\n", t("defense_squadron_report_shield"), i, ship:getShieldLevel(i), ship:getShieldMax(i), ship:getShieldLevel(i) / ship:getShieldMax(i) * 100))
    end

    for _, weapon in pairs({"hvli", "homing", "mine", "nuke", "emp"}) do
        if ship:getWeaponStorageMax(weapon) > 0 then
            screen:addText(f("%s: %d/%d (%.2f%%)\n", weapon, ship:getWeaponStorage(weapon), ship:getWeaponStorageMax(weapon), ship:getWeaponStorage(weapon) / ship:getWeaponStorageMax(weapon) * 100))
        end
    end
end
local fleetReport = function(screen, fleet)
    local countShips = 0
    local countWeapons = {}
    local countWeaponsMax = {}
    local shields = 0
    local shieldsMax = 0
    local hulls = 0
    local hullsMax = 0

    for _, ship in pairs(fleet:getShips()) do
        countShips = countShips + 1
        for _, weapon in pairs({"hvli", "homing", "mine", "nuke", "emp"}) do
            if ship:getWeaponStorageMax(weapon) > 0 then
                countWeaponsMax[weapon] = (countWeaponsMax[weapon] or 0) + ship:getWeaponStorageMax(weapon)
                countWeapons[weapon] = (countWeapons[weapon] or 0) + ship:getWeaponStorage(weapon)
            end
        end
        hulls = hulls + ship:getHull()
        hullsMax = hullsMax + ship:getHullMax()
        for i=0,ship:getShieldCount()-1 do
            shields = shields + ship:getShieldLevel(i)
            shieldsMax = shieldsMax + ship:getShieldMax(i)
        end
    end

    screen:addText(f("%s: %d\n", t("defense_squadron_report_total_fleet"), countShips))
    screen:addText(f("%s: %d/%d (%.2f%%)\n", t("defense_squadron_report_total_hull"), math.floor(hulls), math.floor(hullsMax), hulls / hullsMax * 100))
    screen:addText(f("%s: %d/%d (%.2f%%)\n", t("defense_squadron_report_total_shield"), math.floor(shields), math.floor(shieldsMax), shields / shieldsMax * 100))
    for _, weapon in pairs({"hvli", "homing", "mine", "nuke", "emp"}) do
        if countWeaponsMax[weapon] ~= nil then
            screen:addText(f("%s: %d/%d (%.2f%%)\n", weapon, countWeapons[weapon], countWeaponsMax[weapon], countWeapons[weapon] / countWeaponsMax[weapon] * 100))
        end
    end
end

My.Comms.shipReport = (function()
    local report
    report = function(self, comms_target, comms_source)
        local screen = Comms:newScreen()

        if Ship:hasFleet(comms_target) and comms_target:isFleetLeader() then
            fleetReport(screen, comms_target:getFleet())
        else
            shipReport(screen, comms_target)
        end

        screen:addReply(Comms:newReply(t("generic_button_back")))
        return screen
    end

    return Comms:newReply(t("defense_squadron_report"), report)
end)()
