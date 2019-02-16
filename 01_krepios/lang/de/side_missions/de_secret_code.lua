local f = string.format
local t = My.Translator.translate

My.Translator:register("de", {
    side_mission_secret_code = function(stationCallSign)
        return "Geheime Nachricht für " .. stationCallSign
    end,
    side_mission_secret_code_description = function(receiverPerson, stationCallSign, payment)
        local HeShe, HisHer
        if Person:hasTags(receiverPerson) and receiverPerson:hasTag("male") then
            HisHer = "Sein"
            HeShe = "Er"
        else
            HisHer = "Ihr"
            HeShe = "Sie"
        end
        return Util.random({
            "Psst. Ja, sie.",
            "Hey Sie. Jetzt schauen Sie doch nicht so auffällig.",
            "Hier drüben! Ist ihnen auch niemand gefolgt?",
        }) .. " " .. Util.random({
            f("Sie müssen eine geheime Botschaft an meinen Kontakt auf %s überbringen.", stationCallSign),
            f("Ich habe Informationen für meinen Kontakt auf %s die sie so schnell wie möglich überbringen müssen.", stationCallSign),
            f("Mein Kontakt auf %s hat mich gebeten meine Informationen zu teilen.", stationCallSign)
        }) .. " " .. Util.random({
            f(HisHer .. " Deckname lautet \"%s\".", receiverPerson:getFormalName()),
            f(HeShe .. " ist dort unter dem Namen \"%s\" bekannt.", receiverPerson:getFormalName()),
            f("Suchen Sie auf der Station nach jemandem mit dem Namen \"%s\". Natürlich ist das ein Deckname.", receiverPerson:getFormalName()),
        }) .. " " .. Util.random({
            "Ich erwarte absolute Vertraulichkeit.",
            "Wenn Sie die Nachricht ausplaudern werde ich sie leider töten müssen. Aber so weit müssen Sie es ja nicht kommen lassen, oder? ... Kleiner Spass meinerseits.",
        }) .. " " .. Util.random({
            f("Sobald Sie die Nachricht erfolgreich überbracht haben, werden Ihnen %0.2fRP gezahlt.", payment),
            f("Ihre Verschwiegenheit in der Sache wird mit %0.2fRP entlohnt.", payment),
        })
    end,

    side_mission_secret_code_not_docked = function(stationCallSign)
        return Util.random({
            f("Bitte treffen sie mich persönlich auf %s um die Angelegenheit zu besprechen.", stationCallSign)
        }) .. " ".. Util.random({
            "Ich würde ihre Hilfe nicht brauchen, wenn ich die Nachricht auch einfach funken könnte.",
        })
    end,

    side_mission_secret_code_accept = function(senderPerson, phrase)
        local derDie
        if Person:hasTags(senderPerson) and senderPerson:hasTag("male") then
            derDie = "der"
        else
            derDie = "die"
        end
        return Util.random({
            "Sehr gut.",
            "Ausgezeichnet.",
        }) .. " " .. Util.random({
            "Ich werde Ihnen die Nachricht nun ein einziges Mal sagen.",
            "Bitte bedenken Sie, dass ich ihnen die Nachricht lediglich ein mal mitteilen werde.",
        }) .. " " .. Util.random({
            "Sie dürfen Sie auf keinen Fall vergessen.",
            "Vergessen Sie sie nicht.",
            "Sie müssen sich die Nachricht merken.",
            "Ich hoffe ihr Gedächtnis ist in Topform."
        }) .. " " .. Util.random({
            "Die Nachricht ist:",
            "Sagen Sie folgendes:",
            "Prägen Sie sich diese Nachricht gut ein:",
        }) .. "\n\n\"" .. phrase .. "\"\n\n" .. Util.random({
            "[Mit diesen Worten verschwindet " .. derDie .. " Fremde in einem kleinen Seitengang.]",
        })
    end,

    side_mission_secret_code_hint = function(senderPerson, receiverPerson, stationCallSign)
        return f("Nachricht von \"%s\" an \"%s\" auf %s überbringen.", senderPerson:getFormalName(), receiverPerson:getFormalName(), stationCallSign)
    end,

    side_mission_secret_code_comms_label = function(receiverPerson)
        return f("Mit %s sprechen", receiverPerson:getFormalName())
    end,

    side_mission_secret_code_comms_not_docked = function(stationCallSign)
        return Util.random({
            "Wer sind sie? Ich kenne sie nicht!",
            "Warum kontaktieren sie mich? Sicher haben Sie sich verwählt.",
        }) .. " " .. Util.random({
            f("Wenn Sie vertrauliche Angelegenheiten besprechen wollen, treffen sie mich bitte auf %s.", stationCallSign),
            f("Vertrauliche Dinge sollte man nicht über Comms besprechen. Bitte treffen sie mich persönlich auf %s.", stationCallSign),
        })
    end,

    side_mission_secret_code_comms = function(receiverPerson, senderPerson)
        local ihnSie
        if Person:hasTags(senderPerson) and senderPerson:hasTag("male") then
            ihnSie = "ihn"
        else
            ihnSie = "sie"
        end
        return Util.random({
            "Psst. Ja, sie.",
            "Hey Sie. Jetzt schauen Sie doch nicht so auffällig.",
            "Hier drüben! Ist ihnen auch niemand gefolgt?",
        }) .. " " .. Util.random({
            f("Falls sie %s suchen haben sie " .. ihnSie .. " gefunden.", receiverPerson:getFormalName()),
            t("comms_generic_introduction", receiverPerson) .. " Ich habe sie erwartet.",
        })
        .. " " .. Util.random({
            f("%s hat erwähnt, dass sie eine Nachricht für mich haben!?", senderPerson:getFormalName()),
            f("Sie sollen mir eine Nachricht von %s überbringen. Wie lautet sie?", senderPerson:getFormalName()),
            f("Wie lautet die Nachricht, die sie mir von %s überbringen sollen?", senderPerson:getFormalName()),
        })
    end,

    side_mission_secret_code_success = function(payment)
        return Util.random({
            "Aha!",
            "Ach so.",
            "Aber natürlich!",
            "Hmmhm, aha.",
            "Ach, so ist das?",
        }) .. " " .. Util.random({
            "Jetzt macht auf einmal alles Sinn.",
            "Das erklärt selbstverständlich die Vorkommnisse in letzter Zeit.",
            "Daran hätte ich auch selber denken können.",
            "Diese Information lässt die Situation natürlich in einem ganz anderen Licht erscheinen.",
            "Wenn das so ist, dann erklärt das das merkwürde Verhalten der letzten Tage.",
            "So etwas in der Art dachte ich mir schon. Aber dass es so schlimm ist hätte ich nicht erwartet.",
            "Und ich hatte schon an etwas anderes gedacht. Gut, dass die Information noch rechtzeitig bei mir angekommen ist.",
            "Das heißt also, dass ich die ganze Zeit falsche Schlussfolgerungen gezogen habe. Danke, dass sie mir geholfen haben die Zusammenhänge zu verstehen.",
        }) .. " " .. Util.random({
            "Ich werde entsprechende Vorbereitungen treffen.",
            "Dann habe ich keine Zeit zu verlieren.",
            "Ich werde mich sofort auf den Weg machen.",
            "Ich muss sofort einen Plan ausarbeiten.",
            "Diese Information muss unbedingt weiter verteilt werden.",
        }) .. "\n\n" .. Util.random({
            f("Vielen Dank für eure Hilfe. Die Bezahlung von %0.2fRP wurde überwiesen.", payment),
            f("Sie haben die Bezahlung von %0.2fRP erhalten.", payment),
        })
    end,

    side_mission_secret_code_failure = function(senderPerson)
        return Util.random({
            "Sie sind ein verdammter Lügner.",
            "Hören Sie doch auf zu lügen.",
            "Lügen Sie jemand anderen an.",
        }) .. " " .. Util.random({
            "Nein, das kann nicht sein.",
            f("Niemals hat %s das gesagt.", senderPerson:getFormalName()),
            "Die Nachricht ergibt so überhaupt keinen Sinn.",
        }) .. " " .. Util.random({
            "Verschwinden Sie und lassen sie mich in Frieden.",
            "Da müssen Sie sich verhört haben.",
        }) .. " " .. Util.random({
            "Eine Belohnung bekommen Sie von mir für so einen Mumpitz sicher nicht.",
            "Für das Kauderwelsch werde ich sie nicht bezahlen.",
        })
    end,

})