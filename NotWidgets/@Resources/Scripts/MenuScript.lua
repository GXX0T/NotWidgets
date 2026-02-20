local categories = {
    { name = 'Battery', folder = 'Battery', skins = {
        { label = 'Multiple Dark',  variant = 'Dark',  sub = '', ini = 'Multiple_Dark.ini' },
        { label = 'Multiple Light', variant = 'Light', sub = '', ini = 'Multiple_Light.ini' },
    }},
    { name = 'Clock', folder = 'Clock', skins = {
        { label = 'Bold Dark',      variant = 'Dark',  sub = 'Analogue\\Bold',  ini = 'Bold_Dark.ini' },
        { label = 'Bold Light',     variant = 'Light', sub = 'Analogue\\Bold',  ini = 'Bold_light.ini' },
        { label = 'Scale Dark',     variant = 'Dark',  sub = 'Analogue\\Scale', ini = 'Scale_Dark.ini' },
        { label = 'Scale Light',    variant = 'Light', sub = 'Analogue\\Scale', ini = 'Scale_Light.ini' },
        { label = 'Digital 1x2 D',  variant = 'Dark',  sub = 'Digital\\1x2',   ini = 'Digital_1x2_Dark.ini' },
        { label = 'Digital 1x2 L',  variant = 'Light', sub = 'Digital\\1x2',   ini = 'Digital_1x2_Light.ini' },
        { label = 'Digital 2x1 D',  variant = 'Dark',  sub = 'Digital\\2x1',   ini = 'Digital_2x1_Dark.ini' },
        { label = 'Digital 2x1 L',  variant = 'Light', sub = 'Digital\\2x1',   ini = 'Digital_2x1_Light.ini' },
        { label = 'LockScreen V1',  variant = '',       sub = 'LockScreen',     ini = 'Vol_1.ini' },
        { label = 'LockScreen V2',  variant = '',       sub = 'LockScreen',     ini = 'Vol_2.ini' },
    }},
    { name = 'Date', folder = 'Date', skins = {
        { label = 'Date Dark',  variant = 'Dark',  sub = '', ini = 'Date_Dark.ini' },
        { label = 'Date Light', variant = 'Light', sub = '', ini = 'Date_Light.ini' },
    }},
    { name = 'Insights', folder = 'Insights', skins = {
        { label = 'Insights Light', variant = 'Light', sub = '', ini = 'Insights_Light.ini' },
        { label = 'Insights Dark',  variant = 'Dark',  sub = '', ini = 'Insights_Dark.ini' },
    }},
    { name = 'Monitor', folder = 'Monitor', skins = {
        { label = 'Perf Dark',  variant = 'Dark',  sub = '', ini = 'Perfomance_Dark.ini' },
        { label = 'Perf Light', variant = 'Light', sub = '', ini = 'Perfomance_Light.ini' },
    }},
    { name = 'Music', folder = 'Music', skins = {
        { label = 'Music Dark',  variant = 'Dark',  sub = '', ini = 'MusicPlayer_Dark.ini' },
        { label = 'Music Light', variant = 'Light', sub = '', ini = 'MusicPlayer_Light.ini' },
    }},
    { name = 'Photos', folder = 'Photos', skins = {
        { label = 'Circle 2x2 D', variant = 'Dark',  sub = 'Circle\\2x2', ini = 'Photo_Circle_2x2_Dark.ini' },
        { label = 'Circle 2x2 L', variant = 'Light', sub = 'Circle\\2x2', ini = 'Photo_Circle_2x2_Light.ini' },
        { label = 'Circle 2x4 D', variant = 'Dark',  sub = 'Circle\\2x4', ini = 'Photo_Circle_2x4_Dark.ini' },
        { label = 'Circle 2x4 L', variant = 'Light', sub = 'Circle\\2x4', ini = 'Photo_Circle_2x4_Light.ini' },
        { label = 'Circle 4x2 D', variant = 'Dark',  sub = 'Circle\\4x2', ini = 'Photo_Circle_4x2_Dark.ini' },
        { label = 'Circle 4x2 L', variant = 'Light', sub = 'Circle\\4x2', ini = 'Photo_Circle_4x2_Light.ini' },
        { label = 'Square 2x2 D', variant = 'Dark',  sub = 'Square\\2x2', ini = 'Photo_Square_2x2_Dark.ini' },
        { label = 'Square 2x2 L', variant = 'Light', sub = 'Square\\2x2', ini = 'Photo_Square_2x2_Light.ini' },
        { label = 'Square 2x4 D', variant = 'Dark',  sub = 'Square\\2x4', ini = 'Photo_Square_2x4_Dark.ini' },
        { label = 'Square 2x4 L', variant = 'Light', sub = 'Square\\2x4', ini = 'Photo_Square_2x4_Light.ini' },
        { label = 'Square 4x2 D', variant = 'Dark',  sub = 'Square\\4x2', ini = 'Photo_Square_4x2_Dark.ini' },
        { label = 'Square 4x2 L', variant = 'Light', sub = 'Square\\4x2', ini = 'Photo_Square_4x2_Light.ini' },
        { label = 'Square 4x4 D', variant = 'Dark',  sub = 'Square\\4x4', ini = 'Photo_Square_4x4_Dark.ini' },
        { label = 'Square 4x4 L', variant = 'Light', sub = 'Square\\4x4', ini = 'Photo_Square_4x4_Light.ini' },
    }},
}

local SLOTS       = 15
local COLS        = 5
local TILE_SIZE   = 160
local STROKE_W    = 4

local COL_GAP     = 20
local ROW_GAP     = 40

local START_X     = 20
local START_Y     = 80
local TEXT_OFFSET = 20

local BG_DARK      = {27,  28,  29}
local BG_SUB_DARK  = {48, 48, 48}
local BG_LIGHT     = {241, 241, 241}
local BG_SUB_LIGHT = {255, 255, 255}

local C_TILE_DARK     = "48,48,48"
local C_STROKE_DARK   = "48,48,48"
local TXT_DARK        = "241,241,241"
local SUB_DARK        = "150,150,150"
local HOVER_DARK      = "241,241,241"

local C_TILE_LIGHT    = "255,255,255"
local C_STROKE_LIGHT  = "255,255,255"
local TXT_LIGHT       = "21,21,21"
local SUB_LIGHT       = "100,100,100"
local HOVER_LIGHT     = "50,50,50"

local ANIM_TICKS = 10

local view         = 'categories'
local catIdx       = 0
local pageFirst    = 1
local _dotState    = {}
local currentTheme = 'Dark'

local anim = {
    active   = false,
    fromR=27, fromG=28, fromB=29,
    toR=27,   toG=28,   toB=29,
    tick     = 0,
    duration = ANIM_TICKS,
}

local function s(meter, key, val)
    SKIN:Bang('!SetOption', meter, key, tostring(val))
end

local function hideAllTiles()
    for i = 1, SLOTS do
        s('Tile'..i..'BG',     'Hidden', '1')
        s('Tile'..i..'Border', 'Hidden', '1')
        s('Tile'..i..'Img',    'Hidden', '1')
        s('Tile'..i..'Txt',    'Hidden', '1')
    end
end

local function flush()
    SKIN:Bang('!UpdateMeter', '*')
    SKIN:Bang('!Redraw')
end

local function applyBG(r, g, b)
    local cs = math.floor(r)..','..math.floor(g)..','..math.floor(b)
    s('BG', 'Shape',
        'Rectangle 0,0,'..SKIN:GetVariable('MenuWidth')..','
        ..SKIN:GetVariable('MenuHeight')..',#CR#'
        ..' | Fill Color '..cs..' | StrokeWidth 0')
end

local function ease(t)
    t = math.max(0, math.min(1, t))
    return t * t * (3 - 2 * t)
end

local function fadeToColor(target)
    if anim.active then
        local t = ease(anim.tick / anim.duration)
        anim.fromR = anim.fromR + (anim.toR - anim.fromR) * t
        anim.fromG = anim.fromG + (anim.toG - anim.fromG) * t
        anim.fromB = anim.fromB + (anim.toB - anim.fromB) * t
    else
        anim.fromR, anim.fromG, anim.fromB = anim.toR, anim.toG, anim.toB
    end
    anim.toR, anim.toG, anim.toB = target[1], target[2], target[3]
    anim.tick   = 0
    anim.active = true
end

local function setBGInstant(colorTable)
    anim.fromR, anim.fromG, anim.fromB = colorTable[1], colorTable[2], colorTable[3]
    anim.toR,   anim.toG,   anim.toB   = colorTable[1], colorTable[2], colorTable[3]
    anim.tick   = 0
    anim.active = false
    applyBG(colorTable[1], colorTable[2], colorTable[3])
end

local function updateTextColors()
    local color = currentTheme == 'Dark' and TXT_DARK or TXT_LIGHT
    for i = 1, SLOTS do
        s('Tile'..i..'Txt', 'FontColor', color)
    end
end

local function getRootConfig()
    local rc = SKIN:GetVariable('ROOTCONFIG') or ''
    if rc ~= '' then return rc end
    local cfg = SKIN:GetVariable('CONFIG') or ''
    return cfg:match('^(.+)\\[^\\]+$') or cfg
end

local function buildConfig(ci, si)
    local cat  = categories[ci]
    local sk   = cat.skins[si]
    local root = getRootConfig()
    local cfg
    if sk.sub and sk.sub ~= '' then
        cfg = root..'\\'..cat.folder..'\\'..sk.sub
    else
        cfg = root..'\\'..cat.folder
    end
    return cfg, sk.ini
end

local function isVisible(variant)
    if variant == '' then return true end
    if currentTheme == 'Dark'  and variant == 'Dark'  then return true end
    if currentTheme == 'Light' and variant == 'Light' then return true end
    return false
end

local function cleanLabel(label)
    label = label:gsub('%s+Dark$',  '')
    label = label:gsub('%s+Light$', '')
    label = label:gsub('%s+D$',     '')
    label = label:gsub('%s+L$',     '')
    return label
end

function Update()
    if not anim.active then return end

    anim.tick = anim.tick + 1
    local t   = ease(anim.tick / anim.duration)
    local r   = anim.fromR + (anim.toR - anim.fromR) * t
    local g   = anim.fromG + (anim.toG - anim.fromG) * t
    local b   = anim.fromB + (anim.toB - anim.fromB) * t

    applyBG(r, g, b)
    SKIN:Bang('!UpdateMeter', 'BG')
    SKIN:Bang('!Redraw')

    if anim.tick >= anim.duration then
        anim.active = false
        anim.fromR, anim.fromG, anim.fromB = anim.toR, anim.toG, anim.toB
    end
end


local function renderCategoryGrid()
    hideAllTiles()
    local slot         = 0
    local visibleIndex = 0

    for i = 1, #categories do
        local cat = categories[i]
        visibleIndex = visibleIndex + 1

        if visibleIndex >= pageFirst then
            slot = slot + 1
            if slot > SLOTS then break end

            local col = (slot - 1) % COLS
            local row = math.floor((slot - 1) / COLS)

            local x = START_X + col * (TILE_SIZE + COL_GAP)
            local y = START_Y + row * (TILE_SIZE + TEXT_OFFSET + ROW_GAP)

            local cTile   = currentTheme == 'Dark' and C_TILE_DARK  or C_TILE_LIGHT
            local cStroke = currentTheme == 'Dark' and C_STROKE_DARK or C_STROKE_LIGHT

            local fillStr = string.format(
                "Rectangle %d,%d,%d,%d,15 | Fill Color %s | StrokeWidth 0",
                x, y, TILE_SIZE, TILE_SIZE, cTile)
            s('Tile'..slot..'BG', 'Shape', fillStr)
            s('Tile'..slot..'BG', 'LeftMouseUpAction',
                '[!CommandMeasure Script "SelectCategory('..i..')"]')
            s('Tile'..slot..'BG', 'Hidden', '0')

            local cPath = SKIN:GetVariable('CategoryPath')
            s('Tile'..slot..'Img', 'ImageName',
                cPath..cat.name..'_'..currentTheme..'.png')
            s('Tile'..slot..'Img', 'X', x)
            s('Tile'..slot..'Img', 'Y', y)
            s('Tile'..slot..'Img', 'W', TILE_SIZE)
            s('Tile'..slot..'Img', 'H', TILE_SIZE)
            s('Tile'..slot..'Img', 'Hidden', '0')

            local inset     = STROKE_W / 2
            local borderStr = string.format(
                "Rectangle %d,%d,%d,%d,15 | Fill Color 0,0,0,0 | StrokeWidth %d | Stroke Color %s",
                x+inset, y+inset,
                TILE_SIZE-STROKE_W, TILE_SIZE-STROKE_W,
                STROKE_W, cStroke)
            s('Tile'..slot..'Border', 'Shape', borderStr)
            s('Tile'..slot..'Border', 'Hidden', '0')

            s('Tile'..slot..'Txt', 'Text', cat.name)
            s('Tile'..slot..'Txt', 'X', x + TILE_SIZE / 2)
            s('Tile'..slot..'Txt', 'Y', y + TILE_SIZE + TEXT_OFFSET)
            s('Tile'..slot..'Txt', 'W', TILE_SIZE)
            s('Tile'..slot..'Txt', 'Hidden', '0')
        end
    end
end

local function renderSkinGrid(ci)
    hideAllTiles()
    local list    = categories[ci].skins
    local imgPath = SKIN:GetVariable('SkinPath')

    local slot         = 0
    local visibleIndex = 0

    for i = 1, #list do
        local sk = list[i]
        if isVisible(sk.variant) then
            visibleIndex = visibleIndex + 1

            if visibleIndex >= pageFirst then
                slot = slot + 1
                if slot > SLOTS then break end

                local col = (slot - 1) % COLS
                local row = math.floor((slot - 1) / COLS)

                local x = START_X + col * (TILE_SIZE + COL_GAP)
                local y = START_Y + row * (TILE_SIZE + TEXT_OFFSET + ROW_GAP)

                local invisFill = string.format(
                    "Rectangle %d,%d,%d,%d,15 | Fill Color 0,0,0,0 | StrokeWidth 0",
                    x, y, TILE_SIZE, TILE_SIZE)
                s('Tile'..slot..'BG', 'Shape', invisFill)
                s('Tile'..slot..'BG', 'LeftMouseUpAction',
                    '[!CommandMeasure Script "ToggleSkin('..ci..','..i..')"]')
                s('Tile'..slot..'BG', 'Hidden', '0')

                local fname = sk.label:gsub('%s+', '_'):gsub('[^%w_]', '')
                s('Tile'..slot..'Img', 'ImageName', imgPath..fname..'.png')
                s('Tile'..slot..'Img', 'X', x)
                s('Tile'..slot..'Img', 'Y', y)
                s('Tile'..slot..'Img', 'W', TILE_SIZE)
                s('Tile'..slot..'Img', 'H', TILE_SIZE)
                s('Tile'..slot..'Img', 'Hidden', '0')

                s('Tile'..slot..'Border', 'Hidden', '1')

                s('Tile'..slot..'Txt', 'Text', cleanLabel(sk.label))
                s('Tile'..slot..'Txt', 'X', x + TILE_SIZE / 2)
                s('Tile'..slot..'Txt', 'Y', y + TILE_SIZE + TEXT_OFFSET)
                s('Tile'..slot..'Txt', 'W', TILE_SIZE)
                s('Tile'..slot..'Txt', 'Hidden', '0')
            end
        end
    end
end

function ToggleTheme()
    if currentTheme == 'Dark' then
        currentTheme = 'Light'
        s('ThemeButton', 'Text', 'L')
        s('TitleText',   'FontColor', TXT_LIGHT)
        s('BackButton',  'FontColor', SUB_LIGHT)
        s('CloseButton', 'FontColor', SUB_LIGHT)
        s('ThemeButton', 'FontColor', SUB_LIGHT)
        s('BackButton',  'MouseOverAction',
            '[!SetOption BackButton FontColor "'..HOVER_LIGHT..'"][!UpdateMeter BackButton][!Redraw]')
        s('CloseButton', 'MouseOverAction',
            '[!SetOption CloseButton FontColor "'..HOVER_LIGHT..'"][!UpdateMeter CloseButton][!Redraw]')
        s('ThemeButton', 'MouseOverAction',
            '[!SetOption ThemeButton FontColor "'..HOVER_LIGHT..'"][!UpdateMeter ThemeButton][!Redraw]')
        fadeToColor(view == 'skins' and BG_SUB_LIGHT or BG_LIGHT)
    else
        currentTheme = 'Dark'
        s('ThemeButton', 'Text', 'D')
        s('TitleText',   'FontColor', TXT_DARK)
        s('BackButton',  'FontColor', SUB_DARK)
        s('CloseButton', 'FontColor', SUB_DARK)
        s('ThemeButton', 'FontColor', SUB_DARK)
        s('BackButton',  'MouseOverAction',
            '[!SetOption BackButton FontColor "'..HOVER_DARK..'"][!UpdateMeter BackButton][!Redraw]')
        s('CloseButton', 'MouseOverAction',
            '[!SetOption CloseButton FontColor "'..HOVER_DARK..'"][!UpdateMeter CloseButton][!Redraw]')
        s('ThemeButton', 'MouseOverAction',
            '[!SetOption ThemeButton FontColor "'..HOVER_DARK..'"][!UpdateMeter ThemeButton][!Redraw]')
        fadeToColor(view == 'skins' and BG_SUB_DARK or BG_DARK)
    end

    updateTextColors()
    pageFirst = 1

    if view == 'skins' then
        renderSkinGrid(catIdx)
    else
        renderCategoryGrid()
    end

    flush()
end

function ToggleSkin(ci, si)
    ci = tonumber(ci); si = tonumber(si)
    if not ci or not si then return end

    local cfg, ini = buildConfig(ci, si)
    SKIN:Bang('!ToggleConfig', cfg, ini)

    local key = ci..'_'..si
    _dotState[key] = not _dotState[key]

    if view == 'skins' then
        renderSkinGrid(catIdx)
    end
    flush()
end

function Initialize()
    _dotState  = {}
    view       = 'categories'
    catIdx     = 0
    pageFirst  = 1

    currentTheme = 'Dark'
    setBGInstant(BG_DARK)

    s('ThemeButton', 'Text', 'D')
    s('TitleText',   'FontColor', TXT_DARK)
    s('BackButton',  'FontColor', SUB_DARK)
    s('CloseButton', 'FontColor', SUB_DARK)
    s('ThemeButton', 'FontColor', SUB_DARK)

    s('BackButton',  'MouseOverAction',
        '[!SetOption BackButton FontColor "'..HOVER_DARK..'"][!UpdateMeter BackButton][!Redraw]')
    s('CloseButton', 'MouseOverAction',
        '[!SetOption CloseButton FontColor "'..HOVER_DARK..'"][!UpdateMeter CloseButton][!Redraw]')
    s('ThemeButton', 'MouseOverAction',
        '[!SetOption ThemeButton FontColor "'..HOVER_DARK..'"][!UpdateMeter ThemeButton][!Redraw]')

    updateTextColors()
    s('TitleText', 'Text', 'NotWidgets')
    s('BackButton', 'Hidden', '1')

    renderCategoryGrid()
    flush()
end

function SelectCategory(index)
    index = tonumber(index)
    if not index then return end

    view      = 'skins'
    catIdx    = index
    pageFirst = 1

    fadeToColor(currentTheme == 'Dark' and BG_SUB_DARK or BG_SUB_LIGHT)

    s('TitleText', 'Text', categories[index].name)
    s('BackButton', 'Hidden', '0')

    renderSkinGrid(catIdx)
    flush()
end

function GoBack()
    view      = 'categories'
    catIdx    = 0
    pageFirst = 1

    fadeToColor(currentTheme == 'Dark' and BG_DARK or BG_LIGHT)

    s('TitleText', 'Text', 'NotWidgets')
    s('BackButton', 'Hidden', '1')

    renderCategoryGrid()
    flush()
end

function CloseOrBack()
    if view == 'skins' then
        GoBack()
    else
        SKIN:Bang('!DeactivateConfig')
    end
end