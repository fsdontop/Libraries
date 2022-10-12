local InsertService = game:GetService("InsertService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

if game:GetService("CoreGui"):FindFirstChild("NotificationUI") then
    game:GetService("CoreGui"):FindFirstChild("NotificationUI"):Destroy();
end

if ReplicatedStorage:FindFirstChild("LocalStorage") then
    ReplicatedStorage:FindFirstChild("LocalStorage"):Destroy();
end

local System = {}

local TransparencyValues = {
    ["Description"] = "TextTransparency",
    ["Title"] = "TextTransparency",
    ["Shadow"] = "ImageTransparency",
}

local LocalStorage = Instance.new("Folder", ReplicatedStorage);
LocalStorage.Name = "LocalStorage";

local UI = InsertService:LoadLocalAsset("rbxassetid://11214434330"):Clone();

local Notification = UI.NotificationFrame.Notification;

Notification.Parent = LocalStorage

for _, Object in ipairs(Notification:GetDescendants()) do
    if TransparencyValues[Object.Name] then
        Object[TransparencyValues[Object.Name]] = 1;
    end
end

UI.Parent = game:GetService("CoreGui")

System.Notify = function(Title, Text, Duration)
    local ClonedNotification = Notification:Clone();

    ClonedNotification.Parent = UI.NotificationFrame;

    ClonedNotification.Title.Text = Title;
    ClonedNotification.Description.Text = Text;

    local FrameTween = TweenService:Create(ClonedNotification, TweenInfo.new(0.55, Enum.EasingStyle.Quint), {
        BackgroundTransparency = 0;
    });

    FrameTween:Play();

    for _, Object in pairs(ClonedNotification:GetDescendants()) do
        if TransparencyValues[Object.Name] then
            local Tween = TweenService:Create(Object, TweenInfo.new(0.55, Enum.EasingStyle.Quint), {
                [TransparencyValues[Object.Name]] = 0;
            });
        
            Tween:Play();
        end
    end

    task.delay(Duration, function()
        local FrameTween = TweenService:Create(ClonedNotification, TweenInfo.new(0.55, Enum.EasingStyle.Quint), {
            BackgroundTransparency = 1;
        });

        FrameTween:Play();

        for _, Object in pairs(ClonedNotification:GetDescendants()) do
            if TransparencyValues[Object.Name] then
                local Tween = TweenService:Create(Object, TweenInfo.new(0.55, Enum.EasingStyle.Quint), {
                    [TransparencyValues[Object.Name]] = 1;
                });
            
                Tween:Play();
            end
        end

        task.delay(0.5, function()
            ClonedNotification:Destroy();
        end);
    end);
end

return System;
