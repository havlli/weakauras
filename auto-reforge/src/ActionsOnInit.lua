print("AutoReforge Loaded...");
aura_env.enchants = MYSTIC_ENCHANTS

if not PoliMysticEnchantingFrameAutoReforgeButton then
    local button = CreateFrame("Button", "PoliMysticEnchantingFrameAutoReforgeButton", EnchantCollection.Slots.ReforgeTab, "UIPanelButtonTemplate")
    button:SetWidth(125)
    button:SetHeight(25)
    button:SetPoint("TOPLEFT", 120, -36)
    button:Disable()
    button:RegisterForClicks("AnyUp")
    button:SetScript("OnClick",
            function(self)
                if self:GetText() == "Auto Reforge" then
                    WeakAuras.ScanEvents("POLI_AUTO_REFORGE_ON")
                    WeakAuras.ScanEvents("POLI_REFORGE_REQUESTED")
                else
                    WeakAuras.ScanEvents("POLI_AUTO_REFORGE_OFF")
                end
            end
    )
    button:SetText("Auto Reforge")

    EnchantCollection.Slots.ReforgeTab.Button1:HookScript("OnDisable",
            function()
                print("OnDisable")
                PoliMysticEnchantingFrameAutoReforgeButton:Disable()
                WeakAuras.ScanEvents("POLI_REFORGE_ITEM_UPDATE")
            end
    )

    EnchantCollection.Slots.ReforgeTab.Button1:HookScript("OnEnable",
            function()
                print("OnEnable")
                PoliMysticEnchantingFrameAutoReforgeButton:Enable()
                WeakAuras.ScanEvents("POLI_REFORGE_ITEM_UPDATE")
            end
    )


    EnchantCollection.Slots.ReforgeTab.Button1:HookScript("OnShow",
            function()
                print("OnShow");
                if string.find(EnchantCollection.Slots.ReforgeTab.Button1:GetText(), "Reforge") then
                    if EnchantCollection.Slots.ReforgeTab.Button1:IsEnabled() then
                        print("Enabled");
                    else
                        print("Disabled");
                    end
                end
                WeakAuras.ScanEvents("POLI_LOAD_MYSTIC_ENCHANTS");
            end
    )
end

local c = aura_env.config

aura_env.stopIfNoRunes = c.stopIfNoRunes

aura_env.stopOnQuality = c.stopOnQuality
aura_env.qualityDenyList = {
    [2] = c.uncommonQ,
    [3] = c.rareQ,
    [4] = c.epicQ,
    [5] = c.legendaryQ
}

aura_env.stopForShop = c.stopForShop
if c.stopForShop then
    local enchantsOfInterest = {}
    for _, list in ipairs(c.shoppingLists) do
        for _, enchantName in pairs(list) do
            if _ ~= "name" and enchantName ~= "" then
                local n = enchantName:lower()
                enchantsOfInterest[select(3, n:find("%[(.-)%]")) or select(3, n:find("(.+)"))] = true
            end
        end
    end
    aura_env.enchantsOfInterest = enchantsOfInterest
end

aura_env.stopOnUnknown = c.stopOnUnknown
aura_env.unknownDenyList = {
    [2] = c.uncommonU,
    [3] = c.rareU,
    [4] = c.epicU,
    [5] = c.legendaryU
}

aura_env.idToQuality = {
    [2] = "|cff1eff00Uncommon|r",
    [3] = "|cff0070ddRare|r",
    [4] = "|cffa335eeEpic|r",
    [5] = "|cffff8000Legendary|r"
}


function aura_env.configConditionMet(currentEnchant, enchantID)
    return aura_env.stopIfNoRunes and GetItemCount(98462) <= 0
            or aura_env.stopOnQuality and aura_env.qualityDenyList[currentEnchant.quality]
            or aura_env.stopForShop and aura_env.enchantsOfInterest[currentEnchant.spellName:lower()]
            or aura_env.stopOnUnknown and not IsReforgeEnchantmentKnown(enchantID)
            and aura_env.unknownDenyList[currentEnchant.quality]
end

-- return true if another insignia is found
function aura_env.findNextInsignia()
    local bagID, slotIndex = aura_env.bagID, aura_env.slotIndex
    for i=bagID, 4 do
        for j=slotIndex + 1, GetContainerNumSlots(i) do
            local item = select(7, GetContainerItemInfo(i, j))
            if item and item:find("Insignia of the") then
                --print("next: "..tostring(i).." "..tostring(j))
                aura_env.bagID = i
                aura_env.slotIndex = j
                return true
            end
        end
        slotIndex = 0
    end
end
