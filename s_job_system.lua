mysql = exports.mysql
local lockTimer = nil
chDimension = 125
chInterior = 3

function onEmploymentServer()
	exports.global:textNrpLocalSend(source, "Jessie Smith says: Hello, are you looking for a new job?", nil, nil, nil, 10)
	exports.global:textNrpLocalSend(source, " *Jessie Smith hands over a list with jobs to " .. getPlayerName(source):gsub("_", " ") .. ".", 255, 51, 102)
end

addEvent("onEmploymentServer", true)
addEventHandler("onEmploymentServer", getRootElement(), onEmploymentServer)

function givePlayerJob(jobID)
	local charname = getPlayerName(source)
	local charID = getElementData(source, "dbid")
	if getElementData(source, "level") < 3 and jobID == 2 then
		outputChatBox("[!] #FFFFFFTaksici olabilmek için en az 3. seviye olmanız gerekmektedir!", source, 255, 0, 0, true)
		return
	end
	mysql:query_free("UPDATE `characters` SET `job`='"..tostring(jobID).."' WHERE `id`='"..mysql:escape_string(charID).."' ")
	
	if (jobID==4) then -- CITY MAINTENANCE
		exports.global:giveItem(source, 115, "41:1:Spraycan", 2500)
		outputChatBox("Use this spray to paint over the graffiti you find.", source, 255, 194, 14)
		exports.nrpSavunma4:changeProtectedElementDataEx(source, "tag", 9, false)
		mysql:query_free("UPDATE characters SET tag=9 WHERE id = " .. mysql:escape_string(getElementData(source, "dbid")) )
	end
	fetchJobInfoForOnePlayer(source)
end
addEvent("acceptJob", true)
addEventHandler("acceptJob", getRootElement(), givePlayerJob)

function fetchJobInfo()
	if not charID then
		for key, player in pairs(getElementsByType("player")) do
			fetchJobInfoForOnePlayer(player)
		end
	end
end
addEvent("job-system:fetchJobInfo", true)
addEventHandler("job-system:fetchJobInfo", getRootElement(), fetchJobInfo)

function fetchJobInfoForOnePlayer(thePlayer)
	local charID = getElementData(thePlayer, "dbid")
	local jobInfo = mysql:query_fetch_assoc("SELECT `job` , `jobID`, `jobLevel`, `jobProgress`, `jobTruckingRuns` FROM `characters` LEFT JOIN `jobs` ON `id` = `jobCharID` AND `job` = `jobID` WHERE `id`='" .. tostring(charID) .. "' ")
	if jobInfo then
		local job = tonumber(jobInfo["job"])
		local jobID = tonumber(jobInfo["jobID"])
		if job and job == 0 then
			setElementData(thePlayer, "job", 0, true)
			setElementData(thePlayer, "jobLevel", 0 , true)
			setElementData(thePlayer, "jobProgress", 0, true)
			setElementData(thePlayer, "job-system-trucker:truckruns", 0, true)
			return true
		end
		
		if not jobID then
			mysql:query_free("INSERT INTO `jobs` SET `jobID`='"..tostring(job).."', `jobCharID`='"..mysql:escape_string(charID).."' ")
		end
	
		setElementData(thePlayer, "job", job, true)
		setElementData(thePlayer, "jobLevel", tonumber(jobInfo["jobLevel"]) or 1, true)
		setElementData(thePlayer, "jobProgress", tonumber(jobInfo["jobProgress"]) or 0, true)
		setElementData(thePlayer, "job-system-trucker:truckruns", tonumber(jobInfo["jobTruckingRuns"]) or 0, true)
	else
		outputDebugString("[Job system] fetchJobInfoForOnePlayer / DB error")
		return false
	end
end
addEvent("job-system:fetchJobInfoForOnePlayer", true)
addEventHandler("job-system:fetchJobInfoForOnePlayer", getRootElement(), fetchJobInfo)

function printJobInfo(thePlayer)
	outputChatBox("~-~-~-~-~-~-~-~-~-~Kariyer Bilgisi~-~-~-~-~-~-~-~-~-~-~-~", thePlayer, 255, 194, 14)
	outputChatBox("İş: "..(getJobTitleFromID(getElementData(thePlayer, "job")) or "Unemployed") , thePlayer, 255, 194, 14)
	outputChatBox("Rütbe/Level: "..(tonumber(getElementData(thePlayer, "jobLevel")) or "0") , thePlayer, 255, 194, 14)
	outputChatBox("İlerleme: "..(tonumber(getElementData(thePlayer, "jobProgress")) or "0") , thePlayer, 255, 194, 14)
	outputChatBox("~-~-~-~--~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-", thePlayer, 255, 194, 14)
end
addCommandHandler("myjob", printJobInfo)
addCommandHandler("işim", printJobInfo)
addCommandHandler("iş", printJobInfo)

function quitJob(source)
	local logged = getElementData(source, "loggedin")
	if logged == 1 then
		local job = getElementData(source, "job")
		if job == 0 then
			outputChatBox("You are currently unemployed.", source, 255, 0, 0)
		else
			local charID = getElementData(source, "dbid")
			mysql:query_free("UPDATE `characters` SET `job`='0' WHERE `id`='"..mysql:escape_string(charID).."' ")
			fetchJobInfoForOnePlayer(source)
			if job == 4 then
				exports.nrpSavunma4:changeProtectedElementDataEx(source, "tag", 1, false)
				mysql:query_free("UPDATE characters SET tag=1 WHERE id = " .. mysql:escape_string(charID) )
			end
			triggerClientEvent(source, "quitJob", source, job)
		end
	end
end
addCommandHandler("endjob", quitJob, false, false)
addCommandHandler("quitjob", quitJob, false, false)
addCommandHandler("istifa", quitJob, false, false)


function startEnterVehJob(thePlayer, seat, jacked) 
	local vjob = tonumber(getElementData(source, "job")) or 0
	local job = getElementData(thePlayer, "job")
	local seat = getPedOccupiedVehicleSeat(thePlayer)
	if vjob>0 and job~=vjob and seat == 0 and not (getElementData(thePlayer, "duty_admin") == 1) and not (getElementData(thePlayer, "duty_supporter") == 1) then
		if (vjob==2) then
			outputChatBox("[!] #FFFFFFBu aracı kullanabilmek için, Taksi Şoförü mesleğinde olmanız gerekir!", thePlayer, 255, 0, 0, true)
            cancelEvent()
            return
		elseif (vjob==3) then
			outputChatBox("[!] #FFFFFFBu aracı kullanabilmek için, Otobüs Şoförü mesleğinde olmanız gerekir!", thePlayer, 255, 0, 0, true)
            cancelEvent()
            return
		elseif (vjob==4) then
			outputChatBox("[!] #FFFFFFBu aracı kullanabilmek için, Sigara Kaçakçılığı mesleğinde olmanız gerekmektedir.", thePlayer, 255, 0, 0, true)
            cancelEvent()
            return
        elseif (vjob==11) then
            outputChatBox("[!] #FFFFFFBu aracı kullanabilmek için, Kamyon Şoförü mesleğinde olmanız gerekir!", thePlayer, 255, 0, 0, true)
            cancelEvent()
            return
		end
		
	end
end
addEventHandler("onVehicleStartEnter", getRootElement(), startEnterVehJob)
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
