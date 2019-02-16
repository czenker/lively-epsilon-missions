local f = string.format

My.Translator:register("de", {
    side_mission_raging_miner = function(sectorName)
        return f("Schürfer in Sektor %s zerstören", sectorName)
    end,
    side_mission_raging_miner_description = function(payment)
        local cause = Util.random({
            "einen Meteorideneinschlag",
            "Altersschwäche",
            "Weltraumschrott",
            "einen elektromagnetischen Impuls",
            "Korrosion",
            "radioaktive Strahlung",
            "einen Kurzschluss",
        })

        return Util.random({
            "Wir haben ein kleines Problemchen.",
            "Ich habe da ein delikates Problem.",
        }) .. " " .. Util.random({
            "Mein Schürfer",
            "Ich bin Schürfer und mein Raumschiff",
        }) .. " wurde durch " .. cause .. " " .. Util.random({
            "vor einigen Tagen",
            "gestern",
            "vor ein paar Stunden",
        }) .. " schwer beschädigt. Dabei sind einige Systeme ausgefallen. " .. Util.random({
            "Leider habe ich den Autopilot aktiviert",
            "Bevor ich das Schiff verlassen habe habe ich noch den Autopilot aktiviert",
        }) .. " doch jetzt " .. Util.random({
            "läuft das Schiff Amok",
            "dreht der Schrotthaufen endgültig durch",
        }) .. ". Die Freund-Feind-Erkennung " .. Util.random({
            "hat es zermatscht wie eine Raumfliege",
            "ist nur noch ein Haufen Schrott",
            "hats nicht überlebt",
            "hat den Geist aufgegeben",
        }) .. " und nun hält die AI jedes Schiff für einen Asteroiden. Der Laser ist extrem " .. Util.random({
            "gefährlich",
            "tödlich",
        }) .. ". Hinzu kommt, dass die Schilde " .. Util.random({
            "verrückt spielen",
            "einen Knacks weghaben",
            "einen Schaden haben",
            "zerfetzt wurden",
            "einen Kurzschluss haben",
        }) .. " und nicht mehr " .. Util.random({
            "starten"
        }) .. ", sondern stattdessen einen heftigen EMP Impuls aussenden. Ich brauche jemanden, der das Schrottding zerstört und dabei dachte ich an euch. " .. f("Wie klingen %0.2fRP als Belohnung?", payment)
    end,

    side_mission_raging_miner_too_close = "Ey Alter, du bist viel zu nah am Zielgebiet.", -- @TODO
    side_mission_raging_miner_accept = "Yeah. Ein Zweikampf mit einer durchgeknallten Maschine. Schade, dass ich nicht zu schauen kann.",

    side_mission_raging_miner_ship_description = function()
        return Util.random({
            "Ein alter Schürfer",
            "Ein schrottreifer Schürfer",
        }) .. ", der beschädigt wurde."
    end,
    side_mission_raging_miner_ship_description_simple = "Die Freund-Feind-Erkennung und die Schildgeneratoren scheinen schweren Schaden genommen zu haben. Es wird empfohlen das Schiff weiträumig zu meiden.",
    side_mission_raging_miner_ship_description_extended = "Das Schiff verursacht immensen EMP Schaden, sobald die Schilde auf 0% geladen wurden. Die Freund-Feind-Erkennung ist defekt und jedes Objekt wird als erzreicher Asteroid erkannt. Mit äußerster Vorsicht nähern.",

    side_mission_raging_miner_approach_comms = "Mein Schürfer sollte jetzt auf eurem Radar zu sehen sein. Bitte seid vorsichtig. Der Laser ist extrem gefährlich und sein EMP Puls zerstört eure Schilde in Sekunden.",
    side_mission_raging_miner_success_comms = function(payment)
        return "Endlich ist " .. Util.random({
            "dieses Drecksding",
            "diese Rostlaube",
            "diese Blechkiste",
            "diese Schrottkiste",
        }) .. " " .. Util.random({
            "Vergangenheit",
            "Geschichte",
            "verschrottet worden",
        }) .. ". Diese durchgeknallte Schrottmühle hat es auch nicht anders verdient. " .. f("Hier sind ihre %0.2fRP - versaufen Sie sie nicht auf einmal.", payment)
    end,
})