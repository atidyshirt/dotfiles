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
end
}
