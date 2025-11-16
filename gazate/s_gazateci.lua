function gazeteParaVer(thePlayer)
	exports.global:giveMoney(thePlayer, 333)
	outputChatBox("[!] #FFFFFFTebrikler, bu turdan 333TL kazandınız!", thePlayer, 0, 255, 0, true)
end
addEvent("gazeteParaVer", true)
addEventHandler("gazeteParaVer", getRootElement(), gazeteParaVer)

function gazeteBitir(thePlayer)
	local pedVeh = getPedOccupiedVehicle(thePlayer)
	removePedFromVehicle(thePlayer)
	respawnVehicle(pedVeh)
	setVehicleLocked(pedVeh, false)
	setElementPosition(thePlayer, 1914.5322265625, -1741.736328125, 13.52370262146)
	setElementRotation(thePlayer, 0, 0, 91.338989257813)
end
addEvent("gazeteBitir", true)
addEventHandler("gazeteBitir", getRootElement(), gazeteBitir)