function Initialize()
    ZONE_LEFT = 1
    ZONE_CENTER = 2
    ZONE_RIGHT = 3
    ZONE_BOTTOM = 4
    
    COVER_SIZE = tonumber(SKIN:GetVariable('CoverSize'))
    PADDING = tonumber(SKIN:GetVariable('Padding'))
    SMALL_MARGIN = tonumber(SKIN:GetVariable('SmallCoverMargin'))
    
    PANEL_VISIBLE = false
    CURRENT_OFFSET = tonumber(SKIN:GetVariable('CoverOffset')) or 0
    TARGET_OFFSET = CURRENT_OFFSET
    TINT_ACTIVE = false

    FADE_STEPS = 10
    DARK_TINT = "150,150,150,255"
    NORMAL_TINT = "255,255,255,255"
    CURRENT_TINT = NORMAL_TINT
    FADE_PROGRESS = 0

    ICON_VISIBLE = false
    ICON_FADE_STEPS = 10
    ICON_FADE_PROGRESS = 0
    CURRENT_ICON = ""
    SMALL_ICON = ""
    PLAYER_STATE = 0
end

function ApplyTintEffect()
    SKIN:Bang('!CommandMeasure', 'MeasureTimer', 'Stop 1')
    SKIN:Bang('!CommandMeasure', 'MeasureIconTimer', 'Stop 1')
    
    if PLAYER_STATE == 1 then
        CURRENT_ICON = "FullSizeIconStop"
        SMALL_ICON = "SmallIconStop"
    else
        CURRENT_ICON = "FullSizeIconPlay"
        SMALL_ICON = "SmallIconPlay"
    end
    
    ICON_VISIBLE = true
    ICON_FADE_PROGRESS = 0
    
    if PANEL_VISIBLE then
        SKIN:Bang('!SetOption', SMALL_ICON, 'ImageTint', '255,255,255,255')
        SKIN:Bang('!ShowMeter', SMALL_ICON)
    else
        SKIN:Bang('!SetOption', CURRENT_ICON, 'ImageTint', '255,255,255,255')
        SKIN:Bang('!ShowMeter', CURRENT_ICON)
    end
    
    SKIN:Bang('!UpdateMeter', CURRENT_ICON)
    SKIN:Bang('!UpdateMeter', SMALL_ICON)
    SKIN:Bang('!Redraw')
    
    SKIN:Bang('!CommandMeasure', 'MeasureIconTimer', 'Execute 1')
    CURRENT_TINT = DARK_TINT
    FADE_PROGRESS = 0
    UpdateCoverTint()
    SKIN:Bang('!CommandMeasure', 'MeasureTimer', 'Execute 1')
end

function FadeIconStep()
    if ICON_FADE_PROGRESS < ICON_FADE_STEPS then
        ICON_FADE_PROGRESS = ICON_FADE_PROGRESS + 1
        local opacity = 255 - (255 * (ICON_FADE_PROGRESS / ICON_FADE_STEPS))
        SKIN:Bang('!SetOption', CURRENT_ICON, 'ImageTint', '255,255,255,'..math.floor(opacity))
        SKIN:Bang('!SetOption', SMALL_ICON, 'ImageTint', '255,255,255,'..math.floor(opacity))
        SKIN:Bang('!UpdateMeter', CURRENT_ICON)
        SKIN:Bang('!UpdateMeter', SMALL_ICON)
        SKIN:Bang('!Redraw')
    else
        SKIN:Bang('!HideMeter', CURRENT_ICON)
        SKIN:Bang('!HideMeter', SMALL_ICON)
        SKIN:Bang('!Redraw')
        ICON_VISIBLE = false
    end
end

function FadeToNormalStep()
    if FADE_PROGRESS < FADE_STEPS then
        FADE_PROGRESS = FADE_PROGRESS + 1
        local progressRatio = FADE_PROGRESS / FADE_STEPS
        local r = 100 + (255 - 100) * progressRatio
        local g = 100 + (255 - 100) * progressRatio
        local b = 100 + (255 - 100) * progressRatio
        CURRENT_TINT = math.floor(r)..","..math.floor(g)..","..math.floor(b)..",255"
        UpdateCoverTint()
    else
        SKIN:Bang('!CommandMeasure', 'MeasureTimer', 'Stop 1')
        CURRENT_TINT = NORMAL_TINT
        UpdateCoverTint()
    end
end

function UpdateCoverTint()
    SKIN:Bang('!SetOption', 'FullSizeCover', 'ImageTint', CURRENT_TINT)
    SKIN:Bang('!SetOption', 'SmallCover', 'ImageTint', CURRENT_TINT)
    SKIN:Bang('!UpdateMeter', 'FullSizeCover')
    SKIN:Bang('!UpdateMeter', 'SmallCover')
    SKIN:Bang('!Redraw')
end

function Update()
    PLAYER_STATE = tonumber(SKIN:GetVariable('PlayerState')) or 0
    if math.abs(CURRENT_OFFSET - TARGET_OFFSET) > 0.1 then
        CURRENT_OFFSET = CURRENT_OFFSET + (TARGET_OFFSET - CURRENT_OFFSET) / tonumber(SKIN:GetVariable('AnimationSpeed'))
        SKIN:Bang('!SetVariable', 'CoverOffset', CURRENT_OFFSET)
        SKIN:Bang('!UpdateMeterGroup', 'CoverGroup')
        SKIN:Bang('!Redraw')
    end
end

function LeftHover()
    TARGET_OFFSET = tonumber(SKIN:GetVariable('HoverOffset'))
end

function RightHover()
    TARGET_OFFSET = -tonumber(SKIN:GetVariable('HoverOffset'))
end

function ResetHover()
    TARGET_OFFSET = 0
end

function HandleClick(x, y)
    local totalSize = COVER_SIZE + PADDING*2
    local relX = x / totalSize
    local relY = y / totalSize
    
    local zone
    if relY > 0.85 then
        zone = ZONE_BOTTOM
    elseif relX < 0.25 then
        zone = ZONE_LEFT
    elseif relX > 0.75 then
        zone = ZONE_RIGHT
    else
        zone = ZONE_CENTER
    end
    
    if zone == ZONE_LEFT then
        SKIN:Bang('!CommandMeasure', 'MeasurePlayer', 'Previous')
    elseif zone == ZONE_RIGHT then
        SKIN:Bang('!CommandMeasure', 'MeasurePlayer', 'Next')
    elseif zone == ZONE_CENTER then
        SKIN:Bang('!CommandMeasure', 'MeasurePlayer', 'PlayPause')
        ApplyTintEffect()
    elseif zone == ZONE_BOTTOM then
        ToggleInfoDisplay()
    end
    
    SKIN:Bang('!Update')
    SKIN:Bang('!Redraw')
end

function ToggleInfoDisplay()
    PANEL_VISIBLE = not PANEL_VISIBLE
    
    if ICON_VISIBLE then
        SKIN:Bang('!CommandMeasure', 'MeasureIconTimer', 'Stop 1')
        SKIN:Bang('!HideMeter', CURRENT_ICON)
        SKIN:Bang('!HideMeter', SMALL_ICON)
        ICON_VISIBLE = false
    end
    
    if PANEL_VISIBLE then
        SKIN:Bang('!HideMeterGroup', 'FullCover')
        SKIN:Bang('!ShowMeterGroup', 'SmallCover')
        SKIN:Bang('!ShowMeterGroup', 'InfoElements')
    else
        SKIN:Bang('!ShowMeterGroup', 'FullCover')
        SKIN:Bang('!HideMeterGroup', 'SmallCover')
        SKIN:Bang('!HideMeterGroup', 'InfoElements')
    end
    
    SKIN:Bang('!Update')
    SKIN:Bang('!Redraw')
end