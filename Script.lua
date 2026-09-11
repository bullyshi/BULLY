local ProtectionConfig = {
    -- 🔴 CRITICAL: This MUST exactly match the 'Secret' value in your Key System's Config!
    -- If your Key System has: Secret = "Test"
    -- Then this must also be: SecretKey = "Test"
    SecretKey = "BULLY1234",
    
    -- The name of your Hub (shown in the kick message if they try to bypass)
    HubName = "BULLY HUB"
}

-- Anti-Bypass Logic: Checks if the Key System successfully set the global variable
if not _G[ProtectionConfig.SecretKey] then
    local player = game:GetService("Players").LocalPlayer
    if player then
        player:Kick("\n🛡️ Unauthorized Execution 🛡️\n\nPlease use the official Key System to run " .. ProtectionConfig.HubName)
    end
    return -- Stops the rest of the script from loading!
end

-------------------------------------------------------------------------------
-- 👇 YOUR MAIN SCRIPT CODE STARTS HERE 👇
-------------------------------------------------------------------------------

print(ProtectionConfig.HubName .. " Loaded Successfully!")


-- ================== СЕРВИСЫ ==================
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer

-- ================== РОДИТЕЛЬ ДЛЯ GUI ==================
local function getGuiParent()
    local ok, hui = pcall(function() return gethui and gethui() end)
    if ok and hui then return hui end
    return game:GetService("CoreGui")
end

-- ================== СОХРАНЕНИЕ ЯЗЫКА ==================
local CONFIG_FILE = "BullySDRP_Config.json"
local ScriptActive = true
local Language = "EN"

local function saveLanguage()
    if type(writefile) ~= "function" then return end
    pcall(function()
        writefile(CONFIG_FILE, HttpService:JSONEncode({ Language = Language }))
    end)
end

local function loadLanguage()
    if type(readfile) ~= "function" or type(isfile) ~= "function" then return end
    pcall(function()
        if not isfile(CONFIG_FILE) then return end
        local data = HttpService:JSONDecode(readfile(CONFIG_FILE))
        if type(data) == "table" and (data.Language == "EN" or data.Language == "RU") then
            Language = data.Language
        end
    end)
end

loadLanguage()

-- ================== ЛОКАЛИЗАЦИЯ ==================
local L = {
    EN = {
        LoadingTitle = "Loading...",
        VehicleTab = "Vehicle", PlayerTab = "Player", CombatTab = "Aimbot",
        VisualTab = "Visual",
        FunctionsTab = "Functions", SettingsTab = "Settings",

        VehicleSection = "Vehicle Control",
        VehicleSpeed = "SpeedHack [Alt]",
        VehicleMode = "SpeedHack Mode",
        ModeLegit = "Legit",
        ModeHard = "Hard",
        Speed = "Speed",
        AntiTip = "AntiTip",
        BindsSection = "Hotkeys (Binds)",
        ShiftLockLabel = "Vehicle Shift Lock — [RightShift]",

        AimbotSection = "Aimbot Settings",
        AimbotToggle = "Aimbot Enabled",
        Smoothness = "Smoothness",
        MaxDistance = "Max Distance (Studs)",
        TargetPart = "Target Part",
        PartHead = "Head",
        PartBody = "HumanoidRootPart",
        TeamCheck = "Team Check",
        FovSection = "FOV Settings",
        ShowFov = "Show FOV Circle",
        FovRadius = "FOV Radius",

        MovementSection = "Movement",
        PlayerSpeedHack = "SpeedHack [LeftShift]",

        NoclipSection = "Noclip",
        NoclipToggle = "Noclip (walk through walls)",
        BindNoclipName = "Noclip Key",

        TeleportSection = "Click TP",
        BindClickTPName = "Click TP Key",
        ClickTPReset = "Reset TP Key",
        NotifyTPReset = "Click TP key reset",
        ClickTPLabel = "Set the key on the chip, then HOLD that key and Left Click a point to teleport",

        PlayersSection = "Players",
        PlayerEsp = "Player ESP",

        DeletionSection = "Object Deletion",
        Gates = "Barriers",
        BankWall = "Bank Walls",
        NotifySuccess = "Success",
        NotifyRemoved = "Removed objects: ",
        NotifyRestored = "Restored objects: ",
        NotifyInfo = "Info",
        NotifyNotFound = "Objects not found or already removed",

        JobsSection = "Auto",
        AutoJob = "Auto Job (Boxes)",

        TrackerSection = "Player Money Transfer",
        SelectTarget = "Select Target",
        RefreshList = "Refresh Player List",
        NotifyListUpdated = "Player list updated",
        RepeatCount = "Repeat Count",
        RepeatPlaceholder = "Number of runs",
        RunToggle = "Transfer Money",
        NotifyPlayerNotFound = "Player not found!",
        NotifyDone = "Done: ",
        NotifyTimes = " time(s)",

        MainSection = "Main",
        Unload = "Unload Script",
        NotifyLangTitle = "Language",
        NotifyLangEn = "Language set to English",
        NotifyLangRu = "Язык изменён на русский",

        BindAimbotName = "Aimbot Key",
        BindFlyName = "Vehicle Fly",
        BindUnstuckName = "Unstuck Vehicle",

        VFlyAutoOff = "Fly disabled (left the vehicle)",
    },
    RU = {
        LoadingTitle = "Загрузка...",
        VehicleTab = "Транспорт", PlayerTab = "Игрок", CombatTab = "Аимбот",
        VisualTab = "Визуал",
        FunctionsTab = "Функции", SettingsTab = "Настройки",

        VehicleSection = "Управление машиной",
        VehicleSpeed = "Спидхак [Alt]",
        VehicleMode = "Режим спидхака",
        ModeLegit = "Обычный",
        ModeHard = "Хард",
        Speed = "Скорость",
        AntiTip = "Анти-переворот",
        BindsSection = "Горячие клавиши",
        ShiftLockLabel = "Шифтлок в транспорте — [RightShift]",

        AimbotSection = "Настройки аимбота",
        AimbotToggle = "Аимбот",
        Smoothness = "Плавность",
        MaxDistance = "Макс. дистанция (студы)",
        TargetPart = "Точка наводки",
        PartHead = "Голова",
        PartBody = "Тело",
        TeamCheck = "Проверка команды",
        FovSection = "Настройки FOV",
        ShowFov = "Показывать FOV",
        FovRadius = "Радиус FOV",

        MovementSection = "Перемещение",
        PlayerSpeedHack = "Спидхак [LeftShift]",

        NoclipSection = "Ноуклип",
        NoclipToggle = "Ноуклип (сквозь стены)",
        BindNoclipName = "Клавиша ноуклипа",

        TeleportSection = "Клик-ТП",
        BindClickTPName = "Клавиша клик-ТП",
        ClickTPReset = "Сбросить клавишу ТП",
        NotifyTPReset = "Клавиша клик-ТП сброшена",
        ClickTPLabel = "Назначь клавишу на квадратике, ЗАЖМИ её и кликни ЛКМ в точку — телепорт",

        PlayersSection = "Игроки",
        PlayerEsp = "ESP игроков",

        DeletionSection = "Удаление объектов",
        Gates = "Шлагбаумы",
        BankWall = "Стены банка",
        NotifySuccess = "Успешно",
        NotifyRemoved = "Удалено объектов: ",
        NotifyRestored = "Возвращено объектов: ",
        NotifyInfo = "Информация",
        NotifyNotFound = "Объекты не найдены или уже удалены",

        JobsSection = "Авто",
        AutoJob = "Авто-работа (Коробки)",

        TrackerSection = "Передать деньги игроку",
        SelectTarget = "Выбрать игрока",
        RefreshList = "Обновить список игроков",
        NotifyListUpdated = "Список игроков обновлён",
        RepeatCount = "Количество повторений",
        RepeatPlaceholder = "Число передач",
        RunToggle = "Передать деньги",
        NotifyPlayerNotFound = "Игрок не найден!",
        NotifyDone = "Готово: ",
        NotifyTimes = " раз(а)",

        MainSection = "Главное",
        Unload = "Выйти из скрипта",
        NotifyLangTitle = "Язык",
        NotifyLangEn = "Language set to English",
        NotifyLangRu = "Язык изменён на русский",

        BindAimbotName = "Клавиша аимбота",
        BindFlyName = "Полёт на транспорте",
        BindUnstuckName = "Вернуть машину (от застревания)",

        VFlyAutoOff = "Полёт отключён (вы покинули транспорт)",
    }
}

-- ================== ПЕРЕМЕННЫЕ ==================
local PlayerSpeedEnabled = false
local PlayerSpeed = 1.4

local NoclipEnabled = false
local NoclipLoop = nil

local VehicleSpeedEnabled = false
local VehicleSpeedMode = "Legit"
local VehicleAltSpeed = 200
local VehicleAltRisky = false

local EspEnabled = false
local EspMaxDistance = 250
local EspObjects = {}

local VFlyEnabled = false
local VFlySpeed = 45
local VFlyLoop = nil

local VehicleShiftLockEnabled = false
local ShiftLockLoop = nil

local BoxJobEnabled = false
local BoxJobActiveRoutine = true
local FETCH_POS = Vector3.new(-25.368, 17.209, -71.160)
local DELIVER_POS = Vector3.new(2.932, 17.282, -62.212)

local AimbotEnabled = false
local AimbotSmoothness = 0.9
local AimbotPart = "Head"
local AimbotTeamCheck = true
local AimbotMaxDistance = 300
local AimbotFovRadius = 150
local AimbotShowFov = false
local AimbotLoop = nil
local CurrentTarget = nil

local TrackerRunning = false
local TrackerConnection = nil
local TrackerTargetName = ""
local TrackerRuns = 1

-- Клик-ТП
local ClickTPKeyName = nil   -- по дефолту бинда НЕТ, юзер назначает сам (сохраняется Rayfield'ом)
local HeldKeys = {}          -- карта физически зажатых клавиш
local ClickTPDeadKey = nil   -- клавиша, заблокированная после сброса
local ClickTPSawListening = false -- видели "..." в квадратике (юзер начал переназначать)

local UIRefs = {
    Window = nil,
    AimbotToggle = nil,
    NoclipToggle = nil,
    ClickTPKeybind = nil,
    TrackToggle = nil,
    TargetDropdown = nil,
    LangHolder = nil,
    EnBtn = nil,
    RuBtn = nil,
}

local buildUI, switchLanguage, attachLangButtons

-- ================== FOV КРУГ ==================
local FovCircle = Drawing.new("Circle")
FovCircle.Color = Color3.fromRGB(255, 255, 255)
FovCircle.Thickness = 1.5
FovCircle.Filled = false
FovCircle.Transparency = 1
FovCircle.Visible = false

-- ================== ПОИСК МОДУЛЯ VEHICLEUTIL (в фоне) ==================
local VehicleUtil = nil
task.spawn(function()
    local ok, module = pcall(function()
        return require(
            ReplicatedStorage
                :WaitForChild("SharedModules", 10)
                :WaitForChild("VehicleUtil", 10)
        )
    end)
    if ok and type(module) == "table" then
        VehicleUtil = module
    end
end)

-- ================== ЛОГИКА СПИДХАКА АВТО ==================
local AC_CONFIG = {
    AIR_GUARD = 2.5,
    SAFE_MULTIPLIER = 2,
    VehicleAttrs = setmetatable({}, { __mode = "k" }),
}

AC_CONFIG.resolveGeometry = function()
    if AC_CONFIG.Geometry then return AC_CONFIG.Geometry end
    local ok, geometry = pcall(function()
        return require(ReplicatedStorage:WaitForChild("SharedModules", 5):WaitForChild("AntiCheatGeometry", 5))
    end)
    if ok and type(geometry) == "table" then
        AC_CONFIG.Geometry = geometry
    end
    return AC_CONFIG.Geometry
end

AC_CONFIG.updateAirborne = function(vehicle, deltaTime)
    local geometry = AC_CONFIG.resolveGeometry()
    if not vehicle or not geometry or type(geometry.IsVehicleGrounded) ~= "function" then
        AC_CONFIG.AirborneSince = nil
        return false
    end
    AC_CONFIG.GroundPoll = (AC_CONFIG.GroundPoll or 0) + deltaTime
    if AC_CONFIG.GroundPoll >= 0.15 then
        AC_CONFIG.GroundPoll = 0
        local ok, grounded = pcall(geometry.IsVehicleGrounded, vehicle)
        if ok and grounded then
            AC_CONFIG.AirborneSince = nil
        elseif ok and not AC_CONFIG.AirborneSince then
            AC_CONFIG.AirborneSince = os.clock()
        end
    end
    local since = AC_CONFIG.AirborneSince
    return since ~= nil and (os.clock() - since) >= AC_CONFIG.AIR_GUARD
end

AC_CONFIG.resolveVehicle = function(humanoid)
    if not humanoid then return nil end
    if VehicleUtil then
        local ok, vehicle = pcall(function()
            return VehicleUtil:GetHumanoidDrivenVehicle(humanoid)
        end)
        if ok and vehicle then return vehicle end
        local seat = humanoid.SeatPart
        if seat then
            local okPart, fallback = pcall(function()
                return VehicleUtil:GetVehicleModelFromPart(seat)
            end)
            if okPart and fallback then return fallback end
        end
    end
    local seat = humanoid.SeatPart
    local vehicles = Workspace:FindFirstChild("Vehicles")
    if not seat or not vehicles then return nil end
    local object = seat
    while object and object.Parent ~= vehicles do
        object = object.Parent
    end
    if object and object.Parent == vehicles and object:IsA("Model") then
        return object
    end
    return nil
end

AC_CONFIG.getSafeMultiplier = function()
    local multiplier = math.clamp(VehicleAltSpeed / 100, 1, 6)
    if VehicleSpeedMode == "Legit" and not VehicleAltRisky then
        multiplier = math.min(multiplier, AC_CONFIG.SAFE_MULTIPLIER)
    elseif VehicleSpeedMode == "Hard" then
        multiplier = math.clamp(VehicleAltSpeed / 50, 1, 12)
    end
    return multiplier
end

AC_CONFIG.boostVehicle = function(vehicle, seat, root)
    if not vehicle or not vehicle.Parent then return false end
    local saved = AC_CONFIG.VehicleAttrs[vehicle]
    if not saved then
        saved = {
            Top = vehicle:GetAttribute("TopSpeedMultiplier"),
            Power = vehicle:GetAttribute("EnginePowerMultiplier"),
        }
        AC_CONFIG.VehicleAttrs[vehicle] = saved
    end
    local top = saved.Top or 1
    local power = saved.Power or 1
    local multiplier = AC_CONFIG.getSafeMultiplier()
    local target = top * multiplier
    local current = vehicle:GetAttribute("TopSpeedMultiplier")

    if type(current) ~= "number" or math.abs(current - target) >= 0.001 then
        pcall(function()
            vehicle:SetAttribute("TopSpeedMultiplier", target)
            vehicle:SetAttribute("EnginePowerMultiplier", power * multiplier)
        end)
    end

    if seat and root and seat:IsA("VehicleSeat") then
        local isBackward = UserInputService:IsKeyDown(Enum.KeyCode.S) or UserInputService:IsKeyDown(Enum.KeyCode.Down) or seat.ThrottleFloat < 0
        if isBackward then
            local reverseForce = (multiplier - 1) * 15
            root.AssemblyLinearVelocity = root.AssemblyLinearVelocity + (-seat.CFrame.LookVector * reverseForce * RunService.Heartbeat:Wait())
        end
    end
end

AC_CONFIG.restoreVehicles = function()
    for vehicle, saved in pairs(AC_CONFIG.VehicleAttrs) do
        if vehicle and vehicle.Parent then
            pcall(function()
                vehicle:SetAttribute("TopSpeedMultiplier", saved.Top)
                vehicle:SetAttribute("EnginePowerMultiplier", saved.Power)
            end)
        end
        AC_CONFIG.VehicleAttrs[vehicle] = nil
    end
end

-- ================== АИМБОТ ==================
local function isTargetValid(targetPart)
    if not targetPart or not targetPart.Parent then return false end
    local char = targetPart.Parent
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    local myChar = LocalPlayer.Character
    local myHrp = myChar and myChar:FindFirstChild("HumanoidRootPart")

    if not humanoid or humanoid.Health <= 0 or not myHrp then return false end
    local studDistance = (targetPart.Position - myHrp.Position).Magnitude
    if studDistance > AimbotMaxDistance then return false end

    local camera = Workspace.CurrentCamera
    local _, onScreen = camera:WorldToViewportPoint(targetPart.Position)
    return onScreen
end

local function getClosestPlayer()
    local camera = Workspace.CurrentCamera
    local mousePos = UserInputService:GetMouseLocation()
    local closestPlayer = nil
    local shortestDistance = math.huge
    local myChar = LocalPlayer.Character
    local myHrp = myChar and myChar:FindFirstChild("HumanoidRootPart")

    if not myHrp then return nil end

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            if not (AimbotTeamCheck and player.Team and LocalPlayer.Team and player.Team == LocalPlayer.Team) then
                local char = player.Character
                local targetPart = char and char:FindFirstChild(AimbotPart)
                local humanoid = char and char:FindFirstChildOfClass("Humanoid")

                if targetPart and humanoid and humanoid.Health > 0 then
                    local studDistance = (targetPart.Position - myHrp.Position).Magnitude
                    if studDistance <= AimbotMaxDistance then
                        local screenPos, onScreen = camera:WorldToViewportPoint(targetPart.Position)
                        if onScreen then
                            local fovDistance = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                            if fovDistance <= AimbotFovRadius and fovDistance < shortestDistance then
                                shortestDistance = fovDistance
                                closestPlayer = targetPart
                            end
                        end
                    end
                end
            end
        end
    end
    return closestPlayer
end

AimbotLoop = RunService.RenderStepped:Connect(function()
    local mousePos = UserInputService:GetMouseLocation()
    FovCircle.Position = mousePos
    FovCircle.Radius = AimbotFovRadius
    FovCircle.Visible = AimbotShowFov and AimbotEnabled

    if AimbotEnabled then
        if not isTargetValid(CurrentTarget) then
            CurrentTarget = getClosestPlayer()
        end

        if CurrentTarget then
            local camera = Workspace.CurrentCamera
            local targetCF = CFrame.new(camera.CFrame.Position, CurrentTarget.Position)
            camera.CFrame = camera.CFrame:Lerp(targetCF, AimbotSmoothness)
        end
    else
        CurrentTarget = nil
    end
end)

-- ================== ESP ==================
local function getPlayerColor(player)
    local wantedLevel = player:GetAttribute("WantedLevel")
    local charWanted = player.Character and player.Character:GetAttribute("WantedLevel")

    if (typeof(wantedLevel) == "number" and wantedLevel > 0) or (typeof(charWanted) == "number" and charWanted > 0) or player:GetAttribute("Wanted") then
        return Color3.fromRGB(255, 50, 50)
    end

    local teamName = player.Team and player.Team.Name:lower() or ""

    if teamName:find("police") or teamName:find("cop") or teamName:find("sheriff") or teamName:find("police department") then
        return Color3.fromRGB(50, 120, 255)
    elseif teamName:find("border") or teamName:find("patrol") or teamName:find("guard") or teamName:find("army") or teamName:find("military") then
        return Color3.fromRGB(255, 220, 50)
    elseif teamName:find("civilian") or teamName:find("civil") or teamName:find("citizen") then
        return Color3.fromRGB(50, 255, 100)
    elseif player.TeamColor then
        return player.TeamColor.Color
    end

    return Color3.fromRGB(255, 255, 255)
end

local function removeEsp(player)
    if EspObjects[player] then
        if EspObjects[player].Highlight then EspObjects[player].Highlight:Destroy() end
        if EspObjects[player].Billboard then EspObjects[player].Billboard:Destroy() end
        if EspObjects[player].Connection then EspObjects[player].Connection:Disconnect() end
        EspObjects[player] = nil
    end
end

local function applyEsp(player)
    if player == LocalPlayer then return end
    removeEsp(player)

    if not EspEnabled then return end

    local char = player.Character
    if not char then return end
    local head = char:FindFirstChild("Head")
    if not head then return end

    local color = getPlayerColor(player)

    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP_Highlight"
    highlight.Adornee = char
    highlight.FillColor = color
    highlight.FillTransparency = 0.5
    highlight.OutlineColor = color
    highlight.OutlineTransparency = 0
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = char

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_Billboard"
    billboard.Adornee = head
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 2.5, 0)
    billboard.MaxDistance = EspMaxDistance
    billboard.AlwaysOnTop = true

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Parent = billboard
    nameLabel.Size = UDim2.new(1, 0, 1, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = player.Name
    nameLabel.TextColor3 = color
    nameLabel.TextStrokeTransparency = 0
    nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    nameLabel.Font = Enum.Font.SourceSansBold
    nameLabel.TextSize = 14

    billboard.Parent = head

    local conn = player:GetAttributeChangedSignal("WantedLevel"):Connect(function()
        if EspEnabled then applyEsp(player) end
    end)

    EspObjects[player] = { Highlight = highlight, Billboard = billboard, Connection = conn }
end

local function updateAllEsp()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            if EspEnabled then
                applyEsp(player)
            else
                removeEsp(player)
            end
        end
    end
end

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        task.wait(1)
        if EspEnabled then applyEsp(player) end
    end)
end)

Players.PlayerRemoving:Connect(removeEsp)

for _, player in ipairs(Players:GetPlayers()) do
    player.CharacterAdded:Connect(function()
        task.wait(1)
        if EspEnabled then applyEsp(player) end
    end)
end

-- ================== VFly (ЛОГИКА) ==================
local function stopVFly()
    if VFlyLoop then
        VFlyLoop:Disconnect()
        VFlyLoop = nil
    end
end

local function disableVFly(seat)
    VFlyEnabled = false
    stopVFly()

    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if hrp then
        hrp.AssemblyLinearVelocity = Vector3.zero
        hrp.AssemblyAngularVelocity = Vector3.zero
    end

    if seat and seat:IsA("BasePart") then
        local ok, root = pcall(function() return seat.AssemblyRootPart or seat end)
        if ok and root then
            pcall(function()
                root.AssemblyLinearVelocity = Vector3.zero
                root.AssemblyAngularVelocity = Vector3.zero
            end)
        end
    end

    pcall(function()
        if Rayfield and Rayfield.Notify then
            Rayfield:Notify({ Title = "Vehicle Fly", Content = L[Language].VFlyAutoOff, Duration = 2 })
        end
    end)
end

local function startVFly()
    if VFlyLoop then VFlyLoop:Disconnect() end
    VFlyLoop = RunService.RenderStepped:Connect(function()
        if not VFlyEnabled then return end

        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local seat = hum and hum.SeatPart

        if not (char and hum and hrp and seat) or hum.Health <= 0 then
            disableVFly(seat)
            return
        end

        local okAsm, stillInside = pcall(function()
            return hrp:GetRootPart() == seat:GetRootPart()
        end)
        if okAsm and not stillInside then
            disableVFly(seat)
            return
        end

        if (hrp.Position - seat.Position).Magnitude > 15 then
            disableVFly(seat)
            return
        end

        local root = seat.AssemblyRootPart or seat
        local camera = Workspace.CurrentCamera
        local moveDir = Vector3.zero

        if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir = moveDir - Vector3.new(0, 1, 0) end

        root.AssemblyLinearVelocity = moveDir * (VFlySpeed * 10)

        local lookDir = Vector3.new(camera.CFrame.LookVector.X, 0, camera.CFrame.LookVector.Z)
        if lookDir.Magnitude > 0.001 then
            root.CFrame = CFrame.lookAt(root.Position, root.Position + lookDir)
        end

        root.AssemblyAngularVelocity = Vector3.zero
    end)
end

-- ================== NOCLIP (ЛОГИКА) ==================
local function setNoclipState(state)
    NoclipEnabled = state

    if not state then
        local char = LocalPlayer.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") and not part:FindFirstAncestorOfClass("Accessory") then
                    part.CanCollide = true
                end
            end
        end
    end
end

NoclipLoop = RunService.Stepped:Connect(function()
    if not NoclipEnabled then return end
    local char = LocalPlayer.Character
    if not char then return end
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
        end
    end
end)

-- ================== КЛИК-ТП ==================
local function doClickTP()
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    local hrp = char and char:FindFirstChild("HumanoidRootPart")

    if not (hum and hrp) or hum.Health <= 0 then return end
    if hum.SeatPart then return end

    local mouse = LocalPlayer:GetMouse()
    local ray = mouse.UnitRay
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = { char }

    local result = workspace:Raycast(ray.Origin, ray.Direction * 5000, params)
    local targetPos = result and result.Position or (ray.Origin + ray.Direction * 5000)

    hrp.CFrame = CFrame.new(targetPos + Vector3.new(0, 3, 0))
end

-- Принятие бинда. Источник — только явное имя клавиши. Никаких «последних нажатий».
local function adoptClickTPKey(name)
    if type(name) ~= "string" then return end
    name = name:match("^%s*(.-)%s*$")
    if #name == 0 or #name > 20 then return end

    if name == "None" or name == "Unknown" then
        ClickTPKeyName = nil
        return
    end

    local ok, kc = pcall(function() return Enum.KeyCode[name] end)
    if not (ok and kc) then return end

    -- Клавиша, заблокированная сбросом, принимается только если юзер
    -- начал переназначение через квадратик (мы видели "...")
    if ClickTPDeadKey and name == ClickTPDeadKey and not ClickTPSawListening then
        return
    end

    ClickTPKeyName = name
    ClickTPDeadKey = nil
    ClickTPSawListening = false
end

-- Физический трекинг зажатых клавиш (по каждой отдельно)
local ClickTPKeyTracker = UserInputService.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Keyboard then
        HeldKeys[input.KeyCode.Name] = true
    end
end)

local ClickTPRelease = UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Keyboard then
        HeldKeys[input.KeyCode.Name] = nil
    end
end)

-- Зажат бинд + клик ЛКМ (не по GUI) = телепорт
local ClickTPClick = UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
    local k = ClickTPKeyName
    if k and HeldKeys[k] then
        doClickTP()
    end
end)

-- === Источник 1: callback квадратика — только ЯВНЫЙ аргумент-клавиша ===
local function makeClickTPCallback()
    return function(...)
        local args = { ... }
        task.defer(function()
            if not ScriptActive then return end
            for _, a in ipairs(args) do
                if typeof(a) == "EnumItem" and a.EnumType == Enum.KeyCode then
                    adoptClickTPKey(a.Name)
                    return
                elseif type(a) == "string" then
                    adoptClickTPKey(a)
                    return
                end
            end
        end)
    end
end

-- === Источник 2: Rayfield.Flags (внутреннее состояние квадрата) ===
local function getFlagKeybindValue()
    local ok, res = pcall(function()
        local flags = Rayfield and Rayfield.Flags
        if type(flags) ~= "table" then return nil end
        local el = flags["BindClickTP"]
        if type(el) ~= "table" then return nil end
        if type(el.CurrentKeybind) == "string" then return el.CurrentKeybind end
        if typeof(el.CurrentKeybind) == "EnumItem" then return el.CurrentKeybind.Name end
        return nil
    end)
    if ok then return res end
    return nil
end

-- === Источник 3: конфиг-файл Rayfield (куда он пишет бинды) ===
local RAYFIELD_CONFIG = "BullySDRP/Binds.json"

local function getFileKeybindValue()
    if type(readfile) ~= "function" or type(isfile) ~= "function" then return nil end
    local ok, res = pcall(function()
        if not isfile(RAYFIELD_CONFIG) then return nil end
        local data = HttpService:JSONDecode(readfile(RAYFIELD_CONFIG))
        if type(data) ~= "table" then return nil end
        local v = data["BindClickTP"]
        if v == nil and type(data.Flags) == "table" then v = data.Flags["BindClickTP"] end
        if type(v) == "table" then v = v.CurrentKeybind end
        if type(v) == "string" then
            return v:match("Enum%.KeyCode%.(.+)$") or v
        end
        return nil
    end)
    if ok then return res end
    return nil
end

-- === Источник 4: текст квадратика (резервный поиск по заголовку строки) ===
local function normalizeText(s)
    if type(s) ~= "string" then return "" end
    return s:lower():gsub("^%s+", ""):gsub("%s+$", "")
end

local function isValidKeyName(txt)
    if type(txt) ~= "string" then return false end
    txt = txt:match("^%s*(.-)%s*$")
    if #txt == 0 or #txt > 15 then return false end
    if txt == "None" then return true end
    local ok, kc = pcall(function() return Enum.KeyCode[txt] end)
    return ok and kc ~= nil
end

local ClickTPChipObj = nil

local function findClickTPChip()
    if ClickTPChipObj and ClickTPChipObj.Parent
        and (ClickTPChipObj:IsA("TextLabel") or ClickTPChipObj:IsA("TextButton")) then
        return ClickTPChipObj
    end
    ClickTPChipObj = nil

    local rayfieldGui = getGuiParent():FindFirstChild("Rayfield")
    if not rayfieldGui then return nil end

    local ntitle = normalizeText(L[Language].BindClickTPName)

    for _, d in ipairs(rayfieldGui:GetDescendants()) do
        if (d:IsA("TextLabel") or d:IsA("TextButton")) then
            local nt = normalizeText(d.Text)
            if #nt >= 6 and (nt == ntitle or nt:find(ntitle, 1, true) ~= nil or ntitle:find(nt, 1, true) ~= nil) then
                local containers = { d.Parent, d.Parent and d.Parent.Parent }
                local fallback = nil
                for _, container in ipairs(containers) do
                    if container then
                        for _, c in ipairs(container:GetDescendants()) do
                            if (c:IsA("TextLabel") or c:IsA("TextButton")) and c ~= d then
                                if isValidKeyName(c.Text) then
                                    if c:IsA("TextButton") then
                                        ClickTPChipObj = c
                                        return c
                                    elseif not fallback then
                                        fallback = c
                                    end
                                end
                            end
                        end
                    end
                end
                if fallback then
                    ClickTPChipObj = fallback
                    return fallback
                end
            end
        end
    end

    return nil
end

-- Опрос источников (0.25 сек)
task.spawn(function()
    while ScriptActive do
        task.wait(0.25)
        pcall(function()
            local v = getFlagKeybindValue()
            if v == nil then v = getFileKeybindValue() end

            if v == nil then
                local chip = findClickTPChip()
                if chip then
                    local txt = chip.Text:match("^%s*(.-)%s*$")
                    if txt == "..." or txt == "…" or txt == "" then
                        ClickTPSawListening = true
                        return
                    end
                    v = txt
                end
            end

            if v ~= nil then
                adoptClickTPKey(v)
            end
        end)
    end
end)

local function forceChipTextNone()
    pcall(function()
        local chip = findClickTPChip()
        if chip then
            chip.Text = "None"
        end
    end)
end

-- ================== ШИФТЛОК (жёсткая клавиша RightShift) ==================
ShiftLockLoop = RunService.RenderStepped:Connect(function()
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")

    if VehicleShiftLockEnabled and hum and hum.SeatPart then
        UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
    else
        if UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter and VehicleShiftLockEnabled then
            UserInputService.MouseBehavior = Enum.MouseBehavior.Default
        end
    end
end)

local ShiftLockConnection
ShiftLockConnection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.RightShift then
        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum and hum.SeatPart then
            VehicleShiftLockEnabled = not VehicleShiftLockEnabled
            if not VehicleShiftLockEnabled then
                UserInputService.MouseBehavior = Enum.MouseBehavior.Default
            end
        end
    end
end)

-- ================== УДАЛЕНИЕ: ШЛАГБАУМЫ ==================
local RemovedGates = {}

local function collectGates()
    local list = {}

    local map = Workspace:FindFirstChild("Map")
    local static = map and map:FindFirstChild("Static")
    local global = static and static:FindFirstChild("Global")
    local gatesFolder = global and global:FindFirstChild("Gates")

    if gatesFolder then
        for _, obj in ipairs(gatesFolder:GetChildren()) do
            if obj.Name == "Gate" then
                table.insert(list, obj)
            end
        end
    end

    if #list == 0 then
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj:IsA("Model") and obj.Name == "Gate" and obj.Parent and obj.Parent.Name == "Gates" then
                table.insert(list, obj)
            end
        end
    end

    return list
end

local function toggleGates(state)
    if state then
        local removed = 0
        for _, gate in ipairs(collectGates()) do
            local parent = gate.Parent
            local ok = pcall(function() gate.Parent = nil end)
            if ok then
                table.insert(RemovedGates, { obj = gate, parent = parent })
                removed = removed + 1
            end
        end
        return removed
    else
        local restored = 0
        for i = #RemovedGates, 1, -1 do
            local entry = RemovedGates[i]
            if entry.obj and entry.parent and entry.parent.Parent then
                if pcall(function() entry.obj.Parent = entry.parent end) then
                    restored = restored + 1
                end
            end
            table.remove(RemovedGates, i)
        end
        return restored
    end
end

-- ================== УДАЛЕНИЕ: СТЕНЫ БАНКА ==================
local RemovedBankObjects = {}

local function toggleBankWalls(state)
    if state then
        local removed = 0
        local toDetach = {}

        local partTargets = {
            { Size = Vector3.new(75, 1.5, 17.5), Pos = Vector3.new(-236.858, 4.839, -261.628) },
            { Size = Vector3.new(74, 2.5, 0.01), Pos = Vector3.new(-236.359, -2.661, -262.403) },
            { Size = Vector3.new(6, 1, 10.5), Pos = Vector3.new(-274.108, 2.089, -251.878) },
            { Size = Vector3.new(6, 1, 10.5), Pos = Vector3.new(-274.108, 2.089, -245.378) },
            { Size = Vector3.new(20, 13.5, 0.5), Pos = Vector3.new(-273.608, 1.839, -233.228) },
            { Size = Vector3.new(6, 1, 10.5), Pos = Vector3.new(-274.108, 2.089, -238.878) },
        }

        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj:IsA("BasePart") then
                for _, target in ipairs(partTargets) do
                    local sizeMatch = (obj.Size - target.Size).Magnitude < 0.5
                    local posMatch = (obj.CFrame.Position - target.Pos).Magnitude < 3.0

                    if sizeMatch and posMatch then
                        table.insert(toDetach, obj)
                        break
                    end
                end
            end
        end

        local bank = Workspace:FindFirstChild("Gameplay") and Workspace.Gameplay:FindFirstChild("Bank")
        if bank then
            local building = bank:FindFirstChild("Building")
            local sewer = building and building:FindFirstChild("Sewer")
            if sewer then
                for _, model in ipairs(sewer:GetChildren()) do
                    if model:IsA("Model") and (model.Name == "SewerPipe1" or model.Name == "SewerPipe4") then
                        table.insert(toDetach, model)
                    end
                end
            end

            local escapeC4 = bank:FindFirstChild("EscapeC4")
            if escapeC4 then
                for _, obj in ipairs(escapeC4:GetDescendants()) do
                    if obj.Name == "SurroundWall" then
                        table.insert(toDetach, obj)
                    end
                end
            end
        end

        for _, obj in ipairs(toDetach) do
            local parent = obj.Parent
            if parent then
                local ok = pcall(function() obj.Parent = nil end)
                if ok then
                    table.insert(RemovedBankObjects, { obj = obj, parent = parent })
                    removed = removed + 1
                end
            end
        end

        return removed
    else
        local restored = 0
        for i = #RemovedBankObjects, 1, -1 do
            local entry = RemovedBankObjects[i]
            if entry.obj and entry.parent and entry.parent.Parent then
                if pcall(function() entry.obj.Parent = entry.parent end) then
                    restored = restored + 1
                end
            end
            table.remove(RemovedBankObjects, i)
        end
        return restored
    end
end

-- ================== ЦИКЛЫ СПИДХАКОВ ==================
local PlayerLoop = RunService.Heartbeat:Connect(function()
    if PlayerSpeedEnabled and UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
        local char = LocalPlayer.Character
        if char then
            local hrp = char:FindFirstChild("HumanoidRootPart")
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hrp and hum and hum.MoveDirection.Magnitude > 0 and not hum.SeatPart then
                hrp.CFrame = hrp.CFrame + (hum.MoveDirection * (PlayerSpeed * 0.1))
            end
        end
    end
end)

local VehicleLoop = RunService.Heartbeat:Connect(function(deltaTime)
    local altHeld = UserInputService:IsKeyDown(Enum.KeyCode.LeftAlt) or UserInputService:IsKeyDown(Enum.KeyCode.RightAlt)

    if VehicleSpeedEnabled and altHeld then
        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum and hum.SeatPart then
            local seat = hum.SeatPart
            local root = seat.AssemblyRootPart or seat
            if root then
                local vehicle = AC_CONFIG.resolveVehicle(hum)
                if AC_CONFIG.updateAirborne(vehicle, deltaTime) then
                    local velocity = root.AssemblyLinearVelocity
                    root.AssemblyLinearVelocity = Vector3.new(velocity.X, math.min(velocity.Y, -40), velocity.Z)
                else
                    AC_CONFIG.boostVehicle(vehicle, seat, root)
                end
            end
        end
    else
        AC_CONFIG.restoreVehicles()
    end
end)

-- ================== АВТО-РАБОТА (BOXJOB) ==================
local function moveToTargetForJob(pos)
    local char = LocalPlayer.Character
    if not char then return false end
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    local rootPart = char:FindFirstChild("HumanoidRootPart")

    if humanoid and rootPart then
        humanoid:MoveTo(pos)

        local startTime = tick()
        repeat
            task.wait(0.1)
            if not BoxJobEnabled or not BoxJobActiveRoutine then
                humanoid:MoveTo(rootPart.Position)
                return false
            end
        until (rootPart.Position - pos).Magnitude < 4 or (tick() - startTime) > 10

        return true
    end
    return false
end

task.spawn(function()
    while BoxJobActiveRoutine do
        if BoxJobEnabled then
            local reachedFetch = moveToTargetForJob(FETCH_POS)

            if reachedFetch and BoxJobEnabled and BoxJobActiveRoutine then
                pcall(function()
                    local fetchArgs = {
                        Workspace:WaitForChild("Gameplay"):WaitForChild("BoxJob"):WaitForChild("PromptParts"):WaitForChild("FetchPromptPart")
                    }
                    ReplicatedStorage:WaitForChild("__remotes"):WaitForChild("BoxJobService"):WaitForChild("FetchBox"):FireServer(unpack(fetchArgs))
                end)
                task.wait(0.5)
            end

            if BoxJobEnabled and BoxJobActiveRoutine then
                local reachedDeliver = moveToTargetForJob(DELIVER_POS)

                if reachedDeliver and BoxJobEnabled and BoxJobActiveRoutine then
                    pcall(function()
                        local deliverArgs = {
                            Workspace:WaitForChild("Gameplay"):WaitForChild("BoxJob"):WaitForChild("PromptParts"):WaitForChild("DeliverPromptPart")
                        }
                        ReplicatedStorage:WaitForChild("__remotes"):WaitForChild("BoxJobService"):WaitForChild("DeliverBox"):FireServer(unpack(deliverArgs))
                    end)
                    task.wait(0.5)
                end
            end
        else
            task.wait(0.2)
        end
    end
end)

-- ================== ТРЕКЕР ЦЕЛИ ==================
local function getPlayerNames()
    local names = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            table.insert(names, p.Name)
        end
    end
    table.sort(names)
    return names
end

local function refreshTargetDropdown()
    if UIRefs.TargetDropdown then
        pcall(function()
            UIRefs.TargetDropdown:Refresh(getPlayerNames())
        end)
    end
end

local function stopTracker()
    TrackerRunning = false
    if TrackerConnection then
        TrackerConnection:Disconnect()
        TrackerConnection = nil
    end
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum then hum.WalkSpeed = 16 end
end

Players.PlayerAdded:Connect(function()
    task.defer(refreshTargetDropdown)
end)
Players.PlayerRemoving:Connect(function()
    task.defer(refreshTargetDropdown)
end)

-- ================== УТИЛИТЫ GUI ==================
local function applyBottomPadding()
    local rayfieldGui = getGuiParent():FindFirstChild("Rayfield")
    if not rayfieldGui then return end
    for _, sf in ipairs(rayfieldGui:GetDescendants()) do
        if sf:IsA("ScrollingFrame") then
            local skip = false

            for _, child in ipairs(sf:GetChildren()) do
                if child:IsA("UIListLayout") and child.FillDirection == Enum.FillDirection.Horizontal then
                    skip = true
                    break
                end
            end

            if not skip and sf:FindFirstAncestor("Topbar") then
                skip = true
            end

            if not skip and sf.AbsoluteSize.Y > 0 and sf.AbsoluteSize.Y < 80 then
                skip = true
            end

            if not skip then
                local pad = sf:FindFirstChild("BULLY_BottomPad")
                if not pad then
                    pad = Instance.new("UIPadding")
                    pad.Name = "BULLY_BottomPad"
                    pad.Parent = sf
                end
                pad.PaddingBottom = UDim.new(0, 60)
            end
        end
    end
end

-- ================== КНОПКИ EN/RU ==================
local LangActiveColor = Color3.fromRGB(0, 120, 255)
local LangInactiveColor = Color3.fromRGB(40, 40, 40)

local function styleLangButtons()
    if UIRefs.EnBtn and UIRefs.EnBtn.Parent then
        UIRefs.EnBtn.BackgroundColor3 = (Language == "EN") and LangActiveColor or LangInactiveColor
    end
    if UIRefs.RuBtn and UIRefs.RuBtn.Parent then
        UIRefs.RuBtn.BackgroundColor3 = (Language == "RU") and LangActiveColor or LangInactiveColor
    end
end

attachLangButtons = function()
    if not ScriptActive then return end

    task.delay(0.6, function()
        if not ScriptActive then return end

        if UIRefs.LangHolder and UIRefs.LangHolder.Parent then
            UIRefs.LangHolder:Destroy()
        end
        UIRefs.LangHolder = nil
        UIRefs.EnBtn = nil
        UIRefs.RuBtn = nil

        local rayfieldGui = getGuiParent():FindFirstChild("Rayfield")
        if not rayfieldGui then return end

        local main = rayfieldGui:FindFirstChild("Main") or rayfieldGui:FindFirstChildWhichIsA("Frame")
        if not main then return end

        local topbar = main:FindFirstChild("Topbar")

        local holder = Instance.new("Frame")
        holder.Name = "BULLY_LangSwitch"
        holder.BackgroundTransparency = 1
        holder.Size = UDim2.new(0, 92, 0, 24)
        holder.ZIndex = 100

        if topbar then
            holder.AnchorPoint = Vector2.new(1, 0.5)
            holder.Position = UDim2.new(1, -135, 0.5, 0)
            holder.Parent = topbar
        else
            holder.AnchorPoint = Vector2.new(1, 0)
            holder.Position = UDim2.new(1, -145, 0, 9)
            holder.Parent = main
        end
        UIRefs.LangHolder = holder

        local layout = Instance.new("UIListLayout")
        layout.FillDirection = Enum.FillDirection.Horizontal
        layout.VerticalAlignment = Enum.VerticalAlignment.Center
        layout.HorizontalAlignment = Enum.HorizontalAlignment.Right
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Padding = UDim.new(0, 5)
        layout.Parent = holder

        local function makeBtn(name, text, order)
            local b = Instance.new("TextButton")
            b.Name = name
            b.LayoutOrder = order
            b.Size = UDim2.new(0, 43, 0, 22)
            b.Text = text
            b.Font = Enum.Font.GothamBold
            b.TextSize = 12
            b.TextColor3 = Color3.fromRGB(255, 255, 255)
            b.AutoButtonColor = false
            b.BackgroundColor3 = LangInactiveColor
            b.ZIndex = 101
            b.Parent = holder

            local c = Instance.new("UICorner")
            c.CornerRadius = UDim.new(0, 6)
            c.Parent = b

            local s = Instance.new("UIStroke")
            s.Color = Color3.fromRGB(70, 70, 70)
            s.Thickness = 1
            s.Parent = b

            return b
        end

        UIRefs.EnBtn = makeBtn("LangEN", "EN", 1)
        UIRefs.RuBtn = makeBtn("LangRU", "RU", 2)

        UIRefs.EnBtn.MouseButton1Click:Connect(function() switchLanguage("EN") end)
        UIRefs.RuBtn.MouseButton1Click:Connect(function() switchLanguage("RU") end)

        styleLangButtons()
    end)
end

-- ================== КОНВЕРТАЦИЯ ОТОБРАЖЕНИЙ ==================
local function modeDisplay(mode)
    local t = L[Language]
    return (mode == "Legit") and t.ModeLegit or t.ModeHard
end

local function modeFromDisplay(display)
    local t = L[Language]
    if display == t.ModeLegit then return "Legit" end
    if display == t.ModeHard then return "Hard" end
    return "Legit"
end

local function partDisplay(part)
    local t = L[Language]
    return (part == "Head") and t.PartHead or t.PartBody
end

local function partFromDisplay(display)
    local t = L[Language]
    if display == t.PartHead then return "Head" end
    if display == t.PartBody then return "HumanoidRootPart" end
    return "Head"
end

-- ================== ПОСТРОЕНИЕ ИНТЕРФЕЙСА ==================
buildUI = function()
    if not ScriptActive then return end
    local t = L[Language]

    pcall(function()
        local old = getGuiParent():FindFirstChild("Rayfield")
        if old then old:Destroy() end
    end)

    local ok = pcall(function()
        Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
    end)
    if not ok or not Rayfield then return end

    local Window = Rayfield:CreateWindow({
        Name = "BULLY | San Diego Border RP",
        LoadingTitle = t.LoadingTitle,
        ConfigurationSaving = {
            Enabled = true,
            FolderName = "BullySDRP",
            FileName = "Binds"
        },
        KeySystem = false
    })
    UIRefs.Window = Window

    local VehicleTab = Window:CreateTab(t.VehicleTab, 4483362458)
    local PlayerTab = Window:CreateTab(t.PlayerTab, 4483362458)
    local CombatTab = Window:CreateTab(t.CombatTab, 4483362458)
    local VisualTab = Window:CreateTab(t.VisualTab, 4483362458)
    local FunctionsTab = Window:CreateTab(t.FunctionsTab, 4483362458)
    local SettingsTab = Window:CreateTab(t.SettingsTab, 4483362458)

    -- ---------- Vehicle ----------
    VehicleTab:CreateSection(t.VehicleSection)
    VehicleTab:CreateToggle({
        Name = t.VehicleSpeed,
        CurrentValue = VehicleSpeedEnabled,
        Callback = function(v)
            VehicleSpeedEnabled = v
            if not v then AC_CONFIG.restoreVehicles() end
        end
    })
    VehicleTab:CreateDropdown({
        Name = t.VehicleMode,
        Options = { t.ModeLegit, t.ModeHard },
        CurrentOption = { modeDisplay(VehicleSpeedMode) },
        MultipleOptions = false,
        Callback = function(v)
            VehicleSpeedMode = modeFromDisplay(v[1] or v)
            AC_CONFIG.restoreVehicles()
        end
    })
    VehicleTab:CreateSlider({
        Name = t.Speed,
        Range = { 100, 400 },
        Increment = 5,
        CurrentValue = VehicleAltSpeed,
        Callback = function(v) VehicleAltSpeed = v end
    })
    VehicleTab:CreateToggle({
        Name = t.AntiTip,
        CurrentValue = VehicleAltRisky,
        Callback = function(v) VehicleAltRisky = v end
    })

    VehicleTab:CreateSection(t.BindsSection)
    VehicleTab:CreateKeybind({
        Name = t.BindFlyName,
        Flag = "BindVFly",
        CurrentKeybind = "L",
        HoldToInteract = false,
        Callback = function()
            local char = LocalPlayer.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if hum and hum.SeatPart then
                VFlyEnabled = not VFlyEnabled
                if VFlyEnabled then
                    startVFly()
                else
                    stopVFly()
                end
            end
        end
    })
    VehicleTab:CreateKeybind({
        Name = t.BindUnstuckName,
        Flag = "BindUnstuck",
        CurrentKeybind = "R",
        HoldToInteract = false,
        Callback = function()
            local remotes = ReplicatedStorage:FindFirstChild("__remotes")
            local vehicleService = remotes and remotes:FindFirstChild("VehicleService")
            local unstuckRemote = vehicleService and vehicleService:FindFirstChild("UnstuckVehicle")
            if unstuckRemote then
                unstuckRemote:FireServer()
            end
        end
    })
    VehicleTab:CreateLabel(t.ShiftLockLabel)

    -- ---------- Combat (Аимбот) ----------
    CombatTab:CreateSection(t.AimbotSection)
    UIRefs.AimbotToggle = CombatTab:CreateToggle({
        Name = t.AimbotToggle,
        CurrentValue = AimbotEnabled,
        Callback = function(v) AimbotEnabled = v if not v then CurrentTarget = nil end end
    })
    CombatTab:CreateKeybind({
        Name = t.BindAimbotName,
        Flag = "BindAimbot",
        CurrentKeybind = "Q",
        HoldToInteract = false,
        Callback = function()
            AimbotEnabled = not AimbotEnabled
            if not AimbotEnabled then CurrentTarget = nil end
            if UIRefs.AimbotToggle then
                pcall(function() UIRefs.AimbotToggle:Set(AimbotEnabled) end)
            end
        end
    })
    CombatTab:CreateSlider({
        Name = t.Smoothness,
        Range = { 0.05, 1 },
        Increment = 0.05,
        CurrentValue = AimbotSmoothness,
        Callback = function(v) AimbotSmoothness = v end
    })
    CombatTab:CreateSlider({
        Name = t.MaxDistance,
        Range = { 50, 1000 },
        Increment = 25,
        CurrentValue = AimbotMaxDistance,
        Callback = function(v) AimbotMaxDistance = v end
    })
    CombatTab:CreateDropdown({
        Name = t.TargetPart,
        Options = { t.PartHead, t.PartBody },
        CurrentOption = { partDisplay(AimbotPart) },
        MultipleOptions = false,
        Callback = function(v) AimbotPart = partFromDisplay(v[1] or v) end
    })
    CombatTab:CreateToggle({
        Name = t.TeamCheck,
        CurrentValue = AimbotTeamCheck,
        Callback = function(v) AimbotTeamCheck = v end
    })

    CombatTab:CreateSection(t.FovSection)
    CombatTab:CreateToggle({
        Name = t.ShowFov,
        CurrentValue = AimbotShowFov,
        Callback = function(v) AimbotShowFov = v end
    })
    CombatTab:CreateSlider({
        Name = t.FovRadius,
        Range = { 20, 500 },
        Increment = 5,
        CurrentValue = AimbotFovRadius,
        Callback = function(v) AimbotFovRadius = v end
    })

    -- ---------- Player ----------
    PlayerTab:CreateSection(t.MovementSection)
    PlayerTab:CreateToggle({
        Name = t.PlayerSpeedHack,
        CurrentValue = PlayerSpeedEnabled,
        Callback = function(v) PlayerSpeedEnabled = v end
    })
    PlayerTab:CreateSlider({
        Name = t.Speed,
        Range = { 0, 5 },
        Increment = 0.1,
        CurrentValue = PlayerSpeed,
        Callback = function(v) PlayerSpeed = v end
    })

    PlayerTab:CreateSection(t.NoclipSection)
    UIRefs.NoclipToggle = PlayerTab:CreateToggle({
        Name = t.NoclipToggle,
        CurrentValue = NoclipEnabled,
        Callback = function(v) setNoclipState(v) end
    })
    PlayerTab:CreateKeybind({
        Name = t.BindNoclipName,
        Flag = "BindNoclip",
        CurrentKeybind = "N",
        HoldToInteract = false,
        Callback = function()
            setNoclipState(not NoclipEnabled)
            if UIRefs.NoclipToggle then
                pcall(function() UIRefs.NoclipToggle:Set(NoclipEnabled) end)
            end
        end
    })

    PlayerTab:CreateSection(t.TeleportSection)
    -- Родной квадратик. Дефолта НЕТ — юзер назначает сам, Rayfield сохраняет выбор.
    UIRefs.ClickTPKeybind = PlayerTab:CreateKeybind({
        Name = t.BindClickTPName,
        Flag = "BindClickTP",
        CurrentKeybind = "None",
        HoldToInteract = false,
        Callback = makeClickTPCallback()
    })
    PlayerTab:CreateButton({
        Name = t.ClickTPReset,
        Callback = function()
            ClickTPDeadKey = ClickTPKeyName
            ClickTPKeyName = nil
            ClickTPSawListening = false
            pcall(function()
                if UIRefs.ClickTPKeybind and UIRefs.ClickTPKeybind.Set then
                    UIRefs.ClickTPKeybind:Set("None")
                end
            end)
            forceChipTextNone()
            Rayfield:Notify({ Title = "Click TP", Content = t.NotifyTPReset, Duration = 2 })
        end
    })
    -- Маленький прозрачный отступ (10px)
    local spacer = PlayerTab:CreateLabel("")
    pcall(function()
        local o = spacer and spacer.Object
        if o and o:IsA("GuiObject") then
            o.Size = UDim2.new(1, 0, 0, 10)
            o.BackgroundTransparency = 1
            if o:IsA("TextLabel") then o.Text = "" end
        end
    end)
    PlayerTab:CreateLabel(t.ClickTPLabel)

    -- ---------- Visual ----------
    VisualTab:CreateSection(t.PlayersSection)
    VisualTab:CreateToggle({
        Name = t.PlayerEsp,
        CurrentValue = EspEnabled,
        Callback = function(v)
            EspEnabled = v
            updateAllEsp()
        end
    })

    -- ---------- Functions (УДАЛЕНИЕ — ПЕРВЫЙ РАЗДЕЛ) ----------
    FunctionsTab:CreateSection(t.DeletionSection)

    -- Шлагбаумы
    FunctionsTab:CreateToggle({
        Name = t.Gates,
        CurrentValue = (#RemovedGates > 0),
        Callback = function(v)
            local count = toggleGates(v)
            local msgKey = v and L[Language].NotifyRemoved or L[Language].NotifyRestored
            if count > 0 then
                Rayfield:Notify({ Title = L[Language].NotifySuccess, Content = msgKey .. count, Duration = 3 })
            else
                Rayfield:Notify({ Title = L[Language].NotifyInfo, Content = L[Language].NotifyNotFound, Duration = 3 })
            end
        end
    })

    -- Стены банка
    FunctionsTab:CreateToggle({
        Name = t.BankWall,
        CurrentValue = (#RemovedBankObjects > 0),
        Callback = function(v)
            local count = toggleBankWalls(v)
            local msgKey = v and L[Language].NotifyRemoved or L[Language].NotifyRestored
            if count > 0 then
                Rayfield:Notify({ Title = L[Language].NotifySuccess, Content = msgKey .. count, Duration = 3 })
            else
                Rayfield:Notify({ Title = L[Language].NotifyInfo, Content = L[Language].NotifyNotFound, Duration = 3 })
            end
        end
    })

    -- ---------- Авто (авто-работа) ----------
    FunctionsTab:CreateSection(t.JobsSection)
    FunctionsTab:CreateToggle({
        Name = t.AutoJob,
        CurrentValue = BoxJobEnabled,
        Callback = function(v)
            BoxJobEnabled = v
            if not v then
                local char = LocalPlayer.Character
                if char and char:FindFirstChildOfClass("Humanoid") then
                    char:FindFirstChildOfClass("Humanoid"):MoveTo(char.HumanoidRootPart.Position)
                end
            end
        end
    })

    -- ---------- Передача денег (обычная секция) ----------
    FunctionsTab:CreateSection(t.TrackerSection)

    UIRefs.TargetDropdown = FunctionsTab:CreateDropdown({
        Name = t.SelectTarget,
        Options = getPlayerNames(),
        CurrentOption = (TrackerTargetName ~= "" and { TrackerTargetName }) or {},
        MultipleOptions = false,
        Callback = function(v)
            TrackerTargetName = v[1] or v
        end
    })

    FunctionsTab:CreateButton({
        Name = t.RefreshList,
        Callback = function()
            refreshTargetDropdown()
            Rayfield:Notify({ Title = "Tracker", Content = L[Language].NotifyListUpdated, Duration = 2 })
        end
    })

    FunctionsTab:CreateInput({
        Name = t.RepeatCount,
        PlaceholderText = t.RepeatPlaceholder,
        RemoveTextAfterFocusLost = false,
        Callback = function(text)
            TrackerRuns = tonumber(text) or TrackerRuns
        end
    })

    UIRefs.TrackToggle = FunctionsTab:CreateToggle({
        Name = t.RunToggle,
        CurrentValue = TrackerRunning,
        Callback = function(v)
            if v then
                local target = Players:FindFirstChild(TrackerTargetName)
                if not target or not target.Character then
                    Rayfield:Notify({ Title = "Tracker", Content = L[Language].NotifyPlayerNotFound, Duration = 2 })
                    if UIRefs.TrackToggle then UIRefs.TrackToggle:Set(false) end
                    return
                end

                TrackerRunning = true
                local maxRuns = math.max(1, math.floor(TrackerRuns or 1))
                local currentRuns = 0

                local function startRun()
                    if not TrackerRunning then return end
                    if currentRuns >= maxRuns then
                        stopTracker()
                        if UIRefs.TrackToggle then UIRefs.TrackToggle:Set(false) end
                        return
                    end
                    if TrackerConnection then TrackerConnection:Disconnect() end

                    TrackerConnection = RunService.RenderStepped:Connect(function()
                        if not TrackerRunning then return end

                        local char = LocalPlayer.Character
                        local hum = char and char:FindFirstChildOfClass("Humanoid")
                        local root = char and char:FindFirstChild("HumanoidRootPart")
                        local tChar = target.Character
                        local tRoot = tChar and tChar:FindFirstChild("HumanoidRootPart")

                        if not hum or not root or not tRoot or hum.Health <= 0 then
                            return
                        end

                        hum.WalkSpeed = 24
                        hum:MoveTo(tRoot.Position)

                        if (root.Position - tRoot.Position).Magnitude <= 4 then
                            currentRuns = currentRuns + 1
                            if TrackerConnection then TrackerConnection:Disconnect() end

                            hum.Health = 0

                            if currentRuns < maxRuns then
                                task.spawn(function()
                                    LocalPlayer.CharacterAdded:Wait()
                                    task.wait(0.5)
                                    startRun()
                                end)
                            else
                                stopTracker()
                                if UIRefs.TrackToggle then UIRefs.TrackToggle:Set(false) end
                                Rayfield:Notify({ Title = "Tracker", Content = L[Language].NotifyDone .. maxRuns .. L[Language].NotifyTimes, Duration = 2 })
                            end
                        end
                    end)
                end

                startRun()
            else
                stopTracker()
            end
        end
    })

    -- ---------- Settings (ВЫХОД — ПЕРВАЯ) ----------
    SettingsTab:CreateSection(t.MainSection)
    SettingsTab:CreateButton({
        Name = t.Unload,
        Callback = function()
            ScriptActive = false
            PlayerSpeedEnabled = false
            NoclipEnabled = false
            setNoclipState(false)
            VehicleSpeedEnabled = false
            EspEnabled = false
            VFlyEnabled = false
            VehicleShiftLockEnabled = false
            BoxJobEnabled = false
            BoxJobActiveRoutine = false
            AimbotEnabled = false
            CurrentTarget = nil
            ClickTPKeyName = nil
            ClickTPDeadKey = nil
            HeldKeys = {}
            stopTracker()
            FovCircle.Visible = false
            pcall(function() FovCircle:Remove() end)
            UserInputService.MouseBehavior = Enum.MouseBehavior.Default
            stopVFly()
            updateAllEsp()
            AC_CONFIG.restoreVehicles()
            if PlayerLoop then PlayerLoop:Disconnect() end
            if VehicleLoop then VehicleLoop:Disconnect() end
            if NoclipLoop then NoclipLoop:Disconnect() end
            if ShiftLockLoop then ShiftLockLoop:Disconnect() end
            if ShiftLockConnection then ShiftLockConnection:Disconnect() end
            if AimbotLoop then AimbotLoop:Disconnect() end
            if ClickTPKeyTracker then ClickTPKeyTracker:Disconnect() end
            if ClickTPRelease then ClickTPRelease:Disconnect() end
            if ClickTPClick then ClickTPClick:Disconnect() end
            if UIRefs.Window then pcall(function() UIRefs.Window:Destroy() end) end
            pcall(function()
                local old = getGuiParent():FindFirstChild("Rayfield")
                if old then old:Destroy() end
            end)
        end
    })

    task.delay(0.5, function() if ScriptActive then applyBottomPadding() end end)
    task.delay(1.5, function() if ScriptActive then applyBottomPadding() end end)

    attachLangButtons()
end

-- ================== ПЕРЕКЛЮЧЕНИЕ ЯЗЫКА ==================
switchLanguage = function(lang)
    if Language == lang or not ScriptActive then return end
    Language = lang
    saveLanguage()
    buildUI()
    Rayfield:Notify({
        Title = L[lang].NotifyLangTitle,
        Content = (lang == "EN") and L.EN.NotifyLangEn or L.RU.NotifyLangRu,
        Duration = 2
    })
end

-- ================== СТАРТ ==================
local ok, err = pcall(function()
    Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
end)
if ok and Rayfield then
    buildUI()
end
