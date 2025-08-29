-- loader.lua – pulls the two big data tables from the *computer root*
local utils = require("utils")

local M = {}

function M.loadData()
  -- These files already exist at the root of the computer.
  local items   = utils.loadTable("/data/items.lua")
  local recipes = utils.loadTable("/data/recipes.lua")
  return items, recipes
end

return M