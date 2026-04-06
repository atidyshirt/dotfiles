local colors = require("colors")

-- Layering like SbarLua’s example/topmost; avoid heavy blur/shadow (often reads as invisible on
-- some macOS + wallpaper combos).
sbar.bar({
  height = 40,
  color = colors.bar.bg,
  border_color = colors.bar.border,
  padding_right = 2,
  padding_left = 2,
})
