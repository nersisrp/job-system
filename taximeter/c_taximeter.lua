local gui_base = nil
local meterRunning = false
local lightOn = false
local isDriver = false
local taxiFare = 0
local taxiDistance = 0
local root = getRootElement()
local localPlayer = getLocalPlayer()
local driversSendSyncTimer = nil

local screenW, screenH = guiGetScreenSize()
local fareRenderActive = false
local minFare = 10
local maxFare = 50
local defaultFare = 10
local taxiFare = defaultFare

local fareMenu = {
    x1 = screenW * 0.4224,
    y1 = screenH * 0.4714,
    w = screenW * 0.0461,
    h = screenH * 0.0430,

    x2 = screenW * 0.5403,
    y2 = screenH * 0.4714,
    w = screenW * 0.0461,
    h = screenH * 0.0430,
}

function showTaximeterGui()
	if gui_base then
		destroyElement(gui_base)
		gui_base = nil
	end
	
	local screenX, screenY = guiGetScreenSize()
	local width, height = 299, 168
	local x = 0
	local y = screenY - height - 200
	local speedowidth = 280
	
	if isDriver then
		gui_base = guiCreateStaticImage(x,y,width,height,"taximeter/images/base_driver.png",false,nil)
	else
		gui_base = guiCreateStaticImage(x,y,width,height,"taximeter/images/base_pax.png",false,nil)
	end
	
	gui_label_totalFare = guiCreateLabel(-50,13,108,29,tostring(math.ceil(taxiFare*(taxiDistance/1000))),false,gui_base)
		guiLabelSetColor(gui_label_totalFare, 0, 0, 0)
		guiSetFont(gui_label_totalFare, "default-bold-small")
		guiLabelSetHorizontalAlign(gui_label_totalFare, "right", false)
		guiLabelSetVerticalAlign(gui_label_totalFare, "center")
	gui_label_distance = guiCreateLabel(100,32,93,28,string.format("%.1f", tostring(taxiDistance/1000)),false,gui_base)
		guiLabelSetColor(gui_label_distance, 0, 0, 0)
		guiSetFont(gui_label_distance, "default-bold-small")
		guiLabelSetHorizontalAlign(gui_label_distance, "right", false)
		guiLabelSetVerticalAlign(gui_label_distance, "center")		
	gui_label_fare = guiCreateLabel(20,44,56,17,string.format("%.2f", tostring(taxiFare)),false,gui_base)
		guiLabelSetColor(gui_label_fare, 0, 0, 0)
		guiSetFont(gui_label_fare, "default-bold-small")
		guiLabelSetHorizontalAlign(gui_label_fare, "right", false)
		guiLabelSetVerticalAlign(gui_label_fare, "center")
		
	if isDriver then
		gui_btn1 = guiCreateStaticImage(37,112,31,31,"taximeter/images/btn.png",false,gui_base)
			addEventHandler("onClientGUIClick", gui_btn1, toggleMeter)
			if meterRunning then
				guiStaticImageLoadImage(gui_btn1, "taximeter/images/btn_active.png")
			end
		
		gui_btn2 = guiCreateStaticImage(101,112,31,31,"taximeter/images/btn.png",false,gui_base) --x=+27 =58
			addEventHandler("onClientGUIClick", gui_btn2, resetMeter)
		
		gui_btn3 = guiCreateStaticImage(164,112,31,31,"taximeter/images/btn.png",false,gui_base)
			addEventHandler("onClientGUIClick", gui_btn3, setFare)
		
		gui_btn4 = guiCreateStaticImage(225,112,31,31,"taximeter/images/btn.png",false,gui_base)
			addEventHandler("onClientGUIClick", gui_btn4, toggleLight)
			if lightOn then
				guiStaticImageLoadImage(gui_btn4, "taximeter/images/btn_on.png")
			end		
	else
		if meterRunning then
			gui_label_pax_running = guiCreateLabel(17,113,218,20,"Taximeter running",false,gui_base)
			guiLabelSetColor(gui_label_pax_running,0,255,0)
		else
			gui_label_pax_running = guiCreateLabel(17,113,218,20,"Taximeter not running",false,gui_base)
			guiLabelSetColor(gui_label_pax_running,255,0,0)
		end
	end
	
end

function hideTaximeterGui()
	if gui_base then
		destroyElement(gui_base)
		gui_base = nil
	end
	taxiFare = 0
	taxiDistance = 0
	meterRunning = false
	lightOn = false
	isDriver = false
end

function toggleMeter()
	if(source == gui_btn1) then
		if isDriver then
			if meterRunning then
				meterRunning = false
				local theVehicle = getPedOccupiedVehicle(localPlayer)
				
				if driversSendSyncTimer then
					killTimer(driversSendSyncTimer)
					driversSendSyncTimer = nil
				end
				
				removeEventHandler("onClientRender",root,monitoring)
				sendTaximeterSync()
				
				guiStaticImageLoadImage(gui_btn1, "taximeter/images/btn.png")
			else
				meterRunning = true
				local theVehicle = getPedOccupiedVehicle(localPlayer)
				
				if driversSendSyncTimer then
					killTimer(driversSendSyncTimer)
					driversSendSyncTimer = nil
				end
				
				sendTaximeterSync()
				driversSendSyncTimer = setTimer(sendTaximeterSync, syncInterval, 0)
				addEventHandler("onClientRender",root,monitoring)
				guiStaticImageLoadImage(gui_btn1, "taximeter/images/btn_active.png")
			end
		end
	end
end

function resetMeter()
	if(source == gui_btn2) then
		taxiDistance = 0
		guiSetText(gui_label_totalFare, "0")
		guiSetText(gui_label_distance, "0")
		triggerServerEvent("taximeter:resetMeter", localPlayer)
	end
end

function renderFare()
	dxDrawLine((screenW * 0.3631) - 1, (screenH * 0.3919) - 1, (screenW * 0.3631) - 1, screenH * 0.5911, tocolor(255, 255, 255, 222), 1, false)
    dxDrawLine(screenW * 0.6530, (screenH * 0.3919) - 1, (screenW * 0.3631) - 1, (screenH * 0.3919) - 1, tocolor(255, 255, 255, 222), 1, false)
    dxDrawLine((screenW * 0.3631) - 1, screenH * 0.5911, screenW * 0.6530, screenH * 0.5911, tocolor(255, 255, 255, 222), 1, false)
    dxDrawLine(screenW * 0.6530, screenH * 0.5911, screenW * 0.6530, (screenH * 0.3919) - 1, tocolor(255, 255, 255, 222), 1, false)
    dxDrawRectangle(screenW * 0.3631, screenH * 0.3919, screenW * 0.2899, screenH * 0.1992, tocolor(0, 0, 0, 222), false)
    dxDrawText("Kilometre Fiyatı Ayar Menüsü", screenW * 0.3631, screenH * 0.3906, screenW * 0.6530, screenH * 0.4401, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawRectangle(screenW * 0.4224, screenH * 0.4714, screenW * 0.0461, screenH * 0.0430, tocolor(245, 0, 0, 255), false)
    dxDrawRectangle(screenW * 0.5403, screenH * 0.4714, screenW * 0.0461, screenH * 0.0430, tocolor(17, 245, 0, 255), false)
    dxDrawText("+", (screenW * 0.5542) - 1, (screenH * 0.4818) - 1, (screenW * 0.5717) - 1, (screenH * 0.5013) - 1, tocolor(0, 0, 0, 255), 2.00, "default", "center", "center", false, false, false, false, false)
    dxDrawText("+", (screenW * 0.5542) + 1, (screenH * 0.4818) - 1, (screenW * 0.5717) + 1, (screenH * 0.5013) - 1, tocolor(0, 0, 0, 255), 2.00, "default", "center", "center", false, false, false, false, false)
    dxDrawText("+", (screenW * 0.5542) - 1, (screenH * 0.4818) + 1, (screenW * 0.5717) - 1, (screenH * 0.5013) + 1, tocolor(0, 0, 0, 255), 2.00, "default", "center", "center", false, false, false, false, false)
    dxDrawText("+", (screenW * 0.5542) + 1, (screenH * 0.4818) + 1, (screenW * 0.5717) + 1, (screenH * 0.5013) + 1, tocolor(0, 0, 0, 255), 2.00, "default", "center", "center", false, false, false, false, false)
    dxDrawText("+", screenW * 0.5542, screenH * 0.4818, screenW * 0.5717, screenH * 0.5013, tocolor(255, 255, 255, 255), 2.00, "default", "center", "center", false, false, false, false, false)
    dxDrawText("-", (screenW * 0.4370) - 1, (screenH * 0.4818) - 1, (screenW * 0.4546) - 1, (screenH * 0.5013) - 1, tocolor(0, 0, 0, 255), 2.00, "default", "center", "center", false, false, false, false, false)
    dxDrawText("-", (screenW * 0.4370) + 1, (screenH * 0.4818) - 1, (screenW * 0.4546) + 1, (screenH * 0.5013) - 1, tocolor(0, 0, 0, 255), 2.00, "default", "center", "center", false, false, false, false, false)
    dxDrawText("-", (screenW * 0.4370) - 1, (screenH * 0.4818) + 1, (screenW * 0.4546) - 1, (screenH * 0.5013) + 1, tocolor(0, 0, 0, 255), 2.00, "default", "center", "center", false, false, false, false, false)
    dxDrawText("-", (screenW * 0.4370) + 1, (screenH * 0.4818) + 1, (screenW * 0.4546) + 1, (screenH * 0.5013) + 1, tocolor(0, 0, 0, 255), 2.00, "default", "center", "center", false, false, false, false, false)
    dxDrawText("-", screenW * 0.4370, screenH * 0.4818, screenW * 0.4546, screenH * 0.5013, tocolor(255, 255, 255, 255), 2.00, "default", "center", "center", false, false, false, false, false)
    dxDrawText("Fiyat:" .. string.format("%.2f", taxiFare), screenW * 0.4824, screenH * 0.4714, screenW * 0.5271, screenH * 0.5143, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "center", false, false, false, false, false)
end

function setFare()
    if source == gui_btn3 then
        if fareRenderActive then
            removeEventHandler("onClientRender", root, renderFare)
            fareRenderActive = false
        else
            addEventHandler("onClientRender", root, renderFare)
            fareRenderActive = true
        end
    end
end

function toggleLight()
	if(source == gui_btn4) then
		if lightOn then --turn off
			lightOn = false
			triggerServerEvent("taximeter:setLight", localPlayer, lightOn)
			guiStaticImageLoadImage(gui_btn4, "taximeter/images/btn.png")
		else --turn on
			lightOn = true
			guiStaticImageLoadImage(gui_btn4, "taximeter/images/btn_on.png")
			triggerServerEvent("taximeter:setLight", localPlayer, lightOn)
		end
	end
end


local oX, oY, oZ
function monitoring()
	if(isPedInVehicle(localPlayer)) then
		local x,y,z = getElementPosition(getPedOccupiedVehicle(localPlayer))
		local thisTime  = getDistanceBetweenPoints3D(x,y,z,oX,oY,oZ)
		taxiDistance = taxiDistance + thisTime
		oX = x
		oY = y
		oZ = z
		if gui_base then
			guiSetText(gui_label_totalFare, tostring(math.ceil(taxiFare*(taxiDistance/1000))))
			guiSetText(gui_label_distance, string.format("%.1f", tostring(taxiDistance/1000)))
		end
	end
end

function incomingTaximeterSync(realDistance, realRunning, realPos)
	if not isDriver then
		if meterRunning then
			removeEventHandler("onClientRender",root,monitoring)
		end
		taxiDistance = realDistance
		oX, oY, oZ = realPos[1], realPos[2], realPos[3]
		if realRunning then
			meterRunning = true
			addEventHandler("onClientRender",root,monitoring)
			guiSetText(gui_label_pax_running, "Taximeter running")
			guiLabelSetColor(gui_label_pax_running,0,255,0)
		else
			meterRunning = false
			guiSetText(gui_label_pax_running, "Taximeter not running")
			guiLabelSetColor(gui_label_pax_running,255,0,0)
		end
	end
end
addEvent("taximeter:sync", true)
addEventHandler("taximeter:sync", root, incomingTaximeterSync)

function incomingFareUpdate(newFare)
	taxiFare = newFare
	if gui_base then
		guiSetText(gui_label_fare, string.format("%.2f", tostring(taxiFare)))
	end
end
addEvent("taximeter:sendFare", true)
addEventHandler("taximeter:sendFare", root, incomingFareUpdate)

function incomingReset(newFare)
	taxiDistance = 0
	if gui_base then
		guiSetText(gui_label_distance, "0")
		guiSetText(gui_label_totalFare, "0")
	end
end
addEvent("taximeter:resetMeter", true)
addEventHandler("taximeter:resetMeter", root, incomingReset)

function sendTaximeterSync(vehicle, ignoreCheck)
	if isDriver then
		local theVehicle
		if vehicle then
			theVehicle = vehicle
		else
			theVehicle = getPedOccupiedVehicle(localPlayer)
		end
		local x,y,z = getElementPosition(theVehicle)
		local pos = {x,y,z}
		triggerServerEvent("taximeter:sendSync", theVehicle, taxiDistance, meterRunning, pos, ignoreCheck)
	end
end

function initializeTaximeter(seat, realDistance, realRunning, realPos, realFare, taxiLight)
	local theVehicle = source
	if(seat == 0) then
		isDriver = true
	else
		isDriver = false
	end
	taxiFare = realFare
	taxiDistance = realDistance
	oX, oY, oZ = realPos[1], realPos[2], realPos[3]
	meterRunning = realRunning
	lightOn = taxiLight
	showTaximeterGui()
	if meterRunning then
		addEventHandler("onClientRender",root,monitoring)
		if isDriver then
			if driversSendSyncTimer then
				killTimer(driversSendSyncTimer)
				driversSendSyncTimer = nil
			end
			driversSendSyncTimer = setTimer(sendTaximeterSync, syncInterval, 0)
		end	
	end
end
addEvent("taximeter:initialize", true)
addEventHandler("taximeter:initialize", root, initializeTaximeter)

addEventHandler("onClientVehicleStartExit", root,
		function (player, seat, door)
			if(player == localPlayer) then
				local theVehicle = source
				if(taxiModels[getElementModel(theVehicle)]) then --if taxi	
					if meterRunning then
						meterRunning = false
						removeEventHandler("onClientRender",root,monitoring)
						if isDriver and gui_base then
							guiStaticImageLoadImage(gui_btn1, "taximeter/images/btn.png")
						end
					end
					if isDriver then
						if driversSendSyncTimer then
							killTimer(driversSendSyncTimer)
							driversSendSyncTimer = nil
						end
					end
				end
			end
		end
)
addEventHandler("onClientVehicleExit", root,
		function (player, seat)
			if(player == localPlayer) then
				local theVehicle = source
				if(taxiModels[getElementModel(theVehicle)]) then --if taxi	
					if isDriver then
						sendTaximeterSync(theVehicle, true)
					end
					hideTaximeterGui()
				end
			end
		end
)

function isCursorInPosition(x, y, w, h)
    if not isCursorShowing() then return false end

    local cx, cy = getCursorPosition()
    if not cx or not cy then return false end 

    local sw, sh = guiGetScreenSize()
    return cx * sw >= x and cx * sw <= x + w and cy * sh >= y and cy * sh <= y + h
end


addEventHandler("onClientClick", root, function(button, state)
    if button == "left" and state == "down" then

		local minusX = screenW * 0.4224
        local minusY = screenH * 0.4714
        local minusW = screenW * 0.0461
        local minusH = screenH * 0.0430

        local plusX = screenW * 0.5403
        local plusY = screenH * 0.4714
        local plusW = screenW * 0.0461
        local plusH = screenH * 0.0430

		if isCursorInPosition(minusX, minusY, minusW, minusH) then
			taxiFare = math.max(minFare, taxiFare - 5)
			if gui_label_fare then
				guiSetText(gui_label_fare, string.format("%.2f", taxiFare))
			end
		elseif isCursorInPosition(plusX, plusY, plusW, plusH) then
			taxiFare = math.min(maxFare, taxiFare + 5)
			if gui_label_fare then
				guiSetText(gui_label_fare, string.format("%.2f", taxiFare))
			end
		end
	end
end)


addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()),
		function (startedRes)
			triggerServerEvent("taximeter:clientStarted", localPlayer)
		end
)
