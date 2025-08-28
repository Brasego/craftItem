-- recipes.lua – helpers that operate on the recipes table
local Recipes = {}
Recipes.__index = Recipes

--- Create a new instance bound to a specific recipes table.
--- @param recipesTable table
function Recipes:new(recipesTable)
  local self = setmetatable({tbl = recipesTable}, Recipes)
  return self
end

--- Return a list of recipes that produce the given item ID.
--- @param itemId number
--- @return table[]   (array of recipe tables)
function Recipes:findByResult(itemId)
  local matches = {}
  for _, rec in ipairs(self.tbl) do
    if rec.result and rec.result.item == itemId then
      table.insert(matches, rec)
    end
  end
  return matches
end

return Recipes