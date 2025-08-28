-- craft.lua – checks inventory, prepares ingredients, runs turtle.craft()
local utils = require "src.utils"

local Craft = {}
Craft.__index = Craft

--- Helper: count how many of a given item the turtle holds.
--- @param itemsTbl table   (the full items table, used for name lookup)
--- @param itemId number
--- @return number
local function countInInventory(itemsTbl, itemId)
  local targetName = itemsTbl[itemId].name
  local total = 0
  for slot = 1, 16 do
    local det = turtle.getItemDetail(slot)
    if det and det.name == targetName then
      total = total + det.count
    end
  end
  return total
end

--- Prepare ingredients for a recipe.
--- Returns true on success, false+msg on failure.
--- @param recipe table
--- @param itemsTbl table
--- @return boolean, string
function Craft:prepare(recipe, itemsTbl)
  -- Verify we have enough of each ingredient.
  for _, ing in ipairs(recipe.ingredients or {}) do
    local have = countInInventory(itemsTbl, ing.item)
    if have < ing.count then
      local name = itemsTbl[ing.item].displayName or itemsTbl[ing.item].name
      return false,
        string.format("Missing %d × %s (have %d)", ing.count - have, name, have)
    end
  end
  return true, "All ingredients present"
end

--- Actually craft the item.
--- @return boolean   (true if turtle.craft() succeeded)
function Craft:doCraft()
  return turtle.craft()
end

return Craft