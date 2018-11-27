local module = {}

module.CommandName = "clone"
module.DisplayName = "Clone"
module.Description = "Clones the player."

module.Category = "Fun"

module.PermissionsNeeded = {} -- or just a string
-- The permissions required to use this command.

--[[
	Target - A Player argument, in the cmd you would put in the username or userid.
        Example: 5762824, if the user by the id of 5762824 is in the game it would return the player object in cmd:Run.
        Example: gamenew09, if the user by the username gamenew09 is in the game it would return the player object in cmd:Run.
   		Argument Parameters:
			ImmunityTag - what tag should a target/player have in order to not able to be targeted by this command.
	Number - A number, just put in a number
        Example: 43
    String - A string, or text
        Argument Parameters: (Table keys in an Argument Schema)
            ["Filtered"] - boolean - Tells the command parser to filter this string before sending it to the command. If any string is shown to the screen, you must filter the string as according to ROBLOX's Guidelines.
        Example: "Test 123" - I want to support quoted strings.
    ObjectTarget - String that references a roblox object. 
        Example: game.Workspace.Test - returns the actual object in cmd:Run
--]]

--[[
		{
		["Type"] = "Target",
		["Arguments"] = {
			["ImmunityTag"] = "tag"
		}
	},
--]]

module.ArgumentSchema = {
	{
		["Type"] = "Target",
		["Name"] = "player",
		["Arguments"] = {
			["DisallowSpecial"] = false, -- Should we disallow "me"
			["IgnoreSelf"] = false, -- If the user passes in themselves as an argument (their name, their userid, or "me" [if DisallowSpecial is false]) should we treat it as an invalid target?
			["IgnoreGroupOrder"] = false -- Should we allow users to target anyone? (false, allow targeting anyone)
		}
	}
}

local function getPlayers(pl, string)
   if string:lower() == "" then
      return
   end
   if string:lower( ) == "all" then
      string = ""
   end
   if pl and string:lower() == "me" then
      string = pl.Name
   end
   local localPlayers = {}
   for i,v in pairs(game.Players:GetPlayers()) do
      if v:lower():sub(1, string:len()) then
         table.insert(localPlayers, v)
      end
   end
   return localPlayers
end 


function module:Run(sender, args)
	local target = args[1]
	target = sender:getPlayers(target)
	
	for _, player in pairs(target) do
	    if player.Character then
	        local character = player.Character or player.CharacterAdded:Wait()
	        if character:FindFirstChild("Humanoid") then
		         local Humanoid = character:FindFirstChild("Humanoid")
		         Humanoid.MaxHealth = 100
		         Humanoid.Health = 100
		     end
	    end
	end
	
	return true
end

return module
