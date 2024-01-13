--setDevelopmentMode(true) -- developer mode, console: showcol
local sx,sy = guiGetScreenSize()
local px,py = 1440,900
local x,y =  (sx/px), (sy/py)

vedett_sugar ={
    {1150.4775390625, -1384.837890625, 0.0, 100, 94, 100},
    {1576.12890625, 1781.6796875, 0.0, 70, 80, 100}
}

function crearZonasSeguras()
    for i, _ in ipairs(vedett_sugar) do
        zona_sugar = createColCuboid(vedett_sugar[i][1], vedett_sugar[i][2], vedett_sugar[i][3], vedett_sugar[i][4], vedett_sugar[i][5], vedett_sugar[i][6])
        radar_sugar = createRadarArea(vedett_sugar[i][1], vedett_sugar[i][2], vedett_sugar[i][4], vedett_sugar[i][5], 0, 255, 0, 100)
        addEventHandler("onClientColShapeHit", zona_sugar, function(hitPlayer)
            if getElementType(hitPlayer) == "player" then
                setPedWeaponSlot(hitPlayer, 0)
                cambiarControlesPlayer(false)
                addEventHandler("onClientRender", getRootElement(), vedettszoveg)
                addEventHandler("onClientPlayerDamage", hitPlayer, quitscript)
            end
        end)
        addEventHandler("onClientColShapeLeave", zona_sugar, function(hitPlayer)
            if getElementType(hitPlayer) == "player" then
                cambiarControlesPlayer(true)
                removeEventHandler("onClientRender", getRootElement(), vedettszoveg)
                removeEventHandler("onClientPlayerDamage", hitPlayer, quitscript)
            end
        end)
    end
end
addEventHandler("onClientResourceStart", resourceRoot, crearZonasSeguras)

function cambiarControlesPlayer(status)
    toggleControl("fire", status)
    toggleControl("next_weapon", status)
    toggleControl("previous_weapon", status)
    toggleControl("aim_weapon", status)
    toggleControl("vehicle_fire", status)
    toggleControl("vehicle_secondary_fire", status)
end

function vedettszoveg()
    dxDrawText("Jelenleg Védett Zonában vagy", x*292, y*644, x*1176, y*695, tocolor(0,255,0,255), 1.6, "sans", "center", "center", false, false, true, false, false)
end

function quitscript()
    cancelEvent()
end
