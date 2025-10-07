-- ! Place this script in ServerScriptService ! --

local ServerNetwork = {}

function ServerNetwork.init()
    local ReplicatedStorage = game:GetService("ReplicatedStorage")


    local validREReasons = { -- Add reasons as to why the client can even contact the server in a **RemoteEvent**. This will be checked by the server before anything gets executed.

        -- Add desired RE reasons & accorcing functions here:
        ["input"] = function(data)

        end,

        

    }
    local validRFReasons = { -- Add reasons as to why the client can even contact the server in a **RemoteFunction**. This will be checked by the server before anything gets executed. The value will be the function that executes.

        -- Add desired RF reasons & accorcing functions here:
        

    }

    ServerNetwork.RemoteEvent = Instance.new("RemoteEvent")
    ServerNetwork.RemoteEvent.Parent = ReplicatedStorage

    ServerNetwork.RemoteFunction = Instance.new("RemoteFunction")
    ServerNetwork.RemoteFunction.Parent = ReplicatedStorage

    ServerNetwork.RemoteEvent.OnServerEvent:Connect(function(player, reason, data)
        if not validREReasons[reason] then return end

        -- They have a valid reason. Now validate the client before execution:


        validREReasons[reason](player, data)
    end)

    ServerNetwork.RemoteFunction.OnServerInvoke = function(player, reason, data)
        if not validRFReasons[reason] then return end

        -- They have a valid reason. Now validate the client before execution:


        validRFReasons[reason](player, data)
    end
    
end

function ServerNetwork.fireEvent(player, reason, data)
    ServerNetwork.RemoteEvent:FireClient(player, reason, data)
end

function ServerNetwork.invokeFunction(player, reason, data)
    ServerNetwork.RemoteFunction:InvokeClient(player, reason, data)
end

return ServerNetwork