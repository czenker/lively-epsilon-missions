local t = My.Translator.translate

My = My or {}
My.Upgrades = My.Upgrades or {}

-- possible tags:
--  * freely-sold: will be randomly available at basic stations from the beginning of the game

My.Upgrades.speed1 = (function()
    local speed = 60

    local upgrade = BrokerUpgrade:new({
        name = t("upgrade_speed1_name"),
        onInstall = function(upgrade, player)
            player:setImpulseMaxSpeed(speed)
        end,
        id = "speed1",
        price = 0,
        unique = true,
        description = t("upgrade_speed1_description", speed * 0.06),
    })
    Generic:withTags(upgrade)
    upgrade:addTag("freely-sold")
    return upgrade
end)()
My.Upgrades.speed2 = (function()
    local speed = 80

    local upgrade = BrokerUpgrade:new({
        name = t("upgrade_speed2_name"),
        onInstall = function(upgrade, player)
            player:setImpulseMaxSpeed(speed)
        end,
        id = "speed2",
        price = 250,
        unique = true,
        requiredUpgrade = "speed1",
        description = t("upgrade_speed2_description", speed * 0.06),
    })
    Generic:withTags(upgrade)
    upgrade:addTag("freely-sold")
    return upgrade
end)()
My.Upgrades.speed3 = (function()
    local speed = 95

    local upgrade = BrokerUpgrade:new({
        name = t("upgrade_speed3_name"),
        onInstall = function(upgrade, player)
            player:setImpulseMaxSpeed(speed)
        end,
        id = "speed3",
        price = 250,
        unique = true,
        requiredUpgrade = "speed2",
        description = t("upgrade_speed3_description", speed * 0.06),
    })
    Generic:withTags(upgrade)
    upgrade:addTag("freely-sold")
    return upgrade
end)()
My.Upgrades.speed4 = (function()
    local speed = 105

    local upgrade = BrokerUpgrade:new({
        name = t("upgrade_speed4_name"),
        onInstall = function(upgrade, player)
            player:setImpulseMaxSpeed(speed)
        end,
        id = "speed4",
        price = 250,
        unique = true,
        requiredUpgrade = "speed3",
        description = t("upgrade_speed4_description", speed * 0.06),
    })
    Generic:withTags(upgrade)
    upgrade:addTag("freely-sold")
    return upgrade
end)()

My.Upgrades.rotation1 = (function()
    local speed = 10

    local upgrade = BrokerUpgrade:new({
        name = t("upgrade_rotation1_name"),
        onInstall = function(upgrade, player)
            player:setRotationMaxSpeed(speed)
        end,
        id = "rotation1",
        price = 0,
        unique = true,
        description = t("upgrade_rotation1_description", 180 / speed),
    })
    Generic:withTags(upgrade)
    upgrade:addTag("freely-sold")
    return upgrade
end)()
My.Upgrades.rotation2 = (function()
    local speed = 15

    local upgrade = BrokerUpgrade:new({
        name = t("upgrade_rotation2_name"),
        onInstall = function(upgrade, player)
            player:setRotationMaxSpeed(speed)
        end,
        id = "rotation2",
        price = 150,
        unique = true,
        requiredUpgrade = "rotation1",
        description = t("upgrade_rotation2_description", 180 / speed),
    })
    Generic:withTags(upgrade)
    upgrade:addTag("freely-sold")
    return upgrade
end)()
My.Upgrades.rotation3 = (function()
    local speed = 20

    local upgrade = BrokerUpgrade:new({
        name = t("upgrade_rotation3_name"),
        onInstall = function(upgrade, player)
            player:setRotationMaxSpeed(speed)
        end,
        id = "rotation3",
        price = 200,
        unique = true,
        requiredUpgrade = "rotation2",
        description = t("upgrade_rotation3_description", 180 / speed),
    })
    Generic:withTags(upgrade)
    upgrade:addTag("freely-sold")
    return upgrade
end)()

My.Upgrades.storage1 = (function()
    local storage = 100

    local upgrade = BrokerUpgrade:new({
        name = t("upgrade_storage1_name"),
        onInstall = function(upgrade, player)
            player:setMaxStorageSpace(storage)
        end,
        id = "storage1",
        price = 0,
        unique = true,
        canBeInstalled = function(upgrade, player)
            return Player:hasStorage(player)
        end,
        description = t("upgrade_storage1_description", storage)
    })
    Generic:withTags(upgrade)
    upgrade:addTag("freely-sold")
    return upgrade
end)()
My.Upgrades.storage2 = (function()
    local storage = 50

    local upgrade = BrokerUpgrade:new({
        name = t("upgrade_storage2_name"),
        onInstall = function(upgrade, player)
            player:setMaxStorageSpace(player:getMaxStorageSpace() + storage)
        end,
        id = "storage2",
        price = 250,
        unique = true,
        requiredUpgrade = "storage1",
        canBeInstalled = function(upgrade, player)
            return Player:hasStorage(player)
        end,
        description = t("upgrade_storage2_description", storage)
    })
    Generic:withTags(upgrade)
    upgrade:addTag("freely-sold")
    return upgrade
end)()
My.Upgrades.storage3 = (function()
    local storage = 50

    local upgrade = BrokerUpgrade:new({
        name = t("upgrade_storage3_name"),
        onInstall = function(upgrade, player)
            player:setMaxStorageSpace(player:getMaxStorageSpace() + storage)
        end,
        id = "storage3",
        price = 250,
        unique = true,
        requiredUpgrade = "storage2",
        canBeInstalled = function(upgrade, player)
            return Player:hasStorage(player)
        end,
        description = t("upgrade_storage3_description", storage)
    })
    Generic:withTags(upgrade)
    upgrade:addTag("freely-sold")
    return upgrade
end)()

My.Upgrades.combatManeuver = (function()
    local upgrade = BrokerUpgrade:new({
        name = t("upgrade_combatManeuver_name"),
        onInstall = function(upgrade, player)
            player:setCombatManeuver(250, 150)
        end,
        id = "combat_maneuver",
        price = 250,
        unique = true,
        description = t("upgrade_combatManeuver_description"),
    })
    Generic:withTags(upgrade)
    upgrade:addTag("freely-sold")
    return upgrade
end)()

My.Upgrades.warpDrive = (function()
    local upgrade = BrokerUpgrade:new({
        name = t("upgrade_warpDrive_name"),
        onInstall = function(upgrade, player)
            player:setWarpDrive(true)
        end,
        id = "warpDrive",
        price = 0,
        unique = true,
        canBeInstalled = function(upgrade, player)
            return not player:hasJumpDrive() and not player:hasWarpDrive()
        end,
        description = t("upgrade_warpDrive_description"),
    })
    Generic:withTags(upgrade)
    return upgrade
end)()

My.Upgrades.tacticalJumpDrive = (function()
    local rangeInU = 10
    local upgrade = BrokerUpgrade:new({

        name = t("upgrade_jumpDrive_name", rangeInU),
        onInstall = function(upgrade, player)
            player:setJumpDrive(true)
            player:setJumpDriveRange(0, rangeInU * 1000)
        end,
        id = "tacticalJumpDrive",
        price = 120,
        unique = true,
        requiredUpgrade = "warpDrive",
        description = t("upgrade_tacticalJumpDrive_description", rangeInU),
    })
    Generic:withTags(upgrade)
    upgrade:addTag("freely-sold")
    return upgrade
end)()

My.Upgrades.jumpDrive = (function()
    local rangeInU = 30
    local upgrade = BrokerUpgrade:new({

        name = t("upgrade_jumpDrive_name", rangeInU),
        onInstall = function(upgrade, player)
            player:setJumpDrive(true)
            player:setJumpDriveRange(0, rangeInU * 1000)
            My.installJumpCalculator()
        end,
        id = "jumpDrive",
        price = 0,
        unique = true,
        canBeInstalled = function(upgrade, player)
            return not player:hasJumpDrive() and not player:hasWarpDrive()
        end,
        description = t("upgrade_jumpDrive_description", rangeInU),
    })
    Generic:withTags(upgrade)
    return upgrade
end)()
My.Upgrades.jumpDrive2 = (function()
    local rangeInU = 60
    local upgrade = BrokerUpgrade:new({

        name = t("upgrade_jumpDrive_name", rangeInU),
        onInstall = function(upgrade, player)
            player:setJumpDrive(true)
            player:setJumpDriveRange(0, rangeInU * 1000)
        end,
        id = "jumpDrive2",
        price = 120,
        unique = true,
        requiredUpgrade = "jumpDrive",
        description = t("upgrade_jumpDrive2_description", rangeInU),
    })
    Generic:withTags(upgrade)
    upgrade:addTag("freely-sold")
    return upgrade
end)()

My.Upgrades.hvli1 = (function()
    local amount = 4

    local upgrade = BrokerUpgrade:new({
        name = t("upgrade_hvli1_name"),
        onInstall = function(upgrade, player)
            player:setWeaponStorageMax("hvli", amount)
        end,
        id = "hvli1",
        price = 0,
        unique = true,
        description = t("upgrade_hvli1_description", amount),
    })
    Generic:withTags(upgrade)
    upgrade:addTag("freely-sold")
    return upgrade
end)()
My.Upgrades.hvli2 = (function()
    local amount = 8
    local storageMalus = 4

    local upgrade = BrokerUpgrade:new({
        name = t("upgrade_hvli2_name"),
        onInstall = function(upgrade, player)
            player:setWeaponStorageMax("hvli", amount)
            player:setMaxStorageSpace(player:getMaxStorageSpace() - storageMalus)
        end,
        id = "hvli2",
        price = 75,
        unique = true,
        requiredUpgrade = "hvli1",
        canBeInstalled = function(upgrade, player)
            return Player:hasStorage(player) and player:getMaxStorageSpace() >= storageMalus
        end,
        description = t("upgrade_hvli2_description", amount, storageMalus),
    })
    Generic:withTags(upgrade)
    upgrade:addTag("freely-sold")
    return upgrade
end)()
My.Upgrades.hvli3 = (function()
    local amount = 12
    local storageMalus = 4

    local upgrade = BrokerUpgrade:new({
        name = t("upgrade_hvli3_name"),
        onInstall = function(upgrade, player)
            player:setWeaponStorageMax("hvli", amount)
            player:setMaxStorageSpace(player:getMaxStorageSpace() - storageMalus)
        end,
        id = "hvli3",
        price = 100,
        unique = true,
        requiredUpgrade = "hvli2",
        canBeInstalled = function(upgrade, player)
            return Player:hasStorage(player) and player:getMaxStorageSpace() >= storageMalus
        end,
        description = t("upgrade_hvli3_description", amount, storageMalus),
    })
    Generic:withTags(upgrade)
    upgrade:addTag("freely-sold")
    return upgrade
end)()

My.Upgrades.homing1 = (function()
    local amount = 2

    local upgrade = BrokerUpgrade:new({
        name = t("upgrade_homing1_name"),
        onInstall = function(upgrade, player)
            player:setWeaponStorageMax("homing", amount)
        end,
        id = "homing1",
        price = 0,
        unique = true,
        description = t("upgrade_homing1_description", amount),
    })
    Generic:withTags(upgrade)
    upgrade:addTag("freely-sold")
    return upgrade
end)()
My.Upgrades.homing2 = (function()
    local amount = 4
    local storageMalus = 4

    local upgrade = BrokerUpgrade:new({
        name = t("upgrade_homing2_name"),
        onInstall = function(upgrade, player)
            player:setWeaponStorageMax("homing", amount)
            player:setMaxStorageSpace(player:getMaxStorageSpace() - storageMalus)
        end,
        id = "homing2",
        price = 100,
        unique = true,
        requiredUpgrade = "homing1",
        canBeInstalled = function(upgrade, player)
            return Player:hasStorage(player) and player:getMaxStorageSpace() >= storageMalus
        end,
        description = t("upgrade_homing2_description", amount, storageMalus),
    })
    Generic:withTags(upgrade)
    upgrade:addTag("freely-sold")
    return upgrade
end)()
My.Upgrades.homing3 = (function()
    local amount = 8
    local storageMalus = 8

    local upgrade = BrokerUpgrade:new({
        name = t("upgrade_homing3_name"),
        onInstall = function(upgrade, player)
            player:setWeaponStorageMax("homing", amount)
            player:setMaxStorageSpace(player:getMaxStorageSpace() - storageMalus)
        end,
        id = "homing3",
        price = 150,
        unique = true,
        requiredUpgrade = "homing2",
        canBeInstalled = function(upgrade, player)
            return Player:hasStorage(player) and player:getMaxStorageSpace() >= storageMalus
        end,
        description = t("upgrade_homing3_description", amount, storageMalus),
    })
    Generic:withTags(upgrade)
    upgrade:addTag("freely-sold")
    return upgrade
end)()

My.Upgrades.mine1 = (function()
    local amount = 1
    local storageMalus = 8

    local upgrade = BrokerUpgrade:new({
        name = t("upgrade_mine1_name"),
        onInstall = function(upgrade, player)
            player:setWeaponStorageMax("mine", amount)
            player:setMaxStorageSpace(player:getMaxStorageSpace() - storageMalus)
        end,
        id = "mine1",
        price = 150,
        unique = true,
        canBeInstalled = function(upgrade, player)
            return Player:hasStorage(player) and player:getMaxStorageSpace() >= storageMalus
        end,
        description = t("upgrade_mine1_description", storageMalus),
    })
    Generic:withTags(upgrade)
    upgrade:addTag("freely-sold")
    return upgrade
end)()
My.Upgrades.mine2 = (function()
    local amount = 2
    local storageMalus = 8

    local upgrade = BrokerUpgrade:new({
        name = t("upgrade_mine2_name"),
        onInstall = function(upgrade, player)
            player:setWeaponStorageMax("mine", amount)
            player:setMaxStorageSpace(player:getMaxStorageSpace() - storageMalus)
        end,
        id = "mine2",
        price = 100,
        unique = true,
        requiredUpgrade = "mine1",
        canBeInstalled = function(upgrade, player)
            return Player:hasStorage(player) and player:getMaxStorageSpace() >= storageMalus
        end,
        description = t("upgrade_mine2_description", amount, storageMalus),
    })
    Generic:withTags(upgrade)
    upgrade:addTag("freely-sold")
    return upgrade
end)()
My.Upgrades.mine3 = (function()
    local amount = 4
    local storageMalus = 16

    local upgrade = BrokerUpgrade:new({
        name = t("upgrade_mine3_name"),
        onInstall = function(upgrade, player)
            player:setWeaponStorageMax("mine", amount)
            player:setMaxStorageSpace(player:getMaxStorageSpace() - storageMalus)
        end,
        id = "mine3",
        price = 200,
        unique = true,
        requiredUpgrade = "mine2",
        canBeInstalled = function(upgrade, player)
            return Player:hasStorage(player) and player:getMaxStorageSpace() >= storageMalus
        end,
        description = t("upgrade_mine3_description", amount, storageMalus),
    })
    Generic:withTags(upgrade)
    upgrade:addTag("freely-sold")
    return upgrade
end)()

My.Upgrades.emp1 = (function()
    local amount = 1
    local storageMalus = 4

    local upgrade = BrokerUpgrade:new({
        name = t("upgrade_emp1_name"),
        onInstall = function(upgrade, player)
            player:setWeaponStorageMax("emp", amount)
            player:setMaxStorageSpace(player:getMaxStorageSpace() - storageMalus)
        end,
        id = "emp1",
        price = 100,
        unique = true,
        canBeInstalled = function(upgrade, player)
            return Player:hasStorage(player) and player:getMaxStorageSpace() >= storageMalus
        end,
        description = t("upgrade_emp1_description", storageMalus),
    })
    Generic:withTags(upgrade)
    upgrade:addTag("freely-sold")
    return upgrade
end)()
My.Upgrades.emp2 = (function()
    local amount = 2
    local storageMalus = 4

    local upgrade = BrokerUpgrade:new({
        name = t("upgrade_emp2_name"),
        onInstall = function(upgrade, player)
            player:setWeaponStorageMax("emp", amount)
            player:setMaxStorageSpace(player:getMaxStorageSpace() - storageMalus)
        end,
        id = "emp2",
        price = 75,
        unique = true,
        requiredUpgrade = "emp1",
        canBeInstalled = function(upgrade, player)
            return Player:hasStorage(player) and player:getMaxStorageSpace() >= storageMalus
        end,
        description = t("upgrade_emp2_description", amount, storageMalus),
    })
    Generic:withTags(upgrade)
    upgrade:addTag("freely-sold")
    return upgrade
end)()
My.Upgrades.emp3 = (function()
    local amount = 4
    local storageMalus = 8

    local upgrade = BrokerUpgrade:new({
        name = t("upgrade_emp3_name"),
        onInstall = function(upgrade, player)
            player:setWeaponStorageMax("emp", amount)
            player:setMaxStorageSpace(player:getMaxStorageSpace() - storageMalus)
        end,
        id = "emp3",
        price = 150,
        unique = true,
        requiredUpgrade = "emp2",
        canBeInstalled = function(upgrade, player)
            return Player:hasStorage(player) and player:getMaxStorageSpace() >= storageMalus
        end,
        description = t("upgrade_emp3_description", amount, storageMalus),
    })
    Generic:withTags(upgrade)
    upgrade:addTag("freely-sold")
    return upgrade
end)()

My.Upgrades.nuke1 = (function()
    local amount = 1
    local storageMalus = 16

    local upgrade = BrokerUpgrade:new({
        name = t("upgrade_nuke1_name"),
        onInstall = function(upgrade, player)
            player:setWeaponStorageMax("nuke", amount)
            player:setMaxStorageSpace(player:getMaxStorageSpace() - storageMalus)
        end,
        id = "nuke1",
        price = 300,
        unique = true,
        canBeInstalled = function(upgrade, player)
            return Player:hasStorage(player) and player:getMaxStorageSpace() >= storageMalus
        end,
        description = t("upgrade_nuke1_description", storageMalus),
    })
    Generic:withTags(upgrade)
    return upgrade
end)()
My.Upgrades.nuke2 = (function()
    local amount = 2
    local storageMalus = 16

    local upgrade = BrokerUpgrade:new({
        name = t("upgrade_nuke2_name"),
        onInstall = function(upgrade, player)
            player:setWeaponStorageMax("nuke", amount)
            player:setMaxStorageSpace(player:getMaxStorageSpace() - storageMalus)
        end,
        id = "nuke2",
        price = 200,
        unique = true,
        requiredUpgrade = "nuke1",
        canBeInstalled = function(upgrade, player)
            return Player:hasStorage(player) and player:getMaxStorageSpace() >= storageMalus
        end,
        description = t("upgrade_nuke2_description", storageMalus),
    })
    Generic:withTags(upgrade)
    return upgrade
end)()

My.Upgrades.energy1 = (function()
    local amount = 500
    local upgrade = BrokerUpgrade:new({
        name = t("upgrade_energy1_name"),
        onInstall = function(upgrade, player)
            player:setMaxEnergy(amount)
        end,
        id = "energy1",
        price = 0,
        unique = true,
        description = t("upgrade_energy1_description", amount),
    })
    Generic:withTags(upgrade)
    upgrade:addTag("freely-sold")
    return upgrade
end)()

My.Upgrades.energy2 = (function()
    local amount = 250
    local upgrade = BrokerUpgrade:new({
        name = t("upgrade_energy2_name"),
        onInstall = function(upgrade, player)
            player:setMaxEnergy(player:getMaxEnergy() + amount)
        end,
        id = "energy2",
        price = 50,
        unique = true,
        requiredUpgrade = "energy1",
        description = t("upgrade_energy2_description", amount),
    })
    Generic:withTags(upgrade)
    upgrade:addTag("freely-sold")
    return upgrade
end)()

My.Upgrades.energy3 = (function()
    local amount = 500
    local upgrade = BrokerUpgrade:new({
        name = t("upgrade_energy3_name"),
        onInstall = function(upgrade, player)
            player:setMaxEnergy(player:getMaxEnergy() + amount)
        end,
        id = "energy3",
        price = 100,
        unique = true,
        requiredUpgrade = "energy2",
        description = t("upgrade_energy3_description", amount),
    })
    Generic:withTags(upgrade)
    upgrade:addTag("freely-sold")
    return upgrade
end)()

My.Upgrades.energy4 = (function()
    local amount = 500
    local storageMalus = 10

    local upgrade = BrokerUpgrade:new({
        name = t("upgrade_energy4_name"),
        onInstall = function(upgrade, player)
            player:setMaxEnergy(player:getMaxEnergy() + amount)
        end,
        id = "energy4",
        price = 100,
        unique = true,
        requiredUpgrade = "energy3",
        description = t("upgrade_energy4_description", amount, storageMalus),
    })
    Generic:withTags(upgrade)
    upgrade:addTag("freely-sold")
    return upgrade
end)()

My.Upgrades.powerPresets = (function()
    local slots = 6

    local upgrade = BrokerUpgrade:new({
        name = t("upgrade_powerPresets_name"),
        onInstall = function(upgrade, player)
            Player:withPowerPresets(player, {
                slots = slots,
                label = t("player_power_presets_label"),
                labelLoad = t("player_power_presets_label_load"),
                labelStore = t("player_power_presets_label_store"),
                labelLoadItem = t("player_power_presets_label_load_item"),
                labelStoreItem = t("player_power_presets_label_store_item"),
                labelReset = t("player_power_presets_label_reset"),
                labelInfo = t("player_power_presets_label_info"),
                infoText = t("player_power_presets_info_text", slots),
            })
        end,
        id = "powerPresets",
        price = 0,
        unique = true,
        description = t("upgrade_powerPresets_description", slots),
        canBeInstalled = function(upgrade, player)
            return Player:hasMenu(player) and not Player:hasPowerPresets(player)
        end,
    })
    Generic:withTags(upgrade)
    return upgrade
end)()
My.Upgrades.laserRefit = (function()
    local slots = 6

    local upgrade = BrokerUpgrade:new({
        name = t("upgrade_laserRefit_name"),
        onInstall = function()
            My.installLaserRefit()
        end,
        id = "laserRefit",
        price = 0,
        unique = true,
        description = t("upgrade_laserRefit_description", slots),
        canBeInstalled = function(upgrade, player)
            return Player:hasMenu(player)
        end,
    })
    Generic:withTags(upgrade)
    return upgrade
end)()

My.Upgrades.shield1 = (function()
    local strength = 70
    local upgrade = BrokerUpgrade:new({
        name = t("upgrade_shield1_name"),
        onInstall = function(upgrade, player)
            player:setShieldsMax(strength, strength)
        end,
        id = "shield1",
        price = 0,
        unique = true,
        description = t("upgrade_shield1_description", strength),
    })
    Generic:withTags(upgrade)
    upgrade:addTag("freely-sold")
    return upgrade
end)()

My.Upgrades.shield2 = (function()
    local strength = 100
    local upgrade = BrokerUpgrade:new({
        name = t("upgrade_shield2_name"),
        onInstall = function(upgrade, player)
            player:setShieldsMax(strength, strength)
        end,
        id = "shield2",
        price = 200,
        unique = true,
        requiredUpgrade = "shield1",
        description = t("upgrade_shield2_description", strength),
    })
    Generic:withTags(upgrade)
    upgrade:addTag("freely-sold")
    return upgrade
end)()

My.Upgrades.shield3 = (function()
    local strength = 150
    local upgrade = BrokerUpgrade:new({
        name = t("upgrade_shield3_name"),
        onInstall = function(upgrade, player)
            player:setShieldsMax(strength, strength)
        end,
        id = "shield3",
        price = 250,
        unique = true,
        requiredUpgrade = "shield2",
        description = t("upgrade_shield3_description", strength),
    })
    Generic:withTags(upgrade)
    upgrade:addTag("freely-sold")
    return upgrade
end)()

My.Upgrades.hull1 = (function()
    local strength = 100
    local upgrade = BrokerUpgrade:new({
        name = t("upgrade_hull1_name"),
        onInstall = function(upgrade, player)
            player:setHullMax(strength)
        end,
        id = "hull1",
        price = 0,
        unique = true,
        description = t("upgrade_hull1_description", strength),
    })
    Generic:withTags(upgrade)
    upgrade:addTag("freely-sold")
    return upgrade
end)()

My.Upgrades.hull2 = (function()
    local amount = 150
    local upgrade = BrokerUpgrade:new({
        name = t("upgrade_hull2_name"),
        onInstall = function(upgrade, player)
            player:setHullMax(amount, amount)
        end,
        id = "hull2",
        price = 200,
        unique = true,
        requiredUpgrade = "hull1",
        description = t("upgrade_hull2_description", amount),
    })
    Generic:withTags(upgrade)
    upgrade:addTag("freely-sold")
    return upgrade
end)()

My.Upgrades.beam = (function()
    local slot = 2 -- 0 is the first beam
    local storageMalus = 16
    local upgrade = BrokerUpgrade:new({
        name = t("upgrade_beam_name"),
        onInstall = function(upgrade, player)
            player:setBeamWeapon(slot, 50, 180, 800.0, 8.0, 6)
        end,
        id = "beam",
        price = 200,
        unique = true,
        description = t("upgrade_beam_description", storageMalus),
        canBeInstalled = function(upgrade, player)
            return player:getBeamWeaponRange(slot) <= 0
        end,
    })
    Generic:withTags(upgrade)
    upgrade:addTag("freely-sold")
    return upgrade
end)()

My.Upgrades.autoFoF = (function()
    local upgrade = BrokerUpgrade:new({
        name = t("upgrade_autofof_name"),
        onInstall = function(_, player)
            My.installAutoFriendOrFoe(player)
        end,
        id = "autofof",
        price = 80,
        unique = true,
        description = t("upgrade_autofof_description"),
        canBeInstalled = function()
            return isFunction(My.installAutoFriendOrFoe)
        end,
    })
    Generic:withTags(upgrade)
    return upgrade
end)()

My.Upgrades.probe = (function()
    local amount = 4
    local storageMalus = 6
    local upgrade = BrokerUpgrade:new({
        name = t("upgrade_probe_name"),
        onInstall = function(upgrade, player)
            player:setMaxScanProbeCount(player:getMaxScanProbeCount() + amount)
        end,
        id = "probe",
        price = 80,
        unique = true,
        description = t("upgrade_probe_description", storageMalus, amount),
        canBeInstalled = function(upgrade, player)
            return player:getMaxScanProbeCount() > 0
        end,
    })
    Generic:withTags(upgrade)
    upgrade:addTag("freely-sold")
    return upgrade
end)()

My.Upgrades.nanobot = (function()
    local hullMalus = 10
    local repairAmount = 25
    local repairTime = 90 -- seconds

    local upgrade = BrokerUpgrade:new({
        name = t("upgrade_nanobots_name"),
        onInstall = function(_, player)
            player:setHullMax(player:getHullMax() - hullMalus)
            player:setHull(math.min(player:getHull(), player:getHullMax()))
            My.installNanobots(player, repairAmount, repairTime)
        end,
        id = "nanobot",
        price = 120,
        unique = true,
        description = function(_, player)
            t("upgrade_nanobots_description", hullMalus / player:getHullMax() * 100)
        end,
        canBeInstalled = function(_, player)
            return player:getHullMax() > hullMalus
        end,
    })
    Generic:withTags(upgrade)
    return upgrade
end)()