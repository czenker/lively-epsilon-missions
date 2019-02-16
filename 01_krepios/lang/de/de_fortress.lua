local f = string.format

My.Translator:register("de", {

    fortress_station_initial_description = "Diese Station diente einstmals als Raumhafen für die Konstruktion von Raumschiffen und kleinerer Stationen. Vor über 10 Jahren hat sie ihren Betrieb eingestellt.",
    fortress_station_manned_description = "Dieser ehemalige Raumhafen dient heute als Zentrum zur Verteidigung des Sektors gegen die unbekannten Angreifer.",
    fortress_hail_initial_docked = "Das Innere ist in Dunkelheit gehüllt. Auf den ersten Blick ist klar, dass die Station seit Jahren verlassen ist. Die Hülle scheint intakt zu sein, auch wenn sich im Inneren viel abgeblätterte Farbe und einige Rostflecken finden.",

    fortress_hail_manned = function(commanderPerson)
        return commanderPerson:getFormalName() .. " erwartet euch im Besprechungsraum. Bitte kommt so schnell wie möglich auf die Station."
    end,
    fortress_hail_manned_docked = function(playerCallSign)
        return "Endlich seid ihr da, " .. playerCallSign .. ". Der Kommandant erwartet euch bereits im Besprechungsraum.\n\nGeht den Gang runter und an der Kreuzung rechts. Und stoßt euch nicht den Kopf an den Rohren, die von der Decke hängen. Die Beleuchtung haben wir noch nicht überall wieder in den Griff bekommen."
    end,

    fortress_hail_defense_enemies_close = "Wir sehen eine Feindflotte auf unserem Radar.",
    fortress_hail_defense_attacked = function(isPlayerClose)
        if isPlayerClose then
            return "Verdammt - die Schiffe sind hier und greifen die Station an.\n\nHoffen wir, dass wir den nächsten Tag sehen."
        else
            return "Wir werden von Feindschiffen angegriffen. Helft uns oder wir sind verloren."
        end
    end,
    fortress_hail_defense_docked = function(fortressCallSign, isRepairing)
        local msg = "Willkommen auf " .. fortressCallSign .. "."
        if isRepairing then
            msg = msg .. " Unsere Techniker kümmern sich bereits um euer Schiff."
        end
        msg = msg .. "\n\nWomit können wir euch sonst helfen?"
        return msg
    end,
    fortress_hail_defense = "Die Ruhe vor dem Sturm ist das Schlimmste.",

    fortress_hail_victory = function(playerCallSign)
        return "Wow, " .. playerCallSign .. ". Ihr habt uns gerettet.\n\nDer Kommandant hat in der Bar eine Kiste Schnaps. Kommt doch vorbei und genehmigt euch auch eine."
    end,



    fortress_improvement_hint = "Unsere Techniker sind gerade ohne Arbeit. Was sollen sie als nächstes tun?",
    fortress_improvement_progress = function(improvementName)
        return "Unsere Technikteams arbeiten gerade an folgendem: " .. improvementName .. "."
    end,
    fortress_improvement_label = "Technikern Aufgabe geben",
    fortress_improvement_what_next = "Was sollen wir als nächstes tun?",
    fortress_improvement_confirmation = "Wir machen uns sofort an die Arbeit.",



    fortress_improvement_homing_name = function(amount)
        return f("%d Homing Raketen produzieren", amount)
    end,
    fortress_improvement_homing_confirmation = "Wir werden versuchen in der Station ungenutzte Raketen zu finden.",
    fortress_improvement_homing_completion = "Unsere Ingenieure haben einige Homings gefunden und ins Lager gebracht.",

    fortress_improvement_hvli_name = function(amount)
        return f("%d HVLI Raketen produzieren", amount)
    end,
    fortress_improvement_hvli_confirmation = "Unsere Techniker machen sich an die Arbeit. Hoffentlich finden wir in den Hangars noch einige alte HVLIs.",
    fortress_improvement_hvli_completion = "Wir haben ein paar funktionstüchtige HVLIs gefunden uns ins Lager gebracht.",

    fortress_improvement_mine_name = function(amount)
        return f("%d Minen produzieren", amount)
    end,
    fortress_improvement_mine_confirmation = "Unsere Techniker haben bereits Sprengstoffe gefunden. Sie werden nun mit Hochdruck daran arbeiten Minen daraus zu bauen.",
    fortress_improvement_mine_completion = "Wir haben wie gewünscht Minen hergestellt.",

    fortress_improvement_emp_name = function(amount)
        return f("%d EMP Raketen produzieren", amount)
    end,
    fortress_improvement_emp_confirmation = "Wir haben zwar Energieprobleme, aber wir werden versuchen EMPs zu bauen.",
    fortress_improvement_emp_completion = "Die bestellten EMPs wurden gefertigt und zu unserem Lager hinzugefügt.",

    fortress_improvement_nuke_name = "Nuklear Rakete produzieren",
    fortress_improvement_nuke_confirmation = "Wenn wir dem Feind etwas entgegen setzen wollen können wir uns nicht auf konventionelle Waffen verlassen. Unsere Ingeneure tun ihr Bestes um eine Nuke herzustellen.",
    fortress_improvement_nuke_completion = "Wir haben eine Nuke gefertigt und zu unserem Lager hinzugefügt.",

    fortress_improvement_repair_name = "Reparaturdock in Gang setzen",
    fortress_improvement_repair_confirmation = "Unsere Techniker werden versuchen die Werkstatt zur Reparatur wieder funktionstüchtig zu bekommen.",
    fortress_improvement_repair_completion = "Die Werkstatt wurde repariert. Wir sind nun in der Lage die Hülle eures Schiffes zu reparieren, sollten es die Umstände erforderlich machen.",

    fortress_improvement_shield_name = "Schilde wiederherstellen",
    fortress_improvement_shield_confirmation = "Ok, mal schauen, ob wir die Schilde auf dieser Station wieder ans Laufen bekommen. Drückt uns die Daumen.",
    fortress_improvement_shield_completion = "Wir haben die Schilde der Station wieder aktiviert bekommen. Noch sind sie fern von ihrer maximalen Leistung, aber immerhin sind wir nicht mehr ganz schutzlos.",

    fortress_improvement_shield2_name = "Schilde verstärken",
    fortress_improvement_shield2_confirmation = "Wir werden versuchen noch mehr Energie auf die Schilde zu bekommen. Das könnte ganz schön verzwickt werden.",
    fortress_improvement_shield2_completion = "Wir konnten die Schilde der Station mit einigen Tricks verstärken.",

    fortress_improvement_artillery_name = "Artillerie Fregatte einsatzbereit machen",
    fortress_improvement_artillery_confirmation = "Wir werden die Artillerie Fregatte und zwei Kampfflieger für die Piloten vorbereiten.",
    fortress_improvement_artillery_completion = "Wir haben die Artillerie Fregatte und zwei Kampfflieger einsatztauglich gemacht. Ihr könnt sie nun kontrollieren.",

    fortress_improvement_gunships_name = "Kanonenboot Geschwader einsatzbereit machen",
    fortress_improvement_gunships_confirmation = "Wir werden die Kanonenboote für die Piloten vorbereiten.",
    fortress_improvement_gunships_completion = "Wir haben die Kanonenboote einsatztauglich gemacht. Ihr könnt sie nun kontrollieren.",



    fortress_upgrade_available = function(fortressCallSign, upgradeName, upgradePrice)
        return  Util.random({
            "Wir haben das Upgrade  " .. upgradeName .. "  jetzt im Angebot.",
            "Wir können das Upgrade  " .. upgradeName .. "  auf eurem Schiff installieren.",
            "Habt ihr Interesse an einem Upgrade?  " .. upgradeName .. "?",
            "Klingt  " .. upgradeName .. "  nach einem Upgrade an dem ihr interesse haben könntet?",
            "Gute Nachrichten:  Kommt nach " .. fortressCallSign .. " für das Upgrade  " .. upgradeName .. ".",
        }) .. "\n\n" ..
        Util.random({
            "Einer unserer " .. Util.random({"Techniker", "Technikerinnen"}) .. " konnte es aus einem alten Raumschiff ausbauen.",
            "Es scheint so als wurde das hier auf der Station vergessen.",
            "Ein pazifistisches Genie mit brauner Lederjacke konnte ein kaputtes Teil mit etwas Draht und einer Kugelschreibermine reparieren. Keiner weiß, wie er das gemacht hat, aber jetzt funktioniert es wieder.",
            "Eigentlich ist das Teil nicht für den Kampfeinsatz gedacht, aber im Krieg haben wir kaum eine Wahl.",
            "Wir haben das Teil in einem Lager gefunden, das " .. Util.random({"ein kleiner Junge", "ein kleines Mädchen"}) .. " beim Spielen entdeckt hat.",
            "Hinter einer elektronischen Tür haben wir eine Werkstatt gefunden. Mann, haben wir da viele Ersatzteile gefunden.",
            "Weltraumschrott ist halt doch nicht immer Schrott. Manchmal findet man auch etwas brauchbares darunter.",
        }) .. " " ..
        Util.random({
            f("Für %.2fRP können wir das Upgrade installieren.", upgradePrice),
            f("Kommt auf " .. fortressCallSign .. " vorbei und ich installiere euch das Upgrade für %.2fRP.", upgradePrice),
            f("Für %.2fRP und eine kurze Arbeitszeit installiere ich das Upgrade für euch.", upgradePrice),
            f("Wenn ihr %.2fRP habt gehört das Upgrade euch.", upgradePrice),
        })
    end,


    fortress_intel_label = "Feind Report",
    fortress_intel_menu_no_known_fleets = "Uns sind keine feindlichen Flotten bekannt.",
    fortress_intel_menu_no_valid_fleets = "Alle feindlichen Flotten sind zerstört.",
    fortress_intel_menu_number_of_fleets = function(number)
        if number == 1 then
            return "Es gibt noch eine Feindflotte, die zerstört werden muss."
        else
            return number .. " Feindflotten in diesem Sektor stellen eine Gefahr dar."
        end
    end,
    fortress_intel_distance_close = function(closestFleetId)
        return f("Wir werden im Augenblick von Flotte %d angegriffen und nehmen Schaden.", closestFleetId)
    end,
    fortress_intel_distance = function(distanceInU, closestFleetId)
        return f("Die naheste Feindflotte ist Flotte %d. Sie befindet sich etwa %du von uns.", closestFleetId, distanceInU)
    end,
    fortress_intel_detail_button = function(number)
        return "Flotte " .. number
    end,
    fortress_intel_detail_type_unknown = "unbekannt",
    fortress_intel_detail_info = function(sectorName, distanceInU)
        return f("Die Flotte befindet sich in Sektor %s und ist etwa %du von unserer Station entfernt.", sectorName, distanceInU)
    end,
    fortress_intel_detail_info_detailed = function(sectorName, distanceInU, durationInMin)
        return f("Die Flotte befindet sich in Sektor %s, ist etwa %du von unserer Station entfernt und kann uns in etwa %d Minuten erreichen.", sectorName, distanceInU, durationInMin)
    end,
    fortress_intel_detail_weapons_detail = "Nach unseren Berechnungen sollte die Flotte folgende Raketen geladen haben",
    fortress_intel_detail_weapons = "Nach unseren Schätzungen sollte die Flotte ungefähr über folgende Bewaffnung verfügen",
    fortress_intel_detail_weapons_full = "voll bestückt",
    fortress_intel_detail_weapons_high = "nahezu voll",
    fortress_intel_detail_weapons_half = "etwa halb voll",
    fortress_intel_detail_weapons_low = "fast leer",
    fortress_intel_detail_weapons_empty = "leer",
    fortress_intel_detail_number_of_ships = function(number)
        if number == 1 then
            return "Die Flotte besteht aus einem Schiff."
        else
            return f("Die Flotte besteht aus %d Schiffen.", number)
        end
    end,
    fortress_intel_detail_scan_hint = "Keine weiteren Informationen über die Flotte bekannt. Wenn Sie einige Schiffe der Flotte scannen können wir mehr Informationen bereitstellen.",



})