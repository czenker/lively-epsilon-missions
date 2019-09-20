local t = My.Translator.translate

local function PlayerTemplate()
    local player = PlayerSpaceship():setFaction("Player"):setTemplate("Ranger TX5")

    Player:withMenu(player)

    Player:withStorage(player)
    Player:withStorageDisplay(player, {
        label = t("player_storage_display_label"),
        title = t("player_storage_display_title"),
        labelUsedStorage = t("player_storage_display_label_used_storage"),
        emptyStorage = t("player_storage_display_empty_storage"),
    })

    Player:withMissionTracker(player)
    Player:withMissionDisplay(player, {
        label = t("player_mission_display_label"),
        titleActiveMissions = t("player_mission_display_title_active_missions"),
        noActiveMissions = t("player_mission_display_no_active_missions"),
    })

    Player:withUpgradeTracker(player)
    Player:withUpgradeDisplay(player, {
        label = t("player_upgrade_display_label"),
        title = t("player_upgrade_display_title"),
        noUpgrades = t("player_upgrade_display_no_upgrades"),
    })

    return player
end

My.EventHandler:register("onWorldCreation", function()
    local player = PlayerTemplate():setCallSign(My.Config.playerShipName)

    player:setRepairCrewCount(4)
    player:setImpulseMaxSpeed(60)
    player:setRotationMaxSpeed(10)
    player:setCombatManeuver(0, 0)
    player:setWarpDrive(false)
    player:setJumpDrive(false)
    player:setWeaponStorageMax("hvli", 0)
    player:setWeaponStorageMax("homing", 0)
    player:setWeaponStorageMax("mine", 0)
    player:setWeaponStorageMax("nuke", 0)
    player:setWeaponStorageMax("emp", 0)
    player:setMaxScanProbeCount(4)

    My.Upgrades.speed1:install(player)
    My.Upgrades.rotation1:install(player)
    My.Upgrades.storage1:install(player)
    My.Upgrades.hvli1:install(player)
    My.Upgrades.homing1:install(player)
    My.Upgrades.energy1:install(player)
    My.Upgrades.hull1:install(player)
    My.Upgrades.shield1:install(player)

    for _,weapon in pairs({"hvli", "homing", "mine", "nuke", "emp"}) do
        player:setWeaponStorage(weapon, player:getWeaponStorageMax(weapon))
    end

    My.World.player = player

    Cron.regular(function()
        if not My.World.player:isValid() then
            logInfo("Game ends because player ship is destroyed.")
            victory("Legion")
        end
    end, 1)
end)

My.EventHandler:register("onStart", function()
    local hqX, hqY = My.World.hq:getPosition()
    local player = My.World.player

    setCirclePos(player, hqX, hqY, My.Config.avgAngle + 270, 2000)

    player:setRotation(My.Config.avgAngle + 450)
    player:commandTargetRotation(My.Config.avgAngle + 450)
end)
