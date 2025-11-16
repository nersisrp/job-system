function motorParaVer(thePlayer)
	exports.global:giveMoney(thePlayer, 50)
	outputChatBox("[!] #FFFFFFTebrikler, bu turdan 50TL kazandınız!", thePlayer, 0, 255, 0, true)
end
addEvent("motorParaVer", true)
addEventHandler("motorParaVer", getRootElement(), motorParaVer)

function motorBitir(thePlayer)
	local pedVeh = getPedOccupiedVehicle(thePlayer)
	removePedFromVehicle(thePlayer)
	respawnVehicle(pedVeh)
	setVehicleLocked(pedVeh, false)
	setElementPosition(thePlayer, 784.3916015625, -1599.5283203125, 13.546875)
	setElementRotation(thePlayer, 0, 0, 91.338989257813)
end
addEvent("motorBitir", true)
addEventHandler("motorBitir", getRootElement(), motorBitir)