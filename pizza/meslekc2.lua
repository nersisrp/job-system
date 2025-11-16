 local screenH, screenW = guiGetScreenSize()
local x, y = (screenH/1600), (screenW/900)

font1 = dxCreateFont("font/font.ttf", 13)
font2 = dxCreateFont("font/font2.ttf", 12)


meslek1 = 1
meslek2 = 2
meslek3 = 3
meslek11 = 11
meslek4 = 4
meslek5 = 5
meslek6 = 6
meslek10 = 10
meslek14 = 14
meslek15 = 15

rgb = tocolor
cor = {}

Painel = false
function panel()

	cor[1] = tocolor(255, 255, 255, 255)
	cor[2] = tocolor(255, 255, 255, 255)
	cor[3] = tocolor(255, 255, 255, 255)
	cor[4] = tocolor(255, 255, 255, 255)
	cor[5] = tocolor(255, 255, 255, 255)
	cor[6] = tocolor(255, 255, 255, 255)
	cor[7] = tocolor(255, 255, 255, 255)
	cor[8] = tocolor(255, 255, 255, 255)
	cor[9] = tocolor(0,0,0,255)
	cor[10] = tocolor(255, 255, 255, 255) 
	
	if isMouseInPosition(x*636, y*240, x*328, y*42) then cor[1] = rgb(231, 76, 60) end--1
	if isMouseInPosition(x*636, y*292, x*328, y*42) then cor[2] = rgb(231, 76, 70) end--2
	if isMouseInPosition(x*636, y*344, x*328, y*42) then cor[3] = rgb(231, 76, 80) end--3
	if isMouseInPosition(x*636, y*396, x*328, y*42) then cor[4] = rgb(231, 76, 90) end--4
	if isMouseInPosition(x*636, y*448, x*328, y*42) then cor[5] = rgb(231, 76, 100) end--5
	if isMouseInPosition(x*636, y*500, x*328, y*42) then cor[6] = rgb(231, 76, 120) end--6
	if isMouseInPosition(x*636, y*552, x*328, y*42) then cor[7] = rgb(231, 76, 130) end--7
    if isMouseInPosition(x*636, y*604, x*328, y*42) then cor[8] = rgb(231, 76, 140) end--8
	if isMouseInPosition(x*636, y*656, x*328, y*42) then cor[9] = rgb(255,0,0) end--9
	if isMouseInPosition(x*636, y*656, x*328, y*42) then cor[10] = rgb(0,0,0) end--10
	--[[TASARIM IN ARKA PLAN TARAFI]]
	    dxDrawRectangle(x*585, y*199, x*430, y*627, tocolor(0, 0, 0, 41), false)
        dxDrawRectangle(x*585, y*199, x*430, y*31, tocolor(0, 0, 0, 255), false)
        dxDrawRectangle(x*585, y*197, x*430, y*2, tocolor(221, 0, 0, 255), false)
	--[[Meslek Butonları Hepsi Sırasıyla.]]	
        dxDrawRectangle(x*636, y*240, x*328, y*42, tocolor(0, 0, 0, 255), false)--1
        dxDrawRectangle(x*636, y*292, x*328, y*42, tocolor(0, 0, 0, 255), false)--2
        dxDrawRectangle(x*636, y*344, x*328, y*42, tocolor(0, 0, 0, 255), false)--3
        dxDrawRectangle(x*636, y*396, x*328, y*42, tocolor(0, 0, 0, 255), false)--4
        dxDrawRectangle(x*636, y*448, x*328, y*42, tocolor(0, 0, 0, 255), false)--5
        dxDrawRectangle(x*636, y*500, x*328, y*42, tocolor(0, 0, 0, 255), false)--6
        dxDrawRectangle(x*636, y*552, x*328, y*42, tocolor(0, 0, 0, 255), false)--7
        dxDrawRectangle(x*636, y*604, x*328, y*42, tocolor(0, 0, 0, 255), false)--8
        dxDrawRectangle(x*636, y*656, x*328, y*42, cor[9], false)--9
        dxDrawText("#ffffffBest RPG - #e74c3cMeslek Listesi - Local", x*641, y*199, x*959, y*227, rgb(255, 0, 255, 255), 1.00, font1, "center", "center", true, true, true, true, true)
        dxDrawText("Kargo Şoförlüğü", x*651, y*241, x*949, y*282, cor[1], 1.00, font2, "center", "center", false, false, false, false, false)
        dxDrawText("Taksi Şoförlüğü", x*651, y*292, x*949, y*333, cor[2], 1.00, font2, "center", "center", false, false, false, false, false)
        dxDrawText("Otobüs Şoförlüğü", x*651, y*344, x*949, y*385, cor[3], 1.00, font2, "center", "center", false, false, false, false, false)
        dxDrawText("Kamyon Şoförlüğü", x*651, y*396, x*949, y*437, cor[4], 1.00, font2, "center", "center", false, false, false, false, false)
        dxDrawText("Şehir Temizlikçilisi", x*651, y*447, x*949, y*488, cor[5], 1.00, font2, "center", "center", false, false, false, false, false)
        dxDrawText("Beton Taşımacılığı", x*651, y*500, x*949, y*541, cor[6], 1.00, font2, "center", "center", false, false, false, false, false)
        dxDrawText("Deniz Taşımacılığı", x*651, y*552, x*949, y*593, cor[7], 1.00, font2, "center", "center", false, false, false, false, false)
        dxDrawText("Tır Şoförlüğü", x*651, y*603, x*949, y*644, cor[8], 1.00, font2, "center", "center", false, false, false, false, false)
        dxDrawText("Paneli Kapat", x*651, y*654, x*949, y*695, cor[10], 1.00, font2, "center", "center", true, true, true, true, true)


end

local oldSkinsTable = {}	
	
function meslekleregiris(button, state)
	if Painel and button == "left" and state == "down" then
		if isMouseInPosition(x*636, y*240, x*328, y*42) then
		setPedSkin(thePlayer, 249 )
		setElementData ( localPlayer, "shader", false )
			playSoundFrontEnd(49)
			triggerServerEvent("acceptJob",getLocalPlayer(), meslek1)
			outputChatBox("[!]#999999 Kargo Mesleğine Başarıyla Giriş Yaptın..",0 ,255, 0, true)
            removeEventHandler ("onClientRender", root, panel)
			Painel = false 
			showCursor (false)
			guiSetVisible (panel, false)
		elseif isMouseInPosition(x*636, y*292, x*328, y*42) then
		setElementData ( localPlayer, "shader", false )
			playSoundFrontEnd(49)
			triggerServerEvent("acceptJob",getLocalPlayer(), meslek2)
			outputChatBox("[!]#999999 Taksi Mesleğine Başarıyla Giriş Yaptın..",0 ,255, 0, true)
            removeEventHandler ("onClientRender", root, panel)
			Painel = false 
			showCursor (false)
			guiSetVisible (panel, false)
		elseif isMouseInPosition(x*636, y*344, x*328, y*42) then
		setElementData ( localPlayer, "shader", false )
			playSoundFrontEnd(49)
			triggerServerEvent("acceptJob",getLocalPlayer(), meslek3)
			outputChatBox("[!]#999999 Otobüs Mesleğine Başarıyla Giriş Yaptın..",0 ,255, 0, true)
            removeEventHandler ("onClientRender", root, panel)
			Painel = false 
			showCursor (false)
			guiSetVisible (panel, false)
		elseif isMouseInPosition(x*636, y*396, x*328, y*42) then
		setElementData ( localPlayer, "shader", false )
			playSoundFrontEnd(49)
			triggerServerEvent("acceptJob",getLocalPlayer(), meslek11)
			outputChatBox("[!]#999999 Kamyon Mesleğine Başarıyla Giriş Yaptın..",0 ,255, 0, true)
            removeEventHandler ("onClientRender", root, panel)
			Painel = false 
			showCursor (false)
			guiSetVisible (panel, false)
		elseif isMouseInPosition(x*636, y*448, x*328, y*42) then
		setElementData ( localPlayer, "shader", false )
			playSoundFrontEnd(49)
			triggerServerEvent("acceptJob",getLocalPlayer(), meslek4)
			outputChatBox("[!]#999999 Şehir Temizlikci Mesleğine Başarıyla Giriş Yaptın..",0 ,255, 0, true)
            removeEventHandler ("onClientRender", root, panel)
			Painel = false 
			showCursor (false)
			guiSetVisible (panel, false)
		elseif isMouseInPosition(x*636, y*500, x*328, y*42) then
		setElementData ( localPlayer, "shader", false )
			playSoundFrontEnd(49)
			triggerServerEvent("acceptJob",getLocalPlayer(), meslek14)
			outputChatBox("[!]#999999 Beton Mesleğine Başarıyla Giriş Yaptın..",0 ,255, 0, true)
            removeEventHandler ("onClientRender", root, panel)
			Painel = false 
			showCursor (false)
			guiSetVisible (panel, false)
       elseif isMouseInPosition(x*636, y*604, x*328, y*42) then
	   setElementData ( localPlayer, "shader", false )
			playSoundFrontEnd(49)
			triggerServerEvent("acceptJob",getLocalPlayer(), meslek10)
			outputChatBox("[!]#999999 Tır Mesleğine Başarıyla Giriş Yaptın..",0 ,255, 0, true)
            removeEventHandler ("onClientRender", root, panel)
			Painel = false 
			showCursor (false)
			guiSetVisible (panel, false)
	   elseif isMouseInPosition(x*636, y*552, x*328, y*42) then
	   setElementData ( localPlayer, "shader", false )
			playSoundFrontEnd(49)
			triggerServerEvent("acceptJob",getLocalPlayer(), meslek15)
			outputChatBox("[!]#999999 Deniz Taşımacılığı Mesleğine Başarıyla Giriş Yaptın..",0 ,255, 0, true)
            removeEventHandler ("onClientRender", root, panel)
			Painel = false 
			showCursor (false)
			guiSetVisible (panel, false)				
		elseif isMouseInPosition(x*636, y*656, x*328, y*42) then
		setElementData ( localPlayer, "shader", false )
			playSoundFrontEnd(49)
			removeEventHandler ("onClientRender", root, panel)
			Painel = false 
			showCursor (false)
			guiSetVisible (panel, false)
        end
    end
end
addEventHandler("onClientClick", getRootElement(), meslekleregiris)
	
function abrir()
    if Painel == false then
	setElementData ( localPlayer, "shader", true )
        addEventHandler ("onClientRender", root, panel)
        showCursor(true)
		Painel = true
        guiSetVisible (txt, true)
    else
	setElementData ( localPlayer, "shader", false )
        removeEventHandler ("onClientRender", root, panel)
        Painel = false 
        showCursor (false)
        guiSetVisible (txt, false)
    end
end
addCommandHandler("meslek", abrir)


function isMouseInPosition ( x, y, width, height )
    if ( not isCursorShowing () ) then
	    return false
	end

   local sx, sy = guiGetScreenSize ( )	
   local cx, cy = getCursorPosition ( )	
   local cx, cy = ( cx * sx ), ( cy * sy )
   if ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) then
        return true
	else	
        return false
	end
end	