function(event, unit)
    local auracalls = aura_env.REAuraCalls;
    print(auracalls);
    aura_env.REAuraCalls = auracalls + 1;

    if unit == "player" then
        local auraTable = aura_env.auratable;
        for key, auraName in ipairs(auraTable) do
            local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable,
            shouldConsolidate, spellId = UnitBuff("player", auraName, nil, "PLAYER");

            if spellId then
                return false;
            end
        end
        return true;
    end
end

function(event, unit)
    local throttleExecution = aura_env.throttleExecution();
    if throttleExecution then
        print("executing");
    else
        print("not-executing");
    end
end

