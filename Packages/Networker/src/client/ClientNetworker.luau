-- ! Place this script in ReplicatedStorage ! --

local ClientNetworker = {}

function ClientNetworker.init()
    local ReplicatedStorage = game:GetService("ReplicatedStorage")

    
    local REReasons = { -- When the server sends a **Event** to the client, this table has reasons for the server sending a signal to the client.
        
        -- Add desired RE reasons & accorcing functions here:

    
    }
    local RFReasons = { -- When the server sends a **Function** to the client, this table has reasons for the server sending a signal to the client.

        -- Add desired RF reasons & accorcing functions here:


    }

    ClientNetworker.RemoteEvent = ReplicatedStorage:WaitForChild("RemoteEvent")
    ClientNetworker.RemoteFunction = ReplicatedStorage:WaitForChild("RemoteFunction")

    ClientNetworker.RemoteEvent.OnClientEvent:Connect(function(reason, data)
        if not REReasons[reason] then return warn(reason .. " is not a valid event reason for the client to execute anything. Check client REReasons.") end

        REReasons[reason](data)
    end)
    ClientNetworker.RemoteFunction.OnClientInvoke = function(reason, data)
        if not RFReasons[reason] then return warn(reason .. " is not a valid function reason for the client to execute anything. Check client RFReasons.") end
        
        REReasons[reason](data)
    end

end

function ClientNetworker.fireEvent(reason, data)
    ClientNetworker.RemoteEvent:FireServer(reason, data)
end

function ClientNetworker.invokeEvent(reason, data)
    ClientNetworker.RemoteFunction:InvokeServer(reason, data)
end

return ClientNetworker