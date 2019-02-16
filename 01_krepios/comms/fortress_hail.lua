local t = My.Translator.translate

My = My or {}
My.Comms = My.Comms or {}

My.Comms.FortressHail = {
    initial = function(self, player)
        if player:isDocked(self) then
            return t("fortress_hail_initial_docked")
        else
            return t("generic_comms_station_static")
        end
    end,

    manned = function(self, player)
        if player:isDocked(self) then
            return t("fortress_hail_manned_docked", player:getCallSign())
        else
            return t("fortress_hail_manned", My.Commander:getPerson())
        end
    end,

    defense = function(self, player)
        local msg
        if isString(self.improvementSuccessMessage) then
            msg = self.improvementSuccessMessage
            self.improvementSuccessMessage = nil
        else
            if self:areEnemiesInRange(5000) then
                msg = t("fortress_hail_defense_attacked", distance(self, player) < 10000)
            elseif self:areEnemiesInRange(getLongRangeRadarRange()) then
                msg = t("fortress_hail_defense_enemies_close")
            elseif player:isDocked(self) then
                msg = t("fortress_hail_defense_docked", self:getCallSign(), self:getRepairDocked())
            else
                msg = t("fortress_hail_defense")
            end

            msg = msg .. "\n\n"

            if not My.World.fortress:isImproving() then
                msg = msg .. t("fortress_improvement_hint")
            else
                msg = msg .. t("fortress_improvement_progress", My.World.fortress:getImprovementName())
            end
        end
        return msg
    end,

    victory = function(self, player)
        return t("fortress_hail_victory", player:getCallSign())
    end,

}