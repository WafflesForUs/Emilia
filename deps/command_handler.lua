local fs = require("fs")
local commands = {}

for _, dirs in pairs(fs.readdirSync("./commands")) do
    for _, file in pairs(fs.readdirSync("./commands/"..dirs)) do
        if file:match("(.+)%.lua") then --matches lua files only
            commands[dirs]={}
            local Command_Name = string.sub(file, 1, #file - 4) --removes .lua from the file name
            
            commands[dirs][Command_Name] = require(".commands."..(dirs or "general")..".".. Command_Name) --requires the files
            if type(commands[dirs][Command_Name]) ~= "function" then
                commands[dirs][Command_Name] = nil
            end
         --accepts only files that returned a function and removes everything else
        end
    end
end

return commands
