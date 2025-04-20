local tabNames = { "General", "Keybinds", "Advanced", "Help" }
local tabs = {}

local function selectTab(index)
    for i, tab in ipairs(tabs) do
        if i == index then
            tab:SetBackdropBorderColor(1, 1, 0, 1) -- yellow border
            tab:Disable()
            if (i == 1) then
                RuthesMS.frames.generalFrame.show()
                RuthesMS.frames.keybindFrame.hide()
                RuthesMS.frames.advancedFrame.hide()
                RuthesMS.frames.helpFrame.hide()
            elseif (i == 2) then
                RuthesMS.frames.generalFrame.hide()
                RuthesMS.frames.keybindFrame.show()
                RuthesMS.frames.advancedFrame.hide()
                RuthesMS.frames.helpFrame.hide()
            elseif (i == 3) then
                RuthesMS.frames.generalFrame.hide()
                RuthesMS.frames.keybindFrame.hide()
                RuthesMS.frames.advancedFrame.show()
                RuthesMS.frames.helpFrame.hide()
            elseif (i == 4) then
                RuthesMS.frames.generalFrame.hide()
                RuthesMS.frames.keybindFrame.hide()
                RuthesMS.frames.advancedFrame.hide()
                RuthesMS.frames.helpFrame.show()
            end
        else
            tab:SetBackdropBorderColor(0.4, 0.4, 0.4, 1)
            tab:Enable()
        end
    end
end

local function createTabs()
    local mountSelectorFrame = RuthesMS.frames.mountSelectorFrame.frame

    for i, name in ipairs(tabNames) do
        local tab = CreateFrame("Button", nil, mountSelectorFrame, "UIPanelButtonTemplate, BackdropTemplate")
        tab:SetSize(100, 24)

        if i == 1 then
            tab:SetPoint("TOPLEFT", mountSelectorFrame, "TOPLEFT", 0, -25)
        else
            tab:SetPoint("LEFT", tabs[i - 1], "RIGHT", -1, 0)
        end

        tab:SetText(name)
        tab:SetScript("OnClick", function()
            selectTab(i)
        end)

        -- Add a backdrop so we can change border color
        tab:SetBackdrop({
            bgFile = "Interface/Tooltips/UI-Tooltip-Background",
            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
            edgeSize = 12,
            insets = { left = 2, right = 2, top = 2, bottom = 2 }
        })
        tab:SetBackdropColor(0.1, 0.1, 0.1, 0.9)
        tab:SetBackdropBorderColor(0.4, 0.4, 0.4, 1)

        tabs[i] = tab
    end

    selectTab(1)
end

local function createMountSelectorFrame()
    -- Create the MountSelectorFrame
    local mountSelectorFrame = CreateFrame("Frame", "MountSelectorFrame", UIParent, "BasicFrameTemplateWithInset")
    mountSelectorFrame:SetSize(400, 500)
    mountSelectorFrame:SetPoint("CENTER", UIParent, "CENTER", -400, 0)
    mountSelectorFrame:Hide()
    RuthesMS.frames.mountSelectorFrame.frame = mountSelectorFrame

    -- Make the frame closeable with ESC
    table.insert(UISpecialFrames, "MountSelectorFrame")

    -- Enable the frame to be movable
    mountSelectorFrame:SetMovable(true)
    mountSelectorFrame:EnableMouse(true)

    -- Create a title for the frame
    mountSelectorFrame.title = mountSelectorFrame:CreateFontString(nil, "OVERLAY")
    mountSelectorFrame.title:SetFontObject("GameFontHighlightMedium")
    mountSelectorFrame.title:SetPoint("TOP", mountSelectorFrame.TitleBg, "TOP", 0, -4.5)
    mountSelectorFrame.title:SetText("Ruthe's Mount Selector")

    -- Make the title bar draggable
    mountSelectorFrame.TitleBg:SetScript("OnMouseDown", function(self, button)
        if button == "LeftButton" then
            mountSelectorFrame:StartMoving()
        end
    end)

    mountSelectorFrame.TitleBg:SetScript("OnMouseUp", function(self)
        mountSelectorFrame:StopMovingOrSizing()
    end)

    createTabs()
    RuthesMS.frames.mountSelectorFrame.frame = mountSelectorFrame
end

RuthesMS.frames.mountSelectorFrame = {
    frame = nil,
    create = createMountSelectorFrame,
    selectTab = selectTab
}
