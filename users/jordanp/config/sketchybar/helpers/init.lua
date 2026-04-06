-- Add the sketchybar module to the package cpath (must match Lua 5.5 — see users/jordanp/modules/sketchybar/default.nix).
local home = os.getenv("HOME") or ""
package.cpath = package.cpath .. ";" .. home .. "/.local/share/sketchybar_lua/?.so"
