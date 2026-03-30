-- [[ Xcon Hub 0.1 | FINAL COMPLETE VERSION ]] --

local CoreGui = game:GetService("CoreGui")
local RS = game:GetService("RunService")
local lp = game.Players.LocalPlayer

local KeyLink = "https://pastebin.com/raw/hf5QTYgQ" 
local AdLink = "https://link-hub.net/4678033/vffl8fyduhMy"

if CoreGui:FindFirstChild("XconCompleteHub") then CoreGui.XconCompleteHub:Destroy() end
if CoreGui:FindFirstChild("XconKeySystem") then CoreGui.XconKeySystem:Destroy() end

local function MainScript()
    local ScreenGui = Instance.new("ScreenGui", CoreGui)
    ScreenGui.Name = "XconCompleteHub"

    local Logo = Instance.new("TextButton", ScreenGui)
    Logo.Size = UDim2.new(0, 100, 0, 35); Logo.Position = UDim2.new(0, 50, 0, 50)
    Logo.BackgroundColor3 = Color3.fromRGB(15, 15, 15); Logo.BorderColor3 = Color3.fromRGB(0, 255, 127)
    Logo.Text = "Xcon hub"; Logo.TextColor3 = Color3.fromRGB(0, 255, 127); Logo.Font = Enum.Font.Code; Logo.Draggable = true

    local Main = Instance.new("Frame", ScreenGui)
    Main.Size = UDim2.new(0, 550, 0, 580); Main.Position = UDim2.new(0.5, -275, 0.5, -290)
    Main.BackgroundColor3 = Color3.fromRGB(10, 10, 10); Main.BorderColor3 = Color3.fromRGB(0, 255, 127); Main.Visible = false; Main.Active = true; Main.Draggable = true 

    Logo.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)

    local function CreateSection(name, pos, size)
        local s = Instance.new("Frame", Main); s.Size = size; s.Position = pos; s.BackgroundColor3 = Color3.fromRGB(15, 15, 15); s.BorderSizePixel = 1; s.BorderColor3 = Color3.fromRGB(35, 35, 35)
        local t = Instance.new("TextLabel", s); t.Size = UDim2.new(0, 110, 0, 15); t.Position = UDim2.new(0, 10, 0, -8); t.BackgroundColor3 = Color3.fromRGB(15, 15, 15); t.Text = " "..name.." "; t.TextColor3 = Color3.fromRGB(0, 255, 127); t.Font = Enum.Font.Code
        local l = Instance.new("UIListLayout", s); l.Padding = UDim.new(0, 6); l.HorizontalAlignment = Enum.HorizontalAlignment.Center
        Instance.new("UIPadding", s).PaddingTop = UDim.new(0, 15); return s
    end

    local function CreateCodeNum(name, def, parent, callback)
        local f = Instance.new("Frame", parent); f.Size = UDim2.new(0.9, 0, 0, 30); f.BackgroundTransparency = 1
        local l = Instance.new("TextLabel", f); l.Size = UDim2.new(0.4,0,1,0); l.Text = "> "..name; l.TextColor3 = Color3.new(0.8,0.8,0.8); l.Font = Enum.Font.Code; l.BackgroundTransparency = 1; l.TextXAlignment = 0
        local i = Instance.new("TextBox", f); i.Size = UDim2.new(0,50,0,22); i.Position = UDim2.new(0.4,5,0.1,0); i.BackgroundColor3 = Color3.fromRGB(25,25,25); i.Text = tostring(def); i.TextColor3 = Color3.fromRGB(0,255,127); i.Font = Enum.Font.Code
        local b = Instance.new("TextButton", f); b.Size = UDim2.new(0,40,0,22); b.Position = UDim2.new(0.4,60,0.1,0); b.Text = "SET"; b.BackgroundColor3 = Color3.fromRGB(35,35,35); b.TextColor3 = Color3.new(1,1,1); b.Font = Enum.Font.Code
        b.MouseButton1Click:Connect(function() callback(tonumber(i.Text) or 0) end)
    end

    local function CreateToggle(name, parent, callback)
        local b = Instance.new("TextButton", parent); b.Size = UDim2.new(0.9, 0, 0, 26); b.BackgroundColor3 = Color3.fromRGB(25, 25, 25); b.Text = name.." : [OFF]"; b.TextColor3 = Color3.fromRGB(200, 200, 200); b.Font = Enum.Font.Code
        local s = false; b.MouseButton1Click:Connect(function() s = not s; b.Text = name.." : ["..(s and "ON" or "OFF").."]"; b.TextColor3 = s and Color3.fromRGB(0, 255, 127) or Color3.fromRGB(200, 200, 200); callback(s) end)
    end

    -- [[ 1. MANU ]] --
    local Manu = CreateSection("MANU", UDim2.new(0, 15, 0, 30), UDim2.new(0.46, 0, 0, 230))
    CreateCodeNum("Speed", 16, Manu, function(v) if lp.Character:FindFirstChild("Humanoid") then lp.Character.Humanoid.WalkSpeed = v end end)
    CreateCodeNum("Jump", 50, Manu, function(v) if lp.Character:FindFirstChild("Humanoid") then lp.Character.Humanoid.JumpPower = v end end)
    CreateToggle("Auto Get Gun", Manu, function(v) _G.AGG = v; task.spawn(function() while _G.AGG do task.wait(0.5) local g = workspace:FindFirstChild("GunDrop") or workspace:FindFirstChild("Handle") if g and lp.Character:FindFirstChild("HumanoidRootPart") then local old = lp.Character.HumanoidRootPart.CFrame lp.Character.HumanoidRootPart.CFrame = g.CFrame task.wait(0.2) lp.Character.HumanoidRootPart.CFrame = old end end end) end)
    CreateToggle("Noclip", Manu, function(v) _G.NC = v; task.spawn(function() while _G.NC do if lp.Character then for _,p in pairs(lp.Character:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end end RS.Stepped:Wait() end end) end)

    -- [[ 2. VISION ]] --
    local Vision = CreateSection("VISION", UDim2.new(0, 15, 0, 280), UDim2.new(0.46, 0, 0, 200))
    CreateToggle("Esp Name & Box", Vision, function(v)
        _G.ESP = v; task.spawn(function()
            while _G.ESP do
                for _, p in pairs(game.Players:GetPlayers()) do
                    if p ~= lp and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                        local isMur = p.Backpack:FindFirstChild("Knife") or p.Character:FindFirstChild("Knife")
                        local color = isMur and Color3.new(1,0,0) or Color3.new(0,1,0)
                        local hrp = p.Character.HumanoidRootPart
                        local b = hrp:FindFirstChild("XconBox") or Instance.new("BoxHandleAdornment", hrp)
                        b.Name = "XconBox"; b.AlwaysOnTop = true; b.Size = Vector3.new(4, 5, 1); b.Adornee = hrp; b.Transparency = 0.7; b.Color3 = color
                        local head = p.Character:FindFirstChild("Head")
                        if head then
                            local tag = head:FindFirstChild("XconTag") or Instance.new("BillboardGui", head)
                            tag.Name = "XconTag"; tag.Size = UDim2.new(0,100,0,50); tag.AlwaysOnTop = true; tag.ExtentsOffset = Vector3.new(0,3,0)
                            local label = tag:FindFirstChild("L") or Instance.new("TextLabel", tag)
                            label.Size = UDim2.new(1,0,1,0); label.BackgroundTransparency = 1; label.Text = p.Name; label.TextColor3 = color; label.Font = Enum.Font.Code; label.TextSize = 14
                        end
                    end
                end
                task.wait(1)
            end
            for _,p in pairs(game.Players:GetPlayers()) do if p.Character then if p.Character:FindFirstChild("HumanoidRootPart") and p.Character.HumanoidRootPart:FindFirstChild("XconBox") then p.Character.HumanoidRootPart.XconBox:Destroy() end if p.Character:FindFirstChild("Head") and p.Character.Head:FindFirstChild("XconTag") then p.Character.Head.XconTag:Destroy() end end end
        end)
    end)

    -- [[ 3. TELEPORT ]] --
    local Tele = CreateSection("TELEPORT", UDim2.new(0.52, 0, 0, 30), UDim2.new(0.46, 0, 0, 240))
    local function Btn(t, p, c, f) local b = Instance.new("TextButton", p) b.Size = UDim2.new(0.9, 0, 0, 30) b.BackgroundColor3 = c b.Text = t b.TextColor3 = Color3.new(1,1,1) b.Font = Enum.Font.Code b.MouseButton1Click:Connect(f) end
    Btn("Tp Murderer", Tele, Color3.fromRGB(60,20,20), function() for _,p in pairs(game.Players:GetPlayers()) do if p ~= lp and (p.Backpack:FindFirstChild("Knife") or p.Character:FindFirstChild("Knife")) then lp.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,3) break end end end)
    Btn("Tp Sheriff", Tele, Color3.fromRGB(20,20,60), function() for _,p in pairs(game.Players:GetPlayers()) do if p ~= lp and (p.Backpack:FindFirstChild("Gun") or p.Character:FindFirstChild("Gun")) then lp.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,3) break end end end)
    
    local Target = Instance.new("TextBox", Tele) Target.Size = UDim2.new(0.9,0,0,30) Target.BackgroundColor3 = Color3.fromRGB(25,25,25) Target.TextColor3 = Color3.new(1,1,1) Target.PlaceholderText = "Player Name..." Target.Font = Enum.Font.Code
    Btn("Teleport to Player", Tele, Color3.fromRGB(40,40,40), function() local t = Target.Text:lower() for _,p in pairs(game.Players:GetPlayers()) do if p ~= lp and p.Name:lower():find(t) and p.Character then lp.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame break end end end)

    -- [[ 4. CREDITS ]] --
    local Credits = CreateSection("CREDITS", UDim2.new(0.52, 0, 0, 280), UDim2.new(0.46, 0, 0, 200))
    local function Cre(t, c) local l = Instance.new("TextLabel", Credits) l.Size = UDim2.new(0.9,0,0,22) l.BackgroundTransparency = 1 l.Text = t l.TextColor3 = c l.Font = Enum.Font.Code end
    Cre("Xcon hub 0.1", Color3.fromRGB(0, 255, 127)) Cre("Creator: ким", Color3.new(1,1,1))
end

-- [[ KEY SYSTEM ]] --
local KeyGui = Instance.new("ScreenGui", CoreGui)
local KFrame = Instance.new("Frame", KeyGui) KFrame.Size = UDim2.new(0,350,0,200) KFrame.Position = UDim2.new(0.5,-175,0.5,-100) KFrame.BackgroundColor3 = Color3.fromRGB(15,15,15) KFrame.BorderColor3 = Color3.fromRGB(0,255,127) KFrame.Active = true KFrame.Draggable = true
local KInput = Instance.new("TextBox", KFrame) KInput.Size = UDim2.new(0.85,0,0,35) KInput.Position = UDim2.new(0.075,0,0.3,0) KInput.BackgroundColor3 = Color3.fromRGB(25,25,25) KInput.TextColor3 = Color3.new(1,1,1) KInput.PlaceholderText = "Paste Key..." KInput.Font = Enum.Font.Code
local Check = Instance.new("TextButton", KFrame) Check.Size = UDim2.new(0.4,0,0,35) Check.Position = UDim2.new(0.075,0,0.6,0) Check.Text = "LOGIN" Check.BackgroundColor3 = Color3.fromRGB(30,30,30) Check.TextColor3 = Color3.new(1,1,1) Check.Font = Enum.Font.Code
local Get = Instance.new("TextButton", KFrame) Get.Size = UDim2.new(0.4,0,0,35) Get.Position = UDim2.new(0.525,0,0.6,0) Get.Text = "GET KEY" Get.BackgroundColor3 = Color3.fromRGB(0,100,0) Get.TextColor3 = Color3.new(1,1,1) Get.Font = Enum.Font.Code

Get.MouseButton1Click:Connect(function() setclipboard(AdLink) end)
Check.MouseButton1Click:Connect(function()
    local s, r = pcall(function() return game:HttpGet(KeyLink) end)
    if s and KInput.Text == r:gsub("%s+", "") then KeyGui:Destroy() MainScript() end
end)
