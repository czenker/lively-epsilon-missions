local f = string.format

local description = function(nebulaName, size, sectorName)
    local desc
    if size <= 4 then desc = "kleiner Nebel"
    elseif size >= 6 then desc = "großer Nebel"
    else desc = "Nebel"
    end

    return f("%s ist ein %s im Sektor %s.", nebulaName, desc, sectorName)
end

My.Translator:register("de", {
    nebulas_description = function(nebulaName, size, sectorName)
        return description(nebulaName, size, sectorName) .. " " .. Util.random({
            "Man sagt, er sei einer der schönsten in der Gegend.",
            "Reiseführer empfehlen einen Flug hier hin, weil das Farbenspiel unvergleichlich ist.",
            "Gelegentlich verirren sich kleine Reisegruppen oder Transporter hier hin.",
            "Man sagt, wer hier hin reist wird als glücklicher Mensch zurück kehren. Ob das auch für Aliens gilt ist unbekannt.",
            "Er ist vermutlich der uninteressanteste Nebel in der Region.",
            "Sonst gibt es nichts weiter über ihn zu sagen.",
            "Und das ist auch schon alles, das man über ihn wissen muss.",
        })
    end,
    nebulas_description_battlefield = function(nebulaName, size, sectorName)
        return description(nebulaName, size, sectorName) .. " " .. Util.random({
            "Es wird empfohlen den Nebel zu meiden, da es hier regelmäßig zu Kampfhandlungen kommt.",
            "Unbewaffneten Schiffen wird empfohlen den Nebel nur mit Eskorte zu bereisen.",
            "Er diente in der Vergangenheit Piraten als Rückzugsort und eine Gefahr kann nicht ausgeschlossen werden.",
            "Es wird empfohlen Vorsicht walten zu lassen und den Nebel nicht unvorbereitet zu bereisen.",
            "In den letzten Jahren sind mehrere Händler und kleinere Kampfschiffe in diesem Nebel spurlos verschwunden.",
        })
    end,
    nebulas_description_research = function(nebulaName, size, sectorName, researchStationName)
        return description(nebulaName, size, sectorName) .. " " .. Util.random({
            f("Kaum ein Raumschiff, dass sich hierhin verirrt möchte nicht zur Station %s fliegen.", researchStationName),
            f("Falls man nicht die Station %s besuchen möchte lohnt es sich nicht diesen Nebel zu besuchen.", researchStationName),
            f("Glaubt man den Reiseführern, so sollte man diesen Nebel nicht besuchen, weil er von den \"Eierköpfen von %s\" bewohnt wird.", researchStationName),
        })
    end,
})