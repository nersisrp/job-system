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

function pizzaParaVer(thePlayer)
	local money = 150
	--[[local realTime = getRealTime()
	local weekDay = realTime["weekday"]
	if weekDay == 6 or weekDay == 7 then
		money = 190
	end]]
	exports.global:giveMoney(thePlayer, money)
end
addEvent("pizza:pizzaParaVer", true)
addEventHandler("pizza:pizzaParaVer", getRootElement(), pizzaParaVer)

function pizzaBitir(thePlayer)
	local theVehicle = getPedOccupiedVehicle(thePlayer)
	respawnVehicle(theVehicle)
	removePedFromVehicle(thePlayer)
	setElementPosition(thePlayer, 783.75390625, -1596.4404296875, 13.546875)
	setElementRotation(thePlayer, 0, 0, 359)
end
addEvent("pizza:pizzaBitir", true)
addEventHandler("pizza:pizzaBitir", getRootElement(), pizzaBitir)

function pizzacilikKabul()
	exports.global:textNrpLocalSend(source, "[Türkçe] Murat Kaya diyor ki: Pekala dostum, işe başlayabilirsin!", 255, 255, 255, 10, {}, true)
	triggerEvent("acceptJob", source, 8)
	exports["bildirim"]:addNotification(source, "Artık pizza dağıtımcısısınız!", "success")
end
addEvent("pizza:pizzacilikKabul", true)
addEventHandler("pizza:pizzacilikKabul", getRootElement(), pizzacilikKabul)