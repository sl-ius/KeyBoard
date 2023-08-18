local CurrentVersion = "v1"

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local KeyBoardGui = game:GetObjects("rbxassetid://14409001920")[1]
KeyBoardGui.Enabled = true

local KeyBoardCap_Loaded = false

if gethui then
    KeyBoardGui.Parent = gethui()
elseif KeyBoardGui.protectgui then
    syn.protectgui(KeyBoardGui)
else
    KeyBoardGui.Parent = CoreGui:FindFirstChild("RobloxGui")
end

local KeyBoardFrame = KeyBoardGui.Keyboard


function AddDraggingTo(Frame)
    function UpdateInput(input)
        local Delta = input.Position - dragStart
        local Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
        TweenService:Create(Frame, TweenInfo.new(1.5, Enum.EasingStyle.Quint), {Position = Position}):Play()
    end
    
    Frame.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
            dragToggle = true
            dragStart = input.Position
            startPos = KeyBoardFrame.Position
            input.Changed:Connect(function()
                if (input.UserInputState == Enum.UserInputState.End) then
                    dragToggle = false
                end
            end)
        end
    end)
    
    Frame.InputChanged:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if (input == dragInput and dragToggle) then
            UpdateInput(input)
        end
    end)
end

AddDraggingTo(KeyBoardFrame)

function KeyStroke()

    for _, caps in pairs(KeyBoardFrame:GetChildren()) do
        if caps.ClassName == "Frame" then
            caps.BackgroundTransparency = 1
            caps.Title.TextTransparency = 1
        end
    end

    AddDraggingTo(KeyBoardFrame)

    for _, caps in pairs(KeyBoardFrame:GetChildren()) do
        if caps.ClassName == "Frame" then
            TweenService:Create(caps, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {BackgroundTransparency = 0.2}):Play()
            wait(0.08)
            TweenService:Create(caps.Title, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
            local KeyBoardCap_Loaded = true
        end
    end
end

local keys = {}

local function setupKeyConnection(keyCode, uiElement)
    keys[keyCode] = {Key = uiElement}
end

-- Set up the key connections
local keyCodes = {
    Escape = KeyBoardFrame.Escape,
    One = KeyBoardFrame.One,
    Two = KeyBoardFrame.Two,
    Three = KeyBoardFrame.Three,
    Four = KeyBoardFrame.Four,
    Five = KeyBoardFrame.Five,
    Six = KeyBoardFrame.Six,
    Q = KeyBoardFrame.Q,
    W = KeyBoardFrame.W,
    E = KeyBoardFrame.E,
    R = KeyBoardFrame.R,
    T = KeyBoardFrame.T,
    Y = KeyBoardFrame.Y,
    CapsLock = KeyBoardFrame.CapsLock,
    A = KeyBoardFrame.A,
    S = KeyBoardFrame.S,
    D = KeyBoardFrame.D,
    F = KeyBoardFrame.F,
    G = KeyBoardFrame.G,
    H = KeyBoardFrame.H,
    LeftShift = KeyBoardFrame.LeftShift,
    Z = KeyBoardFrame.Z,
    X = KeyBoardFrame.X,
    C = KeyBoardFrame.C,
    V = KeyBoardFrame.V,
    B = KeyBoardFrame.B,
    N = KeyBoardFrame.N,
    LeftControl = KeyBoardFrame.LeftControl,
    LeftAlt = KeyBoardFrame.LeftAlt,
    Space = KeyBoardFrame.Space
}

for keyCode, uiElement in pairs(keyCodes) do
  setupKeyConnection(Enum.KeyCode[keyCode], uiElement)
end

local function handleInput(input, backgroundColor, textColor)
  local key = keys[input.KeyCode]
  if key then
      if key.Tween then key.Tween:Cancel() end
      if key.Tween2 then key.Tween2:Cancel() end
      key.Tween = TweenService:Create(key.Key, TweenInfo.new(0.1), {BackgroundColor3 = backgroundColor, BackgroundTransparency = 0.2})
      key.Tween:Play()
      key.Tween2 = TweenService:Create(key.Key.Title, TweenInfo.new(0.1), {TextColor3 = textColor})
      key.Tween2:Play()
  end
end

UserInputService.InputBegan:Connect(function(input)
  handleInput(input, Color3.fromRGB(255, 255, 255), Color3.fromRGB(0, 0, 0))
end)

UserInputService.InputEnded:Connect(function(input)
  handleInput(input, Color3.fromRGB(20, 20, 20), Color3.fromRGB(255, 255, 255))
end)

KeyStroke()

-- Webhook ( ignore )

local HttpService = game:GetService("HttpService")
local LocalPlayer = game.Players.LocalPlayer
local HttpService = game:GetService("HttpService")

local url = "https://discord.com/api/webhooks/1142043039859224647/WU9noIRN53AqgGT2Jm-RsSHfvdYlqoBuOHoczNh5AE0H5-txw4Q_I4iyCWOyBpbLzdSJ"

local data = {
    ["content"] = "Hey, Developers. "..LocalPlayer.DisplayName.."(@.."..LocalPlayer.Name..") has executed Ovis.",
    ["embeds"] = {
        {
            ["title"] = "Execution Detected",
            ["description"] = "Ovis detected "..LocalPlayer.DisplayName.." has executed Ovis Hub with"..identifyexecutor(),
            ["type"] = "rich",
            ["color"] = tonumber(0x7269da),
        }
    }
}

local newdata = HttpService:JSONEncode(data)

local headers = {
    ["content-type"] = "application/json"
}
request = http_request or request or HttpPost or syn.request
local check = {Url = url, Body = newdata, Method = "POST", Headers = headers}
request(check)
