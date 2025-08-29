-- items.lua – helpers that operate on the items table
local utils = require("apps.craftItem.utils")

local Items = {}
Items.__index = Items

--- Create a new instance bound to a specific items table.
--- @param itemsTable table
function Items:new(itemsTable)
  local self = setmetatable({tbl = itemsTable}, Items)
  return self
end

--- Find the numeric ID for a display name (case‑insensitive).
--- @param name string
--- @return number|nil, table|nil   (id, definition)
function Items:findIdByName(name)
  for id, def in pairs(self.tbl) do
    if def.displayName and utils.eqIgnoreCase(def.displayName, name) then
      return id, def
    end
  end
  return nil, nil
end

return Items