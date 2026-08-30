local TARGET = 120.0
local acc = 0.0
local ok = false

local function camera()
    local player = Game.GetPlayer()
    if not player then return nil end
    return player:GetFPPCameraComponent()
end

local function menuOpen()
    local ok1, r1 = pcall(function()
        local defs = Game.GetAllBlackboardDefs().UI_System
        local bb = Game.GetBlackboardSystem():Get(defs)
        return bb ~= nil and bb:GetBool(defs.IsInMenu)
    end)
    return ok1 and r1 or false
end

local function enforce()
    if not ok then return end
    if menuOpen() then
        if FovControl.IsLocked() then FovControl.Unlock() end
        return
    end
    local cam = camera()
    if not cam then return end
    local current = cam:GetDisplayFOV()
    if current == 0 then return end
    if math.abs(current - TARGET) < 0.01 and FovControl.IsLocked() then return end
    if FovControl.IsLocked() then FovControl.Unlock() end
    cam:SetDisplayFOV(TARGET)
    FovControl.Lock()
end

registerForEvent("onInit", function()
    ok = FovControl ~= nil
        and type(FovControl.Version) == "function"
        and FovControl.IsPatchingAllowed()
    print("[FovAlways120] FovControl available: " .. tostring(ok))
end)

registerForEvent("onUpdate", function(dt)
    acc = acc + dt
    if acc < 0.5 then return end
    acc = 0
    pcall(enforce)
end)

registerForEvent("onShutdown", function()
    if ok and FovControl.IsLocked() then
        FovControl.ReleasePatching()
        FovControl.Unlock()
    end
end)