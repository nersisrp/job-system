local lockPizzaTimer = nil
local pizzaruns = { }
local pizzawage = { }
local pizzaroute = { }
local pizza = { [448] = true }

function givePizzaMoney(vehicle)
	outputChatBox("You earned TL" .. exports.global:formatMoney( pizzawage[vehicle] or 0 ) .. " on your pizza delivery runs.", source, 255, 194, 15)
	exports.global:giveMoney(source, pizzawage[vehicle] or 0)

	if (pizzawage[vehicle] == nil) then
		triggerPizzaCheatEvent(source, 3)
	elseif (pizzawage[vehicle] > 1500) then
		triggerPizzaCheatEvent(source, 2, pizzawage[vehicle])
	end
	
	-- respawn the vehicle
	exports['anticheat-system']:changeProtectedElementDataEx(source, "realinvehicle", 0, false)
	removePedFromVehicle(source, vehicle)
	respawnVehicle(vehicle)
	setVehicleLocked(vehicle, false)
	setElementVelocity(vehicle,0,0,0)
	
	-- reset runs/wage
	pizzaruns[vehicle] = nil
	pizzawage[vehicle] = nil
end
addEvent("givePizzaMoney", true)
addEventHandler("givePizzaMoney", getRootElement(), givePizzaMoney)


function checkPizzaEnterVehicle(thePlayer, seat)
	if getElementData(source, "owner") == -2 and getElementData(source, "faction") == -1 and seat == 0 and pizza[getElementModel(source)] and getElementData(source,"job") == 10 and getElementData(thePlayer,"job") == 10 then
		triggerClientEvent(thePlayer, "startPizzaJob", thePlayer, pizzaroute[source] or -1)
		if (pizzaruns[vehicle] ~= nil) and (pizzawage[vehicle] > 0) then
			triggerClientEvent(thePlayer, "spawnFinishMarkerPizzaJob", thePlayer)
		end
	end
end
addEventHandler("onVehicleEnter", getRootElement(), checkPizzaEnterVehicle)

function startEnterPizza(thePlayer, seat, jacked) 
	if seat == 0 and pizza[getElementModel(source)] and getElementData(thePlayer,"job") == 10 and jacked then -- if someone try to jack the driver stop him
		if isTimer(lockPizzaTimer) then
			killTimer(lockPizzaTimer)
			lockPizzaTimer = nil
		end
		setVehicleLocked(source, true)
		lockPizzaTimer = setTimer(setVehicleLocked, 5000, 1, source, false)
	end
end
addEventHandler("onVehicleStartEnter", getRootElement(), startEnterPizza)

function savePizzaProgress(vehicle, earnedcash)
	if (pizzaruns[vehicle] == nil) then
		pizzaruns[vehicle] = 0
		pizzawage[vehicle] = 0
	end
	
	pizzaruns[vehicle] = pizzaruns[vehicle] + 1
	pizzawage[vehicle] = pizzawage[vehicle] + earnedcash
	
	outputChatBox("You completed your " .. pizzaruns[vehicle] .. ".  pizza run on this bike and earned TL" .. exports.global:formatMoney(earnedcash) .. ".", client, 0, 255, 0)
	if (earnedcash > 90) then
		triggerPizzaCheatEvent(client, 1, earnedcash)
	end
	
	if (pizzaruns[vehicle] == 25) then
		outputChatBox("#FF9933Your pizza box is empty! Return to the #CC0000resteraunt #FF9933first.", client, 0, 0, 0, true)
	else 
		outputChatBox("#FF9933You can now either return to the #CC0000resteraunt #FF9933and pickup your wage", client, 0, 0, 0, true)
		outputChatBox("#FF9933or continue onto the next #FFFF00delivery point#FF9933 and increase your wage.", client, 0, 0, 0, true)
		triggerClientEvent( client, "loadNewCheckpointPizzaJob",  client)
		triggerEvent("updatePizzaSupplies", client, math.random(10,20))
	end
end
addEvent("savePizzaProgress", true)
addEventHandler("savePizzaProgress", getRootElement(), savePizzaProgress)

function triggerPizzaCheatEvent(thePlayer, cheatType, value1)
	local cheatStr = ""
	if (cheatType == 1) then
		cheatStr = "Too much earned on one trucking run, (c:"..value1..", max 60)"
	elseif (cheatType == 2) then
		cheatStr = "Too much earned in total. (c:"..value1..", max 1500)"
	else
		cheatStr = "unknown triggerPizzaCheatEvent (".. cheatType .."/"..value1..")"
	end
	local finalstr = "[pizza\saveDeliveryProgress]".. getPlayerName(thePlayer) .. " " .. getPlayerIP(thePlayer) .. " ".. cheatStr  
	exports.logs:logMessage(finalstr, 32)
	exports.global:sendMessageToAdmins(finalstr)
end

function updateNextPizzaCheckpoint(vehicle, pointid)
	pizzaroute[vehicle] = pointid
end
addEvent("updateNextPizzaCheckpoint", true)
addEventHandler("updateNextPizzaCheckpoint", getRootElement(), updateNextPizzaCheckpoint)

function restorePizzaJob()
	if getElementData(source, "job") == 10 then
		triggerClientEvent(source, "restorePizzaJob", source)
	end
end
addEventHandler("restoreJob", getRootElement(), restorePizzaJob)