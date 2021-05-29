local fs = require("fs")
local commands = {}

for _, dirs in pairs(fs.readdirSync("./commands")) do
    commands[dirs] = {}

    for _, file in pairs(fs.readdirSync("./commands/" .. dirs)) do
        if file:match("(.+)%.lua") then --matches lua files only
            local Command_Name = string.sub(file, 1, #file - 4) --removes .lua from the file name
            local cmd,info=require(".commands." .. dirs .. "." .. Command_Name)
            commands[dirs][Command_Name] = {cmd,info}  --requires the files

        end
    end
end

return commands
