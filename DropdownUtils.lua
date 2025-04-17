local function collectUniqueValues(data, field1, field2)
    local set = {}
    for _, item in ipairs(data) do
        if item[field1] and item[field1] ~= "" then
            local key = string.lower(item[field1])
            set[key] = item[field1]
        end
        if field2 and item[field2] and item[field2] ~= "" then
            local key = string.lower(item[field2])
            set[key] = item[field2]
        end
    end

    local result = {}
    for _, original in pairs(set) do
        table.insert(result, CapitalizeFirstLetter(original))
    end
    table.sort(result)
    return result
end

local function allOptionsAreSelected(selectedOptions, allOptions)
    return #selectedOptions == #allOptions
end

local function toggleOption(selectedTable, option, allOptionsGetter)
    if option == "All" then
        if allOptionsAreSelected(selectedTable, allOptionsGetter()) then
            return {}
        else
            return allOptionsGetter()
        end
    else
        local found = false
        for i, v in ipairs(selectedTable) do
            if v == option then
                table.remove(selectedTable, i)
                found = true
                break
            end
        end
        if not found then
            table.insert(selectedTable, option)
        end
        return selectedTable
    end
end

local function initializeDropdown(self, allGetter, selectedTable, toggleCallback)
    local info = UIDropDownMenu_CreateInfo()
    info.func = function(self)
        toggleCallback(self.value)
        RuthesMS.buttons.mountButtons.reload()
    end

    -- "All" option
    info.text = "All"
    info.value = "All"
    info.checked = allOptionsAreSelected(selectedTable, allGetter())
    UIDropDownMenu_AddButton(info, 1)

    for _, val in ipairs(allGetter()) do
        info.text, info.value = val, val
        info.checked = tContains(selectedTable, val)
        UIDropDownMenu_AddButton(info, 1)
    end
end

RuthesMS.utils.dropdown = {
    collectUniqueValues = collectUniqueValues,
    allOptionsAreSelected = allOptionsAreSelected,
    toggleOption = toggleOption,
    initializeDropdown = initializeDropdown,
}
