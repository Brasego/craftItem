-- main.lua – glue everything together
local loader   = require("apps.craftItem.loader")
local Items    = require("apps.craftItem.items")
local Recipes  = require("apps.craftItem.recipes")
local Craft    = require("apps.craftItem.craft")I
local function main()
  print("=== Crafty Turtle – createItem (modular version) ===")
  write("Enter the exact item name (case‑insensitive): ")
  local wanted = read()
  if not wanted or wanted == "" then
    print("No item entered – exiting.")
    return
  end

  -- Load the massive data tables (once per run)
  local itemsTbl, recipesTbl = loader.loadData()

  -- Wrap them in our helper objects
  local itemsObj   = Items:new(itemsTbl)
  local recipesObj = Recipes:new(recipesTbl)
  local craftObj   = Craft

  -- Resolve the item the user asked for
  local itemId, itemDef = itemsObj:findIdByName(wanted)
  if not itemId then
    print("❌ Unknown item: " .. wanted)
    return
  end

  -- Find recipes that output this item
  local possible = recipesObj:findByResult(itemId)
  if #possible == 0 then
    print("❌ No recipe produces \"" .. wanted .. "\"")
    return
  end

  -- Choose the first recipe (you could present a menu if you like)
  local recipe = possible[1]
  print(string.format("Found %d recipe(s); using the first one.", #possible))

  -- Verify we have the ingredients
  local ok, msg = craftObj:prepare(recipe, itemsTbl)
  if not ok then
    print("❌ Cannot craft: " .. msg)
    return
  end

  print("🔧 Attempting to craft...")
  if craftObj:doCraft() then
    print("✅ Success! Crafted " .. wanted .. ".")
  else
    print("❌ Crafting failed – check ingredient arrangement.")
  end
end

main()