if not getgenv().Amount then
    getgenv().Amount = 0;
end

local LocalPlayer = game:GetService("Players").LocalPlayer;
local RunService = game:GetService("RunService");

local GetCurrentAnimations = function()
    return LocalPlayer.Character.Humanoid:GetPlayingAnimationTracks()
end

local GetNames = function()
    local CTable = {}
    
    for _, Animation in pairs(GetCurrentAnimations()) do
        table.insert(CTable, Animation.Name) 
    end
    
    return CTable
end

for _ = 1, getgenv().Amount do
    local Tools = {}
    
    for _, Tool in pairs(LocalPlayer.Backpack:GetChildren()) do
        Tool.Parent = LocalPlayer.Character
    end
    
    repeat RunService.RenderStepped:wait() until table.find(GetNames(), "toolnone") or table.find(GetNames(), "ToolNoneAnim")
    
    for _, Animation in pairs(GetCurrentAnimations()) do
        if Animation.Name == "toolnone" or Animation.Name == "ToolNoneAnim" then
            Animation:Stop() 
        end
    end
    
    LocalPlayer.Character.RightHand:Destroy()
    
    local Character = LocalPlayer.Character;
    
    LocalPlayer.Character = nil;
    LocalPlayer.Character = Character;
    
    task.delay(.05, function()
        for _, Tool in pairs(LocalPlayer.Character:GetChildren()) do
            if Tool:IsA("Tool") then
                Tool.Handle.CFrame = CFrame.new(0, 1e5, 0)
                
                table.insert(Tools, Tool)
            end
        end
    end)
    
    wait(game:GetService("Players").RespawnTime - .05)
    
    for _, Tool in pairs(LocalPlayer.Character:GetChildren()) do
        if Tool:IsA("Tool") then
            Tool.Parent = workspace
        end
    end
    
    local Position = LocalPlayer.Character.HumanoidRootPart.CFrame;
    
    LocalPlayer.Character.Humanoid:Remove();
    
    LocalPlayer.CharacterAdded:wait()
    LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = Position;
    
    for _, Tool in pairs(Tools) do
        LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(Tool) 
    end
    
    wait(.15) -- For Safety..
end
