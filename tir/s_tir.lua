function tirParaVer(thePlayer)
	exports.global:giveMoney(thePlayer, 2000)
end
addEvent("tirParaVer", true)
addEventHandler("tirParaVer", getRootElement(), tirParaVer)

function tirBitir(thePlayer)
	local pedVeh = getPedOccupiedVehicle(thePlayer)
	removePedFromVehicle(thePlayer)
	respawnVehicle(pedVeh)
	
	setElementPosition(thePlayer, 2273.498046875, -2348.6064453125, 13.546875)
	setElementRotation(thePlayer, 0, 0, 316)
end
addEvent("tirBitir", true)
addEventHandler("tirBitir", getRootElement(), tirBitir)

function dorseOlustur()
	local vehShopData = exports["vehicle-manager"]:getInfoFromVehShopID(1012)
	local veh = createVehicle(435, 2267.8115234375, -2401.49609375, 14.040822982788, 0, 0, 312.48352050781)
	exports.nrpSavunma4:changeProtectedElementDataEx(veh, "dbid", -1, true)
	exports.nrpSavunma4:changeProtectedElementDataEx(veh, "fuel", exports["fuel-system"]:getMaxFuel(veh), false)
	exports.nrpSavunma4:changeProtectedElementDataEx(veh, "plate", "TIR", true)
	exports.nrpSavunma4:changeProtectedElementDataEx(veh, "Impounded", 0)
	exports.nrpSavunma4:changeProtectedElementDataEx(veh, "engine", 0, false)
	exports.nrpSavunma4:changeProtectedElementDataEx(veh, "oldx", x, false)
	exports.nrpSavunma4:changeProtectedElementDataEx(veh, "oldy", y, false)
	exports.nrpSavunma4:changeProtectedElementDataEx(veh, "oldz", z, false)
	exports.nrpSavunma4:changeProtectedElementDataEx(veh, "faction", -1)
	exports.nrpSavunma4:changeProtectedElementDataEx(veh, "job", 6, false)
	exports.nrpSavunma4:changeProtectedElementDataEx(veh, "handbrake", 0, true)
	exports.nrpSavunma4:changeProtectedElementDataEx(veh, "tirMeslek", 1, true)
	
	exports.nrpSavunma4:changeProtectedElementDataEx(veh, "brand", vehShopData.vehbrand, true)
	exports.nrpSavunma4:changeProtectedElementDataEx(veh, "maximemodel", vehShopData.vehmodel, true)
	exports.nrpSavunma4:changeProtectedElementDataEx(veh, "year", vehShopData.vehyear, true)
	exports.nrpSavunma4:changeProtectedElementDataEx(veh, "vehicle_shop_id", vehShopData.id, true)
	
	return veh
end
addEvent("tir:dorseOlustur", true)
addEventHandler("tir:dorseOlustur", root, dorseOlustur)


function dorseOlustur2()
	local vehShopData = exports["vehicle-manager"]:getInfoFromVehShopID(1012)
	local veh = createVehicle(435, -1687.44921875, 25.59375, 4.0749635696411, 0, 0, 47.428588867188)
	exports.nrpSavunma4:changeProtectedElementDataEx(veh, "dbid", -1, true)
	exports.nrpSavunma4:changeProtectedElementDataEx(veh, "fuel", exports["fuel-system"]:getMaxFuel(veh), false)
	exports.nrpSavunma4:changeProtectedElementDataEx(veh, "plate", "TIR", true)
	exports.nrpSavunma4:changeProtectedElementDataEx(veh, "Impounded", 0)
	exports.nrpSavunma4:changeProtectedElementDataEx(veh, "engine", 0, false)
	exports.nrpSavunma4:changeProtectedElementDataEx(veh, "oldx", x, false)
	exports.nrpSavunma4:changeProtectedElementDataEx(veh, "oldy", y, false)
	exports.nrpSavunma4:changeProtectedElementDataEx(veh, "oldz", z, false)
	exports.nrpSavunma4:changeProtectedElementDataEx(veh, "faction", -1)
	exports.nrpSavunma4:changeProtectedElementDataEx(veh, "job", 6, false)
	exports.nrpSavunma4:changeProtectedElementDataEx(veh, "handbrake", 0, true)
	exports.nrpSavunma4:changeProtectedElementDataEx(veh, "tirMeslek", 1, true)
	
	exports.nrpSavunma4:changeProtectedElementDataEx(veh, "brand", vehShopData.vehbrand, true)
	exports.nrpSavunma4:changeProtectedElementDataEx(veh, "maximemodel", vehShopData.vehmodel, true)
	exports.nrpSavunma4:changeProtectedElementDataEx(veh, "year", vehShopData.vehyear, true)
	exports.nrpSavunma4:changeProtectedElementDataEx(veh, "vehicle_shop_id", vehShopData.id, true)
	
	return veh
end
addEvent("tir:dorseOlustur2", true)
addEventHandler("tir:dorseOlustur2", root, dorseOlustur2)


function dorseSil()
	if getElementData(source, "tirMeslek") == 1 then
		destroyElement(source)
	end
end
addEventHandler("onTrailerDetach", getRootElement(), dorseSil)