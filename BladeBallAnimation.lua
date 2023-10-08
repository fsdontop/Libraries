local OldNameCall = nil
local UserInputService = game:GetService("UserInputService")

UserInputService.InputBegan:Connect(function(Input, GameProcessedEvent)
    if GameProcessedEvent then
        return
    end
    
    if Input.UserInputType == Enum.UserInputType.Keyboard and Input.KeyCode == Enum.KeyCode.E then
        for _, Animation in pairs(game.Players.LocalPlayer.Character.Humanoid:GetPlayingAnimationTracks()) do
            if string.match(string.lower(Animation.Animation.Name), "emote") then
                Animation:Stop()
            end
        end
    end
end)

OldNameCall = hookmetamethod(game, "__namecall", function(Self, ...)
    local Args = {...}
    local NamecallMethod = getnamecallmethod()
    
    if not checkcaller() then
        if Self.ClassName == "AnimationTrack" and string.match(string.lower(Self.Animation.Name), "emote") then
            if NamecallMethod == "Stop" then
                return function() end
            end
        end
    end
    
    return OldNameCall(Self, ...)
end)
