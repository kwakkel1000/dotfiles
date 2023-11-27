-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

config.hide_tab_bar_if_only_one_tab = true
config.line_height = 0.95
config.window_decorations = "RESIZE"
-- For example, changing the color scheme:
--config.color_scheme = 'AdventureTime'

--config.font = wezterm.font = 'Ubu'

--config.window_background_image = '/home/gijsk/bg/dark-eclipse.png'
config.window_background_image = '/home/gijsk/bg/1649074ecd03634e05639d767e131258.jpeg'

config.window_background_image_hsb = {
    -- Darken the background image by reducing it to 1/3rd
    brightness = 0.05,

    -- You can adjust the hue by scaling its value.
    -- a multiplier of 1.0 leaves the value unchanged.
    hue = 1.0,

    -- You can adjust the saturation also.
    saturation = 1.0,
}

wezterm.on('user-var-changed', function(window, pane, name, value)
    local overrides = window:get_config_overrides() or {}
    if name == "ZEN_MODE" then
        local incremental = value:find("+")
        local number_value = tonumber(value)
        if incremental ~= nil then
            while (number_value > 0) do
                window:perform_action(wezterm.action.IncreaseFontSize, pane)
                number_value = number_value - 1
            end
            overrides.enable_tab_bar = false
        elseif number_value < 0 then
            window:perform_action(wezterm.action.ResetFontSize, pane)
            overrides.font_size = nil
            overrides.enable_tab_bar = true
        else
            overrides.font_size = number_value
            overrides.enable_tab_bar = false
        end
    end
    window:set_config_overrides(overrides)
end)

config.keys = {}

for i = 1, 8 do
    -- CTRL+ALT + number to move to that position
    table.insert(config.keys, {
        key = tostring(i),
        mods = 'CTRL|ALT',
        action = wezterm.action.MoveTab(i - 1),
    })
end

-- and finally, return the configuration to wezterm
return config
