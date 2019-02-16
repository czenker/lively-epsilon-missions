local f = string.format

My.Translator:register("de", {
    side_mission_pirate_base_station = function(sectorName)
        return f("Feindstation in Sektor %s zerstören", sectorName)
    end,
    side_mission_pirate_base_jammer = function(sectorName)
        return f("Warp Jammer in Sektor %s zerstören", sectorName)
    end,
    side_mission_pirate_base_station_briefing = function(difficulty, sectorName, payment)
        local descriptionSize
        if difficulty == 1 then descriptionSize = "schwache"
        elseif difficulty == 2 then descriptionSize = "kleine"
        elseif difficulty == 3 then descriptionSize = "ernst zu nehmende"
        elseif difficulty == 4 then descriptionSize = "große"
        elseif difficulty == 5 then descriptionSize = "mächtige"
        end

        return Util.random({
            f("Unsere Sensoren haben eine mögliche Feindstation im Sektor %s geortet.", sectorName),
            f("Unser Science Officer hat uns verdächtige Feindaktivitäten in Sektor %s gemeldet. Es sieht nach einer neuen Station aus.", sectorName),
            f("Wie es aussieht versuchen die Piraten einmal mehr Fuß in Sektor %s zu fassen und eine Station zu errichten.", sectorName),
            f("Wir haben eine Baustelle im Sektor %s entdeckt. Da sie nicht angemeldet ist müssen wir davon ausgehen, dass unsere Feinde versuchen eine Basis in Sektor %s zu errichten.", sectorName, sectorName),
        }) .. " " .. Util.random({
            "Das ist natürlich nicht hinnehmbar.",
            "Das ist für uns natürlich sehr unerfreulich.",
            "Wir sollten ihr Vorhaben schnell unterbinden.",
        }) .. " ".. Util.random({
            f("Die Station wird von einer %sn Flotte beschützt.", descriptionSize),
            f("Um die Station ist eine %s Flotte stationiert.", descriptionSize),
            f("Der Feind lässt die Station von einer %sn Flotte beschützen.", descriptionSize),
        }) .. "\n\n" .. Util.random({
            f("Für die Vernichtung der Station und der begleitenden Flotte ist ein Kopfgeld von %0.2fRP ausgelobt.", payment),
            f("%0.2fRP werden an den Captain bezahlt, der die Station und die Flotte vernichtet.", payment),
        })
    end,
    side_mission_pirate_base_jammer_briefing = function(difficulty, sectorName, payment)
        local descriptionSize
        if difficulty == 1 then descriptionSize = "schwache"
        elseif difficulty == 2 then descriptionSize = "kleine"
        elseif difficulty == 3 then descriptionSize = "ernst zu nehmende"
        elseif difficulty == 4 then descriptionSize = "große"
        elseif difficulty == 5 then descriptionSize = "mächtige"
        end

        return Util.random({
            f("Im Sektor %s wurde ein feindlicher Warp Jammer geortet.", sectorName),
            f("Unsere Feinde haben im Sektor %s einen Warp Jammer installiert um unsere Handelsrouten zu stören.", sectorName),
        }) .. " " .. Util.random({
            "Das ist natürlich nicht hinnehmbar.",
            "Ohne Frage muss er zerstört werden.",
        }) .. " ".. Util.random({
            f("Er wird vom Feind mit einer %sn Flotte beschützt.", descriptionSize),
            f("Eine %s Flotte hindert uns daran ihn zu zerstören.", descriptionSize),
        }) .. "\n\n" .. Util.random({
            f("Wenn Sie diese Gefahr eliminieren zeigen wir uns mit %0.2fRP erkenntlich.", payment),
            f("Dem Schiff, das unseren Feind vernichtet winken %0.2fRP als Belohnung.", payment),
            f("Wenn Sie uns helfen die Handelsrouten wieder sicher zu machen zahlen wir Ihnen %0.2fRP als Belohnung.", payment),
        })
    end,
    side_mission_pirate_base_comms_too_close = "Sie halten sich zu nah am Zielgebiet auf. Wir wollen Sie nicht unnötig gefährden. Bitte halten Sie mehr Abstand um den Auftrag anzunehmen.",
    side_mission_pirate_base_station_description = "Eine Baustelle der Piraten. Die Station ist noch nicht funktionsfähig und kaum über den Rohbau hinaus.",
    side_mission_pirate_base_jammer_description = "Ein Warp Jammer der Piraten, der die nahe gelegenen Handelsrouten stört.",
    side_mission_pirate_base_ship_description = function(shipCallSign)
        return Util.random({
            "Ein dunkel lackiertes Schiff auf dessen Hülle ein riesiger Totenkopf gezeichnet wurde.",
            "Auf der Hülle dieses Schiffs wird eine Strichliste geführt, die offenbar die Abschussliste des Piloten repräsentiert.",
            "Den Energiesignaturen nach zu urteilen hat das Schiff offenbar einige illegale Verbesserungen installiert.",
            "Aus der Entfernung sieht es aus, als sei das Schiff bis an die Zähne bewaffnet. Ein Scan zeigt allerdings, dass die Hälfte der Waffen nur Atrappen sind. Gefährlich ist das Schiff aber dennoch.",
            "Der Name des Schiffes wird eingrahmt aus einer Komposition von Laserstrahlen und Rosendornen.",
        })
    end,

    side_mission_pirate_base_station_start_hint = function(sectorName)
        return f("Finden Sie die Station im Sektor %s", sectorName)
    end,
    side_mission_pirate_base_jammer_start_hint = function(sectorName)
        return f("Finden Sie den Warp Jammer im Sektor %s", sectorName)
    end,
    side_mission_pirate_base_station_destruction_hint = function(numberOfShips, stationValid)
        if stationValid then
            if numberOfShips == 0 then
                return "Zerstören Sie die Station"
            elseif numberOfShips == 1 then
                return "Zerstören Sie den letzen Verteidiger und die Station"
            else
                return f("Zerstören Sie %d Verteidiger und die Station", numberOfShips)
            end
        else
            if numberOfShips == 1 then
                return "Zerstören Sie das letzte Schiff"
            else
                return f("Zerstören Sie die %d Verteidiger", numberOfShips)
            end
        end
    end,
    side_mission_pirate_base_jammer_destruction_hint = function(numberOfShips, stationValid)
        if stationValid then
            if numberOfShips == 0 then
                return "Zerstören Sie den Warp Jammer"
            elseif numberOfShips == 1 then
                return "Zerstören Sie den letzen Verteidiger und den WarpJammer"
            else
                return f("Zerstören Sie %d Verteidiger und den Warp Jammer", numberOfShips)
            end
        else
            if numberOfShips == 1 then
                return "Zerstören Sie das letzte Schiff"
            else
                return f("Zerstören Sie die %d Verteidiger", numberOfShips)
            end
        end
    end,

    side_mission_pirate_base_destruction_last_hint = "Abschuss des letzten Verteidigers bestätigt",
    side_mission_pirate_base_destruction_ship_hint = "Abschuss bestätigt",
    side_mission_pirate_base_destruction_station_hint = "Abschuss der Station bestätigt",
    side_mission_pirate_base_destruction_jammer_hint = "Abschuss des Warp Jammers bestätigt",

    side_mission_pirate_base_success_comms = function(payment)
        return f("Ihr Heldenmut hat uns vor diesem Feind geschützt. Ihre Bezahlung von %0.2fRP haben Sie sich redlich verdient.", payment)
    end,
})