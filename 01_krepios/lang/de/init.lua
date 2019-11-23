local myPackages = {
    "01_krepios/lang/de/de_asteroids.lua",
    "01_krepios/lang/de/de_chatter.lua",
    "01_krepios/lang/de/de_comms.lua",
    "01_krepios/lang/de/de_comms_directions.lua",
    "01_krepios/lang/de/de_comms_merchant.lua",
    "01_krepios/lang/de/de_comms_mission_broker.lua",
    "01_krepios/lang/de/de_comms_upgrade_broker.lua",
    "01_krepios/lang/de/de_comms_who_are_you.lua",
    "01_krepios/lang/de/de_defense_squadron.lua",
    "01_krepios/lang/de/de_drops.lua",
    "01_krepios/lang/de/de_flying_trader.lua",
    "01_krepios/lang/de/de_fortress.lua",
    "01_krepios/lang/de/de_generic.lua",
    "01_krepios/lang/de/de_graveyard.lua",
    "01_krepios/lang/de/de_nebulas.lua",
    "lang/de/de_player.lua",
    "01_krepios/lang/de/de_pirates.lua",
    "01_krepios/lang/de/de_player.lua",
    "01_krepios/lang/de/de_player_science.lua",
    "lang/de/de_products.lua",
    "01_krepios/lang/de/de_random_ships.lua",
    "01_krepios/lang/de/de_products.lua",
    "01_krepios/lang/de/de_station_abandoned.lua",
    "01_krepios/lang/de/de_station_hq.lua",
    "01_krepios/lang/de/de_station_mines.lua",
    "01_krepios/lang/de/de_station_research.lua",
    "01_krepios/lang/de/de_story_mission.lua",
    "01_krepios/lang/de/de_upgrades.lua",

    "01_krepios/lang/de/side_missions/de_buyer.lua",
    "01_krepios/lang/de/side_missions/de_capture.lua",
    "01_krepios/lang/de/side_missions/de_destroy_graveyard.lua",
    "01_krepios/lang/de/side_missions/de_disable_ship.lua",
    "01_krepios/lang/de/side_missions/de_gather_crystals.lua",
    "01_krepios/lang/de/side_missions/de_pirate_base.lua",
    "01_krepios/lang/de/side_missions/de_raging_miner.lua",
    "01_krepios/lang/de/side_missions/de_repair.lua",
    "01_krepios/lang/de/side_missions/de_scan_asteroids.lua",
    "01_krepios/lang/de/side_missions/de_secret_code.lua",
    "01_krepios/lang/de/side_missions/de_transport_human.lua",
    "01_krepios/lang/de/side_missions/de_transport_product.lua",
    "01_krepios/lang/de/side_missions/de_transport_thing.lua",
}

if package ~= nil and package.path ~= nil then
    local basePath = debug.getinfo(1).source
    if basePath:sub(1,1) == "@" then basePath = basePath:sub(2) end
    if basePath:sub(-8) == "init.lua" then basePath = basePath:sub(1, -9) end
    basePath = "./" .. basePath .. "/../../../"

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