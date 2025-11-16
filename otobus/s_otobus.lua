local buspara=45000
function otobusParaVer(thePlayer)
	exports.global:giveMoney(thePlayer, buspara)
	
	local name = getPlayerName( source )	
    exports.dclog:createWinsLog(name.." uzun bir otobüs seferini başarıyla tamamladı ve tam "..buspara.." TL kazandı.")
	outputChatBox( "[!] #FFFFFFTebrikler, bu turdan "..buspara.." TL kazandınız! ", thePlayer, 0, 255, 0, true)
end
addEvent("otobusParaVer", true)
addEventHandler("otobusParaVer", getRootElement(), otobusParaVer)

function otobusBitir(thePlayer)
	local pedVeh = getPedOccupiedVehicle(thePlayer)
	removePedFromVehicle(thePlayer)
	respawnVehicle(pedVeh)
	setElementPosition(thePlayer,1247.1455078125,-1357.533203125,13.39625453949)
	setElementRotation(thePlayer, 0, 0, 270.43533325195)
end
addEvent("otobusBitir", true)
addEventHandler("otobusBitir", getRootElement(), otobusBitir)