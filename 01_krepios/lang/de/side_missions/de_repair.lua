local f = string.format

My.Translator:register("de", {
    side_mission_repair = "Techniker ist verständigt",
    side_mission_repair_description = function(captainPerson, fromCallSign, toCallSign, crewCount, payment)
        return Util.random({
            f("Hey, ich bin %s, Captain eines Raumschiffs", captainPerson:getFormalName())
        }) .. ".\n\n" .. Util.random({"Aufgrund", "Wegen"}) .. " " .. Util.random({
            "eines Kurzschluss im System",
            "einer Überlastung des Reaktors",
            "des Auslaufs von Kühlmittel",
        }) .. " " .. Util.random({
            "ist ein Großteil meiner Systeme ausgefallen",
        }) .. ". " .. Util.random({
            "Ich benötige professionelle Hilfe bei der Reparatur",
            "Allein schaffe ich es nicht den Fehler zu beheben",
            "Ich habe keine Ahnung von Raumschiffreparatur und bin auf Hilfe angewiesen",
            "Die Schäden übersteigen meine technischen Fähigkeiten"
        }) .. ". " .. Util.random({
            f("Ich bin auf dem Flug von %s nach %s stecken geblieben.", fromCallSign, toCallSign),
            f("Ich war auf dem Flug von %s nach %s als das Problem auftrat.", fromCallSign, toCallSign),
            f("Eigentlich wollte ich entspannt von %s nach %s fliegen und dann passiert so etwas.", fromCallSign, toCallSign),
            f("Ich war noch nicht lange von %s abgedockt als ich die Probleme bemerkte. Jetzt komme ich nicht bis %s.", fromCallSign, toCallSign),
        }) .. "\n\n" .. Util.random({
            f("Könnt ihr mir %d eurer Techniker ausleihen?", crewCount),
            f("Mit Unterstützung von %d Technikern bekomme ich das Problem sicher in Griff.", crewCount),
            f("Könnt ihr zeitweise %d eurer Techniker entbehren um mich zu unterstützen?", crewCount),
        }) .. " " .. Util.random({
            f("%0.2fRP zahle ich für Hilfe.", payment),
            f("Eure Hilfe ist mir %0.2fRP wert.", payment),
            f("Sobald das Problem behoben ist bekommt ihr eure Techniker zurück und ich lege %0.2fRP drauf.", payment),
            f("Für %0.2fRP?", payment),
        })
    end,
    side_mission_repair_small_crew = "Öhm, eure Crew erscheint mir etwas mickrig. Ich denke, ich suche jemand anderes.",
    side_mission_repair_accept = function()
        return Util.random({
            "Hervorragend",
            "Ganz ausgezeichnet",
            "Großartig",
        }) .. ". " .. Util.random({
            "Kommt zum Rendevous Punkt",
            "Trefft mich auf meinem Schiff",
        }) .. ". " .. Util.random({
            "Ich, ähm... warte hier auf euch.",
            "Keine Angst, ich fliege nicht weg.",
            "Ich werde einfach hier auf euch warten - gezwungenermaßen.",
        })
    end,
    side_mission_repair_start_hint = function(callSign, sectorName)
        return f("Fliegen Sie sehr dicht an %s in Sektor %s. Ihr Engineer kann die Crew dann herüber senden.", callSign, sectorName)
    end,
    side_mission_repair_hail = function()
        return Util.random({
            "Ihr habt die Techniker für mein Problem an Board?",
            "Ihr bringt die Techniker für das Problem?",
            "Ah, ihr habt die Techniker an Board.",
        }) .. " Fliegt bitte " .. Util.random({
            "bis auf 1u",
            "dicht",
            "sehr nah",
        }) .. " an mein Schiff heran, dann kann euer Engineer die " .. Util.random({"Kollegen", "Techniker", "Ingenieure", "Reparaturmitarbeiter"}) .. " rüber schicken."
    end,


    side_mission_repair_send_crew_label = function(crewCount)
        return f("%d Techniker schicken", crewCount)
    end,
    side_mission_repair_send_crew_failure = function(crewCount)
        return f("Eure Crew ist zu klein. Mindestens %d Techniker werden benötigt.", crewCount)
    end,

    side_mission_repair_crew_arrived_comms = function()
        return Util.random({
            "Super. Die Techniker sind an Board eingetroffen.",
            "Hervorragend. Eure Techniker sind so eben eingetroffen.",
            "Vielen Dank. Die Techniker sind da.",
        }) .. "\n\n" .. Util.random({
            "Ich verstehe allerdings nicht, warum sie sofort meinen Lagerraum aufgesucht haben.",
            "Irgendwie sind sie zielstrebig in den Lagerraum marschiert. Ich verstehe das nicht, aber ich bin ja auch kein Experte.",
            "Sie sind jetzt erst mal im Lagerraum zur \"Inspektion\", wie sie sagen.",
        }) .. " Aber wie auch immer... " .. Util.random({
            "ich informiere euch, wenn die Arbeit erledigt ist",
            "ich sage Bescheid, sobald die Maschine wieder läuft",
            "ich melde mich, wenn alles fertig ist"
        }) .. "."
    end,
    side_mission_repair_crew_arrived_hint = function(callSign)
        return f("Warten Sie, bis die Reparaturen auf %s abgeschlossen sind. Das kann mehrere Minuten dauern. ", callSign)
    end,
    side_mission_repair_crew_ready_comms = function(captainPerson, stationCallSign)
        return Util.random({
            f("Hier ist nochmal %s.", captainPerson:getFormalName()),
            f("Ich bin es noch einmal, Captain %s.", captainPerson:getFormalName()),
        }) .. "\n\n" .. Util.random({
            "Eure Techniker haben volle Arbeit geleistet",
            "Eine fähige Crew, die ihr da habt",
        }) .. " - " .. Util.random({
            "mein Schiff ist wieder voll funktionsfähig",
            "alle Systeme laufen wieder",
            "die alte Mühle ist fast wieder wie neu",
            "sie haben das Problem behoben",
        }) .. ". " .. Util.random({
            f("Ich mache mich wieder auf den Weg nach %s", stationCallSign),
            f("Ich fliege weiter zur Station %s", stationCallSign),
            f("Die Station %s wird sich freuen, dass ich mich jetzt wieder auf den Weg mache", stationCallSign),
        }) .. ". " .. Util.random({
            "Fangt mich unterwegs ab",
            "Wir können uns unterwegs treffen",
        }) .. " oder " .. Util.random({
            "wir treffen uns an der Station",
            "wir treffen uns da",
            "ich warte an der Station auf euch"
        }) .. ". " .. Util.random({
            "Bitte beeilt euch",
            "Lasst euch nicht zu viel Zeit",
        }) .. ", denn " .. Util.random({
            "der Alkohol geht zur Neige",
            "mein selbstgebrannter Alkohol wird knapp",
            "meine Alkoholvorräte sind fast leer"
        }) .. " und ich " .. Util.random({"habe Angst", "befürchte"}) .. ", dass " .. Util.random({
            "die Stimmung kippt",
            "die Stimmung nicht mehr lange hält",
            "die Stimmung demnächst umschwingt",
        }) .. "."
    end,

    side_mission_repair_crew_ready_hint = function(callSign, stationCallSign)
        return f("Holen Sie Ihre Techniker von %s ab. Das Schiff befindet sich auf dem Weg zur Station %s.", callSign, stationCallSign)
    end,
    side_mission_repair_crew_returned_hail = function()
        return Util.random({
            "Danke noch einmal für eure Hilfe.",
            "Eure Techniker haben gute Arbeit geleistet",
        }) .. ". " .. Util.random({
            "Das Schiff flutscht wieder wie ein schleimiger Finanzberater"
        }) .. "."
    end,
    side_mission_repair_crew_returned_comms = function(payment)
        return Util.random({
            "Eure Techniker haben ganze Arbeit geleistet",
            "Ihr habt da eine feine Crew",
        }) .. ". " .. Util.random({
            f("Hier habt ihr wie versprochen die %0.2fRP.", payment),
        })
    end,
    side_mission_repair_failure_comms_crew_lost = "Das Schiff auf das ihr eure Techniker ausgeliehen habt ist von unserem Schirm verschwunden. Eure Crew wird wohl nicht wieder auftauchen. Ist scheiße, aber so ist das Leben hier draußen. Leben und Sterben liegen dicht beeinander.",
    side_mission_repair_failure_comms = "Das Schiff auf das ihr eure Techniker ausleihen solltet ist von unserem Schirm verschwunden. Die Crew wird wohl nicht wieder auftauchen.",


    side_mission_repair_comms_label = "Wie laufen die Reparaturen?",
    side_mission_repair_comms_1 = "Ist ja super, dass ihr euren Technikern so vertraut, aber sie sind gerade erst angekommen. So sehr viel ist bislang nicht passiert.",
    side_mission_repair_comms_2 = "Ich habe euren Technikern das Problem gezeigt und ich denke, sie haben verstanden, was zu tun ist. Jetzt machen sie erst einmal eine Pause und bedienen sich am Alkohol aus meinem Lagerraum bevor sie mit der Arbeit anfangen.",
    side_mission_repair_comms_3 = "Eure Techniker sind hart an der Arbeit und trinken Selbstgebrannten. Aber für mich als Laien ist da nicht so viel zu erkennen. Die Reparatur wird wohl noch ein ganzes Weilchen dauern.",
    side_mission_repair_comms_4 = "Es geht mühsam voran. Ich glaube, die Techniker haben die Ursache für den Defekt entdeckt, aber die meiste Zeit trinken Sie. Die Hälfte der Arbeit sieht aber gemacht aus.",
    side_mission_repair_comms_5 = "Die wichtigsten Systeme laufen wieder. Eure Techniker machen guten Fortschritt - und hin und wieder ein Päuschen im Lager.",
    side_mission_repair_comms_6 = "Die meisten Probleme sind behoben. Hin und wieder flackert noch ein Lämpchen, aber das System funktioniert wieder. Eure Techniker feiern im Lager - sollte also demnächst mit fertig sein.",
    side_mission_repair_comms_7 = "Es sieht wieder alles gut aus. Eure Techniker waschen sich gerade noch die Hände und stoßen mit Selbstgebranntem an. Sie sollten jeden Augenblick fertig sein.",
    side_mission_repair_comms_completed = function(stationCallSign)
        return f("Eure Techniker haben gute Arbeit geleistet. Alle Systeme sind wieder online.\n\nIhr könnt eure Techniker jederzeit wieder abholen.\n\nIch bin auf dem Weg zur Station %s. Fliegt bis auf 1u an mein Schiff heran, damit euer Engineer eure Kollegenzurück holen kann.", stationCallSign)
    end,

    side_mission_repair_return_crew_label = function(crewCount)
        return f("%d Techniker holen", crewCount)
    end,

    side_mission_repair_ship_description = "Ein Schiff älteren Baujahrs.",
    side_mission_repair_ship_description_broken = "Es scheint sich nicht zu bewegen.",
    side_mission_repair_ship_description_extended = "Die Scans des Laderaums zeigen erhöhte Ethanolwerte an Board.",
    side_mission_repair_ship_description_crew = "Die Stimmung an Board scheint ausgelassen zu sein und der Verdacht liegt nahe, dass die Abnahme der Ethanolkonzentration an Board in Verbindung steht.",
    side_mission_repair_ship_description_repaired = "Die Systeme scheinen jedoch erst vor kurzem überholt worden zu sein.",
})