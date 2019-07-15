local f = string.format

My.Translator:register("en", {
    player_science_sector = "Sector",
    player_science_info_station_button = "Stations",

    player_science_info_nebula_button = "Nebulae",

    player_science_info_product_button = "Products",
    player_science_info_product_base_price = "average price",
    player_science_info_product_size = "Size",
    player_science_info_product_bought_at = "Buyers",
    player_science_info_product_sold_at = "Sellers",

    player_science_info_upgrade_button = "Upgrades",
    player_science_info_upgrade_base_price = "recommended retail price",
    player_science_info_upgrade_required_upgrade = function(upgradeName)
        return f("It is required to have the upgrade \"%s\" installed before installing this upgrade.", upgradeName)
    end
})