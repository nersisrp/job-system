function ickiParaVer(thePlayer)
	exports.global:giveMoney(thePlayer, 1650)
	outputChatBox("[!] #FFFFFFTebrikler, bu turdan TL1650 kazandınız!", thePlayer, 0, 255, 0, true)
end
addEvent("ickiParaVer", true)
addEventHandler("ickiParaVer", getRootElement(), ickiParaVer)

function ickiBitir(thePlayer)
	local pedVeh = getPedOccupiedVehicle(thePlayer)
	removePedFromVehicle(thePlayer)
	respawnVehicle(pedVeh)
	setElementPosition(thePlayer, 2579.0166015625, -2424.84765625, 13.635452270508)
	setElementRotation(thePlayer, 0, 0, 312.48065185547)
end
addEvent("ickiBitir", true)
addEventHandler("ickiBitir", getRootElement(), ickiBitir)