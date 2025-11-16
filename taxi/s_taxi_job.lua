addEventHandler( "onVehicleRespawn", getRootElement( ),
	function( )
		if isVehicleTaxiLightOn( source ) then
			setVehicleTaxiLightOn( source, false )
		end
	end
)

addEventHandler( "onVehicleStartExit", getRootElement( ),
	function( player, seat, jacked )
		if isVehicleTaxiLightOn( source ) then
			setVehicleTaxiLightOn( source, false )
		end
	end
)

function toggleTaxiLight(thePlayer, commandName)
	local theVehicle = getPedOccupiedVehicle(thePlayer)
	if theVehicle then
		if getVehicleController(theVehicle) == thePlayer and getElementModel(theVehicle) == 438 or getElementModel(theVehicle) == 420 then
			setVehicleTaxiLightOn(theVehicle, not isVehicleTaxiLightOn(theVehicle))
		end
	end
end
addCommandHandler("taxilight", toggleTaxiLight, false, false)

local coolDown = {}

--[[
addCommandHandler("taksireklam",commandName)
	function(thePlayer, cmd)
		local playerJob = getElementData(thePlayer, "job")
		if playerJob == 2 then
			if not coolDown[thePlayer] then
				local taksiVeh = getPedOccupiedVehicle(thePlayer)
				local taksiciTel = "Bilgi Yok"
				local taksiciItems = exports["item-system"]:getItems(thePlayer)
				for i, val in ipairs(taksiciItems) do
					if val[1] == 2 then
						taksiciTel = val[2]
					end
				end
				if (getElementModel(taksiVeh) == 438 or getElementModel(taksiVeh) == 420) then
					if not (tonumber(taksiciTel)) then
						outputChatBox("[!] #f0f0f0Reklam verebilmeniz için bir telefona ihtiyacınız var.", thePlayer, 255, 0, 0, true)
						return
					end
					if exports.global:hasMoney(thePlayer, 40) then
						exports.global:takeMoney(thePlayer, 40)
						for _, player in ipairs(exports.pool:getPoolElementsByType("player")) do
							outputChatBox("[T] Yellow Cab 24/7 Hizmetinizde. [" .. getPlayerName(thePlayer):gsub("_", " ") .. " | Tel: " .. taksiciTel .. "]", player,0, 255, 64)
						end
						coolDown[thePlayer] = true
						setTimer(function(player) coolDown[player] = true end, 300000, 1, thePlayer)
					else
						outputChatBox("[!] #f0f0f0Reklam verebilmek için en az TL40'a ihtiyacınız var.", thePlayer, 255, 0, 0, true)
					end
				else
					outputChatBox("[!] #f0f0f0Taksi reklamı verebilmek için taksi aracında olmanız gerekmektedir.", thePlayer, 255, 0, 0, true)
				end
			else
				outputChatBox("[!] #f0f0f0Tekrar reklam gönderebilmek için en az 5 dakika beklemeniz gerekmektedir.", thePlayer, 255, 0, 0, true)
			end
		end
	end
)
]]