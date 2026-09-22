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

-- ================== ФАЙЛЫ ==================
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

-- ================== ЗАЩИТА ОТ ДУБЛЕЙ ==================
local function getEnv()
    if type(getgenv) == "function" then
        local ok, env = pcall(getgenv)
        if ok and type(env) == "table" then return env end
    end
    return _G
end

local RUN_TOKEN = {}
getEnv().BULLY_SDRP_RUN = RUN_TOKEN

local function runDead()
    if not ScriptActive then return true end
    return getEnv().BULLY_SDRP_RUN ~= RUN_TOKEN
end

-- ================== ЛОКАЛИЗАЦИЯ ==================
local L = {
    EN = {
        LoadingTitle = "Loading...",
        VehicleTab = "Vehicle", PlayerTab = "Player", CombatTab = "Aimbot",
        VisualTab = "Visual",
        FunctionsTab = "Functions", SettingsTab = "Settings",

        VehicleSection = "Vehicle Control",
        VehicleSpeed = "SpeedHack [Ctrl]",
        VehicleMode = "SpeedHack Mode",
        ModeLegit = "Legit",
        ModeHard = "Hard",
        BindsSection = "Hotkeys (Binds)",
        ShiftLockLabel = "Vehicle Shift Lock — [RightShift]",

        FlySection = "Vehicle Fly",
        FlyToggle = "Vehicle Fly",

        BindSpeedName = "SpeedHack Key",

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
        NoclipToggle = "Noclip",
        BindNoclipName = "Noclip Key",
        NotifyNoclipOn = "Noclip enabled",
        NotifyNoclipOff = "Noclip disabled",

        TeleportSection = "Click TP",

        PlayersSection = "Players",
        PlayerEsp = "Player ESP",
        EspDistance = "Nickname Distance (Studs)",

        DeletionSection = "Object Deletion",
        Gates = "Barriers",
        BankWall = "Bank Walls",
        NotifySuccess = "Success",
        NotifyRemoved = "Removed objects: ",
        NotifyRestored = "Restored objects: ",
        NotifyInfo = "Info",
        NotifyNotFound = "Objects not found or already removed",

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
        BindUnstuckName = "Unstuck Vehicle",

        VFlyAutoOff = "Fly disabled (left the vehicle)",

        ConfigSection = "Configs [PRO]",
        ConfigInfo = "You can save your own settings to a config.",
        ConfigName = "Config Name",
        ConfigPlaceholder = "Enter config name...",
        SaveConfigBtn = "Save Config",
        ConfigList = "Saved Configs",
        LoadConfigBtn = "Load Config",
        DeleteConfigBtn = "Delete Config",
        AutoLoadConfig = "Autoload on inject",
        AutoLoadNone = "(Off)",

        NotifyProOnly = "This feature is available only in the PRO version",

        ProTextTitle = "This is the FREE version of the script with limited access to features.",
        ProTextBody = "\nThe FULL version includes:\n• Vehicle Fly\n• Hard mode for vehicle SpeedHack\n• Click Teleport\n• Bank Walls removal\n• Saving all settings to configs\n\nAnd access anytime without watching ads — forever.",
        ProBtn = "GET FULL ACCESS",
        NotifyCopied = "LINK COPIED!",
    },
    RU = {
        LoadingTitle = "Загрузка...",
        VehicleTab = "Транспорт", PlayerTab = "Игрок", CombatTab = "Аимбот",
        VisualTab = "Визуал",
        FunctionsTab = "Функции", SettingsTab = "Настройки",

        VehicleSection = "Управление машиной",
        VehicleSpeed = "Спидхак [Ctrl]",
        VehicleMode = "Режим спидхака",
        ModeLegit = "Обычный",
        ModeHard = "Хард",
        BindsSection = "Горячие клавиши",
        ShiftLockLabel = "Шифтлок в транспорте — [RightShift]",

        FlySection = "Полёт машины",
        FlyToggle = "Полёт на транспорте",

        BindSpeedName = "Клавиша спидхака",

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
        NotifyNoclipOn = "Ноуклип включен",
        NotifyNoclipOff = "Ноуклип выключен",

        TeleportSection = "Клик-ТП",

        PlayersSection = "Игроки",
        PlayerEsp = "ESP игроков",
        EspDistance = "Дистанция ников (студы)",

        DeletionSection = "Удаление объектов",
        Gates = "Шлагбаумы",
        BankWall = "Стены банка",
        NotifySuccess = "Успешно",
        NotifyRemoved = "Удалено объектов: ",
        NotifyRestored = "Возвращено объектов: ",
        NotifyInfo = "Информация",
        NotifyNotFound = "Объекты не найдены или уже удалены",

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
        BindUnstuckName = "Вернуть машину (от застревания)",

        VFlyAutoOff = "Полёт отключён (вы покинули транспорт)",

        ConfigSection = "Конфиги [PRO]",
        ConfigInfo = "В конфиг можно сохранять свои настройки.",
        ConfigName = "Имя конфига",
        ConfigPlaceholder = "Введите имя конфига...",
        SaveConfigBtn = "Сохранить конфиг",
        ConfigList = "Сохранённые конфиги",
        LoadConfigBtn = "Загрузить конфиг",
        DeleteConfigBtn = "Удалить конфиг",
        AutoLoadConfig = "Автозагрузка при инжекте",
        AutoLoadNone = "(Выключено)",

        NotifyProOnly = "Эта функция доступна только в PRO версии",

        ProTextTitle = "Это бесплатная версия скрипта с ограниченным доступом к функциям.",
        ProTextBody = "\nВ полной версии доступно:\n• Полёт на транспорте\n• Хард режим спидхака на авто\n• Телепортация по клику\n• Удаление стен банка\n• Сохранение всех настроек в конфиг\n\nА также доступ в любое время без просмотра рекламы — навсегда.",
        ProBtn = "ПОЛУЧИТЬ ПОЛНЫЙ ДОСТУП",
        NotifyCopied = "ССЫЛКА СКОПИРОВАНА!",
    }
}

local UIGeneration = 0

-- Уведомление «только PRO»
local function proNotify()
    pcall(function()
        Rayfield:Notify({
            Title = "BULLY",
            Content = L[Language].NotifyProOnly,
            Duration = 3
        })
    end)
end

-- ================== СТИЛЬ PRO-ЭЛЕМЕНТОВ (тёмно-серые) ==================
local PRO_DARK = Color3.fromRGB(36, 36, 38)
local PRO_TEXT = Color3.fromRGB(115, 115, 120)

local function styleProByTitle(title, delay)
    task.delay(delay or 0.15, function()
        if not ScriptActive then return end
        pcall(function()
            local gui = getGuiParent():FindFirstChild("Rayfield")
            if not gui then return end
            for _, d in ipairs(gui:GetDescendants()) do
                if (d:IsA("TextLabel") or d:IsA("TextButton")) and d.Text == title then
                    d.TextColor3 = PRO_TEXT
                    local container = d.Parent
                    if container and container:IsA("GuiObject") then
                        container.BackgroundColor3 = PRO_DARK
                        for _, c in ipairs(container:GetDescendants()) do
                            if c:IsA("TextLabel") then
                                c.TextColor3 = PRO_TEXT
                            elseif c:IsA("TextButton") then
                                c.TextColor3 = PRO_TEXT
                            end
                        end
                    end
                end
            end
        end)
    end)
end

-- ================== БЛОКИРОВКА КЛИКА ПО ОПЦИИ ХАРД ==================
local function blockHardOption(hardDisplay)
    task.spawn(function()
        local gen = UIGeneration
        local gui = getGuiParent():FindFirstChild("Rayfield")
        if not gui then return end

        local function protect(textObj)
            if not textObj or not textObj.Parent then return end
            local holder
            if textObj:IsA("TextButton") then
                holder = textObj
            else
                holder = textObj.Parent
            end
            if not holder or not holder:IsA("GuiObject") then return end
            if holder:FindFirstChild("BULLY_HardBlock") then return end

            local blocker = Instance.new("TextButton")
            blocker.Name = "BULLY_HardBlock"
            blocker.BackgroundTransparency = 1
            blocker.Size = UDim2.new(1, 0, 1, 0)
            blocker.Text = ""
            blocker.AutoButtonColor = false
            blocker.ZIndex = 500
            blocker.Parent = holder
            blocker.MouseButton1Click:Connect(function()
                proNotify()
            end)
        end

        for _, d in ipairs(gui:GetDescendants()) do
            if (d:IsA("TextLabel") or d:IsA("TextButton")) and d.Text == hardDisplay then
                protect(d)
            end
        end

        local conn
        conn = gui.DescendantAdded:Connect(function(d)
            if not ScriptActive or gen ~= UIGeneration then
                if conn then conn:Disconnect() end
                return
            end
            if (d:IsA("TextLabel") or d:IsA("TextButton")) and d.Text == hardDisplay then
                task.defer(function()
                    if ScriptActive and gen == UIGeneration then
                        protect(d)
                    end
                end)
            end
        end)
    end)
end

-- ================== ПЕРЕМЕННЫЕ ==================
local PlayerSpeedEnabled = false
local PlayerSpeed = 1.4

local NoclipEnabled = false
local NoclipLoop = nil

local VehicleSpeedEnabled = false
local VehicleSpeedMode = "Legit"
local VehicleAltSpeed = 200

local VehicleSpeedKeyName = "LeftControl"

local EspEnabled = false
local EspMaxDistance = 250
local EspObjects = {}

local VFlyEnabled = false
local VFlySpeed = 2
local VFlyLoop = nil

local VehicleShiftLockEnabled = false
local ShiftLockLoop = nil

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

local PRO_LINK = "https://t.me/+2rtKpUuJzcEzNTZh"

local UIRefs = {
    Window = nil,
    AimbotToggle = nil,
    NoclipToggle = nil,
    TrackToggle = nil,
    TargetDropdown = nil,
    LangHolder = nil,
    EnBtn = nil,
    RuBtn = nil,
    UnstuckKeybind = nil,
    AimbotKeybind = nil,
    NoclipKeybind = nil,
    SpeedKeybind = nil,
    VehicleSpeedToggle = nil,
    VehicleModeDropdown = nil,
    PlayerSpeedToggle = nil,
    EspToggle = nil,
    EspDistanceSlider = nil,
    SmoothnessSlider = nil,
    MaxDistSlider = nil,
    PartDropdown = nil,
    TeamCheckToggle = nil,
    ShowFovToggle = nil,
    FovRadiusSlider = nil,
    BankWallToggle = nil,
    FlyToggle = nil,
    ConfigDropdown = nil,
    AutoLoadDropdown = nil,
}

local buildUI, switchLanguage, attachLangButtons, hardUnload

-- ================== FOV КРУГ ==================
local FovCircle = Drawing.new("Circle")
FovCircle.Color = Color3.fromRGB(255, 255, 255)
FovCircle.Thickness = 1.5
FovCircle.Filled = false
FovCircle.Transparency = 1
FovCircle.Visible = false

-- ================== ПОИСК МОДУЛЯ VEHICLEUTIL ==================
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

-- ================== ПРОВЕРКА ЗАЖАТОЙ КЛАВИШИ БИНДА ==================
local function isBindKeyDown(name)
    if type(name) ~= "string" or #name == 0 then return false end
    local ok, kc = pcall(function() return Enum.KeyCode[name] end)
    if not (ok and kc) then return false end
    if UserInputService:IsKeyDown(kc) then return true end

    if name == "LeftControl" then return UserInputService:IsKeyDown(Enum.KeyCode.RightControl) end
    if name == "RightControl" then return UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) end
    if name == "LeftAlt" then return UserInputService:IsKeyDown(Enum.KeyCode.RightAlt) end
    if name == "RightAlt" then return UserInputService:IsKeyDown(Enum.KeyCode.LeftAlt) end
    if name == "LeftShift" then return UserInputService:IsKeyDown(Enum.KeyCode.RightShift) end
    if name == "RightShift" then return UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) end
    return false
end

local function getFlagBind(flag)
    local ok, res = pcall(function()
        local flags = Rayfield and Rayfield.Flags
        if type(flags) ~= "table" then return nil end
        local el = flags[flag]
        if type(el) ~= "table" then return nil end
        if typeof(el.CurrentKeybind) == "EnumItem" then return el.CurrentKeybind.Name end
        if type(el.CurrentKeybind) == "string" then return el.CurrentKeybind end
        return nil
    end)
    if ok and type(res) == "string" then
        res = res:match("^%s*(.-)%s*$")
        if res == "None" or res == "Unknown" or res == "" then return nil end
        return res
    end
    return nil
end

-- ================== КОПИРОВАНИЕ В БУФЕР ==================
local function copyToClipboard(text)
    if setclipboard then
        pcall(setclipboard, text)
        return true
    end
    if toclipboard then
        pcall(toclipboard, text)
        return true
    end
    if syn and syn.write_clipboard then
        pcall(syn.write_clipboard, text)
        return true
    end
    return false
end

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
    if VehicleSpeedMode == "Legit" then
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
    if runDead() then return end
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
        if EspEnabled and not runDead() then applyEsp(player) end
    end)

    EspObjects[player] = { Highlight = highlight, Billboard = billboard, Connection = conn }
end

local function updateAllEsp()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            if EspEnabled and not runDead() then
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
        if EspEnabled and not runDead() then applyEsp(player) end
    end)
end)

Players.PlayerRemoving:Connect(removeEsp)

for _, player in ipairs(Players:GetPlayers()) do
    player.CharacterAdded:Connect(function()
        task.wait(1)
        if EspEnabled and not runDead() then applyEsp(player) end
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
        if not VFlyEnabled or runDead() then return end

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

        root.AssemblyLinearVelocity = moveDir * (VFlySpeed * 75)

        local lookDir = Vector3.new(camera.CFrame.LookVector.X, 0, camera.CFrame.LookVector.Z)
        if lookDir.Magnitude > 0.001 then
            root.CFrame = CFrame.lookAt(root.Position, root.Position + lookDir)
        end

        root.AssemblyAngularVelocity = Vector3.zero
    end)
end

-- ================== ВОССТАНОВЛЕНИЕ КОЛЛИЗИЙ ==================
local NOCLIP_COLLIDE_PARTS = { "HumanoidRootPart", "Head", "Torso", "UpperTorso", "LowerTorso" }

local function restoreCharacterCollisions()
    pcall(function()
        local char = LocalPlayer.Character
        if not char then return end
        for _, name in ipairs(NOCLIP_COLLIDE_PARTS) do
            local part = char:FindFirstChild(name)
            if part and part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end)
end

-- ================== NOCLIP ==================
local lastNoclipNotify = 0

local function setNoclipState(state, silent)
    local changed = (NoclipEnabled ~= state)
    NoclipEnabled = state

    if not state then
        restoreCharacterCollisions()
    end

    if changed and not silent and ScriptActive then
        local now = os.clock()
        if now - lastNoclipNotify > 0.3 then
            lastNoclipNotify = now
            pcall(function()
                local t = L[Language]
                Rayfield:Notify({
                    Title = "Noclip",
                    Content = state and t.NotifyNoclipOn or t.NotifyNoclipOff,
                    Duration = 2
                })
            end)
        end
    end
end

NoclipLoop = RunService.Stepped:Connect(function()
    if not NoclipEnabled or runDead() then return end
    local char = LocalPlayer.Character
    if not char then return end
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
        end
    end
end)

-- ================== ШИФТЛОК ==================
ShiftLockLoop = RunService.RenderStepped:Connect(function()
    if runDead() then return end
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
    if runDead() then return end
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

-- ================== ШЛАГБАУМЫ ==================
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

-- ================== СТЕНЫ БАНКА ==================
local function toggleBankWalls(state)
    proNotify()
    return 0
end

-- ================== ЦИКЛЫ СПИДХАКОВ ==================
local PlayerLoop = RunService.Heartbeat:Connect(function()
    if runDead() then return end
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
    if runDead() then return end
    if VehicleSpeedEnabled and isBindKeyDown(VehicleSpeedKeyName) then
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

-- ================== СБРОС ПЕРСОНАЖА ==================
local function resetCharacterState()
    pcall(function()
        local char = LocalPlayer.Character
        if not char then return end

        restoreCharacterCollisions()

        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then
            pcall(function()
                hrp.Anchored = false
                hrp.AssemblyLinearVelocity = Vector3.zero
                hrp.AssemblyAngularVelocity = Vector3.zero
            end)
        end

        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            pcall(function()
                hum.WalkSpeed = 16
                hum.PlatformStand = false
                hum.AutoRotate = true
            end)
        end
    end)
end

-- ================== ПОЛНЫЙ СБРОС (Unload) ==================
hardUnload = function()
    ScriptActive = false
    PlayerSpeedEnabled = false
    NoclipEnabled = false
    setNoclipState(false, true)
    VehicleSpeedEnabled = false
    EspEnabled = false
    VFlyEnabled = false
    VehicleShiftLockEnabled = false
    AimbotEnabled = false
    AimbotShowFov = false
    CurrentTarget = nil
    pcall(stopTracker)
    pcall(stopVFly)
    FovCircle.Visible = false
    pcall(function() FovCircle:Remove() end)
    UserInputService.MouseBehavior = Enum.MouseBehavior.Default
    pcall(function() UserInputService.MouseIconEnabled = true end)

    pcall(updateAllEsp)
    pcall(function() AC_CONFIG.restoreVehicles() end)

    pcall(resetCharacterState)
    task.delay(0.3, resetCharacterState)
    task.delay(1.5, resetCharacterState)
    task.spawn(function()
        local conn
        conn = LocalPlayer.CharacterAdded:Connect(function()
            task.wait(0.5)
            pcall(resetCharacterState)
            if conn then conn:Disconnect() end
        end)
        task.delay(10, function()
            if conn then conn:Disconnect() end
        end)
    end)

    if PlayerLoop then PlayerLoop:Disconnect() end
    if VehicleLoop then VehicleLoop:Disconnect() end
    if NoclipLoop then NoclipLoop:Disconnect() end
    if ShiftLockLoop then ShiftLockLoop:Disconnect() end
    if ShiftLockConnection then ShiftLockConnection:Disconnect() end
    if AimbotLoop then AimbotLoop:Disconnect() end

    if UIRefs.Window then pcall(function() UIRefs.Window:Destroy() end) end
end

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

    local PRO = " [PRO]"
    local hardDisplay = t.ModeHard .. PRO

    UIGeneration = UIGeneration + 1
    local myGen = UIGeneration

    local function guard(cb)
        return function(...)
            if not ScriptActive or runDead() then return end
            if myGen ~= UIGeneration then return end
            return cb(...)
        end
    end

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

    local MainTab = Window:CreateTab(t.MainSection, 4483362458)
    local VehicleTab = Window:CreateTab(t.VehicleTab, 4483362458)
    local PlayerTab = Window:CreateTab(t.PlayerTab, 4483362458)
    local CombatTab = Window:CreateTab(t.CombatTab, 4483362458)
    local VisualTab = Window:CreateTab(t.VisualTab, 4483362458)
    local FunctionsTab = Window:CreateTab(t.FunctionsTab, 4483362458)
    local SettingsTab = Window:CreateTab(t.SettingsTab, 4483362458)

    MainTab:CreateParagraph({
        Title = t.ProTextTitle,
        Content = t.ProTextBody
    })

    local proBtn = MainTab:CreateButton({
        Name = t.ProBtn,
        Callback = function()
            copyToClipboard(PRO_LINK)
            pcall(function()
                Rayfield:Notify({
                    Title = "BULLY",
                    Content = t.NotifyCopied,
                    Duration = 3
                })
            end)
        end
    })

    VehicleTab:CreateSection(t.VehicleSection)
    UIRefs.VehicleSpeedToggle = VehicleTab:CreateToggle({
        Name = t.VehicleSpeed,
        CurrentValue = VehicleSpeedEnabled,
        Callback = function(v)
            VehicleSpeedEnabled = v
            if not v then AC_CONFIG.restoreVehicles() end
        end
    })

    UIRefs.VehicleModeDropdown = VehicleTab:CreateDropdown({
        Name = t.VehicleMode,
        Options = { t.ModeLegit, hardDisplay },
        CurrentOption = { t.ModeLegit },
        MultipleOptions = false,
        Callback = guard(function(v)
            local val = v
            if type(val) == "table" then val = val[1] end
            if modeFromDisplay(val) == "Hard" then
                proNotify()
                VehicleSpeedMode = "Legit"
                AC_CONFIG.restoreVehicles()
                return
            end
            VehicleSpeedMode = "Legit"
            AC_CONFIG.restoreVehicles()
        end)
    })

    blockHardOption(hardDisplay)

    task.spawn(function()
        while ScriptActive and myGen == UIGeneration do
            task.wait(2)
            pcall(function()
                local gui = getGuiParent():FindFirstChild("Rayfield")
                if not gui then return end
                for _, d in ipairs(gui:GetDescendants()) do
                    if (d:IsA("TextLabel") or d:IsA("TextButton")) and d.Text == hardDisplay then
                        d.TextColor3 = PRO_TEXT
                        if d:IsA("TextButton") then
                            d.BackgroundColor3 = PRO_DARK
                        end
                        local p = d.Parent
                        if p and p:IsA("GuiObject") and not p:IsA("ScreenGui") then
                            p.BackgroundColor3 = PRO_DARK
                        end
                    end
                end
            end)
        end
    end)

    VehicleTab:CreateSection(t.FlySection .. PRO)
    styleProByTitle(t.FlySection .. PRO, 0.2)
    UIRefs.FlyToggle = VehicleTab:CreateToggle({
        Name = t.FlyToggle .. PRO,
        CurrentValue = false,
        Callback = function(v)
            if v then
                proNotify()
                pcall(function() UIRefs.FlyToggle:Set(false) end)
            end
        end
    })
    styleProByTitle(t.FlyToggle .. PRO, 0.25)

    VehicleTab:CreateSection(t.BindsSection)
    UIRefs.SpeedKeybind = VehicleTab:CreateKeybind({
        Name = t.BindSpeedName,
        Flag = "BindVehicleSpeed",
        CurrentKeybind = "LeftControl",
        HoldToInteract = false,
        Callback = guard(function(key)
            local name = key
            if typeof(name) == "EnumItem" then name = name.Name end
            if type(name) == "string" then
                name = name:match("^%s*(.-)%s*$")
                if #name > 0 and name ~= "Unknown" then
                    VehicleSpeedKeyName = name
                end
            end
        end)
    })
    UIRefs.UnstuckKeybind = VehicleTab:CreateKeybind({
        Name = t.BindUnstuckName,
        Flag = "BindUnstuck",
        CurrentKeybind = "R",
        HoldToInteract = false,
        Callback = guard(function()
            local remotes = ReplicatedStorage:FindFirstChild("__remotes")
            local vehicleService = remotes and remotes:FindFirstChild("VehicleService")
            local unstuckRemote = vehicleService and vehicleService:FindFirstChild("UnstuckVehicle")
            if unstuckRemote then
                unstuckRemote:FireServer()
            end
        end)
    })
    VehicleTab:CreateLabel(t.ShiftLockLabel)

    CombatTab:CreateSection(t.AimbotSection)
    UIRefs.AimbotToggle = CombatTab:CreateToggle({
        Name = t.AimbotToggle,
        CurrentValue = AimbotEnabled,
        Callback = function(v) AimbotEnabled = v if not v then CurrentTarget = nil end end
    })
    UIRefs.AimbotKeybind = CombatTab:CreateKeybind({
        Name = t.BindAimbotName,
        Flag = "BindAimbot",
        CurrentKeybind = "Q",
        HoldToInteract = false,
        Callback = guard(function()
            AimbotEnabled = not AimbotEnabled
            if not AimbotEnabled then CurrentTarget = nil end
            if UIRefs.AimbotToggle then
                pcall(function() UIRefs.AimbotToggle:Set(AimbotEnabled) end)
            end
        end)
    })
    UIRefs.SmoothnessSlider = CombatTab:CreateSlider({
        Name = t.Smoothness,
        Range = { 0.05, 1 },
        Increment = 0.05,
        CurrentValue = AimbotSmoothness,
        Callback = function(v) AimbotSmoothness = v end
    })
    UIRefs.MaxDistSlider = CombatTab:CreateSlider({
        Name = t.MaxDistance,
        Range = { 50, 1000 },
        Increment = 25,
        CurrentValue = AimbotMaxDistance,
        Callback = function(v) AimbotMaxDistance = v end
    })
    UIRefs.PartDropdown = CombatTab:CreateDropdown({
        Name = t.TargetPart,
        Options = { t.PartHead, t.PartBody },
        CurrentOption = { partDisplay(AimbotPart) },
        MultipleOptions = false,
        Callback = function(v)
            local val = v
            if type(val) == "table" then val = val[1] end
            AimbotPart = partFromDisplay(val)
        end
    })
    UIRefs.TeamCheckToggle = CombatTab:CreateToggle({
        Name = t.TeamCheck,
        CurrentValue = AimbotTeamCheck,
        Callback = function(v) AimbotTeamCheck = v end
    })

    CombatTab:CreateSection(t.FovSection)
    UIRefs.ShowFovToggle = CombatTab:CreateToggle({
        Name = t.ShowFov,
        CurrentValue = AimbotShowFov,
        Callback = function(v) AimbotShowFov = v end
    })
    UIRefs.FovRadiusSlider = CombatTab:CreateSlider({
        Name = t.FovRadius,
        Range = { 20, 500 },
        Increment = 5,
        CurrentValue = AimbotFovRadius,
        Callback = function(v) AimbotFovRadius = v end
    })

    PlayerTab:CreateSection(t.MovementSection)
    UIRefs.PlayerSpeedToggle = PlayerTab:CreateToggle({
        Name = t.PlayerSpeedHack,
        CurrentValue = PlayerSpeedEnabled,
        Callback = function(v) PlayerSpeedEnabled = v end
    })

    PlayerTab:CreateSection(t.NoclipSection)
    UIRefs.NoclipToggle = PlayerTab:CreateToggle({
        Name = t.NoclipToggle,
        CurrentValue = NoclipEnabled,
        Callback = function(v) setNoclipState(v) end
    })
    UIRefs.NoclipKeybind = PlayerTab:CreateKeybind({
        Name = t.BindNoclipName,
        Flag = "BindNoclip",
        CurrentKeybind = "N",
        HoldToInteract = false,
        Callback = guard(function()
            setNoclipState(not NoclipEnabled)
            if UIRefs.NoclipToggle then
                pcall(function() UIRefs.NoclipToggle:Set(NoclipEnabled) end)
            end
        end)
    })

    PlayerTab:CreateSection(t.TeleportSection)
    local clickTPBtn = PlayerTab:CreateButton({
        Name = t.TeleportSection .. PRO,
        Callback = function()
            proNotify()
        end
    })
    styleProByTitle(t.TeleportSection .. PRO, 0.25)

    VisualTab:CreateSection(t.PlayersSection)
    UIRefs.EspToggle = VisualTab:CreateToggle({
        Name = t.PlayerEsp,
        CurrentValue = EspEnabled,
        Callback = function(v)
            EspEnabled = v
            updateAllEsp()
        end
    })
    UIRefs.EspDistanceSlider = VisualTab:CreateSlider({
        Name = t.EspDistance,
        Range = { 50, 2000 },
        Increment = 25,
        CurrentValue = EspMaxDistance,
        Callback = function(v)
            EspMaxDistance = v
            if EspEnabled then updateAllEsp() end
        end
    })

    FunctionsTab:CreateSection(t.DeletionSection)

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

    UIRefs.BankWallToggle = FunctionsTab:CreateToggle({
        Name = t.BankWall .. PRO,
        CurrentValue = false,
        Callback = function(v)
            if v then
                proNotify()
                pcall(function() UIRefs.BankWallToggle:Set(false) end)
            end
        end
    })
    styleProByTitle(t.BankWall .. PRO, 0.25)

    FunctionsTab:CreateSection(t.TrackerSection)

    UIRefs.TargetDropdown = FunctionsTab:CreateDropdown({
        Name = t.SelectTarget,
        Options = getPlayerNames(),
        CurrentOption = (TrackerTargetName ~= "" and { TrackerTargetName }) or {},
        MultipleOptions = false,
        Callback = function(v)
            local val = v
            if type(val) == "table" then val = val[1] end
            TrackerTargetName = val or ""
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
                        if not TrackerRunning or runDead() then return end

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

    SettingsTab:CreateSection(t.MainSection)
    SettingsTab:CreateButton({
        Name = t.Unload,
        Callback = function()
            hardUnload()
            pcall(function()
                local old = getGuiParent():FindFirstChild("Rayfield")
                if old then old:Destroy() end
            end)
        end
    })

    SettingsTab:CreateSection(t.ConfigSection)
    styleProByTitle(t.ConfigSection, 0.25)

    local configParagraph = SettingsTab:CreateParagraph({ Title = t.ConfigSection, Content = t.ConfigInfo })
    styleProByTitle(t.ConfigSection, 0.3)

    local newConfigName = nil
    local configNameInput = SettingsTab:CreateInput({
        Name = t.ConfigName,
        PlaceholderText = t.ConfigPlaceholder,
        RemoveTextAfterFocusLost = false,
        Callback = function(text)
            newConfigName = text
        end
    })
    styleProByTitle(t.ConfigName, 0.35)

    local saveConfigBtn = SettingsTab:CreateButton({
        Name = t.SaveConfigBtn,
        Callback = function()
            proNotify()
        end
    })
    styleProByTitle(t.SaveConfigBtn, 0.4)

    UIRefs.ConfigDropdown = SettingsTab:CreateDropdown({
        Name = t.ConfigList,
        Options = {},
        CurrentOption = {},
        MultipleOptions = false,
        Callback = function(v)
            proNotify()
        end
    })
    styleProByTitle(t.ConfigList, 0.45)

    local loadConfigBtn = SettingsTab:CreateButton({
        Name = t.LoadConfigBtn,
        Callback = function()
            proNotify()
        end
    })
    styleProByTitle(t.LoadConfigBtn, 0.5)

    local deleteConfigBtn = SettingsTab:CreateButton({
        Name = t.DeleteConfigBtn,
        Callback = function()
            proNotify()
        end
    })
    styleProByTitle(t.DeleteConfigBtn, 0.55)

    UIRefs.AutoLoadDropdown = SettingsTab:CreateDropdown({
        Name = t.AutoLoadConfig,
        Options = { t.AutoLoadNone },
        CurrentOption = { t.AutoLoadNone },
        MultipleOptions = false,
        Callback = function(v)
            proNotify()
        end
    })
    styleProByTitle(t.AutoLoadConfig, 0.6)

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
buildUI()

task.spawn(function()
    while ScriptActive do
        task.wait(0.5)
        pcall(function()
            local v = getFlagBind("BindVehicleSpeed")
            if v then
                VehicleSpeedKeyName = v
            end
        end)
    end
end)

task.spawn(function()
    while not runDead() do
        task.wait(0.5)
    end
    pcall(function() hardUnload() end)
end)

task.delay(1, function()
    if ScriptActive and EspEnabled then
        pcall(updateAllEsp)
    end
end)
