local Job = require("plenary.job")

return {
  get_os_command_output = function (cmd, cwd)
    if type(cmd) ~= "table" then
      return {}
    end
    local command = table.remove(cmd, 1)
    local stderr = {}
    local stdout, ret = Job:new({
      command = command,
      args = cmd,
      cwd = cwd,
      on_stderr = function(_, data)
        table.insert(stderr, data)
      end,
    }):sync()
    return stdout, ret, stderr
  end;

  split_string = function (str, delimiter)
    local result = {}
    for match in (str .. delimiter):gmatch("(.-)" .. delimiter) do
      table.insert(result, match)
    end
    return result
  end;

  get_index_of_string = function (seach_string, command_list)
    for index, value in pairs(command_list.items) do
      if value.value == seach_string then
        return index;
      end
    end
      error("failed to find index")
    return nil;
  end;

  -- @param index: number
  -- @returns 1 | 2 [tmux index to send to terminal]
  get_tmux_terminal_index = function (index)
    if index <= 2 then
      return 1
    else
      return 2
    end
  end;
}
