function Initialize()
    _PopulateConnectedDevices()
end

function RefreshStatus()
    local Status = tonumber(SKIN:ReplaceVariables('[&BluetoothDevicesMeasure:BluetoothStatus()]'))
    local OldStatus = tonumber(SKIN:GetVariable('Status'))

    if (OldStatus ~= Status) then
        SKIN:Bang("!SetVariable", "Status", Status)
        SKIN:Bang("!WriteKeyValue", "Variables", "Status", string.format('%s', Status))
    end
end

function Refresh()
    local DevicesString = SKIN:ReplaceVariables('[&BluetoothDevicesMeasure:AvailableDevices()]')
    local OldDevicesString = SKIN:GetVariable('Devices')
    local Status = tonumber(SKIN:GetVariable('Status'))

    if ((OldDevicesString ~= DevicesString) and (DevicesString ~= "") and (Status ~= 0)) then
        SKIN:Bang("!SetVariable", "Devices", DevicesString)
        SKIN:Bang("!WriteKeyValue", "Variables", "Devices", string.format('%s', DevicesString))
        
        _PopulateConnectedDevices()

        local Devices = _DivideDevices(DevicesString)
        local ConnectedDevices = _GetConnectedDevices(Devices)
        
        SKIN:Bang("!SetVariable", "DevicesNumber", #ConnectedDevices)
        SKIN:Bang("!WriteKeyValue", "Variables", "DevicesNumber", string.format('%s', #ConnectedDevices))
        
        _UpdateBatteryTextVisibility(#ConnectedDevices)
    end
end

function _UpdateBatteryTextVisibility(connectedCount)
    if connectedCount == 0 then
        SKIN:Bang("!ShowMeter", "MeterPC_BatteryText")
    else
        SKIN:Bang("!HideMeter", "MeterPC_BatteryText")
    end
    SKIN:Bang("!Update")
    SKIN:Bang("!Redraw")
end

function PageDown()
end

function PageUp()
end

---- [Private functions] ----

function _PopulateConnectedDevices()
    local DevicesStr = SKIN:GetVariable('Devices')
    local Devices = _DivideDevices(DevicesStr)
    local ConnectedDevices = _GetConnectedDevices(Devices)
    
    for i = 1, 3 do
        _ClearDeviceVariables(i)
    end
    
    local connectedCount = #ConnectedDevices
    
    _UpdateBatteryTextVisibility(connectedCount)
    
    if connectedCount == 0 then
        return
    elseif connectedCount == 1 then
        local device = _DivideItems(ConnectedDevices[1])
        _UpdateDeviceVariables(2, device)
    elseif connectedCount >= 2 then
        
        local device1 = _DivideItems(ConnectedDevices[1])
        _UpdateDeviceVariables(1, device1)
        
        local device2 = _DivideItems(ConnectedDevices[2])
        _UpdateDeviceVariables(3, device2)
        
        if connectedCount >= 3 then
            local device3 = _DivideItems(ConnectedDevices[3])
            _UpdateDeviceVariables(2, device3)
        end
    end
end

function _GetConnectedDevices(Devices)
    local connected = {}
    
    for i, deviceStr in ipairs(Devices) do
        local device = _DivideItems(deviceStr)
        if device[4] == "1" then
            table.insert(connected, deviceStr)
        end
    end
    
    return connected
end

function _UpdateDeviceVariables(deviceNumber, device)
    local prefix = "Device" .. deviceNumber
    
    SKIN:Bang("!SetVariable", prefix .. "Name", device[1])
    SKIN:Bang("!SetVariable", prefix .. "Address", device[2])
    SKIN:Bang("!SetVariable", prefix .. "Id", device[3])
    SKIN:Bang("!SetVariable", prefix .. "Connected", device[4])
    SKIN:Bang("!SetVariable", prefix .. "Paired", device[5])
    SKIN:Bang("!SetVariable", prefix .. "CanPair", device[6])
    SKIN:Bang("!SetVariable", prefix .. "MajorCategory", device[7])
    SKIN:Bang("!SetVariable", prefix .. "MinorCategory", device[8])
    SKIN:Bang("!SetVariable", prefix .. "HasBatteryLevel", device[9])
    SKIN:Bang("!SetVariable", prefix .. "Battery", device[10])
    SKIN:Bang("!SetVariable", prefix .. "IsBLE", device[11])
    
    local imageName = _GenerateImageName(device[1], device[7], device[8])
    SKIN:Bang("!SetVariable", prefix .. "ImageName", imageName)
    
    SKIN:Bang("!WriteKeyValue", "Variables", prefix .. "Name", device[1])
    SKIN:Bang("!WriteKeyValue", "Variables", prefix .. "Address", device[2])
    SKIN:Bang("!WriteKeyValue", "Variables", prefix .. "Id", device[3])
    SKIN:Bang("!WriteKeyValue", "Variables", prefix .. "Connected", device[4])
    SKIN:Bang("!WriteKeyValue", "Variables", prefix .. "Paired", device[5])
    SKIN:Bang("!WriteKeyValue", "Variables", "Device" .. deviceNumber .. "CanPair", device[6])
    SKIN:Bang("!WriteKeyValue", "Variables", prefix .. "MajorCategory", device[7])
    SKIN:Bang("!WriteKeyValue", "Variables", prefix .. "MinorCategory", device[8])
    SKIN:Bang("!WriteKeyValue", "Variables", prefix .. "HasBatteryLevel", device[9])
    SKIN:Bang("!WriteKeyValue", "Variables", prefix .. "Battery", device[10])
    SKIN:Bang("!WriteKeyValue", "Variables", prefix .. "IsBLE", device[11])
end

function _GenerateImageName(deviceName, majorCategory, minorCategory)
    local lowerName = string.lower(deviceName)
    
    if lowerName:find("nothing") or lowerName:find("cmf") then
        if lowerName:find("ear") or lowerName:find("bud") or lowerName:find("air") or lowerName:find("dot") then
            return "Nothing_Ear"
        elseif lowerName:find("headphone") or lowerName:find("phone") or lowerName:find("over") then
            return "Nothing_Headphone"
        else
            return "Nothing_Device"
        end
    end
    
    if lowerName:find("xbox") or lowerName:find("x-box") then
        return "Xbox"
    elseif lowerName:find("psp") or lowerName:find("playstation") or lowerName:find("dualsense") or lowerName:find("dualshock") then
        return "PlayStation"
    elseif lowerName:find("switch") or lowerName:find("pro controller") or lowerName:find("joy%-con") then
        return "Nintendo"
    end
    
    if majorCategory == "Audio/Video" then
        if minorCategory == "Audio Video Wearable Headset" or minorCategory:find("Headset") or minorCategory:find("Headphones") then
            if lowerName:find("bud") or lowerName:find("ear") or lowerName:find("airpod") then
                return "Wireless_Earbuds"
            else
                return "Wireless_Headphone"
            end
        end
    elseif majorCategory == "Peripheral" then
        if minorCategory == "Peripheral Gamepad" or minorCategory:find("Gamepad") then
            return "Gamepad"
        elseif minorCategory:find("Keyboard") then
            return "Keyboard"
        elseif minorCategory:find("Mouse") then
            return "Mouse"
        end
    end
    
    return "unknown_device"
end

function _ClearDeviceVariables(deviceNumber)
    local prefix = "Device" .. deviceNumber
    SKIN:Bang("!SetVariable", prefix .. "Name", "")
    SKIN:Bang("!SetVariable", prefix .. "Address", "")
    SKIN:Bang("!SetVariable", prefix .. "Id", "")
    SKIN:Bang("!SetVariable", prefix .. "Connected", "0")
    SKIN:Bang("!SetVariable", prefix .. "Paired", "0")
    SKIN:Bang("!SetVariable", prefix .. "CanPair", "0")
    SKIN:Bang("!SetVariable", prefix .. "MajorCategory", "")
    SKIN:Bang("!SetVariable", prefix .. "MinorCategory", "")
    SKIN:Bang("!SetVariable", prefix .. "HasBatteryLevel", "0")
    SKIN:Bang("!SetVariable", prefix .. "Battery", "0")
    SKIN:Bang("!SetVariable", prefix .. "IsBLE", "0")
    SKIN:Bang("!SetVariable", prefix .. "ImageName", "default")

    SKIN:Bang("!WriteKeyValue", "Variables", prefix .. "Name", "")
    SKIN:Bang("!WriteKeyValue", "Variables", prefix .. "Address", "")
    SKIN:Bang("!WriteKeyValue", "Variables", prefix .. "Id", "")
    SKIN:Bang("!WriteKeyValue", "Variables", prefix .. "Connected", "0")
    SKIN:Bang("!WriteKeyValue", "Variables", prefix .. "Paired", "0")
    SKIN:Bang("!WriteKeyValue", "Variables", prefix .. "CanPair", "0")
    SKIN:Bang("!WriteKeyValue", "Variables", prefix .. "MajorCategory", "")
    SKIN:Bang("!WriteKeyValue", "Variables", prefix .. "MinorCategory", "")
    SKIN:Bang("!WriteKeyValue", "Variables", prefix .. "HasBatteryLevel", "0")
    SKIN:Bang("!WriteKeyValue", "Variables", prefix .. "Battery", "0")
    SKIN:Bang("!WriteKeyValue", "Variables", prefix .. "IsBLE", "0")
end

function _DivideDevices(DevicesStr)
    local Devices = {}
    if DevicesStr and DevicesStr ~= "" then
        for section in DevicesStr:gmatch("[^;]+") do
            table.insert(Devices, section)
        end
    end
    return Devices
end

function _DivideItems(DeviceStr)
    local Device = {}
    if DeviceStr and DeviceStr ~= "" then
        for section in DeviceStr:gmatch("[^|]+") do
            table.insert(Device, section)
        end
    end
    return Device
end