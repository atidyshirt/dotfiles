return {
  black = 0xff32302f,
  white = 0xffd4be98,
  red = 0xffea6962,
  green = 0xffa9b665,
  blue = 0xff7daea3,
  yellow = 0xffd8a657,
  orange = 0xffe78a4e,
  magenta = 0xffd3869b,
  grey = 0xffa89984,
  transparent = 0x00000000,

  bar = {
    bg = 0xff262626,
    border = 0xff62554A,
  },
  popup = {
    bg = 0xff262626,
    border = 0xff62554A
  },
  bg1 = 0xff32302f,
  bg2 = 0xff262626,

  with_alpha = function(color, alpha)
    if alpha > 1.0 or alpha < 0.0 then return color end
    return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
  end,
}
