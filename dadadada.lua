-- 🌐 SERVICES
local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local localPlayer = Players.LocalPlayer
if not localPlayer then
    warn("❗ ERROR: LocalPlayer not found.")
    return
end

-- 🖥 LOADING GUI
local loadingGui = Instance.new("ScreenGui", localPlayer:WaitForChild("PlayerGui"))
loadingGui.Name = "LoadingPetRandomizer"
loadingGui.IgnoreGuiInset = true
loadingGui.ResetOnSpawn = false

local loadingFrame = Instance.new("Frame", loadingGui)
loadingFrame.Size = UDim2.new(1, 0, 1, 0)
loadingFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)

local titleLabel = Instance.new("TextLabel", loadingFrame)
titleLabel.Size = UDim2.new(1, 0, 0.15, 0)
titleLabel.Position = UDim2.new(0, 0, 0.2, 0)
titleLabel.Text = "🐾 Loading Pet Script..."
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextScaled = true
titleLabel.TextColor3 = Color3.new(1,1,1)
titleLabel.BackgroundTransparency = 1

local barBG = Instance.new("Frame", loadingFrame)
barBG.Size = UDim2.new(0.6, 0, 0.05, 0)
barBG.Position = UDim2.new(0.2, 0, 0.5, 0)
barBG.BackgroundColor3 = Color3.fromRGB(60, 60, 80)

local barFill = Instance.new("Frame", barBG)
barFill.Size = UDim2.new(0, 0, 1, 0)
barFill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)

local percentLabel = Instance.new("TextLabel", barBG)
percentLabel.Size = UDim2.new(1, 0, 1, 0)
percentLabel.Text = "0%"
percentLabel.TextColor3 = Color3.new(1,1,1)
percentLabel.Font = Enum.Font.Gotham
percentLabel.BackgroundTransparency = 1
percentLabel.TextScaled = true

local eggsLabel = Instance.new("TextLabel", loadingFrame)
eggsLabel.Size = UDim2.new(1, 0, 0.1, 0)
eggsLabel.Position = UDim2.new(0, 0, 0.65, 0)
eggsLabel.Text = "🥚 Detected Eggs: 0"
eggsLabel.Font = Enum.Font.Gotham
eggsLabel.TextScaled = true
eggsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
eggsLabel.BackgroundTransparency = 1

-- Simulate progress
local detectedEggs = 0
for i = 1, 100 do
    barFill:TweenSize(UDim2.new(i/100, 0, 1, 0), "Out", "Sine", 0.05, true)
    percentLabel.Text = i .. "%"
    if i % 10 == 0 then
        detectedEggs += math.random(1, 3)
        eggsLabel.Text = "🥚 Detected Eggs: " .. detectedEggs
    end
    wait(0.03)
end

TweenService:Create(loadingFrame, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
wait(0.5)
loadingGui:Destroy()

-- 🌟 PET LEVELER UI
local playerGui = localPlayer:WaitForChild("PlayerGui")
local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "PetLevelerUI"
screenGui.ResetOnSpawn = false

local function roundify(obj)
    local corner = Instance.new("UICorner", obj)
    corner.CornerRadius = UDim.new(0, 10)
end

-- UI elements
local startButton = Instance.new("TextButton", screenGui)
startButton.Size = UDim2.new(0, 200, 0, 50)
startButton.Position = UDim2.new(0.5, -100, 0.4, 0)
startButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
startButton.Text = "▶️ Start"
startButton.TextSize = 22
startButton.Font = Enum.Font.GothamBold
startButton.TextColor3 = Color3.new(1, 1, 1)
roundify(startButton)

local countdownLabel = Instance.new("TextLabel", screenGui)
countdownLabel.Size = UDim2.new(0, 250, 0, 50)
countdownLabel.Position = UDim2.new(0.5, -125, 0.47, 0)
countdownLabel.BackgroundTransparency = 1
countdownLabel.Text = ""
countdownLabel.Font = Enum.Font.Gotham
countdownLabel.TextSize = 20
countdownLabel.TextColor3 = Color3.new(1, 1, 1)

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 260, 0, 190)
mainFrame.Position = UDim2.new(0.5, -130, 0.3, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
mainFrame.Visible = false
roundify(mainFrame)
mainFrame.Active = true
mainFrame.Draggable = true

local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "🐺 Level Up Your Pets"
title.Font = Enum.Font.GothamBlack
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(255, 70, 70)

local holdPetLabel = Instance.new("TextLabel", mainFrame)
holdPetLabel.Size = UDim2.new(1, 0, 0, 25)
holdPetLabel.Position = UDim2.new(0, 0, 0, 40)
holdPetLabel.BackgroundTransparency = 1
holdPetLabel.Text = "PLEASE HOLD A PET"
holdPetLabel.Font = Enum.Font.Gotham
holdPetLabel.TextSize = 16
holdPetLabel.TextColor3 = Color3.fromRGB(255, 200, 200)

local levelButton = Instance.new("TextButton", mainFrame)
levelButton.Size = UDim2.new(0.8, 0, 0, 40)
levelButton.Position = UDim2.new(0.1, 0, 0.45, 0)
levelButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
levelButton.Text = "🔥 Level Up 50+ Instantly"
levelButton.Font = Enum.Font.GothamBold
levelButton.TextSize = 18
levelButton.TextColor3 = Color3.new(1, 1, 1)
roundify(levelButton)

local footer = Instance.new("TextLabel", mainFrame)
footer.Size = UDim2.new(1, 0, 0, 30)
footer.Position = UDim2.new(0, 0, 1, -30)
footer.BackgroundTransparency = 1
footer.Text = "Modified Script: zeno"
footer.Font = Enum.Font.GothamSemibold
footer.TextSize = 14
footer.TextColor3 = Color3.fromRGB(180, 180, 180)

-- Billboard Percent & Success
local head = localPlayer.Character and localPlayer.Character:FindFirstChild("Head") or localPlayer.CharacterAdded:Wait():WaitForChild("Head")

local percentageLabel = Instance.new("BillboardGui", head)
percentageLabel.Size = UDim2.new(0, 300, 0, 50)
percentageLabel.StudsOffset = Vector3.new(0, 2.5, 0)
percentageLabel.AlwaysOnTop = true
percentageLabel.Enabled = false

local percentText = Instance.new("TextLabel", percentageLabel)
percentText.Size = UDim2.new(1, 0, 1, 0)
percentText.BackgroundTransparency = 1
percentText.Text = ""
percentText.TextColor3 = Color3.fromRGB(255, 0, 0)
percentText.Font = Enum.Font.GothamBlack
percentText.TextSize = 28
percentText.TextStrokeTransparency = 0.4

local successMsg = Instance.new("BillboardGui", head)
successMsg.Size = UDim2.new(0, 350, 0, 60)
successMsg.StudsOffset = Vector3.new(0, 2.5, 0)
successMsg.AlwaysOnTop = true
successMsg.Enabled = false

local successText = Instance.new("TextLabel", successMsg)
successText.Size = UDim2.new(1, 0, 1, 0)
successText.BackgroundTransparency = 1
successText.Text = "✅ Your pet leveled up and its weight randomly shifted successfully!\nPLEASE REJOIN IN SERVER"
successText.TextColor3 = Color3.fromRGB(0, 255, 0)
successText.Font = Enum.Font.GothamBold
successText.TextSize = 20
successText.TextStrokeTransparency = 0.3
successText.TextWrapped = true
successText.TextYAlignment = Enum.TextYAlignment.Top

-- 🎮 Logic
startButton.MouseButton1Click:Connect(function()
    startButton.Visible = false
    local countdown = 15
    countdownLabel.Text = "⏳ Starting in 15 seconds..."
    while countdown > 0 do
        wait(1)
        countdown -= 1
        countdownLabel.Text = "⏳ Starting in " .. countdown .. " seconds..."
    end
    countdownLabel.Visible = false
    mainFrame.Visible = true
end)

levelButton.MouseButton1Click:Connect(function()
    if not levelButton.Active then return end
    levelButton.Active = false
    levelButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    levelButton.Text = "⏳ Leveling Up..."
    percentageLabel.Enabled = true
    local duration = 240
    local interval = duration / 100
    for i = 1, 100 do
        percentText.Text = "🔴 Pets Leveling Up Randomly! " .. i .. "%"
        wait(interval)
    end
    percentageLabel.Enabled = false
    successMsg.Enabled = true
    wait(6)
    successMsg.Enabled = false
end)
