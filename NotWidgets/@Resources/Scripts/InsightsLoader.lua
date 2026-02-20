function Initialize()

    local filePath = SKIN:GetVariable('@') .. 'Insights.txt'
    local maxFontSize = tonumber(SKIN:GetVariable('MaxFontSize')) or 18
    local minFontSize = tonumber(SKIN:GetVariable('MinFontSize')) or 8
    local maxWidth = tonumber(SKIN:GetVariable('TextZoneWidth'))
    local maxHeight = tonumber(SKIN:GetVariable('TextZoneHeight'))
    
    local dayOfYear = os.date('*t').yday
    
    local file = io.open(filePath, 'r')
    if not file then
        SKIN:Bang('!SetOption', 'InsightLine1', 'Text', 'File missing')
        return
    end
    
    local content = file:read('*all')
    file:close()
    
    local lines = {}
    for line in content:gmatch('[^\r\n]+') do
        table.insert(lines, line)
    end
    
    local selectedText = lines[dayOfYear] or lines[1] or "No insight."

    local currentSize = maxFontSize
    local finalSize = minFontSize 

    local widthFactor = 0.6  
    local heightFactor = 1.65 

    while currentSize >= minFontSize do
        local charWidth = currentSize * widthFactor
        local charsPerLine = math.max(1, math.floor(maxWidth / charWidth))
        local neededLines = math.ceil(#selectedText / charsPerLine)
        local neededHeight = neededLines * (currentSize * heightFactor)
        
        if neededHeight <= maxHeight then
            finalSize = currentSize
            break
        end
        
        currentSize = currentSize - 1
    end

    -- 4. Apply Changes
    SKIN:Bang('!SetOption', 'InsightLine1', 'Text', selectedText)
    SKIN:Bang('!SetOption', 'InsightLine1', 'FontSize', finalSize)
    -- Apply same size to other lines if they share the style
    SKIN:Bang('!SetOption', 'InsightLine2', 'FontSize', finalSize)
    SKIN:Bang('!SetOption', 'InsightLine3', 'FontSize', finalSize)
    
    SKIN:Bang('!UpdateMeasureGroup', 'TextGroup')
    SKIN:Bang('!Redraw')
end

function HandleClick(x, y) end