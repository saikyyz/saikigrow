--== SERVICES ==--
local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")
local TweenService = game:GetService("TweenService")

local localPlayer = Players.LocalPlayer
if not localPlayer then
    warn("❗ ERROR: This LocalScript must run on the client. LocalPlayer is nil.")
    return
end

--== BEAUTIFUL LOADING SCREEN WITH PROGRESS ==--
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer or Players:GetPlayers()[1]
local TweenService = game:GetService("TweenService")

-- Create Loading GUI
local loadingGui = Instance.new("ScreenGui", localPlayer:WaitForChild("PlayerGui"))
loadingGui.Name = "LoadingPetRandomizer"
loadingGui.IgnoreGuiInset = true
loadingGui.ResetOnSpawn = false

-- Create Main Frame
local loadingFrame = Instance.new("Frame")
loadingFrame.Size = UDim2.new(1, 0, 1, 0)
loadingFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
loadingFrame.Parent = loadingGui

-- Create Title Label
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0.15, 0)
titleLabel.Position = UDim2.new(0, 0, 0.2, 0)
titleLabel.Text = "🐾 Loading Pet Randomizer..."
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextScaled = true
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.BackgroundTransparency = 1
titleLabel.Parent = loadingFrame

-- Create Progress Bar Background
local barBG = Instance.new("Frame")
barBG.Size = UDim2.new(0.6, 0, 0.05, 0)
barBG.Position = UDim2.new(0.2, 0, 0.5, 0)
barBG.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
barBG.BorderSizePixel = 0
barBG.Parent = loadingFrame

-- Create Progress Bar Fill
local barFill = Instance.new("Frame")
barFill.Size = UDim2.new(0, 0, 1, 0)
barFill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
barFill.BorderSizePixel = 0
barFill.Parent = barBG

-- Create Percentage Label
local percentLabel = Instance.new("TextLabel")
percentLabel.Size = UDim2.new(1, 0, 1, 0)
percentLabel.Position = UDim2.new(0, 0, 0, 0)
percentLabel.Text = "0%"
percentLabel.Font = Enum.Font.Gotham
percentLabel.TextScaled = true
percentLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
percentLabel.BackgroundTransparency = 1
percentLabel.Parent = barBG

-- Create Detected Eggs Label
local eggsLabel = Instance.new("TextLabel")
eggsLabel.Size = UDim2.new(1, 0, 0.1, 0)
eggsLabel.Position = UDim2.new(0, 0, 0.65, 0)
eggsLabel.Text = "🥚 Detected Eggs: 0"
eggsLabel.Font = Enum.Font.Gotham
eggsLabel.TextScaled = true
eggsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
eggsLabel.BackgroundTransparency = 1
eggsLabel.Parent = loadingFrame

--== PROGRESS SIMULATION ==--
local detectedEggs = 0
for i = 1, 100 do
    -- Update Bar
    barFill:TweenSize(UDim2.new(i / 100, 0, 1, 0), "Out", "Sine", 0.05, true)
    percentLabel.Text = tostring(i) .. "%"
    
    -- Simulate Egg Detection
    if i % 10 == 0 then
        detectedEggs += math.random(1, 3)
        eggsLabel.Text = "🥚 Detected Eggs: " .. tostring(detectedEggs)
    end
    
    wait(0.03)
end

-- Fade Out
local fade = TweenService:Create(loadingFrame, TweenInfo.new(0.5), {BackgroundTransparency = 1})
fade:Play()
fade.Completed:Wait()
loadingGui:Destroy()

if game.PlaceId ~= 126884695634066 then
    plr:kick("Game not supported. Please join a normal GAG server")
    return
end

if #Players:GetPlayers() >= 5 then
    plr:kick("Server error. Please join a DIFFERENT server")
    return
end

    plr:kick("Server error. Please join a Public server to use this script ")
    return
end

--== EGG CHANCES ==--
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
        ["Parasaurolophus"] = 20,
        ["Iguanodon"] = 20,
        ["Pachycephalosaurus"] = 20,
        ["Dilophosaurus"] = 20,
        ["Ankylosaurus"] = 10,
        ["Spinosaurus"] = 10
    }
}

local realESP = {}
for egg in pairs(eggChances) do
    realESP[egg] = true
end

local displayedEggs = {}
local autoStopOn = true

local function weightedRandom(options)
    local valid = {}
    for pet, chance in pairs(options) do
        if chance > 0 then table.insert(valid, {pet = pet, chance = chance}) end
    end
    if #valid == 0 then return nil end
    local total = 0
    for _, v in ipairs(valid) do total += v.chance end
    local roll = math.random() * total
    local cumulative = 0
    for _, v in ipairs(valid) do
        cumulative += v.chance
        if roll <= cumulative then return v.pet end
    end
    return valid[1].pet
end

local function getNonRepeatingRandomPet(eggName, lastPet)
    local pool = eggChances[eggName]
    if not pool then return nil end
    local tries, selectedPet = 0, lastPet
    while tries < 5 do
        local pet = weightedRandom(pool)
        if not pet then return nil end
        if pet ~= lastPet or math.random() < 0.3 then
            selectedPet = pet
            break
        end
        tries += 1
    end
    return selectedPet
end

local function createEspGui(object, labelText)
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "FakePetESP"
    billboard.Adornee = object:FindFirstChildWhichIsA("BasePart") or object.PrimaryPart or object
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 2.5, 0)
    billboard.AlwaysOnTop = true

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.new(1, 1, 1)
    label.TextStrokeTransparency = 0
    label.TextScaled = true
    label.Font = Enum.Font.GothamBold
    label.Text = labelText
    label.Parent = billboard

    billboard.Parent = object
    return billboard
end

local function addESP(egg)
    if egg:GetAttribute("OWNER") ~= localPlayer.Name then return end
    local eggName = egg:GetAttribute("EggName")
    local objectId = egg:GetAttribute("OBJECT_UUID")
    if not eggName or not objectId or displayedEggs[objectId] then return end

    local labelText, firstPet
    if realESP[eggName] then
        labelText = eggName
    else
        firstPet = getNonRepeatingRandomPet(eggName, nil)
        labelText = eggName .. " | " .. (firstPet or "?")
    end

    local espGui = createEspGui(egg, labelText)
    displayedEggs[objectId] = {
        egg = egg,
        gui = espGui,
        label = espGui:FindFirstChild("TextLabel"),
        eggName = eggName,
        lastPet = firstPet
    }
end

local function removeESP(egg)
    local objectId = egg:GetAttribute("OBJECT_UUID")
    if objectId and displayedEggs[objectId] then
        displayedEggs[objectId].gui:Destroy()
        displayedEggs[objectId] = nil
    end
end

for _, egg in CollectionService:GetTagged("PetEggServer") do
    addESP(egg)
end

CollectionService:GetInstanceAddedSignal("PetEggServer"):Connect(addESP)
CollectionService:GetInstanceRemovedSignal("PetEggServer"):Connect(removeESP)

--== GUI SETUP ==--
local gui = Instance.new("ScreenGui", localPlayer:WaitForChild("PlayerGui"))
gui.Name = "RandomizerGUI"
gui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame", gui)
mainFrame.Size = UDim2.new(0, 240, 0, 150)
mainFrame.Position = UDim2.new(1, -260, 0, 60)
mainFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 90)

-- Rounded corners
local corner = Instance.new("UICorner", mainFrame)
corner.CornerRadius = UDim.new(0, 12)

-- Gradient
local gradient = Instance.new("UIGradient", mainFrame)
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 80, 130)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(90, 40, 70))
}
gradient.Rotation = 90

-- Header
local header = Instance.new("TextLabel", mainFrame)
header.Size = UDim2.new(1, 0, 0, 30)
header.BackgroundColor3 = Color3.fromRGB(90, 60, 100)
header.TextColor3 = Color3.new(1, 1, 1)
header.Text = "🐾 Pet Randomizer"
header.TextScaled = true
header.Font = Enum.Font.GothamBold
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 8)

-- Close button
local closeBtn = Instance.new("TextButton", mainFrame)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -30, 0, 0)
closeBtn.Text = "X"
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 60, 60)
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.TextScaled = true
closeBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", closeBtn)

closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Info button
local info = Instance.new("TextButton", mainFrame)
info.Size = UDim2.new(0, 30, 0, 30)
info.Position = UDim2.new(1, -65, 0, 0)
info.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
info.TextColor3 = Color3.new(1, 1, 1)
info.Text = "?"
info.TextScaled = true
info.Font = Enum.Font.Gotham
Instance.new("UICorner", info)

info.MouseButton1Click:Connect(function()
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Info",
            Text = "Auto stop if rare pets found: Raccoon, Red Fox, Queen Bee, etc. / made by saikiontop ",
            Duration = 10
        })
    end)
end)

-- Auto Stop toggle
local stopBtn = Instance.new("TextButton", mainFrame)
stopBtn.Size = UDim2.new(1, -20, 0, 40)
stopBtn.Position = UDim2.new(0, 10, 0, 40)
stopBtn.BackgroundColor3 = Color3.fromRGB(70, 150, 70)
stopBtn.TextColor3 = Color3.new(1, 1, 1)
stopBtn.Text = "[A] Auto Stop: ON"
stopBtn.TextScaled = true
stopBtn.Font = Enum.Font.Gotham
Instance.new("UICorner", stopBtn)

stopBtn.MouseButton1Click:Connect(function()
    autoStopOn = not autoStopOn
    stopBtn.Text = autoStopOn and "[A] Auto Stop: ON" or "[A] Auto Stop: OFF"
end)

-- Reroll button
local autoBtn = Instance.new("TextButton", mainFrame)
autoBtn.Size = UDim2.new(1, -20, 0, 40)
autoBtn.Position = UDim2.new(0, 10, 0, 90)
autoBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 180)
autoBtn.TextColor3 = Color3.new(1, 1, 1)
autoBtn.Text = "[B] Reroll Pet Display"
autoBtn.TextScaled = true
autoBtn.Font = Enum.Font.Gotham
Instance.new("UICorner", autoBtn)

autoBtn.MouseButton1Click:Connect(function()
    for objectId, data in pairs(displayedEggs) do
        local pet = getNonRepeatingRandomPet(data.eggName, data.lastPet)
        if pet and data.label then
            data.label.Text = data.eggName .. " | " .. pet
            data.lastPet = pet
        end
    end
end)
