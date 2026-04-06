return {
  text = "SF Pro", -- Used for text
  numbers = "SF Mono", -- Used for numbers
  -- Workspace app glyphs (:wezterm: etc.) — must match sketchybar-app-font.ttf + --load-font
  app_icons = {
    family = "sketchybar-app-font",
    style = "Regular",
    size = 14.0,
  },

  -- Unified font style map
  style_map = {
    ["Regular"] = "Regular",
    ["Semibold"] = "Semibold",
    ["Bold"] = "Bold",
    ["Heavy"] = "Heavy",
    ["Black"] = "Black",
  }
}
