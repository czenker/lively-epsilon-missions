local f = string.format

My.Translator:register("de", {

    shipyard_station_description = function(nebulaName)
        return "Früher wurden auf dieser Station Schiffe repariert und konstruiert. Auch einige kleinere Stationen des Sektors wurden hier teilweise gefertigt." ..
        "Nachdem sie aufgrund ihrer Unwirtschaftlichkeit aufgegeben wurde, verwandelten einige Ingenieure und Konstrukteure diese Station in einen Bastelladen " ..
        "für Drohnen and Kleinschiffe.\n\n" ..
        "Im nahe gelegenen Nebel " .. nebulaName .. " unterhält die Station eine Arena, in der regelmäßig Schaukämpfe von Dronen abgehalten werden."
    end,

    shipyard_workshop_name = function(tinkererPerson)
        return Names.possessive(tinkererPerson:getNickName()) .. " Werkstatt"
    end,

    shipyard_workshop_comms_hail = function(tinkerPerson)
        return Util.random({
            "Willkommen. Ich bin " .. tinkerPerson:getNickName() .. "."
        }) .. " " .. Util.random({
            "Wenn ihr auf der Suche nach gebastelten Upgrades seid, dann seid ihr bei mir genau richtig.",
            "Bei mir findet ihr allerlei Ramsch, den ihr nirgends sonst findet.",
        })
    end,

    shipyard_workshop_comms_upgrade_available = function(tinkererPerson, upgradeName, stationName, upgradePrice)
        return Util.random({
            "Hallo Freunde.",
        }) .. " " .. Util.random({
            f("Dank eurer großzügigen Finanzierung konnte ich \"%s\" soweit fertigstellen, dass es weniger oft explodiert.", upgradeName),
            f("Da ihr mich finanziell unterstützt habt, biete ich euch \"%s\" als Alpha Version an.", upgradeName)
        }) .. " " .. Util.random({
            "Euch sollte aber klar sein, dass ich keinerlei Garantie übernehmen kann.",
            "Für Schäden, die an Personen oder Gegenständen durch statische Entladung, Fehlfunktionen oder spontane Entzündungen entstehen, übernehme ich keine Haftung.",
            "Bitte meldet mir nur die kritischsten Fehler, die ihr findet. Ich habe keine Zeit, mich um alle zu kümmern.",
        }) .. " " .. f("Kommt auf %s vorbei, und ich verkaufe es euch zu einem Freundschaftspreis von %0.2fRP.", stationName, upgradePrice) ..
        "\n\n- " .. tinkererPerson:getNickName()
    end,
})