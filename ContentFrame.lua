-- Function to create or refresh the content frame
function createContentFrame()
    -- Recreate the content frame that holds the buttons
    contentFrame = CreateFrame("Frame", "MountSelectorContentFrame", mountSelectorScrollFrame, "BackdropTemplate")
    mountSelectorScrollFrame:SetScrollChild(contentFrame)

    -- Set the content frame's width and height
    contentFrame:SetSize(mountSelectorScrollFrame:GetWidth(), 2000)
end

function deleteContentFrame()   
    -- delete contentFrame if it exists
    if contentFrame then
        contentFrame:Hide()
        contentFrame:SetParent(nil)
        contentFrame = nil
    end
end