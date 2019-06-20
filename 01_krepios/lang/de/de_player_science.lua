local f = string.format

My.Translator:register("de", {
    player_science_sector = "Sektor",
    player_science_info_station_button = "Stationen",

    player_science_info_nebula_button = "Nebel",

    player_science_info_product_button = "Produkte",
    player_science_info_product_base_price = "Normalpreis",
    player_science_info_product_size = "Größe",
    player_science_info_product_bought_at = "Käufer",
    player_science_info_product_sold_at = "Verkäufer",

    player_science_info_upgrade_button = "Upgrades",
    player_science_info_upgrade_base_price = "unverbindliche Preisempfehlung",
    player_science_info_upgrade_required_upgrade = function(upgradeName)
        return f("Die Installation dieses Upgrades setzt voraus, dass das Upgrade \"%s\" bereits auf dem Schiff installiert wurde.", upgradeName)
    end
})