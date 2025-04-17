local function createContentFrame()
    local contentFrame = CreateFrame("Frame", "MountSelectorContentFrame", mountSelectorScrollFrame,
        "BackdropTemplate")
    mountSelectorScrollFrame:SetScrollChild(contentFrame)
    contentFrame:SetSize(mountSelectorScrollFrame:GetWidth(), 2000)
    RuthesMS.frames.contentFrame.frame = contentFrame
end

local function deleteContentFrame()
    local contentFrame = RuthesMS.frames.contentFrame.frame
    if contentFrame then
        contentFrame:Hide()
        contentFrame:SetParent(nil)
        RuthesMS.frames.contentFrame.frame = nil
    end
end

RuthesMS.frames.contentFrame = {
    frame = nil,
    create = createContentFrame,
    delete = deleteContentFrame,
}
