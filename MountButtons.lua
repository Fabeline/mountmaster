local lineheight = 37

local function createMountButtons()
    ToggleCollectionsJournal(1)
    ToggleCollectionsJournal(1)

    RuthesMS.frames.contentFrame.delete()
    RuthesMS.frames.contentFrame.create()
    local contentFrame = RuthesMS.frames.contentFrame.frame

    for i, mount in ipairs(RuthesMS.state.currentMounts) do
        local mountData = mount
        local mountID = mountData.id

        if not contentFrame then
            error("contentFrame is nil. Cannot create texture.")
        end

        local mountIcon = contentFrame:CreateTexture(nil, "ARTWORK")
        mountIcon:SetSize(32, 32)
        mountIcon:SetPoint("TOPLEFT", contentFrame, "TOPLEFT", 35, -(i - 1) * lineheight)
        mountIcon:SetTexture(mountData.icon)

        local iconButton = CreateFrame("Button", nil, contentFrame)
        iconButton:SetAllPoints(mountIcon)
        iconButton:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD")
        iconButton:SetPushedTexture("Interface\\Buttons\\UI-Quickslot-Depress")

        local animGroup = iconButton:CreateAnimationGroup()
        local scaleUp = animGroup:CreateAnimation("Scale")
        scaleUp:SetScale(1.2, 1.2)
        scaleUp:SetDuration(0.1)
        scaleUp:SetOrder(1)

        local scaleDown = animGroup:CreateAnimation("Scale")
        scaleDown:SetScale(0.83, 0.83)
        scaleDown:SetDuration(0.1)
        scaleDown:SetOrder(2)

        iconButton:SetScript("OnClick", function()
            animGroup:Play()
            C_MountJournal.SummonByID(mountID)
        end)

        local mountText = contentFrame:CreateFontString(nil, "OVERLAY")
        mountText:SetFontObject("GameFontNormal")
        mountText:SetPoint("LEFT", mountIcon, "RIGHT", 10, 0)
        mountText:SetText(mountData.name)

        -- Disabling
        enableCheckbox = CreateFrame("CheckButton", "enableCheckbox", contentFrame,
            "ChatConfigCheckButtonTemplate")
        enableCheckbox:SetPoint("TOPLEFT", contentFrame, "TOPLEFT", 7, -(i - 1) * lineheight)
        -- Subtracting some pixels from the right hit rect to avoid overlap with the favorite button
        enableCheckbox:SetHitRectInsets(0, 5, 0, 0)
        enableCheckbox:SetScript("OnClick", function(self)
            local isEnabled = self:GetChecked()
            RuthesMS.settings.disabledMounts[mountID] = not isEnabled
            RuthesMS.db.saveDisabledMounts(RuthesMS.settings.disabledMounts)
            RuthesMS.buttons.mountButtons.reload()
        end)
        enableCheckbox:SetChecked(not RuthesMS.settings.disabledMounts[mountID])

        -- Create a clickable button for the favorite icon
        local favoriteButton = CreateFrame("Button", nil, contentFrame)
        favoriteButton:SetSize(24, 24)
        favoriteButton:SetPoint("LEFT", mountText, "RIGHT", 2, 0)

        -- Add the texture to the button
        local favoriteIcon = favoriteButton:CreateTexture(nil, "OVERLAY")
        favoriteIcon:SetAllPoints(favoriteButton)
        favoriteIcon:SetTexture("Interface\\COMMON\\FavoritesIcon")

        -- Set opacity based on Blizzard favorite status
        if mount.isFavorite then
            favoriteIcon:SetVertexColor(1, 1, 1, 1)
        else
            favoriteIcon:SetVertexColor(1, 1, 1, 0.2)
        end

        -- Make the icon clickable to open the mount in the journal
        favoriteButton:SetScript("OnClick", function()
            local mountIDs = C_MountJournal.GetMountIDs()
            for _, id in ipairs(mountIDs) do
                if id == mountID then
                    MountJournal.selectedMountID = id
                    if MountJournal.ScrollBox then
                        MountJournal.ScrollBox:ScrollToElementDataByPredicate(function(data)
                            return data and data.mountID == id
                        end, ScrollBoxConstants.AlignCenter)
                    end
                    break
                end
            end


            local isMountJournalOpen = CollectionsJournal and CollectionsJournal:IsShown() and
                PanelTemplates_GetSelectedTab(CollectionsJournal) == 1
            if not isMountJournalOpen then
                ToggleCollectionsJournal(1)
            else
                ToggleCollectionsJournal(1)
                ToggleCollectionsJournal(1)
            end
        end)

    end
end

local function ensureMountJournalReady(callback)
    local function proceed()
        local frame = CreateFrame("Frame")

        local done = false
        local function safeCallback()
            if not done then
                done = true
                frame:UnregisterAllEvents()
                callback()
            end
        end

        -- Check if MountJournalEnhanced is already loaded
        if C_AddOns.IsAddOnLoaded("MountJournalEnhanced") then
            C_Timer.After(0.1, safeCallback)
        else
            frame:RegisterEvent("ADDON_LOADED")
            C_Timer.After(1, safeCallback) -- fallback if the addon never loads
            frame:SetScript("OnEvent", function(_, _, arg1)
                if arg1 == "MountJournalEnhanced" then
                    C_Timer.After(0.1, safeCallback)
                end
            end)
        end
    end

    proceed()
end


local function reload()
    ensureMountJournalReady(function()
        RuthesMS.utils.mount.reloadMounts()
        createMountButtons()
    end)
end

RuthesMS.buttons.mountButtons = {
    create = createMountButtons,
    reload = reload,
    lineHeight = lineheight,
}
