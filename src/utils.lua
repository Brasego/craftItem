-- utils.lua – tiny reusable helpers
local utils = {}

--- Load a Lua file that returns a table.
--- @param path string absolute path (e.g. "/data/items.lua")
--- @return table
function utils.loadTable(path)
  print("Loading " .. path .. " ...") -- debug
  local f = io.open(path, "r")
  if not f then error("Cannot open " .. path) end
  print(f)
  local chunk = f:read("*a")
  f:close()
  local fn, err = load(chunk, "=" .. path)
  if not fn then error("Syntax error in " .. path .. ": " .. err) end
  return fn()
end

--- Case‑insensitive string compare (returns true if equal)
function utils.eqIgnoreCase(a, b)
  return a:lower() == b:lower()
end

return utils