local f = string.format

My.Translator:register("de", {
    side_mission_transport_thing = function(productName, stationCallSign)
        return f("Bringen Sie %s nach %s", productName, stationCallSign)
    end,

    side_mission_transport_thing_product_alcohol = "Kiste Alkohol",
    side_mission_transport_thing_description_alcohol = function(stationCallSign, amount, payment)
        return Util.random({
            f("Mir ist zu Ohren gekommen, dass die Arbeiter auf %s zunehmend auf dem Trocknen sitzen.", stationCallSign),
            f("Ich habe gehört, den Arbeitern auf %s geht langsam ihr Alkohol aus.", stationCallSign),
            f("Haben Sie schon gehört, dass auf %s der Alkohol knapp wird?", stationCallSign),
        }) .. " " .. Util.random({
            "Mit einer Kiste Alkohol lässt sich dort sicher ein nettes Sümmchen verdienen.",
            "Ich wittere ein gutes Geschäft. Alles was ich tun muss ist eine Kiste feinsten Alkohol dahin liefern.",
        }) .. " " .. Util.random({
            f("Können Sie mir helfen? Ich benötige ein Schiff, das mindestens %d Einheiten laden kann.", amount),
            f("Falls sie %d Einheiten laden können, könnten wir ins Geschäft kommen.", amount),
        }) .. " " .. Util.random({
            f("Natürlich beteilige ich sie am Gewinn mit %0.2fRP.", payment),
            f("Wenn Sie den Transport übernehmen winken Ihnen %0.2fRP.", payment),
        })
    end,

    side_mission_transport_thing_product_letters = "private Briefe",
    side_mission_transport_thing_description_letters = function(stationCallSign, amount, payment)
        return Util.random({
            f("Im Auftrag des öffentlichen Postwesens suche ich einen Kurier für einige Briefe, die auf %s sehnlichst erwartet werden.", stationCallSign),
        }) .. " " .. Util.random({
            f("Alles in allem brauche ich ein Schiff, das %d Einheiten laden kann.", amount),
        }) .. " " .. Util.random({
            f("Per Tarifgesetz ist eine Zahlung von %0.2fRP als angemessene Entschädigung vorgesehen.", payment),
        })
    end,

    side_mission_transport_thing_product_memory = "Datenspeicher",
    side_mission_transport_thing_description_memory = function(stationCallSign, amount, payment)
        return Util.random({
            f("Wichtige Daten müssen auf die Station %s gebracht werden.", stationCallSign),
            f("Diese Datensticks müssen %s gebracht werden.", stationCallSign),
        }) .. " " .. Util.random({
            "Ich bin nicht befugt Ihnen zu sagen, welche Daten sich darauf befinden.",
            "Wir vertrauen auf Ihre Diskretion bei der Lieferung der Speichermedien.",
            "Die Kiste ist versiegelt und darf nur vom Empfänger geöffnet werden.",
        }) .. " " .. Util.random({
            f("Können Sie %d Einheiten in ihrem Laderaum entbehren?", amount),
            f("Die Datensticks benötigen %d Einheiten Platz.", amount),
        }) .. " " .. Util.random({
            f("Wenn Sie an dem Auftrag interessiert sind können wir Ihnen %0.2fRP zahlen.", payment),
            f("Ihre Diskretion ist uns die Summe von %0.2fRP wert.", payment),
        })
    end,

    side_mission_transport_thing_product_minerals = "Mineralien",
    side_mission_transport_thing_description_minerals = function(stationCallSign, amount, payment)
        return Util.random({
            f("Die Station %s hat uns gebeten ihnen eine Lieferung mit Mineralien zu senden.", stationCallSign),
            f("Auf der Station %s werden Mineralien benötigt.", stationCallSign),
            f("Diese Kiste mit Mineralien muss zur Station %s gebracht werden.", stationCallSign),
        }) .. " " .. Util.random({
            "Soweit ich erfahren habe werden sie dort von den Eierköpfen untersucht.",
            "Ich weiß nicht wofür sie die brauchen, aber die Bezahlung ist gut, darum stelle ich keine Fragen.",
            "Der Chefwissenschaftler hat irgendwas erzählt wofür sie die brauchen, aber ich habs wieder vergessen.",
        }) .. " " .. Util.random({
            f("Können Sie %d Einheiten in ihrem Laderaum entbehren?", amount),
            f("Die Datensticks benötigen %d Einheiten Platz.", amount),
        }) .. " " .. Util.random({
            f("Wenn Sie an dem Auftrag interessiert sind können wir Ihnen %0.2fRP zahlen.", payment),
            f("Ihre Diskretion ist uns die Summe von %0.2fRP wert.", payment),
        })
    end,

    side_mission_transport_thing_no_storage = "Ihr Schiff hat keinen Laderaum. Ich hoffe, Sie haben Verstaendnis, dass wir diesen Auftrag darum nicht an Sie vergeben werden.",
    side_mission_transport_thing_small_storage = function(storageAmount)
        return f("Es tut uns sehr leid, aber der Laderaum Ihres Schiffes ist leider zu klein um diesen Auftrag anzunehmen. Sie benötigen mindestens einen Laderaum von %d.", storageAmount)
    end,

    side_mission_transport_thing_accept_hint = function(stationCallSign, productName)
        return f("Docken Sie an %s um %s zu laden", stationCallSign, productName)
    end,
    side_mission_transport_thing_load_log = function(productName)
        return productName .. " geladen"
    end,
    side_mission_transport_thing_load_hint = function(stationCallSign, productName)
        return f("Docken Sie an %s um %s auszuliefern", stationCallSign, productName)
    end,
    side_mission_transport_thing_insufficient_storage = function(productName, storageAmount)
        return f("Laderaum zu klein um %s aufzunehmen. %d benötigt.", productName, storageAmount)
    end,
    side_mission_transport_thing_success_log = function(productName)
        return productName .. "  ausgeliefert. Mission abgeschlossen"
    end,
    side_mission_transport_thing_success = function(payment)
        return f("Vielen Dank fuer die Lieferung. Wir haben Ihnen die Bezahlung in Höhe von %0.2fRP ueberwiesen. Wenn Sie wieder einen Auftrag suchen melden Sie sich bei uns.", payment)
    end,
})