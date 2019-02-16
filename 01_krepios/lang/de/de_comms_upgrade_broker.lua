local f = string.format

My.Translator:register("de", {
    comms_upgrade_broker_label = "Schiff Upgrades",
    comms_upgrade_broker_main_no_upgrades = "Leider haben wir im Augenblick keine Upgrades im Angebot.",
    comms_upgrade_broker_main_upgrades = "Wir können Ihnen die folgenden Upgrades anbieten:",

    comms_upgrade_broker_detail_not_docked = function(price)
        return f("Wenn Sie an der Station andocken kann ich Ihnen das Upgrade für %0.2fRP installieren.", price)
    end,
    comms_upgrade_broker_detail_not_docked_free = "Wenn Sie an der Station andocken kann ich Ihnen das Upgrade kostenlos installieren.",
    comms_upgrade_broker_detail_not_affordable = function(price)
        return f("Es scheint als können sich den Preis von %0.2fRP nicht leisten.", price)
    end,
    comms_upgrade_broker_detail_installable = function(price)
        return f("Ich kann das Upgrade für %0.2fRP auf Ihrem Schiff installieren.", price)
    end,
    comms_upgrade_broker_detail_installable_free = "Ich kann das Upgrade kostenlos auf Ihrem Schiff installieren.",
    comms_upgrade_broker_detail_install_label = "Installieren",
    comms_upgrade_broker_install_confirm = function(upgradeName)
        return upgradeName .. " installiert."
    end,
})