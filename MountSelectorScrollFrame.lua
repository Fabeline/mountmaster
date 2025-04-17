local function createMountSelectorScrollFrame()
    -- Create a scroll frame to holds the mount buttons
    local mountSelectorFrame = RuthesMS.frames.mountSelectorFrame.frame
    local mountSelectorScrollFrame = CreateFrame("ScrollFrame", "MountSelectorScrollFrame", mountSelectorFrame,
        "UIPanelScrollFrameTemplate")
    mountSelectorScrollFrame:SetPoint("TOPLEFT", mountSelectorFrame, "TOPLEFT", 10, -130)
    mountSelectorScrollFrame:SetPoint("BOTTOMRIGHT", mountSelectorFrame, "BOTTOMRIGHT", -30, 40)
    RuthesMS.frames.mountSelectorScrollFrame.frame = mountSelectorScrollFrame
end

RuthesMS.frames.mountSelectorScrollFrame = {
    frame = nil,
    create = createMountSelectorScrollFrame
}
