# NOTICE
This is extremely unfinished and was more made as a test to see if I could even make it. There is currently no way to respond to events, (i.e there isn't a function for like msg.reply("content")) you can only receive data from Discord, though the ability to do that is planned.
There are bugs bound to exist because I made this in 2ish hours

# Minecord
A Discord Bot library for CC: Tweaked
This was inspired by Discord.JS

# Usage
Install Minecord.lua from this repo by using wget or any other methods
Create a new file which will be used as the script for the bot

An example script can be seen here
```lua
local Discord = require("Minecord")

Discord.on("READY", function(data)
    print("Bot is ready!!!")
end)

Discord.on("MESSAGE_CREATE", function(msg)
    print(msg.author.username .. ": " .. msg.content)
end)

Discord.login("BOT TOKEN", 33283) -- The number is the intents, use this to calculate the number of which intents you need https://discord-intents-calculator.vercel.app/
```

You can view the event names and data that the events give on Discord's docs https://discord.com/developers/docs/topics/gateway-events#receive-events
note that all events must be uppercase, and instead of spaces use underscores
