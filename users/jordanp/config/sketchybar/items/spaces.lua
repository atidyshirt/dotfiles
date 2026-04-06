local colors = require("colors")
local icons = require("icons")
local settings = require("settings")
local app_icons = require("helpers.app_icons")

local spaces = {}

local function get_workspace_apps(workspace_num)
  local handle = io.popen("aerospace list-windows --workspace " .. workspace_num .. " --format \"%{app-name},\" 2>/dev/null")
  local result = handle:read("*a")
  handle:close()

  if not result or result == "" then
    return {}
  end

  local unique_apps = {}
  local seen = {}
  for app_raw in string.gmatch(result, "([^,]+),") do
    local app = app_raw:gsub("%s+$", "")
    if app and app ~= "" and not seen[app] then
      table.insert(unique_apps, app)
      seen[app] = true
    end
  end

  return unique_apps
end

local function get_focused_workspace()
  local handle = io.popen("aerospace list-workspaces --focused 2>/dev/null")
  local result = handle:read("*a")
  handle:close()
  return tonumber(result) or 1
end

local function update_space_label(workspace_num)
  if not spaces[workspace_num] then 
    return 
  end
  
  local apps = get_workspace_apps(workspace_num)
  local icon_line = ""

  if #apps == 0 then
    icon_line = ""
  else
    for _, app in ipairs(apps) do
      local lookup = app_icons[app]
      local icon = ((lookup == nil) and app_icons["Default"] or lookup)
      icon_line = icon_line .. icon
    end
  end

  spaces[workspace_num]:set({
    label = {
      string = icon_line,
      font = settings.font.app_icons,
    },
  })
end

local function update_highlight(focused_ws)
  for i = 1, 5 do
    if spaces[i] then
      local is_focused = (i == focused_ws)
      -- Must keep label.font here: SketchyBar merges label updates; highlight-only sets drop font and
      -- fall back to default.lua (Fira Code), so :wezterm: tokens render as literal text.
      spaces[i]:set({
        icon = { highlight = is_focused },
        label = {
          highlight = is_focused,
          font = settings.font.app_icons,
        },
        background = { border_color = is_focused and colors.black or colors.bg2 }
      })
    end
  end
end

local function update_all_labels()
  for i = 1, 5 do
    update_space_label(i)
  end
end

for i = 1, 5, 1 do
  local apps = get_workspace_apps(i)
  local icon_line = ""

  if #apps == 0 then
    icon_line = ""
  else
    for _, app in ipairs(apps) do
      local lookup = app_icons[app]
      local icon = ((lookup == nil) and app_icons["Default"] or lookup)
      icon_line = icon_line .. icon
    end
  end

  local space = sbar.add("item", "space." .. i, {
    icon = {
      font = { family = settings.font.numbers },
      string = i,
      padding_left = 15,
      padding_right = 8,
      color = colors.white,
      highlight_color = colors.red,
    },
    label = {
      padding_right = 20,
      color = colors.grey,
      highlight_color = colors.white,
      font = settings.font.app_icons,
      y_offset = -1,
      string = icon_line,
    },
    padding_right = 1,
    padding_left = 1,
    background = {
      color = colors.bg1,
      border_width = 1,
      height = 26,
      border_color = colors.black,
    },
  })

  spaces[i] = space

  local space_bracket = sbar.add("bracket", { space.name }, {
    background = {
      color = colors.transparent,
      border_color = colors.bg2,
      height = 28,
      border_width = 2
    }
  })

  sbar.add("item", "space.padding." .. i, {
    padding_left = 1,
    padding_right = 1,
    width = settings.group_paddings,
  })

  space:subscribe("mouse.clicked", function(env)
    if env.BUTTON == "other" then
    else
      sbar.exec("aerospace workspace " .. i)
    end
  end)
end

local spaces_indicator = sbar.add("item", {
  padding_left = -3,
  padding_right = 0,
  icon = {
    padding_left = 8,
    padding_right = 9,
    color = colors.grey,
    string = icons.switch.on,
  },
  label = {
    width = 0,
    padding_left = 0,
    padding_right = 8,
    string = "Spaces",
    color = colors.bg1,
  },
  background = {
    color = colors.with_alpha(colors.grey, 0.0),
    border_color = colors.with_alpha(colors.bg1, 0.0),
  }
})

local space_observer = sbar.add("item", {
  drawing = false,
  updates = true,
})

space_observer:subscribe("aerospace_workspace_change", function(env)
  local focused = tonumber(env.FOCUSED_WORKSPACE) or get_focused_workspace()
  update_highlight(focused)
  update_space_label(focused)
end)

local focused = get_focused_workspace()
update_highlight(focused)

space_observer:subscribe("refresh_spaces", function(env)
  update_all_labels()
end)

spaces_indicator:subscribe("swap_menus_and_spaces", function(env)
  local currently_on = spaces_indicator:query().icon.value == icons.switch.on
  spaces_indicator:set({
    icon = currently_on and icons.switch.off or icons.switch.on
  })
end)

spaces_indicator:subscribe("mouse.entered", function(env)
  sbar.animate("tanh", 30, function()
    spaces_indicator:set({
      background = {
        color = { alpha = 1.0 },
        border_color = { alpha = 1.0 },
      },
      icon = { color = colors.bg1 },
      label = { width = "dynamic" }
    })
  end)
end)

spaces_indicator:subscribe("mouse.exited", function(env)
  sbar.animate("tanh", 30, function()
    spaces_indicator:set({
      background = {
        color = { alpha = 0.0 },
        border_color = { alpha = 0.0 },
      },
      icon = { color = colors.grey },
      label = { width = 0, }
    })
  end)
end)

spaces_indicator:subscribe("mouse.clicked", function(env)
  sbar.trigger("swap_menus_and_spaces")
end)

update_all_labels()
