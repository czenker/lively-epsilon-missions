local f = string.format

My.Translator:register("de", {
    story_welcome_1 = function(commanderPerson, colonelPerson)
        return "Hier spricht Kommandant " .. commanderPerson:getFormalName() .. ". \z
        Seid ihr die kleinen Grünschnäbel, die Colonel " .. colonelPerson:getFormalName() .. " \z
        geschickt hat, um auf mich aufzupassen?"
    end,
    story_welcome_1_response_good = "Jawoll Sir. Wir melden uns zum Dienst.",
    story_welcome_1_response_bad = "Hey, wir sind keine Grünschnäbel!",

    story_welcome_2_good = "Hah. So wie ihr redet, habt ihr an der Akademie den Streber-Kurs mit Bravour bestanden. Das könnt ihr \z
        euch hier gleich abgewöhnen, euer Gelaber interessiert hier niemanden.",
    story_welcome_2_bad = function(colonelPerson)
        return "Oh mein Gott. Natürlich seid ihr keine Grünschnäbel, sondern ein Haufen Heulsusen. Wegen mir könnt ihr \z
        auch zu Colonel " .. colonelPerson:getFormalName() .. " rennen, wenn ihr mit dem Umgangston hier nicht klar kommt."
    end,
    story_welcome_2 = function(colonelPerson)
        return "Aber mal zum Punkt: Mir ist es scheißegal, ob ihr hier seid oder nicht. Ich brauch euch nicht, ich \z
        habe euch nicht angefordert. Colonel " .. colonelPerson:getFormalName() .. " hielt es für eine gute Idee euch \z
        hier her zu schicken, weil wir hier so weit draußen sind und bestimmt Hilfe brauchen. Als ob wir hier nicht \z
        allein klar kämen."
    end,
    story_welcome_2_response_good = "Vielleicht können wir uns ja doch als nützlich erweisen",
    story_welcome_2_response_bad = function(colonelPerson)
        return "Colonel " .. colonelPerson:getFormalName() .. " wird sich etwas dabei gedacht haben"
    end,

    story_welcome_3_good = "Nützlich wie ein paar Kinder, die dir am Hosenbein hängen? Ja, das bestimmt.",
    story_welcome_3_bad = "[sarkastisch] Ja natürlich hat sich der feine Herr was dabei gedacht. Unsere Situation \z
        lässt sich ja hervorragend aus ein paar 1000u einschätzen.",
    story_welcome_3 = "Mit der Drecksmühle, die ihr fliegt werdet ihr sicher nicht lange Freude haben, wenn ihr sie \z
        nicht etwas auf Vordermann bringt. Mit ein paar RP sollte da was zu machen sein. Dann kann ich mit euch \z
        vielleicht auch was anfangen.",
    story_welcome_3_response_good = "Wie kommen wir hier an RP?",
    story_welcome_3_response_bad = "Können wir uns von ihnen Geld leihen?",

    story_welcome_4_good = "Viele sind hier auf der Suche nach Arbeit. Die meisten sind Schürfer, aber ein paar andere \z
        Aufgaben gibt es hier auch noch.",
    story_welcome_4_bad = "Wir sind hier nicht bei der Wohlfahrt, Mädchen! Hier wohnen Menschen, die dir die Kehle \z
        aufschlitzen, um sich einen Drink leisten zu können. RP musst du dir hier selbst erarbeiten.",
    story_welcome_4 = "Am besten schaut ihr mal bei den umliegenden Schürfstationen im Asteroidengürtel vorbei. Dort gibt es \z
        gelegentlich Aufträge. Und wenn ihr auf dem Weg zu ihnen seid, nehmt Energiezellen und Baumaschinen mit - das brauchen \z
        die dort immer.",
    story_welcome_4_response_good = "OK, wir machen uns dann mal auf dem Weg",
    story_welcome_4_response_bad = "Eine Frage hätten wir noch",

    story_welcome_5_good = "Ja, gute Idee.",
    story_welcome_5_bad = "Eh, ihr seid vielleicht ein paar nervige Zecken.",
    story_welcome_5 = "Ich habe noch eine Verabredung mit meinen drei Freunden Johnny, Jack und Jimmy an der Bar.\n\n\z
        Haut ab! Und wenn ihr ein Problem habt... lasst mich damit in Ruhe.",



    story_mission_visit = function(callSign)
        return "Besuchen Sie " .. callSign
    end,
    story_mission_visit_success = function(callSign)
        return f("Station %s wurde zur Schnellwahl hinzugefügt.", callSign)
    end,



    story_after_first_mission = function(commanderPerson)
        return "Ach, habt ihr heraus gefunden, wie man in diesem Sektor Geld verdienen kann. Wollt ihr \z
        euch etwa in dem Sektor häuslich niederlassen oder was?\n\n  - " .. commanderPerson:getFormalName()
    end,


    story_drives_available_mission = function(stationCallSign)
        return "Kaufen Sie einen Sprung- oder Warpantrieb auf " .. stationCallSign
    end,
    story_drives_available = function(colonelPerson, commanderPerson, hqCallSign)
        return "Gut, dass ihr im Krepios System angekommen seid.\n\n\z
        Versucht nicht an Kommandant " .. commanderPerson:getFormalName() .. " zu verzweifeln. Er ist nicht \z
        für seine Freundlichkeit bekannt und ist Neuen gegenüber immer kritisch. Aber macht euch einfach nützlich \z
        und er könnte anfangen euch zu vertrauen.\n\n\z
        Um euch den Einstieg zu erleichtern habe ich mit dem lokalen Upgrade Händler auf " .. hqCallSign .. " gebeten \z
        euch einen Sprungantrieb oder Warpantrieb zu installieren. Die Kosten rechnet er mit mir ab. Ich müsst euch aber \z
        entscheiden, welchen der beiden Antriebe ihr wollt. Euer Schiff sieht nicht vor, dass ihr beide installiert.\n\n\z
        - Colonel " .. colonelPerson:getFormalName()
    end,



    story_laser_refit_award_comms = function(commanderPerson)
        return "Ihr scheint ja doch langsam im Sektor zurechtzukommen. \z
        Hier im Sektor ist es üblich, dass die Schürfer ihre Laser mit - nun sagen wir mal - Software, die man auf \z
        dem freien Markt nicht kaufen kann, ihre Laser modifizieren, um ihre Schadensleistung zu erhöhen. Ein \z
        Programmierer, der sich selbst \"H4><><0R\" nennt, hat eine Software geschrieben, mit der man Laser \z
        jenseits der vom Hersteller vorgegebenen Spezifikation betreiben kann.\n\n\z
        Ich habe euch die Software geschickt. Euer Waffenoffizier kann die Laser der Situation entsprechend neu \z
        kalibrieren. Vielleicht rettet euch das Upgrade bei Kampfmissionen den Arsch.\n\n\z
        Und nur für den Fall, dass jemand fragt: Das Programm habt ihr nicht von mir. Verstanden?\n\n\z
        - Kommandant " .. commanderPerson:getFormalName()
    end,



    story_power_presets_award_comms = function(commanderPerson)
        return "Hey ihr Grünschnäbel. \z
        Ich hab da was Neues für euch. Einer unserer Technikerinnen hat ein Software Update auf einem \z
        Außenwelt-Frachter \"gefunden\" und wollte das ich es euch schicke. Scheint so, als ob es hier auf \z
        der Station doch eine Person gibt, der ihr nicht vollkommen egal seid.\n\n\z
        Das Upgrade soll wohl eurem Technikoffizier irgendwie helfen. So ganz hab ich ihr Geplapper nicht verstanden, aber \z
        sie sagt, es liegt eine Anleitung dabei.\n\n\z
        - Kommandant " .. commanderPerson:getFormalName()
    end,



    story_attack_warning = function(colonelPerson)
        return "Unser Geheimdienst hat mir mitgeteilt, dass in ihrem Sektor merkwürdige Signale entdeckt worden. Leider \z
        wissen wir im Augenblick nicht, worum es sich dabei handelt. Aber halten Sie besser die Augen und Sensoren \z
        offen - irgendetwas geht hier vor.\n\n- Colonel " .. colonelPerson:getFormalName()
    end,



    story_attack_detected_1 = function(commanderPerson, playerCallSign)
        return "Kommandant " .. commanderPerson:getFormalName() .. " an " .. playerCallSign .. ".\n\nWir \z
        stecken ganz tief in der Scheiße. Mehrere unidentifizierte Geschwader sind in diesem Sektor unterwegs und \z
        nähern sich unseren Stationen. Schiffe wie diese habe ich noch nie vorher gesehen und sie reagieren nicht auf \z
        unsere Funksprüche. Ihre Schiffe sind schwer bewaffnet und unsere Scans zeigen, dass sie aktiv nach \z
        zerstörbaren Zielen suchen."
    end,
    story_attack_detected_1_response = "Unbekannte Schiffe?",
    story_attack_detected_2 = "Ich habe keine Ahnung wo diese Kacksdinger herkommen und ich will es auch nicht \z
        rausfinden. Ich will einfach nur meinen Arsch retten und je mehr Seelen in diesem gottverdammten Sektor \z
        überleben, desto eher könnten wir es schaffen eine annehmbare Verteidigung gegen die Flotte aufzustellen.",
    story_attack_detected_2_response = "Welche Rolle spielen wir dabei?",
    story_attack_detected_3 = function(distance)
        return "Ihr Drecksäcke wart doch auf der Militärakademie! Helft uns dem Feind in den Arsch zu treten.\n\n" ..
        distance .. "u von hier gibt es einen alten Kommandoposten. Wenn dort nicht alles verrostet ist, bekommen wir \z
        die Verteidigung vielleicht wieder in Gang und können von da aus unseren Gegenschlag planen."
    end,
    story_attack_detected_3_response = "OK. Wir treffen euch auf dem Kommandoposten",
    story_attack_detected_4 = function(fortressCallSign, fortressSector)
        return "Gut, dass ihr uns helft.\n\nWir treffen uns auf " .. fortressCallSign .. " in Sektor " ..
        fortressSector .. " zur Lagebesprechung. Bummelt nicht und kommt nicht mal auf die Idee euch \z
        mit eurer Schrottmühle gegen den Feind zu stellen. Als ihr ankamt, war das Ding noch schrottiger, aber vergesst \z
        nicht, ihr fliegt immer noch einen aufgepimpten Transporter - kein Kampfschiff."
    end,
    story_attack_detected_4_response = "Keine Alleingänge. Verstanden.",
    story_attack_detected_5 = "Lasst euch nicht zu viel Zeit.\n\nAber wenn ihr es schafft die Schiffe des Feinds aus \z
    der Entfernung zu scannen würde uns das bei der Verteidigung enorm helfen.",

    story_mission_defend_fortress = function(fortressCallSign)
        return "Station " .. fortressCallSign .. " verteidigen"
    end,



    story_mission_plan_defense = function(commanderPerson, fortressCallSign)
        return "Sprechen Sie mit " .. commanderPerson:getFormalName() .. " auf " .. fortressCallSign
    end,
    story_mission_plan_defense_hint = function(fortressSectorName)
        return "Die Station befindet sich in Sektor " .. fortressSectorName .. "."
    end,
    story_mission_plan_defense_hint2 = function(commanderPerson, fortressSectorName)
        return commanderPerson:getFormalName() .. " erwartet sie auf der Station in Sektor " .. fortressSectorName
    end,



    story_mission_plan_defense_arrival = function(commanderPerson, fortressCallSign)
        return commanderPerson:getFormalName() .. " ist auf Station " .. fortressCallSign .. " angekommen."
    end,



    story_mission_financial_support_comms = function(colonelPerson, amount)
        return Util.random({
            f("Hier habt ihr %0.2fRP als Unterstützung für den Kampf gegen den unbekannten Feind.", amount),
            f("Hoffentlich unterstützen euch diese %0.2fRP beim Kampf gegen den unbekannten Feind.", amount),
            f("Damit ihr euer Schiff aufrüsten könnt schicke ich euch %0.2fRP.", amount),
            f("Ich schicke euch %0.2fRP aus der Kriegskasse.", amount),
            f("Wir haben leider kein aktives Sprungloch, um euch Unterstützung zu schicken. Ich hoffe diese %0.2fRP können euch helfen.", amount),
        }) .. " " .. Util.random({
            "Setzt das Geld sinnvoll ein.",
            "Zeigt denen, dass man sich nicht mit der Human Navy anlegt.",
            "Schützt den Sektor vor dem Feind.",
            "Kauft euch ein sinnvolles Upgrade von dem Geld.",
        }) .. "\n\n- Colonel " .. colonelPerson:getFormalName()
    end,
    story_mission_financial_support_hint = function(amount)
        return f("%0.2fRP erhalten", amount)
    end,



    story_mission_scan_enemies = "Scannen Sie die Feindschiffe",
    story_mission_scan_enemies_hint = function(shipNumberRemaining)
        if shipNumberRemaining == 1 then
            return "noch 1 Schiff"
        else
            return "noch " .. shipNumberRemaining .. " Schiffe"
        end
    end,



    story_defense_briefing_label = function(commanderPerson)
        return "Mit " .. commanderPerson:getFormalName() .. " sprechen"
    end,
    story_defense_briefing_not_docked = function(commanderPerson, fortressCallSign)
        return "Kommandant " .. commanderPerson:getFormalName() .. " wartet im Besprechungsraum auf " ..
        fortressCallSign .. " auf Sie.\n\nBitte finden Sie sich dort ein, um die aktuelle Lage zu \z
        besprechen. Leider sind die Systeme zur verschlüsselten Übertragung noch nicht wieder einsatzbereit."
    end,
    story_defense_briefing_1 = function(playerCallSign)
        return "Aaah, die Crew der " .. playerCallSign .. ".\n\nEndlich seid ihr da. Dann können wir ja \z
        anfangen.\n\nWie ihr seht, ist die Station nicht vollkommen funktionsfähig. Wir haben noch Probleme mit dem \z
        Reaktor und den Schilden, aber zumindest funktioniert die Lebenserhaltung und unsere Scanner."
    end,
    story_defense_briefing_1_response = "OK",
    story_defense_briefing_2 = function(colonelPerson)
        return "Wir wissen immer noch nicht, wer uns da angreift, aber es ist offensichtlich, dass sie uns vernichten \z
        wollen. Wenn wir überleben wollen müssen wir ihre Flotten zerstören.\n\nMittlerweile bin ich froh, dass euch Colonel " ..
        colonelPerson:getFormalName() .. " nach Krepios geschickt hat. Ohne euer strategisches Wissen hätten wir \z
        keine Chance."
    end,
    story_defense_briefing_2_response = "Das sind ungewohnt freundliche Worte von ihnen.",
    story_defense_briefing_2 = function(colonelPerson)
        return "Wie ihr wisst, ist unsere Kampfkraft hier auf Krepios nicht besonders stark, aber wir haben noch einige \z
        erfahrene Kampfpiloten aus den Terranischen Kriegen, die euch unterstützen können. Wir können allerdings nur ein \z
        Geschwader bemannen. Ihr müsst entscheiden, welches das ist:\n\n\z
        1. Eine Artillerie Fregatte mit Geschwader. Sie setzt auf den Angriff mit Homing Missiles und wird von einem kleinen \z
        Kampfgeschwader begleitet.\n\z
        2. Kanonenboot Geschwader. Diese Schiffe vertrauen im Kampf auf ihre Laser.\n\n\z
        Welche Schiffe sollen wir bemannen?"
    end,
    story_defense_briefing_2_response_artillery = "Bemannt die Artillerie Fregatte und das Kampfgeschwader.",
    story_defense_briefing_2_response_gunship = "Bemannt die Kanonenboote.",

    story_defense_briefing_3_artillery = "OK, die Piloten sind auf dem Weg in den Hangar und machen die Artillerie Fregatte startklar.",
    story_defense_briefing_3_gunships = "OK, die Piloten sind auf dem Weg in den Hangar und machen die Kanonenboote startklar.",
    story_defense_briefing_3 = function(playerCallSign)
        return "Und noch etwas: Wir haben Techniker hier auf der Station.\n\nSie versuchen aus den ankommenden \z
        Schiffen Upgrades auszubauen, damit ihr sie nutzen könnt. Wir melden uns, sobald wir etwas finden, was wir auf " ..
        playerCallSign .. " installieren können.\n\n\z
        Außerdem können sie verschiedene Verbesserungen an der Station vornehmen und Raketen suchen. Ihr müsst ihnen nur \z
        sagen, was ihr braucht."
    end,


    story_hq_destroyed = function(commanderPerson)
        return "Meine Briefmarkensammlung!! Die Schweine haben unser Hauptquartier zerstört!!\n\nGebt ihnen einen \z
        ordentlichen Tritt in den Arsch. Und falls sie keinen Arsch haben sollten - irgendwo anders hin, wo es weh \z
        tut.\n\nJagt sie einfach in die Luft. Und dann zerlöchert sie mit euren Lasern. In kleine Teile. Sehr kleine \z
        Teile.\n\n- " .. commanderPerson:getFormalName()
    end,



    story_all_destroyed = function(commanderPerson)
        return "Jetzt sind wir die letzten Überlebenden in diesem Sektor.\n\nDie Rache an ihnen kann nichts anderes \z
        als ihre totale Vernichtung sein.  - " .. commanderPerson:getFormalName()
    end,



    story_evacuation_order_1 = function(colonelPerson, playerCallSign, fortressCallSign, wormholeSectorName)
        return "Colonel " .. colonelPerson:getFormalName() .. " an die Besatzung von " .. playerCallSign .. "\n\nDer \z
        Feind nimmt Kurs auf " .. fortressCallSign .. ". Ich habe sie nicht ins Krepios-System geschickt, \z
        damit sie dort sterben. Es gibt in der Nähe des Planeten, im Sektor " .. wormholeSectorName .. " ein \z
        altes Wurmloch, dass sie zurück zur Basis bringt.\n\nSie sind hiermit vom Befehl den Sektor zu verteidigen \z
        befreit. Nutzen Sie das Wurmloch so schnell wie möglich und setzen Sie sich nicht unnötigen Gefahren aus. \z
        Ich brauche Sie noch lebend!"
    end,
    story_evacuation_order_1_response_heroic = "Wir bleiben hier und verteidigen den Sektor",
    story_evacuation_order_1_response_neutral = "Keine unnötigen Risiken. Verstanden.",
    story_evacuation_order_1_response_coward = "Wir machen uns auf den Weg",

    story_evacuation_order_2_heroic = function(playerCallSign)
        return "Ich weiß ihren Mut zu schätzen, " .. playerCallSign .. ", aber tot sind Sie uns auch nicht von Nutzen.\n\nÜberschätzen Sie sich nicht und kommen sie lebend zurück."
    end,
    story_evacuation_order_2_neutral = function(playerCallSign)
        return "Einverstanden.\n\nIch vertraue Ihnen und der Kenntnis ihres Schiffs, " .. playerCallSign .. ". Kommen Sie bitte heil zurück."
    end,
    story_evacuation_order_2_coward = "Sehr gut, ich erwarte Sie im Hauptquartier zurück.",
    story_evacuation_order_2 = "Wir wissen nicht, wer die Angreifer sind. Darum müssen wir eine starke Flotte aufstellen und schnellstmöglich zurückschlagen.",



    story_mission_evacuate = "Das Wurmloch nahe Krepios zur Evakuierung nutzen",
    story_mission_evacuate_hint = function(wormholeSectorName)
        return "Das Wurmloch befindet sich im Sektor " .. wormholeSectorName
    end,



    story_mission_debrief = "Das Wurmloch nahe Krepios nutzen, um zum Hauptquartier zurückzukehren.",
    story_mission_debrief_hint = function(wormholeSectorName)
        return "Das Wurmloch befindet sich im Sektor " .. wormholeSectorName
    end,

    story_mission_debrief_1 = function(commanderPerson)
        return "Ihr habt das unmögliche möglich gemacht! Auf unseren Schirmen sehen wir keine Feindflotten mehr. \z
        Heute ist ein wahrer Tag zum Feiern. Eure Mission auf Krepios ist hiermit beendet - bitte nutzt das Wurmloch, um \z
        euch mit mir zu treffen.\n\n\z- " .. commanderPerson:getFormalName()
    end,



    story_final_evacuation_order_1 = function(playerCallSign, commanderPerson)
        return "Hören Sie, " .. playerCallSign .. ". Kommen Sie zurück zum Hauptquartier. Das ist ein \z
        Befehl!\n\nKommandant " .. commanderPerson:getFormalName() .. " hat sein Leben in diesem Sektor gelassen und \z
        ich möchte nicht, dass ihre Crew ihm folgt. Unsere beste Strategie ist unsere Kräfte zu sammeln und dann \z
        konzentriert zurückzuschlagen.\n\nFliegen Sie zum Wurmloch nahe am Planeten Krepios und passieren Sie es."
    end,
    story_final_evacuation_order_1_response_heroic = "Wir bleiben und kämpfen bis zum Tod",
    story_final_evacuation_order_1_response_coward = "Wir sind schon unterwegs",
    story_final_evacuation_order_2_heroic = function(playerCallSign, colonelPerson)
        return "Das ist doch Wahnsinn! Sie haben mit ihrem Transportschiff doch keine Chance gegen deren \z
        Kampfschiffe.\n\nKommen Sie zur Vernunft und fliegen Sie durch das Wurmloch, " .. playerCallSign ..
        ".\n\nColonel " .. colonelPerson:getFormalName() .. " aus."
    end,
    story_final_evacuation_order_2_coward = function(commanderPerson, colonelPerson)
        return "Heute ist ein schwerer Tag für uns. Nicht nur, dass wir einen Sektor verloren haben, sondern auch " ..
        commanderPerson:getFormalName() .. ". Hoffen wir, dass wenigstens Sie es lebend aus dem Sektor schaffen.\n\n\z
        Colonel " .. colonelPerson:getFormalName() .. " aus."
    end,

    story_final_evacuation_debrief_survivors = function(playerCallSign, commanderPerson)
        return "Ich freue mich zu hören, dass ihr aus Krepios zurück seid, " .. playerCallSign .. ". Dank eures mutigen \z
        Einsatzes konnten wir den Feind aus Krepios in letzter Minute vertreiben.\n\n\z
        Leider musste unser Kamerad " .. commanderPerson:getFormalName() .. " sein Leben lassen. Aber er tat es an der \z
        Seite unzähliger Zivilisten, die er bis zuletzt geschützt hat. Dafür werde ich ihm posthum eine Ehrenmedaille \z
        verleihen.\n\n\z
        Auch ihr seid zu der Feierlichkeit eingeladen und werdet für euren Mut auf Krepios ausgezeichnet.\n\n\z
        Weggetreten, " .. playerCallSign .. "."
    end,
    story_final_evacuation_debrief_heroic = function(playerCallSign, commanderPerson)
        return "Die Station ist in heller Aufregen und hat eurer Ankunft mit hoher Aufregung entgegengeeifert. \z
        Man wartet auf die heroischen Geschichten, die ihr erzählen werdet, darüber wie ihr den Sektor Krepios vor der \z
        sicheren Vernichtung durch eine unbekannte feindliche Macht gerettet habt.\n\n\z
        Das Ende des Sektors ist damit allerdings besiegelt. Ein Wiederaufbau wird sich nicht lohnen. " ..
        commanderPerson:getFormalName() .. " wird die Räumung des Sektors organisieren. Vielen Menschen steht eine \z
        neue Zukunft bevor und wir werden sehen, was sie bringen wird.\n\n\z
        Aber heute ist ein Tag, um zu feiern. Dank eures Heldenmuts können viele Zivilisten aus Krepios den morgigen \z
        Tag erleben. Dafür habt ihr eine Auszeichnung verdient. Diese werde ich ihnen heute Abend verleihen - nachdem \z
        sie sich ausgeruht und frisch gemacht habt.\n\n\z
        Weggetreten, " .. playerCallSign .. "."
    end,
    story_final_evacuation_debrief_lost = function(playerCallSign, commanderPerson)
        return "Heute ist ein trauriger Tag für die Human Navy. Wir haben den Sektor Krepios an eine unbekannte Macht \z
        verloren. Viele Zivilisten und " .. commanderPerson:getFormalName() .. " haben ihr Leben in dem Sektor gelassen. \z
        Umso mehr stimmt es mich glücklich, dass wenigstens ihr es heil zurückgeschafft habt. Wir werden jede Crew brauchen, \z
        um uns dem unbekannten Feind zu stellen. Ihr habt gezeigt, dass er verwundbar ist. Und mit einer großen Flotte \z
        könnten wir Erfolg im Kampf gegen ihn haben.\n\n\z
        Doch für heute ist euer Dienst vorerst beendet. Wir haben das Wurmloch hinter euch geschlossen, sodass uns keine \z
        akute Gefahr droht. Ruht euch aus und trefft mich morgen in meinem Büro.\n\n\z
        Weggetreten, " .. playerCallSign .. "."
    end,
    story_final_evacuation_debrief_unclear = function(playerCallSign, commanderPerson)
        return "Ein Glück, dass ihr es noch lebend aus Krepios geschafft habt. Ihr seid das letzte Schiff, das aus dem \z
        Sektor fliehen konnte. Das Wurmloch wurde nach euch unstabil und ist nicht mehr passierbar. Leider haben wir seitdem \z
        auch keine Nachrichten mehr aus dem Sektor bekommen. Wir gehen von dem Schlimmsten aus, aber geben die Hoffnung \z
        nicht auf. Vielleicht ist " .. commanderPerson:getFormalName() .. " noch am Leben.\n\n\z
        Wir werden bald eine Flotte zusammenstellen, die sich dem unbekannten Feind entgegenstellen kann und nach \z
        Überlebenden sucht. Wenn ihr wollt, könnt ihr an der Expedition teilnehmen. Doch zunächst solltet ihr euch \z
        ausruhen. Wir haben ein Quartier für euch vorbereitet, das ihr für die nächsten Tage beziehen könnt. Trefft mich \z
        morgen in meinem Büro, wenn ihr ausgeruht seid.\n\n\z
        Weggetreten, " .. playerCallSign .. "."
    end,
    story_final_evacuation_debrief_ok = "Jawoll, Colonel."

})