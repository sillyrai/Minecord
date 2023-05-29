local Minecord = {}
local ws = nil -- WebSocket
local json = {}

-- ######### INTERNAL API ######### --
function json.encode(data)
    return textutils.serialiseJSON(data)
end
function json.decode(data)
    return textutils.unserialiseJSON(data) or {}
end
function send(data)
    if not ws then
        error("WebSocket is not initialized")
    end

    term.setTextColor(colors.lightGray)
    -- print(data)
    ws.send(data)
end

local Heartbeat = 5
local Events = {}

-- ######### PUBLIC API ######### --
function Minecord.on(event,callback)
    -- Check if there is a table in Events[event]
    if not Events[event] then
        Events[event] = {}
    end

    -- Insert the callback into the table
    table.insert(Events[event], callback)
end

function Minecord.invoke(event, data)
    -- Check if there is a table in Events[event]
    if not Events[event] then
        return
    end

    -- Call all callbacks
    for _,callback in pairs(Events[event]) do
        callback(data)
    end
end

function Minecord.login(token, intentsNumber) -- https://discord-intents-calculator.vercel.app/
    ws = assert(http.websocket("wss://gateway.discord.gg/?v=10&encoding=json"))

    function heartbeat()
        while ws do
            ws.send(json.encode({op = 1, d = os.time()}))
            os.sleep(Heartbeat)
        end
    end

    function socketMessageReceive()
        while ws do
            local msg,err = ws.receive()
            if(err or not msg) then return end

            term.setTextColor(colors.gray)
            -- print(msg)
            term.setTextColor(colors.white)

            local JS = json.decode(msg)

            if(JS.op == 10) then
                -- print("Request to identify")
                Heartbeat = JS.d.heartbeat_interval / 1000
                send(json.encode({
                    op = 2,
                    d = {
                        token = token,
                        intents = intentsNumber,
                        properties = {
                            ["os"] = "windows",
                            ["browser"] = "CC",
                            ["device"] = "CC"
                        }
                    }
                }))
            elseif(JS.op == 0) then
                Minecord.invoke(JS.t, JS.d)
            end
        end
    end
    parallel.waitForAll(heartbeat, socketMessageReceive) 
end

return Minecord