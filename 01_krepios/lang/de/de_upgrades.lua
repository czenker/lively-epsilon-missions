local f = string.format

My.Translator:register("de", {
    upgrade_speed1_name = "Impulsantrieb MkI",
    upgrade_speed1_description = function(speedUPerMin)
        return f("Der Impulsantrieb MkI ist die Einsteigervariante für kleinere und mittlere Frachter. Geschwindigkeiten über %0.1fu/min sind nur für erfahrene Techniker machbar, aber aufgrund seiner Zuverlässigkeit wird der Antrieb überall geschätzt.", speedUPerMin)
    end,

    upgrade_speed2_name = "Impulsantrieb MkII",
    upgrade_speed2_description = function(speedUPerMin)
        return f("Der Impulsantrieb MkII ist eine verbesserte Version des serienmäßig in leichten Schiffen verbauten Antriebs. Im Normalbetrieb sind mit ihm Geschwindigkeiten bis zu %0.1fu/min möglich - ein guter Techniker kann aber auch mehr herauskitzeln.", speedUPerMin)
    end,

    upgrade_speed3_name = "Impulsantrieb MkIII",
    upgrade_speed3_description = function(speedUPerMin)
        return f("Durch überragende menschliche Konstruktionskunst konnte der Impulsantrieb für kleinere und mittlere Frachter noch weiter optimiert werden. Heraus kam der Impulsantrieb MkIII, der mit einer Maximalgeschwindigkeit %0.1fu/min überzeugt.", speedUPerMin)
    end,

    upgrade_speed4_name = "Impulsantrieb MkIV",
    upgrade_speed4_description = function(speedUPerMin)
        return f("Kleinere Verbesserungen an der Materieeinspritzung und die Optimierung des Wirkungsgrads machen den Impulsantrieb MkIV zu einer der besten Optionen für kleine und mittlere Frachter. Seine Höchstgeschwindigkeit liegt bei %0.1fu/min ohne Turbo.", speedUPerMin)
    end,

    upgrade_rotation1_name = "Schubdüsen MkI",
    upgrade_rotation1_description = function(secondsPer180)
        return f("Die MkI ist eine der einfachsten Schubdüsen, die am Markt verfügbar sind. Wendungen um 180 Grad sind immerhin in %0.1f Sekunden möglich.", secondsPer180)
    end,

    upgrade_rotation2_name = "Schubdüsen MkII",
    upgrade_rotation2_description = function(secondsPer180)
        return f("Eine zielgerichtetere Steuerung der Schubdüsen erhöht die Wendigkeit des Schiffes immens und erlaubt es dem Schiff in weniger als %0.1f Sekunden eine 180 Grad Wende auszuführen.", secondsPer180)
    end,

    upgrade_rotation3_name = "Schubdüsen MkIII",
    upgrade_rotation3_description = function(secondsPer180)
        return f("Dieses Update verteilt die Energie zwischen Schubdüsen und Impulsantrieb dynamisch und erlaubt so in weniger als %0.1f Sekunden eine 180 Grad Wende auszuführen.", secondsPer180)
    end,

    upgrade_storage1_name = "Lagerraum S",
    upgrade_storage1_description = function(storageSize)
        return f("Ein Lagerraum für Frachter, der %d Einheiten lagern kann.", storageSize)
    end,

    upgrade_storage2_name = "Lagerraum M",
    upgrade_storage2_description = function(storageSize)
        return f("Durch Erweiterung des Laderaums kann die Ladekapazität eines kleinen oder mittleren Frachters um %d Einheiten erhöht werden.", storageSize)
    end,

    upgrade_storage3_name = "Lagerraum L",
    upgrade_storage3_description = function(storageSize)
        return f("Die Nutzung des Laderaums kann optimiert werden, in dem unnötige Trennwände entfernt und durch intelligente Lagersysteme ersetzt werden. Dadurch können bis zu %d Einheiten mehr gelagert werden.", storageSize)
    end,

    upgrade_combatManeuver_name = "Manöverdüsen BST200",
    upgrade_combatManeuver_description = "Manöverdüsen erlaubt schnelle, aber kurze Ausweichmanöver durchzuführen. So erlauben sie Objekten im All auszuweichen oder Raketen ins Leere laufen zu lassen.",

    upgrade_warpDrive_name = "Warpantrieb X8",
    upgrade_warpDrive_description = "Für längere Reisen sind größere Schiffe mit Warpantrieben ausgerüstet, die Reisen mit Überlichtgeschwindigkeit ermöglichen.\n\nAuf einem Schiff können nur entweder ein Warpantrieb oder ein Sprungantrieb installiert werden.",

    upgrade_jumpDrive_name = function(range)
        return f("Sprungantrieb %dU", range)
    end,
    upgrade_jumpDrive_description = function(range)
        return f("Der Sprungantrieb wird häufig von militärischen und paramilitärischen Gruppierungen verwendet, um Überraschungsangriffe durchzuführen. Doch auch für längere Reisen ist der Sprungantrieb durchaus geeignet. Dieser Antrieb erlaubt Sprünge bis zu %dU.\n\nAuf einem Schiff können nur entweder ein Warpantrieb oder ein Sprungantrieb installiert werden.", range)
    end,

    upgrade_hvli1_name = "HVLI Lager S",
    upgrade_hvli1_description = function(storageSize)
        return f("Platz für %d HVLI Raketen ist selbst in den kleinsten Schiffen vorhanden. So auch hier: eine kleine Ecke in der Nähe der Torpedorohre reicht vollkommen aus.", storageSize)
    end,

    upgrade_hvli2_name = "HVLI Lager M",
    upgrade_hvli2_description = function(storageSize, storageMalusSize)
        return f("Durch Umbau des Lagerraums kann Platz für %d HVLI Raketen geschaffen werden. Dadurch wird jedoch der Lagerraum um %d Einheiten verringert.", storageSize, storageMalusSize)
    end,

    upgrade_hvli3_name = "HVLI Lager L",
    upgrade_hvli3_description = function(storageSize, storageMalusSize)
        return f("Eine weitere Verkleinerung des Lagerraums um %d Einheiten schafft Platz für Aufhängungen mit denen insgesamt %d HVLI Raketen gelagert werden können.", storageMalusSize, storageSize)
    end,

    upgrade_homing1_name = "Homing Lager S",
    upgrade_homing1_description = function(storageSize)
        return f("In einem kleinen Teil des Raumschiffs wird ein Laderaum für %d Homing Raketen geschaffen. Dieser ist verstärkt, um eine Explosion im Inneren des Schiffs zu vermeiden.", storageSize)
    end,

    upgrade_homing2_name = "Homing Lager M",
    upgrade_homing2_description = function(storageSize, storageMalusSize)
        return f("Durch Umbau des Lagerraums kann Platz für %d Homing Raketen geschaffen werden. Dadurch wird jedoch der Lagerraum um %d Einheiten verringert.", storageSize, storageMalusSize)
    end,

    upgrade_homing3_name = "Homing Lager L",
    upgrade_homing3_description = function(storageSize, storageMalusSize)
        return f("Eine weitere Verkleinerung des Lagerraums um %d Einheiten schafft Platz für Aufhängungen mit denen insgesamt %d Homing Raketen gelagert werden können.", storageMalusSize, storageSize)
    end,

    upgrade_mine1_name = "Mine Lager S",
    upgrade_mine1_description = function(storageMalusSize)
        return f("Durch Einrichtung eines Stasisfelds kann im Lagerraum eine Mine sicher transportiert werden. Der Lagerraum wird durch den Umbau um %d Einheiten verkleinert.", storageMalusSize)
    end,

    upgrade_mine2_name = "Mine Lager M",
    upgrade_mine2_description = function(storageSize, storageMalusSize)
        return f("Durch eine Vergrößerung des Stasisfelds können insgesamt %d Minen im Lagerraum untergebracht werden. Dazu wird aber der Lagerraum um weitere %d Einheiten verkleinert.", storageSize, storageMalusSize)
    end,

    upgrade_mine3_name = "Mine Lager L",
    upgrade_mine3_description = function(storageSize, storageMalusSize)
        return f("Mit diesem Upgrade kann ein mittlerer Transporter zu einem Behelfs-Minenleger umfunktioniert werden. Mit einer Lagerkapazität von %d Minen können kleinere Minengürtel gelegt werden. Durch das Upgrade werden %d Einheiten im Lagerraum nicht anderweitig nutzbar.", storageSize, storageMalusSize)
    end,

    upgrade_emp1_name = "EMP Lager S",
    upgrade_emp1_description = function(storageMalusSize)
        return f("EMP Waffen erlauben das Schild von Schiffen zu deaktivieren, ohne die Hülle zu beschädigen. Durch Reduzierung des Lagerraums um %d Einheiten kann Platz zum Lagern einer EMP Rakete geschaffen werden.", storageMalusSize)
    end,

    upgrade_emp2_name = "EMP Lager M",
    upgrade_emp2_description = function(storageSize, storageMalusSize)
        return f("Durch eine weitere Reduzierung des Lagerraums um %d wird Lagerraum für insgesamt %d EMP Raketen geschaffen.", storageMalusSize, storageSize)
    end,

    upgrade_emp3_name = "EMP Lager L",
    upgrade_emp3_description = function(storageSize, storageMalusSize)
        return f("Die Erweiterung des Lagerraums auf %d EMP Raketen ist besonders bei Piraten und Gesetzeshütern sehr beliebt, da im Gegensatz zu konventionellen Raketen kaum bleibende Schäden verursacht werden. Für den Lagerraum muss der Lagerraum um %d Einheiten verkleinert werden.", storageSize, storageMalusSize)
    end,

    upgrade_nuke1_name = "Nuke Lager S",
    upgrade_nuke1_description = function(storageMalusSize)
        return f("Um ein konventionelles Lager für Nukes nutzbar zu machen sind größere Umbauten nötig um einen zuverlässigen Strahlenschutz der Besatzung und des restlichen Schiffs zu gewährleisten. Der Lagerraum wird um %d Einheiten reduziert.", storageMalusSize)
    end,

    upgrade_nuke2_name = "Nuke Lager M",
    upgrade_nuke2_description = function(storageMalusSize)
        return f("Größerer Lagerraum für eine weitere Nuke, der auf Kosten von %d Einheiten Lagerraum geht. Dafür wird die militärische Schlagkraft des Schiffes enorm erhöht.", storageMalusSize)
    end,

    upgrade_energy1_name = "Power MkI",
    upgrade_energy1_description = function(energyUnits)
        return f("Ein einfacher Energiespeicher für Transportschiffe, der %d Einheiten Energie speichern kann.", energyUnits)
    end,

    upgrade_energy2_name = "Power MkII",
    upgrade_energy2_description = function(energyUnits)
        return f("Technische Fortschritte der Energiespeicherforschung in den letzten Jahren erlauben höhere Mengen Energie auf gleichem Raum zu speichern. Durch ein Upgrade auf Mikroporen Speichertechnologie kann zusätzliche Energie mit einem Level von %d gespeichert werden.", energyUnits)
    end,

    upgrade_energy3_name = "Power MkIII",
    upgrade_energy3_description = function(energyUnits)
        return f("Verteilte Energiesysteme sorgen für Redundanz und Ausfallsicherheit. Durch kleinere Energiespeicher direkt an den Komponenten kann sowohl die Speicherkapazität um %d erhöht werden als auch eine bessere Ausfallsicherheit gewährleistet werden.", energyUnits)
    end,

    upgrade_energy4_name = "Power MkIV",
    upgrade_energy4_description = function(energyUnits, storageMalusSize)
        return f("Zusätzliche Energiespeicher können im Lagerraum installiert werden, um die Speicherkapazität um %d zu erhöhen. Dadurch stehen allerdings %d Einheiten weniger im Lager zur Verfügung.", energyUnits, storageMalusSize)
    end,

    upgrade_powerPresets_name = "Power Magician",
    upgrade_powerPresets_description = function(slots)
        return f("Dieses Software Update für die Engineering Station gestattet es die Energie- und Kühlmittelverteilung in Raumschiffen zu speichern und schnell abzurufen. Viele Engineers auf größeren Schiffen nutzen dieses System, um effizienter zu agieren und schnell auf sich verändernde Anforderungen im Energiebedarf von Raumschiffen zu reagieren.", slots)
    end,

    upgrade_shield1_name = "Schild MkI",
    upgrade_shield1_description = function(strength)
        return f("Kein Handelsschiff sollte sich in die Weiten des Alls ohne adäquate Schilde wagen. Dieses Schild mit einer Nennkapazität von %d hat die vordergründige Aufgabe das Schiff vor Asteroidenkollisionen zu schützen.", strength)
    end,

    upgrade_shield2_name = "Schild MkII",
    upgrade_shield2_description = function(strength)
        return f("Die Nennkapazität von %d dieses Schilds für Handelsschiffe bietet einen grundlegenden Schutz gegen angreifende Piraten. Nicht selten hat die Langlebigkeit des Schilds dafür gesorgt, dass Handelsschiffe lange genug ausharren konnten, bis Begleitschiffe den Feind vertreiben konnten.", strength)
    end,

    upgrade_shield3_name = "Schild MkIII",
    upgrade_shield3_description = function(strength)
        return f("Dies ist die höchste Klasse an Schilden, die für Handelsschiffe zugelassen sind und keine erweiterte Zulassung für Kampfschiffe benötigen. Es wird nicht empfohlen diese Schilde für längere Zeit Kampfhandlungen auszusetzen, aber eine Nennkapazität von %d erlaubt die Teilnahme als Unterstützer an kleinen Scharmützeln.", strength)
    end,

    upgrade_hull1_name = "Basis Hülle",
    upgrade_hull1_description = "Hüllen schützen die Besatzung eines Raumschiffs vor den Einflüssen des Alls, wie Strahlung, Sauerstoffmangel, Asteroideneinschlägen oder Laserbeschuss.",

    upgrade_hull2_name = "Plasteel Verstärkung",
    upgrade_hull2_description = function(strength)
        return f("Die Hülle ihres Schiffs wird mit Platten aus Plasteel ausgekleidet und verstärkt. Dadurch verbessern sich die Widerstands der Außenhaut auf %d. Zusätzlich werden die Systeme des Schiffs effektiver vor Schäden geschützt.", strength)
    end,

    upgrade_laserRefit_name = "Laser Konfigurator",
    upgrade_laserRefit_description = "Der Laser Konfigurator kann die Laser eines Schiffs überladen, um verschiedene Effekte zu erzielen. So kann die Reichweite oder der Schadensausstoß verbessert werden. Allerdings operiert der Laser damit außerhalb seiner üblichen Parameter und erhöhter Energieverbrauch und Überhitzung sind übliche Folgen.",
    upgrade_laserRefit_button = "Laser",
    upgrade_laserRefit_info_button = "Information",
    upgrade_laserRefit_info_title = "Information über Laser",
    upgrade_laserRefit_info_intro = function(refitCostPower, refitTime)
        return "Fortschrittliche Steuerelektronik erlaubt es die Laser, selbst im laufenden Betrieb, an Board von Raumschiffen zu konfigurieren. " ..
                "Änderungen können vom Waffenoffizier vorgenommen werden, der zwischen verschiedenen Konfigurationen wählen kann. " ..
                f("Eine Umkonfiguration benötigt %0.0f Einheiten Energie und dauert %0.1f Sekunden. ", refitCostPower, refitTime) ..
                "Der Vorgang kann aber beschleunigt werden, wenn dem Subsystem mehr Energie zur Verfügung gestellt wird.\n\n" ..
                "Es kann zwischen folgenden Voreinstellungen gewählt werden:"
    end,
    upgrade_laserRefit_beam_button = function(i)
        return f("Laser %d", i)
    end,
    upgrade_laserRefit_beam_info_button = "Information",
    upgrade_laserRefit_beam_info_range = function(range, minAngle, maxAngle)
        return f("Der Laser kann Ziele in einem Winkel von  %0.0f bis %0.0f Grad  und einer Entfernung von bis zu  %0.3fu  erfassen.", minAngle, maxAngle, range)
    end,
    upgrade_laserRefit_beam_info_damage = function(damage, shotsPerMinute, damagePerMinute)
        return f("Er feuert %0.1f Schüsse pro Minute, die jeweils  %0.1f  Schaden verursachen können. Der maximale Schaden pro Minute beträgt somit bis zu  %0.1f.", shotsPerMinute, damage, damagePerMinute)
    end,
    upgrade_laserRefit_beam_info_heat = function(minutesToOverHeat)
        return f("Der Laser kann ungekühlt maximal %0.1f Minuten im Dauerbetrieb gefeuert werden bevor er durch Überhitzung Schaden nimmt.", minutesToOverHeat)
    end,
    upgrade_laserRefit_beam_info_energy = function(energyPerMinute)
        return f("Um optimal arbeiten zu können benötigt der Laser pro Minute %0.0f Energie.", energyPerMinute)
    end,
    upgrade_laserRefit_beam_info_disclaimer = "Alle Werte beziehen sich auf ein gesundes und nicht überlastetes Lasersystem.",

    upgrade_laserRefit_beam_info_default_button = "Standard",
    upgrade_laserRefit_beam_info_default_description = "Dies ist die Standardeinstellung aller industriell gefertigten Laser. Sie bieten ein ausgewogenes Verhältnis von Feuerkraft, Feuerrate und Reichweite und sind auf ihren Energieverbrauch und Hitzeabstrahlung optimiert.",
    upgrade_laserRefit_beam_info_range_button = "Sniper",
    upgrade_laserRefit_beam_info_range_description = "Diese Einstellung opfert Feuerrate und flexible Schusswinkel einer höheren Schussweite. Um den Energiestrahl über höhere Distanzen schießen zu können wurde auch der Energiebedarf der Waffe erhöht, was zu einer schnelleren Überhitzung führt.",
    upgrade_laserRefit_beam_info_power_button = "Schaden",
    upgrade_laserRefit_beam_info_power_description = "In dieser Einstellung werden die Laser auf maximale Schadenswirkung hin optimiert. Der Laserstrahl wird mit mehr Energie vorgeladen, was die Feuerrate verringert, aber auch die Schadenswirkung signifikant steigert. Da der Laser außerhalb der Spezifikation betrieben wird, muss mit schneller Überhitzung und einem ineffizienten Energieverbrauch gerechnet werden. Da solch hochenergetischen Laserstrahlen eine höhere Streung besitzen verringert sich die effektive Reichweite leicht.",
    upgrade_laserRefit_beam_info_speed_button = "Feuerrate",
    upgrade_laserRefit_beam_info_speed_description = "Um mehrere schwache Ziele schnell abzuwehren, kann die Schadenswirkung des Lasers geschwächt werden, um die Feuerrate zu erhöhen. Der mögliche Schadensausstoß pro Zeiteinheit bleibt gleich, allerdings erhöht sich auch der Energiebedarf und die Abwärme, da zwischen den Schüssen nicht genügend Zeit bleibt, um die Komponenten zu kühlen.",
    upgrade_laserRefit_beam_info_is_refitting = "wird konfiguriert...",

    upgrade_beam_name = "Beam Emitter",
    upgrade_beam_description = function(storageMalusSize)
        return f("Auf ihrem Schiff kann ein weiterer Laser installiert werden, der das Heck des Schiffs gegen Beschuss verteidigen kann. Um Platz für den Laser zu schaffen werden %d Einheiten des Lagerraums benötigt, aber gerade bei Händlern ist dieser zusätzliche Laser sehr beliebt, da er das Schiff verteidigen kann, während der Sprungantrieb lädt.", storageMalusSize)
    end,
    upgrade_probe_name = "Sonden Lager",
    upgrade_probe_description = function(storageMalusSize, amount)
        return f("Den Laderaum für Sonden zu vergrößern ist ein sehr einfacher Prozess. Es muss lediglich der Lagerraum um %d Einheiten reduziert werden und als Lagerfläche für %d zusätzliche Sonden ausgewiesen werden.", storageMalusSize, amount)
    end,


})