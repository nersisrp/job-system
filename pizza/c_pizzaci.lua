--[[
    @بسم الله الرحمن الرحيم
    @Script: Pizzacılık Sistemi
    @Version: v1.0
    @Scripter: Leoncio
    @Server: Nersis Roleplay    
--]]

--[[ 
BİLGİ: 
	MESLEK ID = 8 / ARAÇ MESLEK ID = 8
]]

----------------------------------------------------------------------------
-- DEĞİŞKENLER
----------------------------------------------------------------------------
local jobID = 8

-- PED
local pedName = "Murat Kaya"
local pedPosX, pedPosY, pedPosZ = 2124.681640625, -1818.5634765625, 13.555109977722
local pedRot = 270
local pedSkin = 155

-- GLOBAL
local pizzaMarker = 0
local pizzaBlip = 0
local pizzaCreatedMarkers = {}
local pizzaCreatedBlips = {}
local baslangicX, baslangicY, baslangicZ = 789.9814453125, -1598.728515625, 12.98321056366

----------------------------------------------------------------------------
--- MESLEK PED
--[[
local meslekPed = createPed(pedSkin, pedPosX, pedPosY, pedPosZ)
setElementData(meslekPed, "name", pedName)
setElementData(meslekPed, "talk", 1)
setElementFrozen(meslekPed, true)
setElementRotation(meslekPed, 0, 0, pedRot)
]]
----------------------------------------------------------------------------

function pizzaciGUI()
	if getElementData(getLocalPlayer(), "job") == jobID then
		triggerServerEvent("textNrpLocalSend", getLocalPlayer(), getLocalPlayer(), "[Türkçe] " .. pedName .. " diyor ki: İş başı yapabilirsin.", 255, 255, 255, 10, {}, true)
		return
	end
	
    pizzaciWindow = guiCreateWindow(0.31, 0.42, 0.37, 0.17, "Pizza Dağıtıcısı - Nersis Roleplay © Leoncio", true)
    guiWindowSetSizable(pizzaciWindow, false)

    triggerServerEvent("textNrpLocalSend", getLocalPlayer(), getLocalPlayer(), "[Türkçe] " .. pedName .. " diyor ki: Merhaba dostum! İşe ihtiyacın varsa pizza dağıtımcısı olarak burada başlayabilirsin. Ne dersin?", 255, 255, 255, 10, {}, true)
	npcMesajLbl = guiCreateLabel(0.02, 0.19, 0.96, 0.27, "[Türkçe] " .. pedName .. " diyor ki: Merhaba dostum! İşe ihtiyacın varsa pizza dağıtımcısı olarak burada başlayabilirsin. Ne dersin?", true, pizzaciWindow)
    guiLabelSetHorizontalAlign(npcMesajLbl, "left", true)
    kabulBtn = guiCreateButton(9, 69, 232, 48, "Kabul Et", false, pizzaciWindow)
    reddetBtn = guiCreateButton(251, 69, 244, 48, "Reddet", false, pizzaciWindow)   
	addEventHandler("onClientGUIClick", guiRoot,
		function()
			if source == reddetBtn then
				destroyElement(pizzaciWindow)
			elseif source == kabulBtn then
				triggerServerEvent("pizza:pizzacilikKabul", getLocalPlayer())
				destroyElement(pizzaciWindow)
			end
		end
	)
end
addEvent("pizzaci:pizzaciGUI", true)
addEventHandler("pizzaci:pizzaciGUI", root, pizzaciGUI)

----------------------------------------------------------------------------
--- ROTA
----------------------------------------------------------------------------
local pizzaRota = {
	-- X, Y, Z, markerType [0 = Başlangıç, 1 = Normal, 2 = Teslim]

	{ 756.64074707031, -1607.3026123047, 13.224102020264, 1 },
	{ 760.84375, -1744.3388671875, 12.349465370178, 1 },
    { 641.109375, -1715.30859375, 14.27885723114, 1 },
	{ 645.810546875, -1652.1689453125, 15.045569419861, 1 },
	{ 823.6650390625, -1413.240234375, 13.461822509766, 1 },
	{ 993.4228515625, -1047.142578125, 30.808565139771, 1 },
	{ 1089.1669921875, -1066.439453125, 28.891315460205, 1 },
	{ 1168.7578125, -1072.982421875, 27.863723754883, 1 },
	{ 1256.205078125, -1073.2421875, 28.265659332275, 1 },
	{ 1197.1064453125, -1276.458984375, 13.331829071045, 1 },
	{ 999.423828125, -1299.353515625, 13.389896392822, 1 },
	{ 433.8544921875, -1313.9541015625, 15.08180141449, 1 },
	{ 172.3125, -1773.20703125, 4.2601041793823, 1 },
	{ 315.3017578125, -1770.5771484375, 4.6579122543335, 1 },
	{ 625.9140625, -1754.0244140625, 13.351935386658, 1 },
	{ 866.8271484375, -1796.8759765625, 13.80561542511, 1 },
	{ 1160.005859375, -1675.421875, 13.961181640625, 1 },
	{ 1076.9267578125, -1564.65625, 13.539066314697, 1 },
	{ 842.5751953125, -1598.67578125, 13.546875, 1 },
	{ 198.8544921875, -1384.92578125, 48.658184051514, 1 },
	{ 262.439453125, -1331.650390625, 53.238101959229, 1 },
	{ 1364.66015625, -1340.7978515625, 13.546875, 1 },
	{ 219.2734375, -1274.6025390625, 63.895084381104, 1 },
	{ 344.552734375, -1191.6279296875, 76.533767700195, 1 },
	{ 402.23046875, -1163.3212890625, 78.686561584473, 1 },
	{ 688.587890625, -1053.9482421875, 49.984153747559, 1 },
	{ 972.9541015625, -814.1376953125, 97.572799682617, 1 },
	{ 1240.763671875, -740.798828125, 95.538261413574, 1 },
	{ 1521.982421875, -841.845703125, 66.796127319336, 1 },


	{ 805.56640625, -1630.509765625, 13.3828125, 2 },
}

function pizzaBasla(cmd)
	local theVehicle = getPedOccupiedVehicle(getLocalPlayer())
	if not theVehicle or getElementData(theVehicle, "job") ~= jobID then
		exports["bildirim"]:addNotification("Göreve başlamak için bir pizza motorunda olmanız gerekmektedir!", "error")
		return
	end

	if not getElementData(getLocalPlayer(), "meslek:pizza") then
		setElementData(getLocalPlayer(), "meslek:pizza", true)
		
		setElementData(getLocalPlayer(), "oldSkin", getElementModel(getLocalPlayer()))
		triggerServerEvent("setElementModel", getLocalPlayer(), 155)
		
		pizzaRotaGuncelle()
		
		addEventHandler("onClientMarkerHit", resourceRoot, pizzaMarkerHit)
		exports["bildirim"]:addNotification("Mesleğe başladınız!", "info")
	else
		exports["bildirim"]:addNotification("Mesleğe zaten başladınız!", "error")
	end
end
addCommandHandler("pizzabasla", pizzaBasla)

function pizzaRotaGuncelle()
	pizzaMarker = pizzaMarker + 1
	pizzaBlip = pizzaBlip + 1
	if pizzaMarker == 1 then
		local baslangicMarker = createMarker(baslangicX, baslangicY, baslangicZ, "checkpoint", 4, 100, 100, 255, 255, getLocalPlayer())
		local rotaBlip = createBlip(baslangicX, baslangicY, baslangicZ, 0, 2, 100, 100, 255)
		table.insert(pizzaCreatedMarkers, { baslangicMarker, 0 })
		table.insert(pizzaCreatedBlips, { rotaBlip, false })
	else
		local rotaNumber = math.random(#pizzaRota)
		for index, value in ipairs(pizzaRota) do
			if pizzaMarker < 10 then
				if index == rotaNumber then
					if value[4] == 1 then 
						local rotaMarker = createMarker(value[1], value[2], value[3], "checkpoint", 4, 255, 0, 0, 255, getLocalPlayer())
						local rotaBlip = createBlip(value[1], value[2], value[3], 0, 2, 255, 0, 0)
						table.insert(pizzaCreatedMarkers, { rotaMarker, 1 })			
						table.insert(pizzaCreatedBlips, { rotaBlip, false })
					end
				end
			elseif pizzaMarker == 10 then
				if value[4] == 2 then
					local bitisMarker = createMarker(value[1],value[2], value[3], "checkpoint", 4, 255, 255, 0, 255, getLocalPlayer())
					local rotaBlip = createBlip(value[1], value[2], value[3], 0, 2, 255, 255, 0)
					table.insert(pizzaCreatedMarkers, { bitisMarker, 2 })	
					table.insert(pizzaCreatedBlips, { rotaBlip, false })
				end
			end
		end
	end
end

function pizzaMarkerHit(hitPlayer, matchingDimension)
	if hitPlayer == getLocalPlayer() then
		local hitVehicle = getPedOccupiedVehicle(hitPlayer)
		if not hitVehicle or getElementData(hitVehicle, "job") ~= jobID then
			exports["bildirim"]:addNotification("Bu alandan pizza motoruyla geçmeniz gerekmektedir.", "error")
			return
		end
		
		for _, marker in ipairs(pizzaCreatedMarkers) do
			if source == marker[1] and matchingDimension then
				if marker[2] == 0 then
					local hitVehicle = getPedOccupiedVehicle(hitPlayer)
					setElementFrozen(hitPlayer, true)
					setElementFrozen(hitVehicle, true)
					toggleAllControls(false, true, false)
					exports["bildirim"]:addNotification("Pizzaları motora koyana kadar bekleyiniz. (1-2sn)", "info")
					setTimer(
						function(thePlayer, hitVehicle, hitMarker)
							destroyElement(hitMarker)
							destroyElement(pizzaCreatedBlips[pizzaBlip][1])
							exports["bildirim"]:addNotification("Pizzalar yüklenmiştir!", "success")
							setElementFrozen(hitVehicle, false)
							setElementFrozen(thePlayer, false)
							toggleAllControls(true)
							pizzaRotaGuncelle()
						end, 2500, 1, hitPlayer, hitVehicle, source
					)
				elseif marker[2] == 1 then
					local hitVehicle = getPedOccupiedVehicle(hitPlayer)
					setElementFrozen(hitPlayer, true)
					setElementFrozen(hitVehicle, true)
					toggleAllControls(false, true, false)
					exports["bildirim"]:addNotification("Pizzaları servis edene kadar bekleyiniz. (3-4sn)", "info")
					setTimer(
						function(thePlayer, hitVehicle, hitMarker)
							destroyElement(hitMarker)
							destroyElement(pizzaCreatedBlips[pizzaBlip][1])
							exports["bildirim"]:addNotification("Pizzalar servis edilmiştir. Devam edebilirsiniz!", "success")
							setElementFrozen(hitVehicle, false)
							setElementFrozen(thePlayer, false)
							toggleAllControls(true)
			
							triggerServerEvent("pizza:pizzaParaVer", thePlayer, thePlayer)
							pizzaRotaGuncelle()
						end, 3500, 1, hitPlayer, hitVehicle, source
					)	
				elseif marker[2] == 2 then
					exports["bildirim"]:addNotification("Aracı teslim ettiniz ve bu turu başarıyla bitirdiniz!", "info")
					pizzaBitir()
				end
			end
		end
	end
end

function pizzaBitir()
	local playerVehicle = getPedOccupiedVehicle(getLocalPlayer())
	if playerVehicle then
		local vehicleJob = getElementData(playerVehicle, "job")
		local meslekDurumu = getElementData(getLocalPlayer(), "meslek:pizza")
		if vehicleJob == jobID then
			exports.global:fadeToBlack()
			---------------------------- MESLEK BAŞLAMIŞSA ----------------------------
			if meslekDurumu then
				setElementData(getLocalPlayer(), "meslek:pizza", false)
				--- MARKER VE BLİPLERİ TEMİZLE ---
				for _, marker in ipairs(pizzaCreatedMarkers) do
					if isElement(marker[1]) then
						destroyElement(marker[1])
					end
				end
				for _, blip in ipairs(pizzaCreatedBlips) do
					if isElement(blip[1]) then
						destroyElement(blip[1])
					end
				end
				pizzaCreatedMarkers = {}
				pizzaCreatedBlips = {}
				pizzaMarker = 0
				pizzaBlip = 0
				----------------------------------
				triggerServerEvent("setElementModel", getLocalPlayer(), getElementData(getLocalPlayer(), "oldSkin"))
			end
			---------------------------------------------------------------------------
			triggerServerEvent("pizza:pizzaBitir", getLocalPlayer(), getLocalPlayer())
			removeEventHandler("onClientMarkerHit", resourceRoot, pizzaMarkerHit)
			setTimer(function() exports.global:fadeFromBlack() end, 1000, 1)
		end
	end
end
addCommandHandler("pizzabitir", pizzaBitir)

-----------------------------------------------------------------------------------------------------------------------------------------------------------
function showPizzaBlip()
	exports.hud:sendBottomNotification(localPlayer, "Pizza Dağıtımcısı", "Haritadaki sarı işarete giderek pizzacılık mesleğinize başlayabilirsiniz.")
	blip = createBlip(2125.36328125, -1820.875, 13.554777145386, 0, 4, 255, 255, 0)
end