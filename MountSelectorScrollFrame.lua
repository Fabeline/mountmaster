local function createMountSelectorScrollFrame()
    -- Create a scroll frame to holds the mount buttons
    local generalFrame = RuthesMS.frames.generalFrame.frame

    local mountSelectorScrollFrame = CreateFrame("ScrollFrame", "MountSelectorScrollFrame", generalFrame,
        "UIPanelScrollFrameTemplate")
    mountSelectorScrollFrame:SetPoint("TOPLEFT", generalFrame, "TOPLEFT", 10, -95)
    mountSelectorScrollFrame:SetPoint("BOTTOMRIGHT", generalFrame, "BOTTOMRIGHT", -30, 40)
    RuthesMS.frames.mountSelectorScrollFrame.frame = mountSelectorScrollFrame
end

RuthesMS.frames.mountSelectorScrollFrame = {
    frame = nil,
    create = createMountSelectorScrollFrame
}
