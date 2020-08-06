local t = My.Translator.translate
local f = string.format

My.Translator:register("de", {
    side_mission_scan_crystal = "Komplexen Kristall scannen",
    side_mission_scan_crystal_description = function(tinkererPerson, nebulaName, payment)
        return Util.random({
            f("Hi Freunde. Ich bins, euer Lieblingsbastler %s.", tinkererPerson:getNickName()),
            f("Das ist eine ganz besondere Mission von %s. Wollt ihr etwas Wichtiges für meine Forschung erledigen?", tinkererPerson:getNickName())
        }) .. " " .. Util.random({
            f("Vor ein paar Wochen habe ich einen merkwürdigen Kristall in %s gefunden.", nebulaName),
            f("Es gibt da einen sehr interessanten Kristall im nahegelegenen Nebel %s. ", nebulaName),
            f("Mir wurde von einem ausergewöhnlichen Kristall in %s berichtet, und ich wollte mehr darüber erfahren.", nebulaName),
        }) .. " " .. Util.random({
            "Ich vermute, dass es meinen Entwicklungen sehr helfen würde die kristalline Struktur zu kennen. Aber der Scan ist sehr kompliziert.",
            "Ich hatte versucht seine molekulare Zusammensetzung zu scannen. Aber dann wurde ich von einem Geistesblitz unterbrochen und musste dem nachgehen. Aber ich bin überzeugt, dass der Scan sehr komplex ist.",
            "Es hat mich einiges an Zeit gekostet ihn zu scannen, aber ich musste in mein Werkstatt zurück kehren bevor ich fertig wurde. Irgendwas hatte wohl Feuer gefangen.",
        }) .. " " .. Util.random({
            "Könnt ihr mir helfen und ihn scannen?",
            "Würdet ihr einem Kollegen helfen und in scannen?",
        }) .. "\n\n" .. Util.random({
            f("Ich zahle euch %0.2fRP und ihr tut etwas gute für meine Entwicklung.", payment),
            f("Ihr bekommt einen Rabatt und eine Erwähnung bei meiner nächsten Entwicklung. Und obendrauf zahle ich %0.2fRP.", payment),
        })
    end,
    side_mission_scan_crystal_artifact_name = "Kristall",
    side_mission_scan_crystal_artifact_description = "Ein mysteriöser, hochkomplexer Kristall",
    side_mission_scan_crystal_accept = function()
        return Util.random({
            "Ihr seid wahre Freunde.\n\nScannt den Kristall und schickt mir die Daten. Ich hoffe, euer Wissenschaftsoffizier hat mehr Geduld als ich.",
            "Ausgezeichnet. Schickt mir die Daten, wenn ihr fertig seid und ich... Moment. Riecht es hier nach verbranntem Gummi? ... Das kommt aus meiner Werkstatt, oder? Ich muss los. Ihr wisst, wo ihr mich findet.",
        })
    end,
    side_mission_scan_crystal_hint = function(sectorName)
        return f("Scannen Sie den Kristall in Sektor %s.", sectorName)
    end,
    side_mission_scan_crystal_success = function(tinkererPerson, payment)
        return Util.random({
            "Ihr habt die Signatur des Kristalls entschlüsselt! Drückt eurem Wissenschaftsoffizier meinen tiefsten Respekt aus. Ich bin ernsthaft beeindruckt.",
            "Ich war mir nicht sicher, ob man die Signatur des Kristalls knacken kann, aber euer Wissenschaftsoffiziert scheint ein Genie zu sein.",
        }) .. " " .. Util.random({
            "Mit der Information werde ich meine Entwicklung beschleunigen können.",
            "Das wird mir den Durchbruch bei meiner Entwicklung bringen.",
        }) .. " " .. Util.random({
            f("Eure Bezahlung von %0.2fRP habe ich bereits übertragen.", payment),
        }) .. " " .. Util.random({
            "Ich hoffe, wir treffen uns bald wieder.",
            "Kommt in meiner Werkstatt vorbei, wenn ihr zurück auf der Station seid. Vielleicht habe ich dann ein Upgrade, das euch interessiert.",
        }) .. "\n\n- " .. tinkererPerson:getNickName()
    end,
})