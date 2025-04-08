--[[
    TeleTransportador Universal - Delta Executor
    Versión: 2.0
    Descripción: Transporta a todos los jugadores a un juego específico con opciones avanzadas
    Características:
        - Interfaz de usuario personalizada
        - Notificaciones personalizadas
        - Manejo de errores
        - Soporte para diferentes tipos de ID de juego
        - Protección contra spam
]]

local TeleService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TextService = game:GetService("TextService")
local RunService = game:GetService("RunService")

-- Configuración
local SETTINGS = {
    TargetGameId = 987654321,  -- Cambia esto al ID del juego destino
    ReservedServerCode = nil,   -- Código de servidor reservado (opcional)
    NotificationDuration = 5,   -- Duración de notificaciones en segundos
    TeleportDelay = 3,           -- Tiempo antes del tele transporte
    UseScreenGui = true,         -- Mostrar interfaz gráfica
    BypassPrivacy = true,        -- Intentar saltar configuraciones de privacidad
    TeleportMethod = "Party",    -- "Single", "Party" o "ReservedServer"
    MaxRetries = 3,              -- Intentos máximos por jugador
    RetryDelay = 2               -- Espera entre intentos en segundos
}

-- Validar configuración
if SETTINGS.TeleportMethod == "ReservedServer" and not SETTINGS.ReservedServerCode then
    warn("Advertencia: Método de servidor reservado seleccionado pero no se proporcionó código")
    SETTINGS.TeleportMethod = "Party"
end

-- Cache de jugadores
local PlayerCache = {}
local TeleportInProgress = false
local LastTeleportTime = 0
local Cooldown = 10  -- Segundos entre usos

-- Verificar si es un lugar válido
local function isValidPlaceId(placeId)
    if type(placeId) ~= "number" then return false end
    if placeId <= 0 then return false end
    return true
end

-- Obtener información del juego destino
local function fetchGameInfo(placeId)
    local success, result = pcall(function()
        return HttpService:JSONDecode(game:HttpGet(
            "https://games.roblox.com/v1/games/"..placeId.."/game-detail?isPlayableGame=true"
        ))
    end)
    
    return success and result or nil
end

-- Mostrar notificación
local function showNotification(player, message, duration)
    if not player or not player:IsA("Player") then return end
    
    if SETTINGS.UseScreenGui then
        local gui = Instance.new("ScreenGui")
        local frame = Instance.new("Frame")
        local text = Instance.new("TextLabel")
        
        gui.Name = "TeleportNotification"
        gui.Parent = player:WaitForChild("PlayerGui")
        gui.ResetOnSpawn = false
        
        frame.Size = UDim2.new(0.8, 0, 0.1, 0)
        frame.Position = UDim2.new(0.1, 0, 0.8, 0)
        frame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
        frame.BorderSizePixel = 0
        frame.Parent = gui
        
        text.Size = UDim2.new(1, 0, 1, 0)
        text.Text = message
        text.TextColor3 = Color3.fromRGB(255, 255, 255)
        text.BackgroundTransparency = 1
        text.Font = Enum.Font.GothamBold
        text.TextSize = 18
        text.Parent = frame
        
        -- Animación de entrada
        frame.Position = UDim2.new(0.1, 0, 1, 0)
        frame:TweenPosition(UDim2.new(0.1, 0, 0.8, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5)
        
        -- Eliminar después de la duración
        delay(duration or SETTINGS.NotificationDuration, function()
            frame:TweenPosition(UDim2.new(0.1, 0, 1, 0), Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.5, true, 
                function() gui:Destroy() end)
        end)
    else
        -- Notificación simple si no se usa GUI
        player:Chat(message)
    end
end

-- Tele transportar jugador con manejo de errores
local function teleportPlayer(player, placeId, options)
    if not isValidPlaceId(placeId) then
        showNotification(player, "❌ ID de juego inválido", 3)
        return false
    end
    
    local retries = 0
    local success = false
    
    repeat
        retries = retries + 1
        showNotification(player, string.format("🚀 Preparando tele transporte (Intento %d/%d)...", retries, SETTINGS.MaxRetries), 2)
        
        local teleportOptions = Instance.new("TeleportOptions")
        teleportOptions.ShouldReserveServer = SETTINGS.TeleportMethod == "ReservedServer"
        
        if SETTINGS.ReservedServerCode then
            teleportOptions.ReservedServerAccessCode = SETTINGS.ReservedServerCode
        end
        
        if SETTINGS.BypassPrivacy then
            -- Intentar métodos alternativos para saltar privacidad
            pcall(function()
                teleportOptions.SetTeleportData(HttpService:JSONEncode({
                    BypassPrivacy = true,
                    Timestamp = os.time(),
                    PlayerId = player.UserId
                }))
            end)
        end
        
        local startTime = os.clock()
        
        local teleportSuccess, teleportResult = pcall(function()
            if SETTINGS.TeleportMethod == "Party" then
                TeleService:TeleportPartyAsync(placeId, {player}, teleportOptions)
            else
                TeleService:TeleportAsync(placeId, player, teleportOptions)
            end
        end)
        
        if teleportSuccess then
            success = true
            showNotification(player, "✅ Tele transporte exitoso!", 2)
        else
            warn(string.format("Error al tele transportar %s: %s", player.Name, teleportResult))
            showNotification(player, string.format("⚠️ Error: %s", tostring(teleportResult)), 3)
            
            if retries < SETTINGS.MaxRetries then
                wait(SETTINGS.RetryDelay)
            end
        end
    until success or retries >= SETTINGS.MaxRetries
    
    return success
end

-- Tele transportar a todos los jugadores
local function teleportAllPlayers()
    if TeleportInProgress then
        warn("Ya hay un tele transporte en progreso")
        return false
    end
    
    if os.time() - LastTeleportTime < Cooldown then
        warn("Enfriamiento activo. Espera antes de intentar de nuevo")
        return false
    end
    
    TeleportInProgress = true
    LastTeleportTime = os.time()
    
    -- Verificar el juego destino
    local gameInfo = fetchGameInfo(SETTINGS.TargetGameId)
    if not gameInfo then
        warn("No se pudo obtener información del juego destino")
        TeleportInProgress = false
        return false
    end
    
    local gameName = gameInfo.name or "Juego Desconocido"
    
    -- Notificar a todos
    for _, player in ipairs(Players:GetPlayers()) do
        showNotification(player, string.format("🌌 Preparando tele transporte a: %s...", gameName), SETTINGS.TeleportDelay)
    end
    
    -- Esperar el delay
    wait(SETTINGS.TeleportDelay)
    
    -- Iniciar tele transporte
    local successCount = 0
    local failedPlayers = {}
    
    for _, player in ipairs(Players:GetPlayers()) do
        local success = teleportPlayer(player, SETTINGS.TargetGameId)
        
        if success then
            successCount = successCount + 1
        else
            table.insert(failedPlayers, player.Name)
        end
        
        -- Pequeña espera para evitar saturación
        wait(0.1)
    end
    
    -- Resultados
    if #failedPlayers > 0 then
        warn(string.format("Tele transporte completado con %d fallos: %s", 
            #failedPlayers, table.concat(failedPlayers, ", ")))
    end
    
    TeleportInProgress = false
    return successCount
end

-- Interfaz de comandos (opcional)
local function setupCommands()
    Players.PlayerAdded:Connect(function(player)
        player.Chatted:Connect(function(message)
            if message:lower() == "/teleportall" and player.UserId == game.CreatorId then
                teleportAllPlayers()
            end
        end)
    end)
end

-- Inicialización
if RunService:IsStudio() then
    warn("⚠️ Script ejecutado en Roblox Studio. Algunas funciones pueden no trabajar correctamente.")
else
    setupCommands()
    
    -- Ejecutar automáticamente al cargar (opcional)
    delay(1, function()
        showNotification(game:GetService("Players").LocalPlayer, 
            "✅ TeleTransportador Universal cargado!\nUsa /teleportall como creador para activar.", 5)
    end)
end

-- Función principal para ejecutar desde Delta Executor
local function main()
    if not isValidPlaceId(SETTINGS.TargetGameId) then
        warn("Por favor configura un ID de juego destino válido en SETTINGS.TargetGameId")
        return
    end
    
    local localPlayer = Players.LocalPlayer
    if not localPlayer then return end
    
    showNotification(localPlayer, "⚡ Iniciando tele transporte masivo...", 3)
    wait(2)
    
    teleportAllPlayers()
end

-- Ejecutar
main()
