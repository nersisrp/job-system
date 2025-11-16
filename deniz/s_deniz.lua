function denizParaVer(thePlayer)
	exports.global:giveMoney(thePlayer, 261)
	outputChatBox("[!] #FFFFFFTebrikler, bu turdan TL261 kazandınız!", thePlayer, 0, 255, 0, true)
end
addEvent("denizParaVer", true)
addEventHandler("denizParaVer", getRootElement(), denizParaVer)

function denizBitir(thePlayer)
	local pedVeh = getPedOccupiedVehicle(thePlayer)
	removePedFromVehicle(thePlayer)
	respawnVehicle(pedVeh)
	setElementPosition(thePlayer, 136.57266235352, -1794.5427246094, 2.1546874046326)
	setElementRotation(thePlayer, 0, 0, 181.5051574707)
end
addEvent("denizBitir", true)
addEventHandler("denizBitir", getRootElement(), denizBitir)