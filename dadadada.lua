-- 🌐 SERVICES
local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local localPlayer = Players.LocalPlayer
if not localPlayer then
    warn("ERROR: LocalPlayer not found.")
    return
end

-- 🖼 LOADING GUI
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
titleLabel.Text = "Loading Script..."
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextScaled = true
titleLabel.TextColor3 = Color3.new(1,1,1)
titleLabel.BackgroundTransparency = 1

local barBG = Instance.new("Frame", loadingFrame)
barBG.Size = UDim2.new(0.6, 0, 0.05, 0)
barBG.Position = UDim2.new(0.2, 0, 0.5, 0)
barBG.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
Instance.new("UICorner", barBG).CornerRadius = UDim.new(0, 6)

local barFill = Instance.new("Frame", barBG)
barFill.Size = UDim2.new(0, 0, 1, 0)
barFill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
Instance.new("UICorner", barFill).CornerRadius = UDim.new(0, 6)

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

-- Simulate loading progress
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

-- 🧬 MUTATION ESP SETUP
local mutations = {"Shiny", "Inverted", "Frozen", "Windy", "Golden", "Mega", "Tiny", "Tranquil", "IronSkin", "Radiant", "Rainbow", "Shocked", "Ascended"}
local currentMutation = mutations[math.random(#mutations)]
local espVisible = true

local function findMachine()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj.Name:lower():find("mutation") then
            return obj
        end
    end
end

local machine = findMachine()
local basePart = machine and machine:FindFirstChildWhichIsA("BasePart")

local espGui, espLabel
if basePart then
    espGui = Instance.new("BillboardGui", basePart)
    espGui.Name = "MutationESP"
    espGui.Adornee = basePart
    espGui.Size = UDim2.new(0, 200, 0, 40)
    espGui.StudsOffset = Vector3.new(0, 3, 0)
    espGui.AlwaysOnTop = true

    espLabel = Instance.new("TextLabel", espGui)
    espLabel.Size = UDim2.new(1, 0, 1, 0)
    espLabel.BackgroundTransparency = 1
    espLabel.Font = Enum.Font.FredokaOne
    espLabel.TextSize = 24
    espLabel.TextStrokeTransparency = 0.25
    espLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    espLabel.Text = currentMutation
end

RunService.RenderStepped:Connect(function()
    if espVisible and espLabel then
        local hue = tick() % 5 / 5
        espLabel.TextColor3 = Color3.fromHSV(hue, 1, 1)
    end
end)

-- 📦 MAIN UI
local gui = Instance.new("ScreenGui", localPlayer:WaitForChild("PlayerGui"))
gui.Name = "PetFinderUI"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 240, 0, 230)
frame.Position = UDim2.new(0.4, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

local function createButton(text, y, color)
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(0.9, 0, 0, 38)
    btn.Position = UDim2.new(0.05, 0, 0, y)
    btn.BackgroundColor3 = color
    btn.Text = text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 17
    btn.TextColor3 = Color3.new(0, 0, 0)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    return btn
end

local toggleESP = createButton(" Toggle Mutation ESP", 40, Color3.fromRGB(120, 255, 150))
local rerollMutation = createButton(" Reroll Mutation", 90, Color3.fromRGB(90, 200, 255))
local rerollPetDisplay = createButton(" Reroll Pet ESP", 140, Color3.fromRGB(80, 140, 255))

local credit = Instance.new("TextLabel", frame)
credit.Size = UDim2.new(1, 0, 0, 20)
credit.Position = UDim2.new(0, 0, 1, -22)
credit.Text = "Made by: yokayborg"
credit.TextColor3 = Color3.fromRGB(180, 180, 180)
credit.BackgroundTransparency = 1
credit.Font = Enum.Font.Gotham
credit.TextSize = 12

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "🐺 Yokayborg Hub Grow a garden "
title.Font = Enum.Font.GothamBlack
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(255, 70, 70)

local holdPetLabel = Instance.new("TextLabel", frame)
holdPetLabel.Size = UDim2.new(1, 0, 0, 25)
holdPetLabel.Position = UDim2.new(0, 0, 0, 40)
holdPetLabel.BackgroundTransparency = 1
holdPetLabel.Text = ""
holdPetLabel.Font = Enum.Font.Gotham
holdPetLabel.TextSize = 16
holdPetLabel.TextColor3 = Color3.fromRGB(255, 200, 200)

-- Event: ESP Toggle
toggleESP.MouseButton1Click:Connect(function()
    if espGui then
        espVisible = not espVisible
        espGui.Enabled = espVisible
    end
end)

-- Event: Mutation Reroll
rerollMutation.MouseButton1Click:Connect(function()
    if not espLabel then return end
    rerollMutation.Text = "Rerolling..."
    for i = 1, 15 do
        espLabel.Text = mutations[math.random(#mutations)]
        wait(0.08)
    end
    currentMutation = mutations[math.random(#mutations)]
    espLabel.Text = currentMutation
    rerollMutation.Text = "Reroll Mutation"
end)
-- 🥚 EGG CHANCES
local eggChances = {
    ["Common Egg"] = {["Dog"] = 33, ["Bunny"] = 33, ["Golden Lab"] = 33},
    ["Uncommon Egg"] = {["Black Bunny"] = 25, ["Chicken"] = 25, ["Cat"] = 25, ["Deer"] = 25},
    ["Rare Egg"] = {["Orange Tabby"] = 33.33, ["Spotted Deer"] = 25, ["Pig"] = 16.67, ["Rooster"] = 16.67, ["Monkey"] = 8.33},
    ["Legendary Egg"] = {["Cow"] = 42.55, ["Silver Monkey"] = 42.55, ["Sea Otter"] = 10.64, ["Turtle"] = 2.13, ["Polar Bear"] = 2.13},
    ["Mythic Egg"] = {["Grey Mouse"] = 37.5, ["Brown Mouse"] = 26.79, ["Squirrel"] = 26.79, ["Red Giant Ant"] = 8.93, ["Red Fox"] = 0},
    ["Bug Egg"] = {["Snail"] = 40, ["Giant Ant"] = 35, ["Caterpillar"] = 25, ["Praying Mantis"] = 0, ["Dragon Fly"] = 0},
    ["Night Egg"] = {["Hedgehog"] = 47, ["Mole"] = 23.5, ["Frog"] = 21.16, ["Echo Frog"] = 8.35, ["Night Owl"] = 0, ["Raccoon"] = 0},
    ["Bee Egg"] = {["Bee"] = 65, ["Honey Bee"] = 20, ["Bear Bee"] = 10, ["Petal Bee"] = 5, ["Queen Bee"] = 0},
    ["Anti Bee Egg"] = {["Wasp"] = 55, ["Tarantula Hawk"] = 31, ["Moth"] = 14, ["Butterfly"] = 0, ["Disco Bee"] = 0},
    ["Common Summer Egg"] = {["Starfish"] = 50, ["Seafull"] = 25, ["Crab"] = 25},
    ["Rare Summer Egg"] = {["Flamingo"] = 30, ["Toucan"] = 25, ["Sea Turtle"] = 20, ["Orangutan"] = 15, ["Seal"] = 10},
    ["Paradise Egg"] = {["Ostrich"] = 43, ["Peacock"] = 33, ["Capybara"] = 24, ["Scarlet Macaw"] = 3, ["Mimic Octopus"] = 1},
    ["Premium Night Egg"] = {["Hedgehog"] = 50, ["Mole"] = 26, ["Frog"] = 14, ["Echo Frog"] = 10},
    ["Dinosaur Egg"] = {["Raptor"] = 33, ["Triceratops"] = 33, ["T-Rex"] = 1, ["Stegosaurus"] = 33, ["Pterodactyl"] = 33, ["Brontosaurus"] = 33},
    ["Primal Egg"] = {
        ["Parasaurolophus"] = 20, ["Iguanodon"] = 20, ["Pachycephalosaurus"] = 20,
        ["Dilophosaurus"] = 20, ["Ankylosaurus"] = 10, ["Spinosaurus"] = 10
    }
}

local displayedEggs = {}

-- 🧠 Weighted Random Function
local function weightedRandom(tbl)
    local total = 0
    for _, chance in pairs(tbl) do total += chance end
    local rand = math.random() * total
    local accum = 0
    for pet, chance in pairs(tbl) do
        accum += chance
        if rand <= accum then return pet end
    end
end

-- 🔍 Display ESP Above Eggs
local function displayESP(egg)
    if egg:GetAttribute("OWNER") ~= localPlayer.Name then return end
    local eggName = egg:GetAttribute("EggName")
    local uuid = egg:GetAttribute("OBJECT_UUID")
    if displayedEggs[uuid] then return end

    local pet = weightedRandom(eggChances[eggName] or {})
    local labelText = pet and (eggName .. " | " .. pet) or eggName

    local billboard = Instance.new("BillboardGui", egg)
    billboard.Name = "PetESP"
    billboard.Adornee = egg:FindFirstChildWhichIsA("BasePart") or egg
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 2.5, 0)
    billboard.AlwaysOnTop = true

    local label = Instance.new("TextLabel", billboard)
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.new(1, 1, 1)
    label.TextStrokeTransparency = 0
    label.TextScaled = true
    label.Font = Enum.Font.GothamBold
    label.Text = labelText

    displayedEggs[uuid] = {label = label, name = eggName}
end

-- 🧲 Detect New Eggs
CollectionService:GetInstanceAddedSignal("PetEggServer"):Connect(displayESP)
for _, egg in CollectionService:GetTagged("PetEggServer") do
    displayESP(egg)
end

-- 🔁 Button: Reroll Pet Display
rerollPetDisplay.MouseButton1Click:Connect(function()
    for uuid, data in pairs(displayedEggs) do
        local pet = weightedRandom(eggChances[data.name] or {})
        if pet then
            data.label.Text = data.name .. " | " .. pet
        end
    end
end)

-- 📈 PERCENTAGE + SUCCESS UI
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local head = character:WaitForChild("Head")

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
successText.Text = "✅ Your pet leveled up and its weight randomly shifted successfully!\nPLEASE REJOIN THE SERVER"
successText.TextColor3 = Color3.fromRGB(0, 255, 0)
successText.Font = Enum.Font.GothamBold
successText.TextSize = 20
successText.TextStrokeTransparency = 0.3
successText.TextWrapped = true
successText.TextYAlignment = Enum.TextYAlignment.Top

-- 🔥 Level Up Button Logic
levelButton.MouseButton1Click:Connect(function()
    if not levelButton.Active then return end
    levelButton.Active = false
    levelButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    levelButton.Text = "⏳ Leveling Up..."
    percentageLabel.Enabled = true

    local duration = 60 -- seconds
    local interval = duration / 100
    for i = 1, 100 do
        percentText.Text = "🔴 Pets Leveling Up Randomly! " .. i .. "%"
        wait(interval)
    end

    percentageLabel.Enabled = false
    successMsg.Enabled = true
    wait(6)
    successMsg.Enabled = false
    levelButton.Active = true
    levelButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    levelButton.Text = "🔥 Level Up 50+ Instantly"
end)
