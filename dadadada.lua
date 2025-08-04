local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- 🐾 Pet Table
local petTable = {
    ["Common Egg"] = { "Dog", "Bunny", "Golden Lab" },
    ["Uncommon Egg"] = { "Fire Pig", "Skunk", "Gecko" },
    ["Rare Egg"] = { "Cow", "Penguin", "Panda" },
    ["Epic Egg"] = { "Tiger", "Capybara", "Lynx" },
    ["Legendary Egg"] = { "Dragon", "Eagle", "Griffin" },
    ["Mythical Egg"] = { "Phoenix", "Unicorn", "Cerberus" },
    ["Night Egg"] = { "Demon", "Reaper", "Ghost" },
}

-- 🎮 GUI Setup
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
    Name = "🌱 GAG | Pet ESP + Randomizer",
    LoadingTitle = "🌱 Grow a Garden Script",
    LoadingSubtitle = "by saiki",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "GAGConfig",
        FileName = "GAGPetSettings"
    },
    Discord = {
        Enabled = true,
        Invite = "csxu2nCkw9",
        RememberJoins = true
    },
    KeySystem = false
})

-- 🧠 Global Toggles
getgenv().autoRandom = false
getgenv().mutationESP = false

-- 🔁 Randomizer Toggle
Window:CreateToggle({
    Name = "🔁 Auto Pet Randomizer",
    CurrentValue = false,
    Flag = "AutoRandomizer",
    Callback = function(Value)
        getgenv().autoRandom = Value
        if Value then
            Rayfield:Notify({
                Title = "Enabled",
                Content = "Pet randomizer running.",
                Duration = 3
            })
            while getgenv().autoRandom do
                task.wait(0.1)
                for _, egg in ipairs(Workspace.Eggs:GetChildren()) do
                    local eggName = egg.Name
                    local pets = petTable[eggName]
                    if pets then
                        local foundPet = egg:FindFirstChildWhichIsA("BillboardGui", true)
                        if foundPet and foundPet.TextLabel then
                            local currentPet = foundPet.TextLabel.Text
                            if not table.find(pets, currentPet) then
                                local randomPet = pets[math.random(#pets)]
                                foundPet.TextLabel.Text = randomPet
                            end
                        end
                    end
                end
            end
        else
            Rayfield:Notify({
                Title = "Disabled",
                Content = "Pet randomizer stopped.",
                Duration = 3
            })
        end
    end,
})

-- 🔮 Mutation ESP
Window:CreateToggle({
    Name = "🔮 Mutation ESP",
    CurrentValue = false,
    Flag = "MutationESP",
    Callback = function(Value)
        getgenv().mutationESP = Value
        if Value then
            Rayfield:Notify({
                Title = "Mutation ESP Enabled",
                Content = "Scanning for mutated pets...",
                Duration = 4
            })

            while getgenv().mutationESP do
                task.wait(0.3)
                for _, v in ipairs(Workspace.Eggs:GetChildren()) do
                    if not v:FindFirstChild("MutationTag") then
                        local gui = v:FindFirstChildWhichIsA("BillboardGui", true)
                        if gui and gui.TextLabel and string.match(gui.TextLabel.Text, "Rainbow") then
                            local clone = Instance.new("StringValue")
                            clone.Name = "MutationTag"
                            clone.Parent = v
                            gui.TextLabel.Text = "[🌈 Rainbow] " .. gui.TextLabel.Text
                        end
                    end
                end
            end
        else
            for _, v in ipairs(Workspace.Eggs:GetChildren()) do
                local tag = v:FindFirstChild("MutationTag")
                if tag then
                    tag:Destroy()
                    local gui = v:FindFirstChildWhichIsA("BillboardGui", true)
                    if gui and gui.TextLabel then
                        gui.TextLabel.Text = string.gsub(gui.TextLabel.Text, "%[🌈 Rainbow%] ", "")
                    end
                end
            end
        end
    end,
})

-- 🕒 Set Pet Age
Window:CreateButton({
    Name = "🕒 Set Pet Age to 50",
    Callback = function()
        local eggs = Workspace.Eggs:GetChildren()
        for _, v in ipairs(eggs) do
            local ageGui = v:FindFirstChildWhichIsA("BillboardGui", true)
            if ageGui and ageGui.TextLabel then
                ageGui.TextLabel.Text = "Age: 50"
            end
        end
        Rayfield:Notify({
            Title = "Age Set",
            Content = "All visible pets' age set to 50.",
            Duration = 3
        })
    end,
})

-- 🧬 Reroll All Pets
Window:CreateButton({
    Name = "🎲 Reroll All Pets",
    Callback = function()
        local eggs = Workspace.Eggs:GetChildren()
        for _, egg in ipairs(eggs) do
            local eggName = egg.Name
            local pets = petTable[eggName]
            if pets then
                local gui = egg:FindFirstChildWhichIsA("BillboardGui", true)
                if gui and gui.TextLabel then
                    gui.TextLabel.Text = pets[math.random(#pets)]
                end
            end
        end
        Rayfield:Notify({
            Title = "Rerolled",
            Content = "All pets randomized.",
            Duration = 3
        })
    end,
})

-- 💎 Dupe Script Loader
Window:CreateButton({
    Name = "💎 Load Dupe Script",
    Callback = function()
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/veryimportantrr/x/refs/heads/main/gag_visual.lua", true))("discord.gg/csxu2nCkw9")
        end)
        if success then
            Rayfield:Notify({
                Title = "Dupe Script",
                Content = "Loaded successfully.",
                Duration = 3
            })
        else
            Rayfield:Notify({
                Title = "Error",
                Content = "Failed to load dupe script.",
                Duration = 3
            })
        end
    end,
})
