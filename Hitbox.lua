--[[
getgenv().HitBox = {
 Settings = {
        Size = 10;
        Transparency = 0.5;
        Color = Color3.fromRGB(255, 0, 0);
        Material = Enum.Material.Neon;
    };
    Outline = {
        Color = Color3.fromRGB(0, 0, 0);
        Width = 0.1;
    };
};
]] 







local Ninja = {}

local Config = {
    Services = {
        RunService = game:GetService("RunService")
    },
    Player = {
        LocalPlayer = game.Players.LocalPlayer
    }
}

local function Death(Plr)
    if Plr.Character and Plr.Character:FindFirstChild("BodyEffects") then
        local bodyEffects = Plr.Character.BodyEffects
        local ko = bodyEffects:FindFirstChild("K.O") or bodyEffects:FindFirstChild("KO")
        return ko and ko.Value
    end
    return false
end

local function Grabbed(Plr)
    return Plr.Character and Plr.Character:FindFirstChild("GRABBING_CONSTRAINT") ~= nil
end

Config.Services.RunService.Heartbeat:Connect(function()
    for _, ops in pairs(game.Players:GetPlayers()) do
        if ops ~= Config.Player.LocalPlayer then
            local biggestbird = ops.Character
            if biggestbird then
                local eyeofrah = biggestbird:FindFirstChild("HumanoidRootPart")
                if eyeofrah then
                    if Death(ops) or Grabbed(ops) then
                        eyeofrah.Size = Vector3.new(0, 0, 0)
                        if Ninja[eyeofrah] then
                            Ninja[eyeofrah]:Destroy()
                            Ninja[eyeofrah] = nil
                        end
                    else
                        if eyeofrah.Size ~= Vector3.new(HitBox.Settings.Size, HitBox.Settings.Size, HitBox.Settings.Size) then
                            eyeofrah.Size = Vector3.new(HitBox.Settings.Size, HitBox.Settings.Size, HitBox.Settings.Size)
                        end
                        if eyeofrah.CanCollide then
                            eyeofrah.CanCollide = false
                        end
                        if eyeofrah.Transparency ~= HitBox.Settings.Transparency then
                            eyeofrah.Transparency = HitBox.Settings.Transparency
                        end
                        if eyeofrah.Color ~= HitBox.Settings.Color then
                            eyeofrah.Color = HitBox.Settings.Color
                        end
                        if eyeofrah.Material ~= HitBox.Settings.Material then
                            eyeofrah.Material = HitBox.Settings.Material
                        end
                        if not Ninja[eyeofrah] then
                            local choppedchin = Instance.new("SelectionBox")
                            choppedchin.Adornee = eyeofrah
                            choppedchin.LineThickness = HitBox.Outline.Width
                            choppedchin.Color3 = HitBox.Outline.Color
                            choppedchin.Parent = biggestbird
                            Ninja[eyeofrah] = choppedchin
                        end
                    end
                end
            end
        end
    end
end)
