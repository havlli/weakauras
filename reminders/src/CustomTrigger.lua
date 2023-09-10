function(event, unit)
    if unit == "player" then
        local auraTable = aura_env.auratable;
        for key, auraName in ipairs(auraTable) do
            local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable,
            shouldConsolidate, spellId = UnitBuff("player", auraName, nil, "PLAYER");

            if spellId then
                -- The player has the specified buff
                print("You have the buff: " .. auraName);
                return false;
            end
        end

        return true;
    end
end

