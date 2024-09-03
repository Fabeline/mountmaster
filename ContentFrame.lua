-- Function to create or refresh the content frame
function createContentFrame()
    -- Recreate the content frame that holds the buttons
    contentFrame = CreateFrame("Frame", "MountSelectorContentFrame", mountSelectorScrollFrame, "BackdropTemplate")
    mountSelectorScrollFrame:SetScrollChild(contentFrame)
    contentFrame:SetSize(mountSelectorScrollFrame:GetWidth(), 2000)
end

function deleteContentFrame()   
    if contentFrame then
        contentFrame:Hide()
        contentFrame:SetParent(nil)
        contentFrame = nil
    end
end