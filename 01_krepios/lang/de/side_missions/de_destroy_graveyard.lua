local f = string.format

My.Translator:register("de", {
    side_mission_destroy_graveyard_too_close = "Sie halten sich zu nah am Zielgebiet auf und können die Mission darum nicht annehmen.",
    side_mission_destroy_graveyard = function(sectorName)
        return f("Weltraumschrott in Sektor %s zerstören", sectorName)
    end,
    side_mission_destroy_graveyard_description = function(sectorName, number, payment)
        return Util.random({
            "Sie haben vielleicht schon bemerkt, dass wir hier ein Problem mit Weltraumschrott haben.",
            "Zugegeben, diese Mission ist nicht die ruhmreichste. Aber irgendjemand muss sie erledigen.",
        }) .. " " .. Util.random({
            f("Auf dem Schiffsfriedhof im Sektor %s haben sich einige Wracks selbstständig gemacht und drohen in die nahegelegenen Handelsrouten abzudriften. Sie müssen die Wracks von %d Schiffen pulverisieren.", sectorName, number),
            f("%d Schiffe auf dem nahegelegenen Schiffsfriedhof drohen ihren stabilen Orbit zu verlassen. Damit sie die nahen Reiserouten nicht gefährden, suchen wir jemanden, der sie pulverisiert.", number),
        }) .. "\n\n" .. Util.random({
            f("Wir zahlen %0.2fRP fürs Erledigen dieses Auftrags.", payment),
            f("Wenn Sie sich erbarmen, diesen Auftrag auszuführen, zahlen wir Ihnen %0.2fRP.", payment)
        })

    end,
    side_mission_destroy_graveyard_hint = function(numberOfTargets)
        if numberOfTargets > 1 then
            return f("Zerstören Sie %d weitere markierte Schiffe auf dem Schiffsfriedhof.", numberOfTargets)
        else
            return "Zerstören Sie das letzte markierte Schiff auf dem Schiffsfriedhof."
        end
    end,

    side_mission_destroy_graveyard_success_comms = function(payment)
        return Util.random({
            "Hervorragend. Sie haben bewiesen, dass sie auf unbewegliche Ziele feuern können.",
        }) .. " " .. Util.random({
            "Sollten wir wieder jemanden brauchen, um mit überdimensional Waffen unbewegliche Ziele zu zerstören, kommen wir vielleicht wieder auf Sie zu.",
            "Machen Sie sich nichts draus: Jeder gute Kampfpilot hat mal klein angefangen.",
            "Wenn Sie sich weiterhin so ins Zeug legen, lassen wir Sie demnächst vielleicht auch auf bewegliche Ziele schießen - so wie die großen Jungs.",
            "Hören sie nicht auf die Leute, die sagen, dass die Mission auch eine Gruppe Pfadfinderinnen hätte ausführen können. Die sind nur neidisch.",
        }) .. "\n\n" .. Util.random({
            f("Hier haben sie %0.2fRP.", payment),
            f("Wie vereinbart bekommen Sie von uns %0.2fRP.", payment),
        }) .. " " .. Util.random({
            "Sie dürfen sich davon im Spieleland einen Orden für Sauberkeit kaufen.",
            "Kaufen Sie sich ein Eis davon.",
            "Wenn Sie das Geld gut anlegen, können sie sich in einigen Jahren bestimmt ein Puppenhaus kaufen.",
        })
    end,
})