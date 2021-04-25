return function(...)
    local message, client = ...
    message:reply {
        embed = {
            title = "About Emilia",
            description = "bot owner: " ..
                client:getUser("411887008160415766").mentionString ..
                    "\n guilds: " ..
                        #client.guilds ..
                            "\n members: " ..
                                message.guild.totalMemberCount ..
                                    "\ncached members:" ..
                                        #message.guild.members ..
                                            "\n\n[github](https://github.com/senor-init/Emilia/)\n [library](https://github.com/sinisterrectus/discordia/)"
        }
    }
end
