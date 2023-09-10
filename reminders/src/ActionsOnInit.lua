local options = aura_env.config;

aura_env.auratable = aura_env.constructAuraTable();

function aura_env.validateAuras(auratable)
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

function aura_env.constructAuraTable()
    local hasteAuras = options.hasteauras;
    local delimiter = "[, ]";
    local elements = {};

    for element in string.gmatch(hasteAuras, "([^" .. delimiter .. "]+)") do
        table.insert(elements, element);
    end

    return elements;
end