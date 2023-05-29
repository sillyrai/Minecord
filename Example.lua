local Discord = require("Minecord")

Discord.on("READY", function(data)
    print("Bot is ready!!!")
end)
Discord.on("MESSAGE_CREATE", function(msg)
    print(msg.author.username .. ": " .. msg.content)
end)

Discord.login("Bot Token Here", 33283)