local t = My.Translator.translate
local f = string.format

-- things a typical miner cares about:
--  - hate for their job
--  - health issues
--  - drinking
--  - gambling
--  - hate for their crappy ship
--  - that they got no money
--  - hope for a better future far away
--  - listening to Heavy Metal music

My.Translator:register("de", {

    mines_miner_station_description = function(stationCallSign)
        return Util.random({
            "Ein Stützpunkt für Schürfer.",
            "Von hier aus brechen Schürfer auf, um die umliegenden Asteroiden abzubauen.",
            "Eine der alten Handelsstationen im Sektor, von dem aus Schürfer aufbrechen.",
            "Eine in die Jahre gekommenene Schürfstation der SMC.",
        }) .. " " .. Util.random({
            "Schürfer kehren hierhin zurück um ihre Ausbeute zu verkaufen und ihre Einnahmen zu versaufen.",
        })
    end,

    mines_miner_description = function(shipCallSign, captainPerson)
        return Util.random({
            "Ein Schürfer, der die besten Tage schon hinter sich hat.",
            "Ein klappriges Schiff, dass zum Abbau von Asteroiden in den äußeren Bezirken eingesetzt wird.",
            "Die besten Zeiten als Schürfer hat das Schiff schon hinter sich.",
            "Ein zum Schürfer umgebauter Transporter.",
        }) .. " " .. Util.random({
            "Die Hülle ist mit Kratzern übersäht.",
            "Wie dieses Schiff noch fliegen kann ist ein Geheimnis.",
            "Ein notdürftig geflicktes Loch in der Hülle erzählt von der jüngeren Geschichte des Schiffs.",
            "Jemand hat mit weißer Farbe groß den Schiffsnahmen \"" .. shipCallSign .. "\" auf die Hülle geschmiert.",
            "Das Schiff zieht eine riesige Wolke aus Asteroidenstaub hinter sich her.",
            "Es scheint nicht, als ob das Schiff eine gültige Zulassung hat.",
            "Ein Graffiti auf dem Rumpf informiert, dass Kapitän " .. captainPerson:getNickName() .. " " .. Util.random({
                "eine \"Saufnase\" ist.",
                "ein dummer Mensch ist.",
                "streng riecht. Oder ist damit das Schiff gemeint?",
            }),
            "Mit einem Finger ist in den Staub auf einem der Fenster \"Putz mich\" geschrieben worden.",
        })
    end,

    mines_miner_who_are_you = function(captainPerson, stationCallSign, minedProductNames)
        local minedProducts = Util.mkString(minedProductNames, ", ", " " .. t("generic_and") .. " ")
        return t("comms_generic_introduction", captainPerson) .. " " .. Util.random({
            f("Ich arbeite für die Station %s.", stationCallSign),
            f("Ich bin im Auftrag der Station %s für die Saiku Mining Corporation unterwegs.", stationCallSign),
            f("Ich wurde von der Saiku Mining Corporation angeheuert und liefere meine Ausbeute auf %s ab.", stationCallSign),
        }) .. " " .. Util.random({
            f("Ich extrahiere %s aus Asteroiden und liefere sie an meine Heimatstation zurück.", minedProducts),
            f("Ich baue %s in Asteroiden ab.", minedProducts),
            f("Ich habe mich auf den Abbau von Asteroiden spezialisiert. %s sind mein Spezialgebiet.", minedProducts),
            f("Meine Aufgabe ist %s aus Asteroiden abzubauen.", minedProducts),
        }) .. " " .. Util.random({
            "Die Bezahlung ist nicht die Beste, aber irgendwie muss ich meinen Lebensunterhalt verdienen.",
            "Für die Gefahren, die ich hier draußen täglich eingehe werde ich viel zu schlecht bezahlt. Aber für einen besseren Job bin ich nicht qualifiziert genug.",
        })
    end,

    mines_miner_undocking_chat_1 = function(minerCallSign, stationCallSign, shipPerson, stationPerson)
        return Util.random({
            "Und auf gehts zu einer weiteren Stunde umgeben von Asteroiden.",
            "Der Boss sagt ich soll die nächste Tour fliegen.",

            -- say bye
            "Bis später. Ich muss Asteroiden lasern.",

            -- crappy ship
            "Wenn " .. Util.random({
                "der Laser",
                "der Antrieb",
                "das Schild",
                "die Steuerung",
            }) .. " heute nicht wieder " .. Util.random({"spinnt", "versagt", "ausfällt"}) .. " wird die Schicht schnell vergehen.",
        })
    end,
    mines_miner_undocking_chat_2 = function(minerCallSign, stationCallSign, shipPerson, stationPerson, randomPerson)
        return Util.random({
            -- personal
            "Und wer wischt deine Kotze im Hangar weg?",
            "Komm ja zurück. Heute Abend gibt es eine Revange.",
            "Wir sehen uns dann heute Abend " .. Util.random({
                "bei " .. randomPerson:getNickName() .. ".",
                "im Kasino.",
                "an der Bar.",
                "in der Kantine.",
                "beim Poker.",
            }),
            -- crappy ship
            Util.random({
                "Die Mechaniker meinten",
                "Der Mechaniker meinte",
                "Die Mechanikerin meinte",
                randomPerson:getNickName() .. " meinte",
            }) .. f(" der Schrotthaufen, den du %s nennst sollte diesen Flug noch überstehen.", minerCallSign),
        })
    end,

    mines_miner_dock_initiation_chat_request = function(minerCallSign, stationCallSign, shipPerson, stationPerson)
        local hail = Util.random({
            f("Hey %s.", stationCallSign),
            f("Hallo %s.", stationCallSign),
            f("Captain %s an die Deppen auf %s.", shipPerson:getFormalName(), stationCallSign),
            f("Hört mich jemand auf %s?.", stationCallSign),
            f("Hey, %s. Hört ihr mich?", stationCallSign),
            f("Hallo?? Hört ihr mich, %s?", stationCallSign),
            f("Hörst du mich, %s? Mein Funk scheint wieder zu spinnen.", stationPerson:getNickName()),
            f("Funktioniert mein Funkgerät noch, %s?", stationCallSign),
        })
        local jobDone = Util.random({
            "Ich habe meine Schicht beendet und befinde mich im Anflug auf die Station.",
            "Wenn die Schrottmühle noch einen Augenlick hält, bin ich sofort bei euch.",
            "Falls ihr wollt, dass mein Schiff nicht sofort auseinander fällt solltet ihr schon mal ein Reparaturteam bereit stellen. Ich bin sofort da.",
            "Stellt mir schon mal ein Bier kalt. Ich bin sofort zurück.",
        })

        return hail .. " " .. jobDone
    end,
    mines_miner_dock_initiation_chat_response = function(minerCallSign, stationCallSign, shipPerson, stationPerson, randomPerson)
        local response = Util.random({
            "Und ich dachte schon, du bist gegen einen Asteroiden geflogen.",
            f("Du lebst noch? Scheiße, jetzt muss ich %s einen Drink spendieren.", randomPerson:getNickName()),
            "Ich hab deine Schrottmühle schon vor zwei Stunden gerochen.",
            "Ich hab dich schon seit einiger Zeit auf dem Schirm. Dein fetter Arsch ist auch kaum zu übersehen.",
            f("Bist du das, %s? Ich hab dich unter all dem Schrott gar nicht erkannt.", shipPerson:getNickName()),
            "Andockerlaubnis gibts hier nur unter zwei Promille. Aber bei dir mache ich eine Ausnahme.",
        })

        local additional = Util.random({
            "Willkommen zuhause.",
            f("Willkommen zurück auf %s.", stationCallSign),
            "Gut, dass du wieder da bist.",
            Util.random({
                "Der Boss",
                "Die Chefin",
                "Dein Bruder",
                "Deine Schwester",
                "Der Dicke",
                randomPerson:getNickName(),
            }) .. " " .. Util.random({
                "hat dich gesucht und erwartet dich",
                "wartet auf dich",
                "hat schon nach dir gefragt und sucht dich",
                "scheint dich zu vermissen und wartet auf dich"
            }) .. " " .. Util.random({
                "im Hangar zur Inspektion.",
                "in der Bar mit einem Klaren.",
                "im Hangar, um über deine Spielschulden zu sprechen.",
                "im Kasino mit einem Stapel Karten.",
                "mit Selbstgebranntem in der Kantine.",
                "im Ring. " .. Util.random({
                    "Meiner Meinung nach hast du keine Chance.",
                    "Ich habe schon auf dich gesetzt."
                }),
                "auf der Krankenstation zum Checkup.",
            })
        })

        return response .. " " .. additional
    end,

})