local t = My.Translator.translate
local f = string.format

My.Translator:register("de", {
    side_mission_scan_asteroids = function(number)
        return f("%d Asteroiden scannen", number)
    end,
    side_mission_scan_asteroids_description = function(number, sectorName, payment)
        return Util.random({
            f("Unsere Aufzeichnungen zu einigen Asteroiden in Sektor %s sind nicht mehr aktuell.", sectorName),
            f("Die SMC hat uns nach unseren Schüftquoten für den nächsten Monat gefragt. Aber ohne die Mineralienkonzentration von einigen Asteroiden in Sektor %s zu kennen geht das nicht.", sectorName),
            f("Unsere Schürfer haben uns widersprüchliche Zahlen zur Mineralienkonzentration von Asteroiden in Sektor %s genannt. Wir suchen nach jemandem, der überprüft, wer Recht hat.", sectorName),
        }) .. " " .. Util.random({
            "Ihr müsst dort hin fliegen und die neusten Daten holen.",
            "Fliegt dort hin und holt die Zahlen für uns.",
            "Machen Sie ihr Schiff fertig und fliegen sie unverzüglich da hin.",
        }) .. "\n\n" .. Util.random({
            f("Wir zahlen ihnen %0.2fRP, wenn sie den Auftrag annehmen.", payment),
            f("%0.2fRP, wenn sie den Auftrag annehmen. Das ist leicht verdientes Geld.", payment),
            f("%0.2fRP als Bezahung könnt ihr nicht ablehnen.", payment),
        })
    end,
    side_mission_scan_asteroids_accept = function(asteroidNames, sectorName)
        return Util.random({
            f("Nun gut. Das ist euer Arbeitsauftrag: Scannt die folgenden Asteroiden in Sektor %s:", sectorName),
            f("Macht folgendes. Fliegt in Sektor %s und scannt dort folgende Asteroiden:", sectorName),
            f("Ihr Auftrag ist diese Asteroiden in Sektor %s zu scannen:", sectorName),
        }) .. "\n\n" .. Util.mkString(Util.map(asteroidNames, function(asteroidName) return "  * " .. asteroidName end), "\n") .. "\n\n" .. Util.random({
            "Habt ihr das verstanden?",
            "Und jetzt los. Ihr werdet nicht fürs Rumstehen bezahlt.",
            "Hört auf hier herum zu stehen und tut, was ich euch gesagt habe.",
            "Bei dieser Mission bin ich ihr Vorgesetzter. Also los jetzt. An die Arbeit!",
        })
    end,
    side_mission_scan_asteroids_short_hint = function(numberOfAsteroids)
        if numberOfAsteroids > 1 then
            return f("Weitere %d Asteroiden scannen.", numberOfAsteroids)
        else
            return "Noch einen Asteroiden scannen."
        end
    end,
    side_mission_scan_asteroids_hint = function(asteroidNames, sectorName)
        return "Scannen Sie die folgenden Asteroiden in Sektor " .. sectorName .. ": " .. Util.mkString(asteroidNames, ", ", " " .. t("generic_and") .. " ")
    end,
    side_mission_scan_asteroids_success = function(payment)
        return Util.random({
            f("Nun gut. Hier sind eure %0.2fRP für das Scannen der Asteroiden.", payment),
            f("Euer Auftrag wurde erledigt. Eure Belohnung beträgt %0.2fRP.", payment),
        }) .. " " .. Util.random({
            "Verschwendet nicht alles davon für Drinks.",
            "Meldet euch um euren nächsten Auftrag zu bekommen.",
        })
    end,
})