# Minecord
A Discord Bot library for CC: Tweaked
This was inspired by Discord.JS

This was made at midnight when I was also sleep deprived. Currently only supports receiving data from events, not responding. Since the json data is just passed back to the listener without any modifications (i.e, no extra functions like :reply("message") for example)

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
