--[[
    @بسم الله الرحمن الرحيم
    @Script: Tüpçülük Sistemi
    @Version: v1.0
    @Scripter: Leoncio
    @Server: Nersis Roleplay    
--]]

--[[ 
BİLGİ: 
	MESLEK ID = 16 / ARAÇ MESLEK ID = 16
]]

----------------------------------------------------------------------------
-- DEĞİŞKENLER
----------------------------------------------------------------------------
local jobID = 16

-- GLOBAL
local tupMarker = 0
local tupBlip = 0
local tupCreatedMarkers = {}
local tupCreatedBlips = {}
local baslangicX, baslangicY, baslangicZ = 2337.228515625, -2071.154296875, 13.553783416748

----------------------------------------------------------------------------
--- ROTA
----------------------------------------------------------------------------
local tupRota = {
	-- X, Y, Z, markerType [0 = Başlangıç, 1 = Normal, 2 = Teslim]

	{ 2157.005859375, -1709.220703125, 15.0859375, 1 },
	{ 2139.1865234375, -1697.5078125, 15.0859375, 1 },
	{ 2250.609375, -1649.529296875, 15.477319717407, 1 },
	{ 2383.4345703125, -1651.603515625, 13.546875, 1 },
	{ 2392.8603515625, -1666.0087890625, 13.451147079468, 1 },
	{ 2461.224609375, -1665.78125, 13.4732837677, 1 },
	{ 2476.1767578125, -1683.6943359375, 13.40719127655, 1 },
	{ 2497.4111328125, -1684.6083984375, 13.397441864014, 1 },
	{ 2517.51953125, -1662.080078125, 14.15544128418, 1 },
	{ 2152.9287109375, -1808.17578125, 13.547382354736, 1 },
	{ 2176.2431640625, -1813.88671875, 13.546875, 1 },
	{ 2421.236328125, -1800.37890625, 13.546875, 1 },
	{ 2733.2177734375, -1926.47265625, 13.546875, 1 },
	{ 2696.40625, -1992.443359375, 13.5546875, 1 },
	{ 2675.1669921875, -1994.927734375, 13.5546875, 1 },
	{ 2653.5859375, -1996.6533203125, 13.5546875, 1 },
	{ 2641.6826171875, -1994.8310546875, 13.5546875, 1 },
	{ 2638.51171875, -2010.818359375, 13.5546875, 1 },
	{ 2648.33203125, -2021.8837890625, 13.546875, 1 },
	{ 2674.482421875, -2010.6396484375, 13.5546875, 1 },
	{ 2692.4921875, -2011.234375, 13.5546875, 1 },
	{ 2754.5126953125, -2056.185546875, 12.709347724915, 1 },
	{ 2787.509765625, -2056.375, 11.806643486023, 1 },
	{ 2732.8896484375, -1952.021484375, 13.539363861084, 1 },
	{ 2733.0107421875, -1926.5478515625, 13.546875, 1 },
	{ 2782.587890625, -1926.0361328125, 13.546875, 1 },
	{ 2781.306640625, -1952.3212890625, 13.546875, 1 },
	{ 2779.2890625, -1615.3154296875, 10.921875, 1 },
	{ 2820.9423828125, -1615.2666015625, 11.088410377502, 1 },
	{ 2496.5400390625, -1369.16796875, 28.839694976807, 1 },
	{ 2488.3544921875, -1143.390625, 38.071380615234, 1 },
	{ 2422.8525390625, -1143.875, 31.71865272522, 1 },
	{ 2400.7314453125, -1146.8544921875, 29.7076587677, 1 },
	{ 2352.419921875, -1162.263671875, 27.422475814819, 1 },
	{ 2279.98046875, -1074.234375, 47.454109191895, 1 },
	{ 2352.3037109375, -1043.6484375, 54.06526184082, 1 },
	{ 2081.57421875, -1087.87109375, 25.04674911499, 1 },
	{ 2060.228515625, -1078.7626953125, 24.894197463989, 1 },
	{ 2077.6494140625, -1120.75, 24.162576675415, 1 },
	{ 2012.8115234375, -1128.103515625, 25.154817581177, 1 },
	{ 2071.9951171875, -973.72265625, 48.792938232422, 1 },
	{ 2068.0517578125, -985.3359375, 48.448516845703, 1 },
	{ 2048.9345703125, -984.185546875, 44.542495727539, 1 },
	{ 1340.1748046875, -1093.0068359375, 24.112630844116, 1 },
	{ 1256.6728515625, -1075.1025390625, 28.023077011108, 1 },
	{ 1232.810546875, -1028.6220703125, 32.030502319336, 1 },
	{ 1193.55859375, -1029.5166015625, 31.969236373901, 1 },
	{ 960.8818359375, -945.806640625, 40.294040679932, 1 },
	{ 834.578125, -868.193359375, 68.93286895752, 1 },
	{ 862.8955078125, -858.869140625, 77.363105773926, 1 },
	{ 721.72265625, -993.1787109375, 52.49161529541, 1 },
	{ 689.2236328125, -1053.8916015625, 50.068405151367, 1 },
	{ 570.3701171875, -1133.2001953125, 50.450225830078, 1 },
	{ 323.9453125, -1191.2275390625, 76.186859130859, 1 },
	{ 264.3408203125, -1234.1103515625, 73.59285736084, 1 },
	{ 145.1201171875, -1466.328125, 25.375, 1 },
	{ 304.595703125, -1746.076171875, 4.5405507087708, 1 },
	{ 648.3134765625, -1655.4990234375, 14.907594680786, 1 },
	{ 645.94921875, -1620.1689453125, 15.120822906494, 1 },
	{ 687.6923828125, -1592.16796875, 14.109518051147, 1 },


	{ 2107.09765625, -1827.37890625, 13.155982017517, 2 },
}

function tupBasla(cmd)
	local theVehicle = getPedOccupiedVehicle(getLocalPlayer())
	if not theVehicle or getElementData(theVehicle, "job") ~= jobID then
		exports["bildirim"]:addNotification("Göreve başlamak için bir tüp kamyonunda olmanız gerekmektedir!", "error")
		return
	end

	if not getElementData(getLocalPlayer(), "meslek:tup") then
		setElementData(getLocalPlayer(), "meslek:tup", true)
		
		tupRotaGuncelle()
		
		addEventHandler("onClientMarkerHit", resourceRoot, tupMarkerHit)
		exports["bildirim"]:addNotification("Mesleğe başladınız!", "info")
	else
		exports["bildirim"]:addNotification("Mesleğe zaten başladınız!", "error")
	end
end
addCommandHandler("tupbasla", tupBasla)

function tupRotaGuncelle()
	tupMarker = tupMarker + 1
	tupBlip = tupBlip + 1
	if tupMarker == 1 then
		local baslangicMarker = createMarker(baslangicX, baslangicY, baslangicZ, "checkpoint", 4, 100, 100, 255, 255, getLocalPlayer())
		local rotaBlip = createBlip(baslangicX, baslangicY, baslangicZ, 0, 2, 100, 100, 255)
		table.insert(tupCreatedMarkers, { baslangicMarker, 0 })
		table.insert(tupCreatedBlips, { rotaBlip, false })
	else
		local rotaNumber = math.random(#tupRota)
		for index, value in ipairs(tupRota) do
			if tupMarker < 10 then
				if index == rotaNumber then
					if value[4] == 1 then 
						local rotaMarker = createMarker(value[1], value[2], value[3], "checkpoint", 4, 255, 0, 0, 255, getLocalPlayer())
						local rotaBlip = createBlip(value[1], value[2], value[3], 0, 2, 255, 0, 0)
						table.insert(tupCreatedMarkers, { rotaMarker, 1 })			
						table.insert(tupCreatedBlips, { rotaBlip, false })
					end
				end
			elseif tupMarker == 10 then
				if value[4] == 2 then
					local bitisMarker = createMarker(baslangicX, baslangicY, baslangicZ, "checkpoint", 4, 255, 255, 0, 255, getLocalPlayer())
					local rotaBlip = createBlip(baslangicX, baslangicY, baslangicZ, 0, 2, 255, 255, 0)
					table.insert(tupCreatedMarkers, { bitisMarker, 2 })	
					table.insert(tupCreatedBlips, { rotaBlip, false })
				end
			end
		end
	end
end

function tupMarkerHit(hitPlayer, matchingDimension)
	if hitPlayer == getLocalPlayer() then
		local hitVehicle = getPedOccupiedVehicle(hitPlayer)
		if not hitVehicle or getElementData(hitVehicle, "job") ~= jobID then
			exports["bildirim"]:addNotification("Bu alandan tüp kamyonuyla geçmeniz gerekmektedir.", "error")
			return
		end
		
		for _, marker in ipairs(tupCreatedMarkers) do
			if source == marker[1] and matchingDimension then
				if marker[2] == 0 then
					local hitVehicle = getPedOccupiedVehicle(hitPlayer)
					setElementFrozen(hitPlayer, true)
					setElementFrozen(hitVehicle, true)
					toggleAllControls(false, true, false)
					exports["bildirim"]:addNotification("Araca tüp yükleniyor lütfen bekleyiniz. (1-2sn)", "info")
					setTimer(
						function(thePlayer, hitVehicle, hitMarker)
							destroyElement(hitMarker)
							destroyElement(tupCreatedBlips[tupBlip][1])
							exports["bildirim"]:addNotification("Tüpler yüklenmiştir, devam edebilirsiniz!", "success")
							setElementFrozen(hitVehicle, false)
							setElementFrozen(thePlayer, false)
							toggleAllControls(true)
							tupRotaGuncelle()
						end, 1500, 1, hitPlayer, hitVehicle, source
					)
				elseif marker[2] == 1 then
					if getElementData(hitPlayer, "tup:markerde") then
						exports.global:sendMessageToStaff("AntiBug: " .. getPlayerName(client) .. " isimli bir arkadaş Tüpçülük mesleğinde para bugu denedi. İfadesini alın.")
						outputChatBox("Onu yapmayacaktın işte...", hitPlayer, 255, 0, 0)
						return false
					end
					setElementData(hitPlayer, "tup:markerde", true)
					local hitVehicle = getPedOccupiedVehicle(hitPlayer)
					setElementFrozen(hitPlayer, true)
					setElementFrozen(hitVehicle, true)
					toggleAllControls(false, true, false)
					exports["bildirim"]:addNotification("Tüpü indiriyorsunuz, lütfen bekleyin. (3-4sn)", "info")
					setTimer(
						function(thePlayer, hitVehicle, hitMarker)
							destroyElement(hitMarker)
							destroyElement(tupCreatedBlips[tupBlip][1])
							exports["bildirim"]:addNotification("Tüp indirilmiştir. Devam edebilirsiniz!", "success")
							setElementFrozen(hitVehicle, false)
							setElementFrozen(thePlayer, false)
							toggleAllControls(true)
							setElementData(thePlayer, "tup:markerde", false)
			
							triggerServerEvent("tup:tupParaVer", thePlayer, thePlayer)
							tupRotaGuncelle()
						end, 3500, 1, hitPlayer, hitVehicle, source
					)	
				elseif marker[2] == 2 then
					exports["bildirim"]:addNotification("Aracı teslim ettiniz ve bu turu başarıyla bitirdiniz!", "info")
					tupBitir()
				end
			end
		end
	end
end

function tupBitir()
	local playerVehicle = getPedOccupiedVehicle(getLocalPlayer())
	if playerVehicle then
		local vehicleJob = getElementData(playerVehicle, "job")
		local meslekDurumu = getElementData(getLocalPlayer(), "meslek:tup")
		if vehicleJob == jobID then
			exports.global:fadeToBlack()
			---------------------------- MESLEK BAŞLAMIŞSA ----------------------------
			if meslekDurumu then
				setElementData(getLocalPlayer(), "meslek:tup", false)
				--- MARKER VE BLİPLERİ TEMİZLE ---
				for _, marker in ipairs(tupCreatedMarkers) do
					if isElement(marker[1]) then
						destroyElement(marker[1])
					end
				end
				for _, blip in ipairs(tupCreatedBlips) do
					if isElement(blip[1]) then
						destroyElement(blip[1])
					end
				end
				tupCreatedMarkers = {}
				tupCreatedBlips = {}
				tupMarker = 0
				tupBlip = 0
				----------------------------------
			end
			---------------------------------------------------------------------------
			triggerServerEvent("tup:tupBitir", getLocalPlayer(), getLocalPlayer())
			removeEventHandler("onClientMarkerHit", resourceRoot, tupMarkerHit)
			setTimer(function() exports.global:fadeFromBlack() end, 1000, 1)
		end
	end
end
addCommandHandler("tupbitir", tupBitir)

-----------------------------------------------------------------------------------------------------------------------------------------------------------