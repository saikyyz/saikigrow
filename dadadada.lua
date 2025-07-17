-- SERVICES
local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")

local localPlayer = Players.LocalPlayer
if not localPlayer then
    warn("❗ ERROR: This LocalScript must run on the client. LocalPlayer is nil.")
    return
end

-- EGG CHANCES
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

local realESP = {
    ["Common Egg"] = true,
    ["Uncommon Egg"] = true,
    ["Rare Egg"] = true,
    ["Legendary Egg"] = true,
    ["Mythic Egg"] = true,
    ["Bug Egg"] = true,
    ["Night Egg"] = true,
    ["Bee Egg"] = true,
    ["Anti Bee Egg"] = true,
    ["Common Summer Egg"] = true,
    ["Rare Summer Egg"] = true,
    ["Paradise Egg"] = true,
    ["Premium Night Egg"] = true,
    ["Dinosaur Egg"] = true,
    ["Primal Egg"] = true
}


local displayedEggs = {}
local autoStopOn = true

-- WEIGHTED RANDOM PICK
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

-- GET RANDOM NON-REPEATING PET
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

-- CREATE ESP GUI
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
    label.Font = Enum.Font.SourceSansBold
    label.Text = labelText
    label.Parent = billboard

    billboard.Parent = object
    return billboard
end

-- ADD/REMOVE ESP
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

-- GUI BUILD
local gui = Instance.new("ScreenGui")
gui.Name = "RandomizerGUI"
gui.ResetOnSpawn = false
gui.Parent = localPlayer:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame", gui)
mainFrame.Size = UDim2.new(0, 220, 0, 140)
mainFrame.Position = UDim2.new(1, -240, 0, 50)
mainFrame.BackgroundColor3 = Color3.fromRGB(90, 60, 45)
mainFrame.BorderSizePixel = 2

local header = Instance.new("TextLabel", mainFrame)
header.Size = UDim2.new(1, 0, 0, 30)
header.BackgroundColor3 = Color3.fromRGB(120, 90, 60)
header.TextColor3 = Color3.new(1, 1, 1)
header.Text = "Randomizer"
header.TextScaled = true
header.Font = Enum.Font.SourceSansBold

local closeBtn = Instance.new("TextButton", mainFrame)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -30, 0, 0)
closeBtn.Text = "X"
closeBtn.BackgroundColor3 = Color3.fromRGB(140, 40, 40)
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.TextScaled = true
closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

local info = Instance.new("TextButton", mainFrame)
info.Size = UDim2.new(0, 30, 0, 30)
info.Position = UDim2.new(1, -65, 0, 0)
info.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
info.TextColor3 = Color3.new(1, 1, 1)
info.Text = "?"
info.TextScaled = true
info.MouseButton1Click:Connect(function()
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Info",
            Text = "Auto Stop when found: Raccoon, Dragonfly, Queen Bee, Red Fox, Disco Bee, Butterfly.",
            Duration = 20
        })
    end)
end)

local stopBtn = Instance.new("TextButton", mainFrame)
stopBtn.Size = UDim2.new(1, -20, 0, 40)
stopBtn.Position = UDim2.new(0, 10, 0, 40)
stopBtn.BackgroundColor3 = Color3.fromRGB(60, 120, 60)
stopBtn.TextColor3 = Color3.new(1, 1, 1)
stopBtn.Text = "[A] Auto Stop: ON"
stopBtn.TextScaled = true
stopBtn.MouseButton1Click:Connect(function()
    autoStopOn = not autoStopOn
    stopBtn.Text = autoStopOn and "[A] Auto Stop: ON" or "[A] Auto Stop: OFF"
end)

local autoBtn = Instance.new("TextButton", mainFrame)
autoBtn.Size = UDim2.new(1, -20, 0, 40)
autoBtn.Position = UDim2.new(0, 10, 0, 85)
autoBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 120)
autoBtn.TextColor3 = Color3.new(1, 1, 1)
autoBtn.Text = "[B] Reroll Pet Display"
autoBtn.TextScaled = true
autoBtn.MouseButton1Click:Connect(function()
    for objectId, data in pairs(displayedEggs) do
        local pet = getNonRepeatingRandomPet(data.eggName, data.lastPet)
        if pet and data.label then
            data.label.Text = data.eggName .. " | " .. pet
            data.lastPet = pet
        end
    end
end)
