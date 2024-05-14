local TmuxApi = require('tvl.core.resources.extensions.harpoon-tmux.tmux-api');
local Utils = require('tvl.core.resources.extensions.harpoon-tmux.utils');

return {
  go_to_terminal = function (idx)
    local window_handle = TmuxApi.find_terminal(idx)
    local _, ret, stderr = Utils.get_os_command_output({
      "tmux",
      "select-window",
      "-t",
      window_handle.window_id,
    }, vim.loop.cwd())

    if ret ~= 0 then
      error("Failed to go to terminal." .. stderr[1])
    end
  end;

  send_command = function (idx, cmd, ...)
    local window_handle = TmuxApi.find_terminal(idx)
    if cmd then
      local _, ret, stderr = Utils.get_os_command_output({
        "tmux",
        "send-keys",
        "-t",
        window_handle.window_id,
        string.format(cmd .. "\n", ...),
      }, vim.loop.cwd())

      if ret ~= 0 then
        error("Failed to send command. " .. stderr[1])
      end
    end
  end;
}
