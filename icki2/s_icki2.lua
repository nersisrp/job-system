function ickiParaVer(thePlayer)
	exports.global:giveMoney(thePlayer, 455)
	outputChatBox("[!] #FFFFFFTebrikler, bu turdan 455TL kazandınız!", thePlayer, 0, 255, 0, true)
end
addEvent("ickiParaVer", true)
addEventHandler("ickiParaVer", getRootElement(), ickiParaVer)

function ickiBitir(thePlayer)
	local pedVeh = getPedOccupiedVehicle(thePlayer)
	removePedFromVehicle(thePlayer)
	respawnVehicle(pedVeh)
	setVehicleLocked(pedVeh, false)
	setElementPosition(thePlayer, 2581.4580078125, -2429.5029296875, 13.63491153717)
	setElementRotation(thePlayer, 0, 0, 91.338989257813)
end
addEvent("ickiBitir", true)
addEventHandler("ickiBitir", getRootElement(), ickiBitir)