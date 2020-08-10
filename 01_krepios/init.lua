_G.My = _G.My or {}
My.World = {}
My.Story = {}
My.Chatter = Chatter:new()

My.EventHandler = EventHandler:new({allowedEvents = {
    "onWorldCreation", -- when the world is created
    "onStart", -- when the player ship first enters the world

    "onFirstMoneyEarned", --
    "onDrivesAvailable", --
    --"onSimulationsAvailable", --

    "onAttackersSpawn", -- when the attackers spawn
    "onAttackersDetection", -- when the attackers are discovered
    "onHQDestroyed", --
    "onAllStationsDestroyed", --
    "onClosingInToFortress", --
    "onFortressManned", -- when the fortress is manned
    "onDefensePlanned", --

    "onCommanderDead", --
    "onEvacComplete", --
    "onEnemiesDestroyed", --
}, unique = true})

My.Translator = Translator:new("en")
My.Translator:useLocale("en")

if isFunction(getScenarioVariation) then
    local scenario = getScenarioVariation() or ""
    if scenario:match('German') ~= nil then
        My.Translator:useLocale("de", "en")
    else
        My.Translator:useLocale("en", "de")
    end
end

local myPackages = {
    "01_krepios/lang/de/init.lua",
    "01_krepios/lang/en/init.lua",

    "01_krepios/products.lua",

    "01_krepios/spaceObjects.lua",
    "01_krepios/world.lua",

    "01_krepios/comms/command_fighter.lua",
    "01_krepios/comms/directions.lua",
    "01_krepios/comms/fortress_hail.lua",
    "01_krepios/comms/fortress_improvement.lua",
    "01_krepios/comms/fortress_intel.lua",
    "01_krepios/comms/merchant.lua",
    "01_krepios/comms/mission_broker.lua",
    "01_krepios/comms/ship_report.lua",
    "01_krepios/comms/shipyard_tinkerer.lua",
    "01_krepios/comms/upgrade_broker.lua",
    "01_krepios/comms/who_are_you.lua",

    "01_krepios/gamemaster/player.lua",
    "01_krepios/gamemaster/stations.lua",
    "01_krepios/gamemaster/story.lua",

    "01_krepios/side_missions/arena_fight.lua",
    "01_krepios/side_missions/buyer.lua",
    "01_krepios/side_missions/capture.lua",
    "01_krepios/side_missions/destroy_graveyard.lua",
    "01_krepios/side_missions/disable_ship.lua",
    "01_krepios/side_missions/drive_test.lua",
    "01_krepios/side_missions/gather_crystals.lua",
    "01_krepios/side_missions/pirate_base.lua",
    "01_krepios/side_missions/raging_miner.lua",
    "01_krepios/side_missions/repair.lua",
    "01_krepios/side_missions/scan_asteroids.lua",
    "01_krepios/side_missions/scan_crystal.lua",
    "01_krepios/side_missions/secret_code.lua",
    "01_krepios/side_missions/transport_human.lua",
    "01_krepios/side_missions/transport_product.lua",
    "01_krepios/side_missions/transport_thing.lua",

    "01_krepios/side_missions.lua",
    "01_krepios/mission_broker.lua",
    "01_krepios/mission_logging.lua",
    "01_krepios/upgrades.lua",
    "01_krepios/flying_trader.lua",
    "01_krepios/chatter.lua",
    "01_krepios/database.lua",
    "01_krepios/raid.lua",

    "01_krepios/upgrades/auto_fof.lua",
    "01_krepios/upgrades/jump_calculator.lua",
    "01_krepios/upgrades/laser_refit.lua",
    "01_krepios/upgrades/nanobots.lua",
    "01_krepios/upgrades/shield_emp.lua",

    "01_krepios/world/helper.lua",
    "01_krepios/world/asteroids.lua",
    "01_krepios/world/commander.lua",
    "01_krepios/world/defense_squadron.lua",
    "01_krepios/world/enemy_fleet.lua",
    "01_krepios/world/drops.lua",
    "01_krepios/world/graveyard.lua",
    "01_krepios/world/nebulas.lua",
    "01_krepios/world/planet.lua",
    "01_krepios/world/player.lua",
    "01_krepios/world/player_mining.lua",
    "01_krepios/world/player_relay.lua",
    --"01_krepios/world/random_ships.lua",
    "01_krepios/world/station_abandoned.lua",
    "01_krepios/world/station_fortress.lua",
    "01_krepios/world/station_colonel.lua",
    "01_krepios/world/station_hq.lua",
    "01_krepios/world/station_mines.lua",
    "01_krepios/world/station_research.lua",
    "01_krepios/world/station_shipyard.lua",
    "01_krepios/world/station_shipyard_tinkerer.lua",
    "01_krepios/world/wormhole.lua",

    "01_krepios/main_story/missions/10_install_drive.lua",
    "01_krepios/main_story/missions/10_visit_stations.lua",
    "01_krepios/main_story/missions/20_defend_fortress.lua",
    "01_krepios/main_story/missions/20_plan_defense.lua",
    "01_krepios/main_story/missions/20_scan_enemies.lua",
    "01_krepios/main_story/missions/25_evacuate.lua",
    "01_krepios/main_story/missions/90_debrief.lua",

    "01_krepios/main_story/01_welcome.lua",
    "01_krepios/main_story/02_after_first_mission.lua",
    "01_krepios/main_story/03_drives_available.lua",
    "01_krepios/main_story/19_attack_warning.lua",
    "01_krepios/main_story/20_attack_detected.lua",
    "01_krepios/main_story/19_attack_warning.lua",
    "01_krepios/main_story/21_defense_briefing.lua",
    "01_krepios/main_story/21_financial_support.lua",
    "01_krepios/main_story/22_hq_destroyed.lua",
    "01_krepios/main_story/23_all_destroyed.lua",
    "01_krepios/main_story/30_evacuation_order.lua",
    "01_krepios/main_story/40_enemies_destroyed.lua",
    "01_krepios/main_story/40_final_evacuation_order.lua",
    "01_krepios/main_story/90_debrief.lua",
    "01_krepios/main_story/wiring.lua",
}

if package ~= nil and package.path ~= nil then
    local basePath = debug.getinfo(1).source
    if basePath:sub(1,1) == "@" then basePath = basePath:sub(2) end
    if basePath:sub(-8) == "init.lua" then basePath = basePath:sub(1, -9) end
    basePath = "./" .. basePath .. "/.."

    package.path = package.path .. ";" .. basePath .. "?.lua"


    for _, package in pairs(myPackages) do
        local name = package:match("^(.+).lua$")
        require(name)
    end
else
    -- within empty epsilon

    for _, package in pairs(myPackages) do
        require(package)
    end
end
