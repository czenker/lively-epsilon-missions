local f = string.format

My.Translator:register("en", {
    comms_upgrade_broker_label = "Ship Upgrades",
    comms_upgrade_broker_main_no_upgrades = "Unfortunately we have no upgrades to offer at the moment.",
    comms_upgrade_broker_main_upgrades = "We can offer you the following upgrades:",

    comms_upgrade_broker_detail_not_docked = function(price)
        return f("If you dock at the station, I can install the upgrade for %0.2fRP.", price)
    end,
    comms_upgrade_broker_detail_not_docked_free = "If you dock at the station, I can install the upgrade for you for free.",
    comms_upgrade_broker_detail_not_affordable = function(price)
        return f("It seems you can not afford the price of %0.2fRP.", price)
    end,
    comms_upgrade_broker_detail_installable = function(price)
        return f("I can install the upgrade for %0.2fRP on your ship.", price)
    end,
    comms_upgrade_broker_detail_installable_free = "I can install the upgrade on your ship for free.",
    comms_upgrade_broker_detail_install_label = "Install",
    comms_upgrade_broker_install_confirm = function(upgradeName)
        return upgradeName .. " installed."
    end,
})