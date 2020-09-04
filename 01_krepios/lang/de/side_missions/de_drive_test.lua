local t = My.Translator.translate
local f = string.format

My.Translator:register("de", {
    side_mission_drive_test = "Neuen Impulsantrieb testen",
    side_mission_drive_test_description = function(tinkererPerson, payment, bonusMinutes, bonusPayment)
        return Util.random({
            f("Hi Freunde. Ich bin es, euer Lieblingsbastler %s.", tinkererPerson:getNickName()),
            f("Hier kommt eine ganz besondere Mission von %s. Wollt ihr etwas wertvolles für meine Entwicklungen tun?", tinkererPerson:getNickName())
        }) .. " " .. Util.random({
            "Ich habe einen neuen Impulsantrieb entwickelt. Auf dem Papier sollte er perfekt funktionieren, aber ich muss auch einen Testlauf unter realen Bedinungen durchführen..",
            "Endlich habe ich den Prototypen meines neuen Impulsantriebs fertig gestellt. Jetzt suche ich jemanden, der ihn testen kann.",
        }) .. " " .. Util.random({
            "Alles was ihr tun müsst ist einmal um die Station zu fliegen. Ich werde die Systeme von der Station aus beobachten.",
            "Eure Aufgabe ist es, so schnell ihr könnt um die Station zu fliegen, um dem Antrieb einem ordentlichen Belastungstest zu unterziehen.",
        }) .. " " .. Util.random({
            f("Ich zahle euch %0.2fRP sobald ihr zur Station zurück kehrt. Und wenn ihr den Test in weniger als %0.1f Minuten beendet, zahle ich weitere %0.2fRP als Bonus.", payment, bonusMinutes, bonusPayment),
            f("%0.2fRP sollen euch gehöhren. Und, wenn ihr den Auftrag in weniger als %0.1f Minuten beendet, gibt es einen Bonus von %0.2fRP oben drauf.", payment, bonusMinutes, bonusPayment)
        }).. "\n\n" .. Util.random({
            "Und lasst euch nicht von den Gerüchten irritieren, dass alle meiner Erfindungen auf furchtbare Weise explodieren. Dies Gerüchte sind weitestgehend falsch.",
            "Das ist meine erste Erfindung, die überhaupt nicht kaputt gehen kann. Vertraut mir!",
        })
    end,
    side_mission_drive_test_accept_dock = "Ihr müsst an der Station angedockt sein, damit ich den Antrieb installieren kann.",
    side_mission_drive_test_accept = function()
        return "Alles klar. Ich habe euren Impulsantrieb mit meiner neuen Version ersetzt und die Parameter an euer vorheriges Modell angepasst. Es beansprucht auch den Platz für Sprung- und Warpantrieb, also könnt ihr die nicht verwenden. Aber in der finalen Version werde ich eine Lösung dafür finden.\n\n" ..
        "Ich habe alle Wegpunkte auf eurer Karte markiert. Folgt ihnen und dockt dann wieder an die Station, damit ich euren alten Antrieb wieder installieren kann. Ich werde das Experiment von dieser station aus beobachten."
    end,
    side_mission_drive_test_artifact_name = function(wayPointId)
        return f("Wegpunkt %d", wayPointId)
    end,
    side_mission_drive_test_hint = function(waypointId, stationCallSign)
        return f("Fliegen sie zu \"%s\" in der Nähe der Station %s.", t("side_mission_drive_test_artifact_name", waypointId), stationCallSign)
    end,
    side_mission_drive_test_hint_bonus = function(time)
        return f("Beenden Sie den Test vor %0.0f um einen Bonus zu erhalten.", time)
    end,
    side_mission_drive_test_log = function(wayPointId)
        return f("Wegpunkt %d passiert", wayPointId)
    end,
    side_mission_drive_test_hint_dock = function(stationCallSign)
        return "Docken Sie an " .. stationCallSign .. " um die Mission zu beenden."
    end,
    side_mission_drive_test_success = function(tinkererPerson, payment)
        return Util.random({
            "Willkommen zurück."
        }) .. "\n\n" .. Util.random({
            "Na, wenigstens ist der Antrieb nicht explodiert.",
            "Der Test lief dann doch besser, als ich dachte.",
            "Naja, der Test hätte schlechter laufen können."
        }) .. " " .. Util.random({
            "Bis auf ein paar kleine Problemchen lief der Test sehr wunderbar.",
            "Ich glaube, die paar kleinen Macken kann ich mit ein wenig Arbeit raus arbeiten.",
        }) .. " " .. Util.random({
            "Aber bei meinen weiteren Entwicklungen wird mir die Erfahrung sicherlich helfen.",
            "Dank eurer Hilfe, kann ich mit meinen Entwicklungen fortfahren.",
        }) .. " " .. Util.random({
            f("Und, wie versprochen, habt ihr hier eure Bezahlung von %0.2fRP.", payment),
            f("Ich denke, %0.2fRP sollten euch für die Unannehmlichkeiten entschädigen.", payment),
        }) .. "\n\n- " .. tinkererPerson:getNickName()
    end,
    side_mission_drive_test_complication1 = function(tinkererPerson)
        return "Schlechte Neuigkeiten.\n\n" ..
               "Die Triebwerke auf der linken Seite haben eine Fehlfunktion und arbeiten nur mit halber Kraft. Dadurch zieht das Schiff nach links. Aber euer Steueroffizier sollte entgegen steuern können, also bestimmt kein großes Problem.\n\n" ..
                "- " .. tinkererPerson:getNickName()
    end,
    side_mission_drive_test_complication2 = function(tinkererPerson)
        return "Der Antrieb verursacht mehr Hitze als angenommen.\n\n" ..
               "Ich weiß nicht, wie das passieren könnte, aber Wärme strahlt vom Impulsantrieb aus auf andere Systeme ab. Euer Boardingenieur sollte Kühlmittel bereitstellen, um die Systeme zu kühlen, um eine Katastrophe zu verhindern.\n\n" ..
                "- " .. tinkererPerson:getNickName()
    end,
    side_mission_drive_test_complication3 = function(tinkererPerson)
        return "War das eine Explosion in einem Triebwerk?\n\n" ..
               "Ich glaube nicht, dass das normal ist. Aber ich habe schon Schlimmeres gesehen. Ich empfehle, das euer Boardingenieur die Reperaturcrew ausschickt, um potentiellen Schaden zu reparieren. Und sagt ihnen, sie sollen sicherheitshalber Feuerlöscher mitnehmen.\n\n" ..
                "- " .. tinkererPerson:getNickName()
    end,
})