local myPackages = {
    "01_krepios/lang/en/en_asteroids.lua",
    "01_krepios/lang/en/en_chatter.lua",
    "01_krepios/lang/en/en_comms.lua",
    "01_krepios/lang/en/en_comms_directions.lua",
    "01_krepios/lang/en/en_comms_merchant.lua",
    "01_krepios/lang/en/en_comms_mission_broker.lua",
    "01_krepios/lang/en/en_comms_upgrade_broker.lua",
    "01_krepios/lang/en/en_comms_who_are_you.lua",
    "01_krepios/lang/en/en_defense_squadron.lua",
    "01_krepios/lang/en/en_drops.lua",
    "01_krepios/lang/en/en_flying_trader.lua",
    "01_krepios/lang/en/en_fortress.lua",
    "01_krepios/lang/en/en_generic.lua",
    "01_krepios/lang/en/en_graveyard.lua",
    "01_krepios/lang/en/en_nebulas.lua",
    "lang/en/en_player.lua",
    "01_krepios/lang/en/en_player.lua",
    "01_krepios/lang/en/en_player_science.lua",
    "lang/en/en_products.lua",
    "01_krepios/lang/en/en_products.lua",
    "01_krepios/lang/en/en_random_ships.lua",
    "01_krepios/lang/en/en_station_abandoned.lua",
    "01_krepios/lang/en/en_station_hq.lua",
    "01_krepios/lang/en/en_station_mines.lua",
    "01_krepios/lang/en/en_station_research.lua",
    "01_krepios/lang/en/en_story_mission.lua",
    "01_krepios/lang/en/en_upgrades.lua",

    "01_krepios/lang/en/side_missions/en_buyer.lua",
    "01_krepios/lang/en/side_missions/en_capture.lua",
    "01_krepios/lang/en/side_missions/en_destroy_graveyard.lua",
    "01_krepios/lang/en/side_missions/en_disable_ship.lua",
    "01_krepios/lang/en/side_missions/en_gather_crystals.lua",
    "01_krepios/lang/en/side_missions/en_pirate_base.lua",
    "01_krepios/lang/en/side_missions/en_raging_miner.lua",
    "01_krepios/lang/en/side_missions/en_repair.lua",
    "01_krepios/lang/en/side_missions/en_scan_asteroids.lua",
    "01_krepios/lang/en/side_missions/en_secret_code.lua",
    "01_krepios/lang/en/side_missions/en_transport_human.lua",
    "01_krepios/lang/en/side_missions/en_transport_product.lua",
    "01_krepios/lang/en/side_missions/en_transport_thing.lua",
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