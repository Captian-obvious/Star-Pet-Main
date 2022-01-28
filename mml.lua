local mml = {};

local Services = {
    Players = game:GetService("Players"),
    ReplicatedStorage = game:GetService("ReplicatedStorage"),
    ServerStorage = game:GetService("ServerStorage")
};

function mml:SetRank(name, rankName)
    local ranks = require(script.Ranks)
    ranks.addPlayer(rankName, name)
end

function mml:Initialize()
    require(script.Server.Server):Init()
    require(script.Client.Client):Init()
end

function mml:SaveMap()
    if Services.ServerStorage.backupMap then
        Services.ServerStorage.backupMap.Parent = nil
    end
    local savedState = Instance.new("Model")
    savedState.Name = "backupMap"
    savedState.Parent = Services.ServerStorage
    for _,obj in pairs(workspace:GetChildren()) do
        if obj then
            obj:Clone().Parent = savedState
        end
    end
end

function mml:LoadMap()
    local newMap = Services.ServerStorage.backupMap:Clone()
    newMap.Parent = workspace
    for _,obj in pairs(newMap:GetChildren()) do
        if obj then
            obj.Parent = workspace
        end
    end
    newMap:Destroy()
end

return mml
