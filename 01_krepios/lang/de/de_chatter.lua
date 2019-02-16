local f = string.format

My.Translator:register("de", {
    --chatter_sick_miner_1 = "Wie geht es deinem Vater? Hat er sich von seiner Krankheit erholt?",
    --chatter_sick_miner_2 = "Nein. Er arbeitet seit Jahren als Miner, aber kaum dass er krank wird ",

    chatter_leave = function()
        return Util.random({
            "Ich kann es kaum erwarten " .. Util.random({
                "aus dem System zu verschwinden",
                "hier abzuhauen",
            }) .. ". Was für ein " .. Util.random({
                "Dreckloch",
                "Höllenloch",
                "Rattenloch",
                "Schweinestall",
            }) .. ".",
        })
    end,

    chatter_existentialism = function()
        return Util.random({
            "Manchmal frage ich mich, ob ich überhaupt existiere, wenn keiner da ist, der mich sieht.",
            "Ich fühle mich beobachtet.",
            "Werde ich beobachtet?",
            "Hey, ich weiß genau, dass du mich belauschst! Hör auf damit!",
        })
    end,

    chatter_existentialism_1 = function()
        return Util.random({
            "Hast du auch manchmal das Gefühl nur ein Produkt der Fantasie einer anderen Person zu sein?",
            "Glaubst du, dass unser Leben vorherbestimmt ist?",
            "Meinst du, dass du aus eigenen Stücken handelst?",
            "Denkst du nicht auch hin und wieder, dass eigentlich jemand anderes dein Leben steuert?",
            "Manchmal fühlt sich mein Leben an wie ein Film, den jemand mit einer Absicht geschrieben hat. Meinst du nicht auch?",
        })
    end,
    chatter_existentialism_2 = function()
        return Util.random({
            "Nein. Ich habe mein Leben in der Hand und bestimme selbst was ich tue.",
            "Das macht keinen Unterschied, so lange ich das Gefühl habe selbst Entscheidungen zu treffen.",
            "Könnte ich dann sagen was ich will? Zum Beispiel \"Halt die Fresse\"? Siehst du! Komplett freier Wille.",
            "Du musst aufhören so viel zu trinken.",
            "Ich könnte jederzeit in ein Schwarzes Loch fliegen und keiner kann mich daran hindern. Aber ich habe mich dagegen entschieden.",
        })
    end,

    chatter_distance_to_dock = function(stationCallSign, distance)
        return Util.random({
            "Reisen im All dauern eine Ewigkeit.",
            "Das Warten bis man am Ziel angekommen ist nervt.",
            "Laaaaangweilig.",
        }) .. " " .. Util.random({
            f("Aber zum Glück sind es nur noch %du bis nach %s.", distance, stationCallSign),
            f("Aber nur noch %du bis nach %s.", distance, stationCallSign),
            f("In %du bin ich in %s.", distance, stationCallSign),
            f("%s ist nur noch %du entfernt. Dann bin ich endlich da.", stationCallSign, distance),
        })
    end,

    chatter_expensive_products_1 = function(productName, amount, price)
        return Util.random({
            "Kannst du dir vorstellen, wie wenig man heutzutage mit dem Handel von Waren verdienen kann?",
        }) .. " " .. "Ich bin " .. Util.random({
            "gestern",
            "letzte Woche",
            "neulich",
        }) .. " an einen " .. Util.random({
            "Händler",
            "Spinner",
            "Betrüger",
        }) .. " geraten, der " .. Util.random({
            f("%.2fRP für %d Einheiten %s haben wollte", price, amount, productName),
            f("von mir für %d Einheiten %s %.2fRP haben wollte", amount, productName, price),
            f("%.2fRP für gerade einmal %d Einheiten %s verlangt hat", price, amount, productName),
        }) .. "."
    end,
    chatter_expensive_products_2 = "Ich hoffe, du hast dir von ihm nichts aufschwatzen lassen.",
    chatter_expensive_products_3 = "Natürlich nicht. Aber das ist doch skandalös.",


    chatter_miner_retire_1 = function()
        return Util.random({
            "Was wirst du tun, wenn du genügend Geld gesammelt hast um aus diesem Drescksloch zu verschwinden?",
        })
    end,
    chatter_miner_retire_2 = function(metalBandName)
        return Util.random({
            "Ich würde gern",
            "Das weiß ich noch nicht. Vielleicht kann ich",
            "Wenn du so fragst. Ich will",
            "Hm, gute Frage. Ich kann"
        }) .. " " .. Util.random({
            "",
            "meine Wohnung verkaufen und ",
            "mein Schiff verkaufen und ",
            "meinen Job schmeißen und ",
        }) .. Util.random({
            "eine kleine Hütte auf " .. Util.random({
                "der Erde",
                "dem Mars",
                "Alpha Centaury",
            }) .. " kaufen.",
            "als Roady für " .. metalBandName .. " arbeiten.",
            "eine Auszeit nehmen und das Universum bereisen.",
            "eine Bar " .. Util.random({
                "in einer freien Handelsstation",
                "auf der Erde",
                "auf dem Mars",
            }) .. " eröffnen.",
        })
    end,
    chatter_miner_retire_3 = function()
        return Util.random({
            "Aber das werde ich mir nie leisten können.",
            "Aber bei den Steuern wird das nie was.",
            "So lange mein Chef mich so schlecht bezahlt bleibt das aber ein Traum.",
            "Aber dafür müsste ich erst einmal beim Pokern gewinnen.",
            "Zuerst muss ich aber meine Wettschulden abbezahlen.",
            "Das klappt nur nicht so lange ich mein Geld versaufe.",
        })
    end,

    chatter_miner_ship_envy_1 = function(merchantCallSign)
        return Util.random({
            f("Hey %s.", merchantCallSign),
            f("Tachchen %s.", merchantCallSign),
            f("Hallöchen %s.", merchantCallSign),
        }) .. " " .. Util.random({
            "Was kostet denn dein heißer Schlitten?",
            "Wieviel kostet es mal eine kleine Spritztour mit deinem Gefährt zu machen?",
            "Was willst du denn im Tausch gegen dein Schiff haben?"
        })
    end,
    chatter_miner_ship_envy_2 = function()
        return Util.random({
            "Mehr als du dir leisten kannst.",
            "Verpiss dich, Spinner.",
        })
    end,

    chatter_abandoned_station_1 = function(stationCallSign)
        return Util.random({
            f("Hast du Lust %s mal aus der Nähe zu erforschen?", stationCallSign),
            f("Wie ist deine Einstellung zu Schatzsuchen auf verlassenen Stationen."),
            f("Ich suche noch eine Person, die mit mir %s plündern würde?", stationCallSign),
        })
    end,
    chatter_abandoned_station_2 = function(stationCallSign)
        return Util.random({
            "Ich bin kein Schatzjäger. Ich halte mich von den verlassenen Stationen fern. Man weiß ja nie, was da für Gefahren lauern.",
            "Das soll nicht ganz ungefährlich sein. Undichte Reaktoren, kurzgeschlossene Leitungen. Da kann alles mögliche passieren.",
            "Die Aussicht auf einen Zufallsfund würde mich schon reizen.",
        })
    end,

    chatter_nebula_1 = function(nebulaName)
        return Util.random({
            f("Hast du %s schon mal aus der Nähe gesehen?", nebulaName),
            f("Ich habe gehört %s soll wunderschön sein.", nebulaName),
            f("Glaubst du %s ist ein geeigneter Ort um sich vor Geldeintreibern zu verstecken?", nebulaName),
        })
    end,
    chatter_nebula_2 = function(nebulaName)
        return Util.random({
            "Ich versuche mich von Nebeln fern zu halten.",
            "Da bekommen mich keine zehn Pferde hin.",
            "Mein Vater hat mir schon als Kind geraten mich von Nebeln fern zu halten."
        }) .. " " .. Util.random({
            "Man weiß nie, was da für Gesindel lebt.",
            "Letztes Jahr bin ich in einem Nebel auf Piraten getroffen. Ich bin gerade noch mit meinem Leben davon gekommen.",
            "Dort begegnet man sowieso nur Abschaum.",
        })
    end,

    chatter_upgrade_1 = function(upgradeName)
        return Util.random({
            f("Weißt du, wo ich das Upgrade %s kaufen kann?", upgradeName),
            f("Ich bin schon seit einer Ewigkeit auf der Suche nach %s. Weißt du wer das verkauft?", upgradeName),
            f("Ich würde gern %s kaufen, aber ich weiß nicht, wo ich es finden kann.", upgradeName),
        })
    end,
    chatter_upgrade_2 = function(stationCallSign)
        return Util.random({
            f("Versuche es doch mal auf %s.", stationCallSign),
            f("Ich glaube, %s hat das.", stationCallSign),
            f("Das habe ich mal auf %s gesehen.", stationCallSign),
            f("Hast du es schon mal auf %s versucht?", stationCallSign),
            f("Vielleicht mal bei %s fragen.", stationCallSign),
        })
    end,

    chatter_waste = function()
        local thing = Util.random({
            "einem alten Sateliten",
            "einem tiefgefrohrenen leblosen Körper",
            "Weltraumschrott",
            "Asteroidenbrocken",
            "einem Klappstuhl",
        })

        return Util.random({
            Util.random({
                "Müll im Weltall ist das größte Problem, dass unsere Generation zu lösen hat.",
                "Überall nur Müll.",
                "Wo man hinschaut, überall nur Schrott hier.",
                "Dieser Müll überall ist ein riesiges Problem."
            }) .. " " .. Util.random({
                f("Nur ein kurzer Sekundenschlaf und schon kollidiert man mit %s.", thing),
                f("Ich wäre fast mit %s zusammen gestoßen.", thing),
                f("Wenn man nicht höllisch aufpasst macht man viel zu schnell mit %s Bekanntschaft.", thing),
            })
        })
    end,

    chatter_betting_1 = function(person, amount)
        local reason = Util.random({
            "beim Pokern",
            "beim Würfeln",
            "bei Sportwetten",
            "beim Armdrücken",
            "bei einem Wettrennen",
            "beim Wrestling",
            "beim Boxen",
            "beim Hahnenkampf",
            "beim Hundekampf",
            "beim Zechen",
            "beim Spaceballspiel",
        })

        return Util.random({
            f("Ich habe gehört, du hast %s %dRP an %s verloren.", reason, amount, person:getFormalName()),
            f("Stimmt es wirklich, dass du %s %dRP an %s verloren hast?", reason, amount, person:getFormalName()),
            f("Mir ist zu Ohren gekommen, dass dich %s beim %s um %dRP erleichtert hat. Ist an der Geschichte was dran?", person:getFormalName(), reason, amount),
            f("Stimmt es, dass du jetzt %dRP weniger hast, weil du %s gegen %s verloren hast?", amount, reason, person:getFormalName()),
        })
    end,

    chatter_betting_2 = function()
        return Util.random({
            "Leider ist die Geschichte wahr.",
            "Das wird aber nicht lange so bleiben.",
            "Von wem hast du denn die Geschichte?",
            "Wer erzählt denn die Geschichte rum? Sicher irgend ein Plappermaul.",
        }) .. " " .. Util.random({
            "Ich habe aber schon einen Plan, wie ich das Geld zurück bekomme.",
            "Heute abend gibt es eine Revange.",
            "Das nächste Mal habe ich mehr Glück. Ich habe jetzt einen neuen Talisman.",
        })
    end,

    chatter_hope_for_peaceful_flight = function(product)
        return Util.random({
            f("Ich hoffe, meine Ladung mit %s lockt keine Piraten an.", product:getName()),
            f("Bei den Geschichten, die man immer hört kann man nur hoffen, dass meine Ladung %s keine Piraten anlockt.", product:getName()),
            f("Meine Ladung %s unter einem Haufen getragener Socken zu verstecken war die beste Idee, die ich je hatte. Kein Pirat wird auf die Idee kommen darunter nach zu schauen.", product:getName()),
            f("Letzte Woche ist schon wieder ein Pilot bei einem Piratenangriff drauf gegangen. Ich kann nur hoffen, dass sie an meiner Ladung %s kein Interesse haben.", product:getName()),
        })
    end,

    chatter_hartman_1 = function(person)
        local insultingAdjectivs = Util.randomSort({
            "bekloppteste",
            "dümmste",
            "egoistischste",
            "fetteste",
            "idiotischste",
            "inkompetenteste",
            "schwachsinnigste",
            "stumpfsinnigste",
            "talentloseste",
            "unbelehrbarste",
            "verantwortungsloseste",
            "versoffenste",
            "verstandsloseste",
            "zurückgebliebenste",
        })

        -- titel: "DER"
        local insult = {
            "Amöbenhirni",
            "Drecksack",
            "Dummkopf",
            "Fratzengulasch",
            "Intelligenzallergiker",
            "Kompetenzversager",
            "Papierindianer",
            "Popelnascher",
            "Schandfleck",
            "Schreibtischkobold",
            "Sesselgnom",
            "Spargeltarzan",
            "Verstandsverweigerer",
        }

        return Util.random({
            "Argh!!!",
            "Jetzt mal ehrlich:",
        }) .. " " .. person:getFormalName() .. " ist der " .. insultingAdjectivs[1] .. " und " .. insultingAdjectivs[2] .. " " .. Util.random(insult) .. " " .. Util.random({
            "der mir in meinem Leben untergekommen ist",
            "den ich je gesehen habe",
        }) .. "."
    end,

    chatter_hartman_2_accept = function(person)
        return Util.random({
            "Haha, gut gesagt.",
            "Ja, gibs ihm.",
            "Dem kann ich nichts hinzufügen.",
            "Du hast es erfasst.",
            "Lol. Genau so ist es.",
        })
    end,

    chatter_hartman_2_reject = function(person)
        return Util.random({
            "So würde ich das nicht sagen. Sicher hat er einen Grund, warum er sich so verhält.",
            "Wenn das die falschen Leute hören, wirst du ganz schnell Ärger an der Backe haben.",
            "Und das würdest du ihm so ins Gesicht sagen? Ich denke nicht.",
            "Hör auf Leute zu beleidigen oder ich nähe dir deine Klappe zu.",
        })
    end,

    chatter_treasure_1 = function(dropSectorName)
        return Util.random({
            f("Ein Freund hat mir erzählt, dass es im Sektor %s einen Schiffscontainer ohne Besitzer gibt. Wenn das Minenfeld dort nicht wäre würde ich mir den holen.", dropSectorName),
            f("Ich habe von einer schnellen Möglichkeit gehört um an Geld zu kommen. Im Sektor %s gibt es in einem Minenfeld einen Schiffscontainer, den keiner vermisst.", dropSectorName),
            f("Lust auf ein paar schnelle RP? Im Minenfeld von %s gibt es angeblich einen Container ohne Besitzer. Bestimmt sind die Minen schon so alt, dass sie nicht mehr auslösen.", dropSectorName),
            f("Hey. Ich habe da einen Tipp, wie du ganz schnell an Geld kommst: Im Sektor %s gibt es einen Schiffscontainer, den keiner vermisst.", dropSectorName),
        })
    end,
    chatter_treasure_2 = function()
        return Util.random({
            "In einem Minenfeld? Bist du wahnsinnig?",
            "Willst du wirklich von einer Mine zerfetzt werden?",
            "Dann machen wir es so: Du holst dir den Container und ich überlebe in der Zwischenzeit. Ok?",
            "Und wenn ich darauf wette, dass du nicht lebend zurück kommst bin ich auch stinkreich.",
        })
    end,

})