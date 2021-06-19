return function(...)
    local message, client, data=...
    message:reply("```"..table.concat(data.prefixes,", ").."```")
end 