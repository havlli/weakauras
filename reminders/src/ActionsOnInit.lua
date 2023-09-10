local options = aura_env.config;

aura_env.REAuraCalls = 0;
aura_env.RELastExecutionTime = 0;
aura_env.REExecutionCooldown = 2;
aura_env.auratable = aura_env.constructAuraTable();

function aura_env.constructAuraTable()
    local hasteAuras = options.hasteauras;
    local delimiter = "[, ]";
    local elements = {};

    for element in string.gmatch(hasteAuras, "([^" .. delimiter .. "]+)") do
        table.insert(elements, element);
    end

    return elements;
end

function aura_env.throttleExecution()
    local currentTime = GetTime();
    local lastExecutionTime = aura_env.RELastExecutionTime;
    local executionCooldown = aura_env.REExecutionCooldown;

    if currentTime - lastExecutionTime >= executionCooldown then
        aura_env.RELastExecutionTime = currentTime;

        return true;
    end

    return false;
end