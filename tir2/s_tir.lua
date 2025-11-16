local tirpara=50000
local tirparayakit=1000
local tirparadepozito=3000

function tirParaVer2(thePlayer)
	local kazanc=tirpara

	local pedVeh = getPedOccupiedVehicle(thePlayer)
	if getElementData(pedVeh, "job") ~= 10 then
		kazanc=kazanc*1.5
	end
	
	exports.global:giveMoney(thePlayer, kazanc)
	local name = getPlayerName( thePlayer )	
	exports.dclog:createWinsLog(name.." zorlu bir tır görevini başarıyla tamamladı ve tam "..kazanc.." TL kazandı.")
end
addEvent("tirParaVer2", true)
addEventHandler("tirParaVer2", getRootElement(), tirParaVer2)

function getPosition3(thePlayer, commandName)
	if (exports.integration:isPlayerTrialAdmin(thePlayer)) or (exports.integration:isPlayerScripter(thePlayer)) then
		local x, y, z = getElementPosition(thePlayer)
		local rx, ry, rz = getElementRotation(thePlayer)
		local dimension = getElementDimension(thePlayer)
		local interior = getElementInterior(thePlayer)
		outputChatBox("Position: " .. x .. ", " .. y .. ", " .. z, thePlayer, 255, 194, 14)
		outputChatBox("Rotation: " .. rx .. ", " .. ry .. ", " .. rz, thePlayer, 255, 194, 14)
		outputChatBox("Dimension: " .. dimension, thePlayer, 255, 194, 14)
		outputChatBox("Interior: " .. interior, thePlayer, 255, 194, 14)
		local prepairedText = "{"..x..","..y..","..z..",false},"
		outputChatBox("'"..prepairedText.."' - copied to clipboard", thePlayer, 200, 200, 200)
		triggerClientEvent(thePlayer, "copyPosToClipboard", thePlayer, prepairedText)
	end
end
addCommandHandler("getpos3", getPosition3, false, false)

function tirBenzinParaVer(thePlayer)
	if exports.global:takeMoney(thePlayer, tirparayakit) then
		outputChatBox("Tıra mazot yüklemek için "..tirparayakit.." ödediniz.", thePlayer, 255, 0, 0)
	else
		outputChatBox("Yakıtı ödemek için "..tirparayakit.." Türk Liranız yok.", thePlayer, 255, 0, 0)
		tirBitirGlobal(thePlayer)
	end
	
	
	local mtaaccount = getPlayerName( thePlayer )
end
addEvent("tirBenzinParaVer", true)
addEventHandler("tirBenzinParaVer", getRootElement(), tirBenzinParaVer)

function tirDepozitoParaVer(thePlayer)
	if exports.global:takeMoney(thePlayer, tirparadepozito) then
		
		outputChatBox("Dorse depozitosunu ödemek için "..tirparadepozito.." TL harcadınız.", thePlayer, 255, 0, 0)
	else
		outputChatBox("Dorse depozitosu için yeterli paran yok! ("..tirparadepozito..").", thePlayer, 255, 0, 0)
		tirBitirGlobal(thePlayer)
	end
	local mtaaccount = getPlayerName( thePlayer )
end
addEvent("tirDepozitoParaVer", true)
addEventHandler("tirDepozitoParaVer", getRootElement(), tirDepozitoParaVer)

function tirDepozitoIade(thePlayer)
	outputChatBox("Dorse iadesi olarak "..tirparadepozito.." TL aldınız.", thePlayer, 255, 0, 0)
	exports.global:giveMoney(thePlayer, tirparadepozito)
	local mtaaccount = getPlayerName( thePlayer )
end
addEvent("tirDepozitoIade", true)
addEventHandler("tirDepozitoIade", getRootElement(), tirDepozitoIade)

function tirBitir2(thePlayer)
	tirBitirGlobal(thePlayer)
end
addEvent("tirBitir2", true)
addEventHandler("tirBitir2", getRootElement(), tirBitir2)



function tirBitirGlobal(thePlayer)
    local pedVeh = getPedOccupiedVehicle(thePlayer)
    if not pedVeh then return end

	detachTrailerFromVehicle(pedVeh)
	if getElementData(pedVeh, "job") ~= 10 then return end

    removePedFromVehicle(thePlayer)
    respawnVehicle(pedVeh)

    exports.nrpSavunma4:changeProtectedElementDataEx(pedVeh, "handbrake", 1, true)

    setVehicleEngineState(pedVeh, false)
    exports.nrpSavunma4:changeProtectedElementDataEx(pedVeh, "engine", 0, true)
 
    fixVehicle(pedVeh)
    setElementPosition(thePlayer, -1549.373046875, -2738.7724609375, 48.541351318359)
    setElementRotation(thePlayer, 0, 0, 167)
end


function getVehiclePosition(player, cmd, dbid)
    dbid = tonumber(dbid)
    if not dbid then
        outputChatBox("Kullanım: /vehpos [dbid]", player, 255, 0, 0)
        return
    end

    for _, vehicle in ipairs(getElementsByType("vehicle")) do
        local vehicleDbid = getElementData(vehicle, "dbid")
        if vehicleDbid and tonumber(vehicleDbid) == dbid then
            local x, y, z = getElementPosition(vehicle)
            local rx, ry, rz = getElementRotation(vehicle)
			outputChatBox(string.format("%.2f, %.2f, %.2f, %.2f, %.2f, %.2f", x, y, z, rx, ry, rz), player, 255, 0, 0)

            return
        end
    end

    outputChatBox("arac bulunamadı", player, 255, 0, 0)
end
addCommandHandler("advehpos", getVehiclePosition)

trailer_positions = {
	--Başlangıç
	{-1526.00, -2755.00, 48.93, 0, 0, 170},
	{-1530.63, -2751.62, 48.93, 0, 0, 170},
	{-1535.26, -2748.24, 48.93, 0, 0, 170},
	{-1539.89, -2744.86, 48.93, 0, 0, 170},
	{-1544.52, -2741.48, 48.93, 0, 0, 170},
    --Tepe
	{-2350.19, -1642.89, 484.08, 1.03, 359.44, 278.27},
	{-2341.00, -1654.61, 484.06, 1.41, 359.79, 270.5},
	{-2344.55, -1649.06, 484.05, 1.29, 359.99, 275.72},
	--Ekstra
	{-2097.02, -1872.73, 110.75, 4.72, 0.08, 133.98},
	{-2809.63, -1537.54, 139.67, 1.77, 359.47, 271.02},
	{-2532.70, -1669.33, 401.81, 4.57, 3.25, 192.42},
	{-2583.42, -1369.71, 266.85, 355.56, 356.03, 338.79}

}

max_distance = 20
check_frequency = 1
local trailers = {}

function createSingleTrailer(index)
	local pos = trailer_positions[index]
	if not pos then return end
	local x, y, z, rx, ry, rz = unpack(pos)
	local veh = createVehicle(435, x, y, z, rx, ry, rz)
	if not isElement(veh) then return end
	exports.nrpSavunma4:changeProtectedElementDataEx(veh, "dbid", -1, true)
	exports.nrpSavunma4:changeProtectedElementDataEx(veh, "fuel", exports["fuel-system"]:getMaxFuel(veh), false)
	exports.nrpSavunma4:changeProtectedElementDataEx(veh, "plate", "TIR", true)
	exports.nrpSavunma4:changeProtectedElementDataEx(veh, "Impounded", 0)
	exports.nrpSavunma4:changeProtectedElementDataEx(veh, "engine", 0, false)
	exports.nrpSavunma4:changeProtectedElementDataEx(veh, "faction", -1)
	exports.nrpSavunma4:changeProtectedElementDataEx(veh, "job", 6, false)
	exports.nrpSavunma4:changeProtectedElementDataEx(veh, "handbrake", 0, true)
	exports.nrpSavunma4:changeProtectedElementDataEx(veh, "tirMeslek", 1, true)
	trailers[index] = veh
end

local function isTrailerAttached(veh)
	for _, truck in ipairs(getElementsByType("vehicle")) do
		local attached = getVehicleTowedByVehicle(truck)
		if isElement(attached) then
			if veh==attached then
				return true
			end
		end
	end
	return false
end

function checkTrailers()
	for i, pos in ipairs(trailer_positions) do
		local veh = trailers[i]
		local x, y, z = pos[1], pos[2], pos[3]

		if not isElement(veh) then
			createSingleTrailer(i)
		else
			local cx, cy, cz = getElementPosition(veh)
			local dist = getDistanceBetweenPoints3D(cx, cy, cz, x, y, z)

			if dist > max_distance then
				if  not isTrailerAttached(veh) then
					destroyElement(veh)
				end
				createSingleTrailer(i)
			end
			
		end
	end
end

for i = 1, #trailer_positions do
	createSingleTrailer(i)
end
setTimer(checkTrailers, check_frequency * 1000, 0)


function dorseSil2()
	if getElementData(source, "tirMeslek") == 1 then
		destroyElement(source)
	end
end
addEventHandler("onTrailerDetach", getRootElement(), dorseSil2)