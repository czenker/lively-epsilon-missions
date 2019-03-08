local f = string.format
local t = My.Translator.translate

My.Translator:register("de", {
    side_mission_disable_ship = function(sectorName)
        return Util.random({
            f("Schiff in Sektor %s abfangen", sectorName),
            f("Schiff abfangen in Sektor %s", sectorName),
        })
    end,
    side_mission_disable_ship_description = function()
        return Util.random({
            "Das Schiff ist im Vergleich zu anderen Schiffen im Sektor eher modern und gilt als eines der Schiffe mit der höchsten Geschwindigkeit.",
            "Ungewöhnliche Signaturen aus Richtung des Impulsantriebs legen nahe, dass das der Antrieb des Schiffs gepimpt wurde.",
        })
    end,
    side_mission_disable_ship_briefing = function(sectorName, minPayment, maxBonus, shipCallSign, clientPerson, thiefPerson)
        return Util.random({
            "Habt ihr das gesehen?",
            "Ihr kommt gerade rechtzeitig.",
            "Gut, dass ihr euch gerade meldet."
        }) .. " " .. t("comms_generic_introduction", clientPerson) .. " " .. Util.random({
            (thiefPerson:hasTag("male") and "Der Dieb" or "Die Diebin") .. " " .. thiefPerson:getFormalName() .. " hat mein Raumschiff direkt vor meinen Augen gestohlen.",
            "Ich war nur kurz " .. Util.random({
                "auf der Toilette",
                "auf dem Marktplatz",
                "in der Spielhalle",
                "im Handelszentrum",
                "bei der Zollbehörde",
            }) .. " und als ich zurück in den Hangar kam, wurde mein Raumschiff von " .. thiefPerson:getFormalName() .. " gestohlen.",
            thiefPerson:getFormalName() .. " hat mich im Hangar mit vorgehaltenem Laser meines Raumschiffs beraubt.",
        }) .. " " .. Util.random({
            "Jetzt ist " .. (thiefPerson:hasTag("male") and "er" or "sie") .. " im Sektor " .. sectorName .. " unterwegs.",
            "Daraufhin hat " .. (thiefPerson:hasTag("male") and "er" or "sie") .. " sich auf den Weg in Richtung Sektor " .. sectorName .. " gemacht.",
        }) .. "\n\n" .. Util.random({
            f("Ihr müsst mir helfen mein Raumschiff %s zurückzubekommen.", shipCallSign),
            f("Ohne mein Raumschiff %s bin ich nicht in der Lage diese Station zu verlassen. Ihr müsst es zurückbringen!", shipCallSign),
        }) .. " " .. Util.random({
            f("Wenn ihr mein Schiff zurückbringt, zahle ich euch %0.2fRP - plus einen Bonus von bis zu %0.2fRP, wenn die Hülle meines Schiffs unbeschädigt ist.", minPayment, maxBonus),
            f("Bringt mein Schiff zurück und ihr bekommt %0.2fRP. Aber zerstört nur den Antrieb oder ich kann euch den Bonus von %0.2fRP nicht vollständig auszahlen.", minPayment, maxBonus),
        })
    end,
    side_mission_disable_ship_accept = "Bitte, bitte zerstören Sie mein Schiff nicht. Zielen sie auf den Antrieb und versuchen Sie die Hülle nicht zu beschädigen.",
    side_mission_disable_ship_comms_too_close = "Sie befinden sich zu nah am Zielgebiet, um die Mission zu starten.",
    side_mission_disable_ship_start_hint = function(shipName, sectorName)
        return f("Finden Sie das Schiff %s im Sektor %s.", shipName, sectorName)
    end,
    side_mission_disable_ship_approach_hint = function(shipCallSign, sectorName)
        return f("Beschädigen Sie den Impulsantrieb von %s im Sektor %s.", shipCallSign, sectorName)
    end,
    side_mission_disable_ship_approach_comms = function(thiefPerson, shipName)
        return Util.random({
            "Haha, seid ihr hier, um das Schiff zurückzuholen?",
        }) .. " " .. Util.random({
            "Ihr glaubt nicht wirklich, dass ich mich freiwillig stelle?",
            "Das wird euch nicht gelingen.",
            "Viel Spaß beim Versuch, aber es wird euch nicht gelingen!",
            "Aber mit eurem kleinen Schiffchen wird das nicht funktionieren.",
        }) .. " " .. Util.random({
            f("%s ist das schnellste Schiff im ganzen Sektor.", shipName),
            f("Ich bin mit dem Schiff verschwunden, bevor ihr auch nur blinzelt."),
            f("Wenn ich den Antrieb auf volle Stärke lade, seht ihr nur noch die Plasmawolke hinter mir."),
        }) .. "\n\n- " .. thiefPerson:getFormalName()
    end,

    side_mission_disable_ship_taunt_hail1 = "Was ist denn los? Ihr stört!",
    side_mission_disable_ship_taunt_player_says = "Gebt sofort das gestohlene Raumschiff zurück.",
    side_mission_disable_ship_taunt_response = function(shipCallSign)
        return Util.random({
            "Ihr glaubt nicht wirklich, dass ich mich freiwillig stelle?",
            "Versucht mich doch zu fangen, wenn ihr das Schiff zurück wollt.",
            "Und mit eurem kleinen Schiffchen wollt ihr mich aufhalten?",
        }) .. " " .. Util.random({
            f("%s ist das schnellste Schiff im ganzen Sektor.", shipCallSign),
            f("Ich bin mit dem Schiff verschwunden, bevor ihr auch nur blinzelt."),
            f("Wenn ich den Antrieb auf volle Stärke lade, seht ihr nur noch die Plasmawolke hinter mir."),
        })
    end,
    side_mission_disable_ship_taunt_hail2 = "Fangt mich doch, wenn ihr könnt.",

    side_mission_disable_ship_surrender_comms = function(shipCallSign, playerCallSign, thiefPerson, stationCallSign)
        return Util.random({
            "OK, OK. Ich gebe auf!",
            f("Hört auf mich weiter zu beschießen, %s. Ich gebe auf!", playerCallSign)
        }) .. "\n\n" .. Util.random({
            f("Ich habe den Autopiloten aktiviert und \"%s\" fliegt selbstständig zurück nach %s.", shipCallSign, stationCallSign),
            f("Ich habe %s als Ziel für den Autopiloten einprogrammiert. \"%s\" wird automatisch dort hin zurückfliegen.", stationCallSign, shipCallSign)
        }) .. "\n\n- " .. thiefPerson:getFormalName()
    end,

    side_mission_disable_ship_destruction_comms = function(shipCallSign, clientPerson)
        return Util.random({
            "Oh!! Ihr Chaoten!!! Ihr habt mein Schiff zerstört?",
            "Seid ihr von allen guten Geistern verlassen?? Ihr habt mein Schiff zerstört!",
            "War das mein Schiff, dass da gerade in einer riesigen Explosion aufging?",
        }) .. " " .. Util.random({
            "Ihr solltet auf die Triebwerke zielen und nicht das Schiff zerstören!",
        }) .. " " .. Util.random({
            f("Euch ist vermutlich klar, dass ich euch nicht für das Zerstören der \"%s\" bezahlen werde.", shipCallSign),
            f("Offenbar habt ihr euren Auftrag nicht verstanden. Der Vertrag ist damit nichtig."),
        }) .. "\n\n- " .. clientPerson:getFormalName()
    end,

    side_mission_disable_ship_success_comms = function(shipCallSign, person, payment)
        return Util.random({
            f("Gute Arbeit. \"%s\" ist auf dem Weg zurück zu mir.", shipCallSign),
            f("Ihr habt mein Schiff zurückgeholt? Vielen Dank."),
            f("Der Autopilot zeigt an, dass sich \"%s\" auf dem Rückweg befindet. Danke.", shipCallSign),
        }) .. " " .. Util.random({
            f("Da ich von eurem Bonus noch Reparaturkosten abziehen muss, erhaltet ihr in der Summe eine Bezahlung von %0.2fRP. Das ist doch auch nicht übel, oder?", payment),
            f("Leider muss ich die Reparaturkosten für den Schaden an der Schiffshülle von eurer Belohnung abziehen. Aber %0.2fRP sehe ich auch als angemessene Entschädigung an.", payment),
        }) .. "\n\n- " .. person:getFormalName()
    end,
})