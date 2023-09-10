local options = aura_env.config;

aura_env.auratable = aura_env.constructAuraTable();

function aura_env.validateAuras()
    local auratable = aura_env.auratable;
    for aura in auratable do
        print(aura);
    end
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