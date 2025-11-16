local blippizza, endblippizza
local jobstatepizza = 0
local route = 0
local oldroute = -1
local markerpizza, endmarkerpizza
local pizzaStopTimer = nil

local localPlayer = getLocalPlayer()

local routes = {
	{ 2073.8505859375, -1659.05078125, 13.546875 },
	{ 2238.02734375, -1645.23046875, 15.485620498657 },
	{ 2507.708984375, -1682.45703125, 13.546875 },
	{ 2486.5224609375, -2016.783203125, 13.546875 },
	{ 2653.427734375, -1997.2109375, 13.5546875 },
	{ 2778.29296875, -1970.7041015625, 13.546875 },
	{ 2801.6083984375, -1495.5595703125, 19.481674194336 },
	{ 2540.4111328125, -1248.4951171875, 40.156902313232 },
	{ 2379.1064453125, -1276.1748046875, 24 },
	{ 2256.4033203125, -1294.5703125, 23.975261688232 },
	{ 2141.23828125, -1306.787109375, 23.989730834961 },
	{ 2137.84765625, -1408.716796875, 23.987300872803 },
	{ 2003.2294921875, -1596.5546875, 13.573805809021 },
	{ 1889.9697265625, -2020.1357421875, 13.539081573486 },
	{ 1872.38671875, -2144.177734375, 13.546875 },
	{ 970.8994140625, -1832.8251953125, 12.608911514282 },
	{ 792.291015625, -1762.2490234375, 13.411386489868 },
	{ 646.3466796875, -1621.599609375, 15.100688934326 },
	{ 760.6962890625, -1600.4609375, 13.426874160767 },
	{ 305.3310546875, -1772.4404296875, 4.5722360610962 }, 
	{ 169.30859375, -1770.724609375, 4.4037179946899 },
	{ 139.4521484375, -1457.9365234375, 26.361795425415 },
	{ 262.927734375, -1330.0771484375, 53.274669647217 },
	{ 343.921875, -1191.681640625, 76.549644470215 },
	{ 400.5546875, -1162.0986328125, 78.544647216797 },
	{ 724.3310546875, -992.6396484375, 52.571556091309 },
	{ 948.6064453125, -763.0146484375, 108.21302032471 },
	{ 1059.724609375, -623.4501953125, 116.28229522705 },
	{ 1059.724609375, -623.4501953125, 116.28229522705 },
	{ 258.0322265625, -301.9169921875, 1.578125 },
	{ 338.251953125, 62.31640625, 3.7442717552185 },
	{ 767.74609375, 349.482421875, 19.972427368164 },
	{ 1450.0380859375, 362.224609375, 18.941917419434 },
	{ 2291.2587890625, 148.7529296875, 26.484375 },
	{ 2402.830078125, 99.828125, 26.472471237183 },
	{ 2541.0185546875, 100.1298828125, 26.484375 },
}

local pizza = { [448] = true }

function resetPizzaJob()
	jobstatepizza = 0
	oldroute = -1
	
	if (isElement(markerpizza)) then
		destroyElement(markerpizza)
		markerpizza = nil
	end
	
	if (isElement(blippizza)) then
		destroyElement(blippizza)
		blippizza = nil
	end
	
	if (isElement(endmarkerpizza)) then
		destroyElement(endmarkerpizza)
		endmarkerpizza = nil
	end
	
	if (isElement(endblippizza)) then
		destroyElement(endblippizza)
		endblippizza = nil
	end
	
	if pizzaStopTimer then
		killTimer(pizzaStopTimer)
		pizzaStopTimer = nil
	end
end
addEventHandler("onClientChangeChar", getRootElement(), resetPizzaJob)

function displayPizzaJob(notext)
	if (jobstatepizza==0) then
		jobstatepizza = 1
		blippizza = createBlip(2115.58984375, -1807.2451171875, 22.21875, 29, 2, 255, 127, 255)
		
		if not notext then
			outputChatBox("#FF9933Approach the pizza #CCCCCCblip#FF9933 on your radar and hop on the pizza delivery bike to start your job.", 255, 194, 15, true)
		end
	end
end
addEvent("restorePizzaJob", true)
addEventHandler("restorePizzaJob", getRootElement(), function() displayPizzaJob(true) end )


function startPizzaJob(routeid)
	if (jobstatepizza==1) then
		local vehicle = getPedOccupiedVehicle(localPlayer)
		if vehicle and getVehicleController(vehicle) == localPlayer and pizza[getElementModel(vehicle)] then
			outputChatBox("#FF9933Head to the #FFFF00blip#FF9933 to complete your first delivery.", 255, 194, 15, true)
			outputChatBox("#FF9933Remember to #FFFF00follow the street rules#FF9933.", 255, 194, 15, true)
			outputChatBox("#FF9933If your bike is #FFFF00damaged#FF9933, the customers may pay less or refuse to accept the pizza.", 255, 194, 15, true)
			outputChatBox("#FF9933Your wage is bound to this pizza delivery bike, #FFFF00don't lose it#FF9933!", 255, 194, 15, true)
			destroyElement(blippizza)
			
			local rand = math.random(1, #routes)
			
			if not (routeid == -1) then
				rand = routeid
			else
				
			end
			route = routes[rand]
			local x, y, z = route[1], route[2], route[3]
			blippizza = createBlip(x, y, z, 0, 2, 255, 200, 0)
			markerpizza = createMarker(x, y, z, "checkpoint", 4, 255, 200, 0, 150)
			addEventHandler("onClientMarkerHit", markerpizza, waitAtHouse)
							
			jobstatepizza = 2
			oldroute = rand
			if (routeid == -1) then
				triggerServerEvent("updateNextPizzaCheckpoint", localPlayer, vehicle, rand)
			end
		else
			outputChatBox("You must be on the pizza delivery bike to start this job.", 255, 0, 0)
		end
	end
end
addEvent("startPizzaJob", true)
addEventHandler("startPizzaJob", getRootElement(), startPizzaJob)

function waitAtHouse(thePlayer)
	local vehicle = getPedOccupiedVehicle(localPlayer)
	if thePlayer == localPlayer and vehicle and getVehicleController(vehicle) == localPlayer and pizza[getElementModel(vehicle)] then
		if getElementHealth(vehicle) < 350 then
			outputChatBox("You need to get your pizza delivery bike repaired.", 255, 0, 0)
		else
			pizzaStopTimer = setTimer(nextPizzaDeliveryCheckpoint, 5000, 1)
			outputChatBox("#FF9933Wait a moment while your pizza box is processed.", 255, 0, 0, true )
			addEventHandler("onClientMarkerLeave", markerpizza, checkWaitAtHouse)
		end
	end
end

function checkWaitAtHouse(thePlayer)
	local vehicle = getPedOccupiedVehicle(localPlayer)
	if vehicle and thePlayer == localPlayer and getVehicleController(vehicle) == localPlayer and pizza[getElementModel(vehicle)] then
		if getElementHealth(vehicle) >= 350 then
			outputChatBox("You didn't wait at the dropoff point.", 255, 0, 0)
			if pizzaStopTimer then
				killTimer(pizzaStopTimer)
				pizzaStopTimer = nil
			end
			removeEventHandler("onClientMarkerLeave", source, checkWaitAtHouse)
		end
	end
end

function nextPizzaDeliveryCheckpoint()
	pizzaStopTimer = nil
	if jobstatepizza == 2 or jobstatepizza == 3 then
		local vehicle = getPedOccupiedVehicle(localPlayer)
		if vehicle and getVehicleController(vehicle) == localPlayer and pizza[getElementModel(vehicle)] then
			destroyElement(markerpizza)
			destroyElement(blippizza)
			
			vehicleid = tonumber( getElementData(vehicle, "dbid") )
			
			local health = getElementHealth(vehicle)
			if health >= 975 then
				paycash = 50 -- bonus: TL60
			elseif health >= 800 then
				paycash = 35
			elseif health >= 350 then
				-- 350 (black smoke) to 800, round to TL5
				paycash = math.ceil( 5 * ( health - 300 ) / 500 ) * 5
			else
				paycash = 0
			end
			spawnFinishMarkerPizzaJob()
			triggerServerEvent("savePizzaProgress", localPlayer, vehicle, paycash)
		else
			outputChatBox("#FF9933You must be on a pizza delivery bike to complete deliverys.", 255, 0, 0, true ) -- Wrong car type.
		end
	end
end

function spawnFinishMarkerPizzaJob()
	if jobstatepizza == 2 then
		-- no final checkpoint set yet
		endblippizza = createBlip(2097.4560546875, -1807.265625, 13.151475906372, 0, 2, 255, 0, 0)
		endmarkerpizza = createMarker(2097.4560546875, -1807.265625, 13.151475906372, "checkpoint", 4, 255, 0, 0, 150)
		setMarkerIcon(endmarkerpizza, "finish")
		addEventHandler("onClientMarkerHit", endmarkerpizza, endPizzaDelivery)
	end
	jobstatepizza = 3
end
addEvent("spawnFinishMarkerPizzaJob", true)
addEventHandler("spawnFinishMarkerPizzaJob", getRootElement(), spawnFinishMarkerPizzaJob)

function loadNewCheckpointPizzaJob()
	local vehicle = getPedOccupiedVehicle(localPlayer)
	-- next drop off
	local rand = -1
	repeat
		rand = math.random(1, #routes)
	until oldroute ~= rand and getDistanceBetweenPoints2D(routes[oldroute][1], routes[oldroute][2], routes[rand][1], routes[rand][2]) > 250
	route = routes[rand]
	oldroute = rand
	local x, y, z = route[1], route[2], route[3]
	blippizza = createBlip(x, y, z, 0, 2, 255, 200, 0)
	markerpizza = createMarker(x, y, z, "checkpoint", 4, 255, 200, 0, 150)
	addEventHandler("onClientMarkerHit", markerpizza, waitAtHouse)
	triggerServerEvent("updateNextPizzaCheckpoint", localPlayer, vehicle, rand)
end
addEvent("loadNewCheckpointPizzaJob", true)
addEventHandler("loadNewCheckpointPizzaJob", getRootElement(), loadNewCheckpointPizzaJob)

function endPizzaDelivery(thePlayer)
	if thePlayer == localPlayer then
		local vehicle = getPedOccupiedVehicle(localPlayer)
		local id = getElementModel(vehicle) or 0
		if not vehicle or getVehicleController(vehicle) ~= localPlayer or not (pizza[id]) then
			outputChatBox("#FF9933You must be on a pizza delivery bike to complete deliverys.", 255, 0, 0, true ) -- Wrong car type.
		else
			local health = getElementHealth(vehicle)
			if health <= 700 then
				outputChatBox("This pizza delivery bike is damaged, fix it first.", 255, 194, 15)
			else
				triggerServerEvent("givePizzaMoney", localPlayer, vehicle)
				resetPizzaJob()
				displayPizzaJob(true)
				setElementFrozen(vehicle, true)
				exports['anticheat-system']:changeProtectedElementDataEx(vehicle, "handbrake", 1, false)
			end
		end
	end
end