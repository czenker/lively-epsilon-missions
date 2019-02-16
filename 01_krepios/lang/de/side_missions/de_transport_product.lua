local f = string.format

My.Translator:register("de", {
    side_mission_transport_product = function(amount, productName, toCallSign)
        return f("Bringen Sie %d Einheiten %s nach %s", amount, productName, toCallSign)
    end,
    side_mission_transport_description = function(amount, productName, toCallSign, payment, penalty)
        return f("Unsere Kollegen von %s haben uns gebeten ihnen eine Ladung %s zu schicken.\n\nWir suchen daher einen Kurier, der %d Einheiten %s ausliefern kann. Wir zahlen für die Auslieferung %0.2fRP. Ausserdem erheben wir eine Kaution in Hoehe von %0.2fRP - nur fuer den Fall, dass sie auf die Idee kommen sollten unsere Waren auf dem freien Markt zu verkaufen.", toCallSign, productName, amount, productName, payment, penalty)
    end,
    side_mission_transport_product_no_storage = "Ihr Schiff hat keinen Laderaum. Ich hoffe, Sie haben Verstaendnis, dass wir diesen Auftrag darum nicht an Sie vergeben werden.",
    side_mission_transport_product_small_storage = function(storageAmount)
        return f("Es tut uns sehr leid, aber der Laderaum Ihres Schiffes ist leider zu klein um diesen Auftrag anzunehmen. Sie benötigen mindestens einen Laderaum von %d.", storageAmount)
    end,
    side_mission_transport_product_no_penalty = "Sie sind im Augenblick nicht in der Lage die Kaution zu uebernehmen. Wir koennen diesen Auftrag darum leider nicht an Sie uebergeben.",

    side_mission_transport_product_accept_hint = function(fromCallSign, productName)
        return f("Docken Sie an %s um %s aufzunehmen", fromCallSign, productName)
    end,
    side_mission_transport_product_load_log = function(productName)
        return f("%s aufgenommen", productName)
    end,
    side_mission_transport_product_load_hint = function(toCallSign, productName)
        return f("Docken Sie an %s um %s auszuladen", toCallSign, productName)
    end,
    side_mission_transport_product_insufficient_storage = function(productName, storageAmount)
        return f("Laderaum zu klein um %s aufzunehmen. %d benötigt.", productName, storageAmount)
    end,
    side_mission_transport_product_product_lost = function(penalty)
        return f("Nun gut. Sie haben die Waren verkauft. Wie vertraglich vereinbart behalten wir daher die Kaution in Höhe von %0.2fRP ein.", penalty)
    end,
    side_mission_transport_product_success = function(payment)
        return f("Vielen Dank fuer die Lieferung. Wir haben Ihnen die Bezahlung in Höhe von %0.2fRP sowie die Kaution ueberwiesen. Wenn Sie wieder einen Auftrag suchen melden Sie sich bei uns.", payment)
    end,
})