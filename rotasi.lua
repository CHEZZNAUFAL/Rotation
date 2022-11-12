botName = ""
startTime = 0
upTime = os.time()

function checkReady(id)
count = 0
for _, tile in pairs(getTiles()) do
if tile.fg == id and tile.ready == true then
count = count + 1
end
end
return count
end

function checkUn(id)
count = 0
for _, tile in pairs(getTiles()) do
if tile.fg == id and tile.ready == false then
count = count + 1
end
end
return count
end

function checkFossil()
count = 0
for _, tile in pairs(getTiles()) do
if tile.fg == 3918 then
count = count + 1
end
end
return count
end

function Webhook(loget,judul,konten,index,website,gasseh)
    local timer = os.time() - upTime
    local sec = (os.clock() - startTime)
    local days = math.floor(sec / 86400)
    local hours = math.floor((sec % 86400) / 3600)
    local minutes = math.floor((sec % 3600) / 60)
    local script = [[
        $webHookUrl = "]]..website..[["
        $CPU = Get-WmiObject Win32_Processor | Measure-Object -Property LoadPercentage -Average | Select -ExpandProperty Average
        $CompObject = Get-WmiObject -Class WIN32_OperatingSystem
        $RAM = (Get-Counter '\Memory\Available MBytes').CounterSamples.CookedValue
        $thumbnailObject = @{
            url = "https://media.discordapp.net/attachments/956485623412318218/1023591358373580810/20220925_204611.jpg?width=406&height=406"
        }
        $footerObject = @{
            text = "SC BY CHEZZ & NAUFAL ( ]]..(os.date("!%a %b %d, %Y at %I:%M %p", os.time() + 7 * 60 * 60))..[[ )"
        }
        $fieldArray = @(
            @{
                name = "[<a:megaphone:1010231960616063116>] Bot Information"
                value = " ]] .. loget .. [["
                inline = "false"
            }
            @{
                name = "<a:big_old_sideways_arrow:1010066401601531914> GrowID"
                value = "**[<a:mini_growtopian:1010066585882480651>] ]] .. botName .. [[**"
                inline = "true"
            }
            @{
                name = "<a:big_old_sideways_arrow:1010066401601531914> World"
                value = "**[<a:globe:1009832421102989322>] ]] .. getBot().world .. [[ (]] .. gasseh .. [[)**"
                inline = "true"
            }
            @{
                name = "<a:big_old_sideways_arrow:1010066401601531914> Status"
                value = "**[<:STATUSNOP:1003738295752196127>] ]] .. getBot().status .. [[**"
                inline = "true"
            }
            @{
                name = "<a:big_old_sideways_arrow:1010066401601531914> Level"
                value = "**[<:arrow_ups:1037183026288918588>] ]]..getBot().level..[[**"
                inline = "true"
            }

            @{
                name = "<a:big_old_sideways_arrow:1010066401601531914> Gems"
                value = "**[<a:growmoji_gems:1009826273612279859>] ]] .. findItem(112) .. [[ (]] .. findItem(112) .. [[/]] .. itemPurchasePrice .. [[)**"
                inline = "true"
            }
            @{
                name = "<a:big_old_sideways_arrow:1010066401601531914> Ready Tree"
                value = "**[:seedling:] ]] .. checkReady(seed) .. [[ (]] .. checkUn(seed) .. [[)**"
                inline = "true"
            }
            @{
                name = "<a:big_old_sideways_arrow:1010066401601531914> Fossil"
                value = "**[<:Fossil:997497957848989737>] ]] .. checkFossil() .. [[**"
                inline = "true"
            }
            @{
                name = "<a:big_old_sideways_arrow:1010066401601531914> CPU"
                value = "**[<a:nuclear_detonator:1010228194978320475>] $CPU% **"
                inline = "true"
            }
            @{
                name = "<a:big_old_sideways_arrow:1010066401601531914> RAM"
                value = "**[<a:lock_bot_remote:1010228167098773527>] $RAM MB **"
                inline = "true"
            }
            @{
                name = "<a:big_old_sideways_arrow:1010066401601531914> Script Running"
                value = "**[:timer:] ]]..math.floor(timer/86400)..[[ Day ]]..math.floor(timer%86400/3600)..[[ Hour ]]..math.floor(timer%86400%3600/60)..[[ Minute**"
                inline = "false"
            }
        )
        $embedObject = @{
            title = "]]..judul..[["
            color = "]]..math.random(1111111,9999999)..[["
            thumbnail = $thumbnailObject
            footer = $footerObject
            fields = $fieldArray
        }
        $embedArray = @($embedObject)
        $payload = @{
            embeds = $embedArray
            "content" = "]].. konten ..[["
            "username" = "Rotation Logs [Grow-X V1]"
            "avatar_url" = "https://images-ext-2.discordapp.net/external/1CgWkgSz9FX-zX4Uwb7f2LAGjsBnKXz22vbY26xbllo/%3Fsize%3D4096%26ignore%3Dtrue%29./https/cdn.discordapp.com/avatars/699482759806320691/55f6cf61a3abbb9771028ee0ad31f890.png"
        }
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Invoke-RestMethod -Uri $webHookUrl -Body ($payload | ConvertTo-Json -Depth 4) -Method Post -ContentType 'application/json'
    ]]
    local pipe = io.popen("powershell -command -", "w")
    pipe:write(script)
    pipe:close()
end

function timerFormat(millisecond)
	local hour = math.floor((millisecond % 86400) / 3600)
	local minute = math.floor((millisecond % 3600) / 60)
	local second = math.floor(millisecond % 60)
	if (hour < 10) then
		hour = "0" .. hour
	end
	if (minute < 10) then
		minute = "0" .. minute
	end
	if (second < 10) then
		second = "0" .. second
	end
	return  hour .. ":" .. minute .. ":" .. second
end

function bot()
	return {
		x = math.floor((getBot().x / 32) + 0.5),
		y = math.floor((getBot().y / 32) + 0.5)
	}
end

function dropItem(id, count)
	sendPacket(2, "action|drop\n|itemID|" .. id)
	sleep(dropDelay)
	sendPacket(2, "action|dialog_return\ndialog_name|drop_item\nitemID|" .. id .. "|\ncount|" .. count)
end

function findBot()
	local count = 0
	for key, value in pairs(getBots()) do
		count = count + 1
	end
	return count
end

function findInventory()
	local count = 0
	for key, value in pairs(getInventory()) do
		count = count + 1
	end
	return count
end

function findItemList(list, relational, count)
	for key, value in pairs(list) do
		if (relational == "==") then
			if (findItem(value) == count) then
				return true
			end
		elseif (relational == "~=") then
			if (findItem(value) ~= count) then
				return true
			end
		elseif (relational == ">") then
			if (findItem(value) > count) then
				return true
			end
		elseif (relational == "<") then
			if (findItem(value) < count) then
				return true
			end
		elseif (relational == ">=") then
			if (findItem(value) >= count) then
				return true
			end
		elseif (relational == "<=") then
			if (findItem(value) <= count) then
				return true
			end
		end
	end
	return false
end

function findObject(id)
	local count = 0
	for key, value in pairs(getObjects()) do
		if (value.id == id) then
			count = count + value.count
		end
	end
	return count
end

function findPlayer()
	local count = 0
	for key, value in pairs(getPlayers()) do
		count = count + 1
	end
	return count
end

function findTile(id)
	local count = 0
	for key, value in pairs(getTiles()) do
		if (value.fg == id or value.bg == id) then
			count = count + 1
		end
	end
	return count
end

function findTree(ready, id)
	local count = 0
	for key, value in pairs(getTiles()) do
		if (value.fg == id and value.ready == ready) then
			count = count + 1
		end
	end
	return count
end

function getContentRequest(url)
    local content = ""
    local powershell = io.popen("powershell -command \"&{[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-RestMethod " .. url .. "}\"", "r")
    content = powershell:read("*a")
    powershell:close()
    return content
end

getItem = dofile("C:\\Users\\" .. os.getenv("USERNAME") .. "\\Desktop\\items.lua")

function getPlayer(name)
	for key, value in pairs(getPlayers()) do
		if (value.name:lower() == name:lower()) then
			return value
		end
	end
end

function init(name)
	for key, value in pairs(botList) do
		if (key:lower() == name:lower()) then
			return value
		end
	end
end

function isCallable(variable)
	local status, exception = pcall(function ()
		type(variable())
	end)
	return status
end

function joinRequest(world, doorID)
	if (doorID == "") then
		while (getBot().world:upper() ~= world:upper()) do
			sendPacket(3,"action|join_request\nname|"..world:upper().."\ninvitedWorld|0")
			sleep(warpDelay)
		end
		sleep(warpDelay)
	else
		while (getBot().world:upper() ~= world:upper()) do
			sendPacket(3,"action|join_request\nname|" ..world:upper().."|"..doorID:upper().."\ninvitedWorld|0")				
			sleep(warpDelay)
		end
		sleep(warpDelay)
		while (getTile(bot().x, bot().y).fg == 6) do
			sendPacket(3,"action|join_request\nname|" ..world:upper().."|"..doorID:upper().."\ninvitedWorld|0")
			sleep(warpDelay)
		end
		sleep(warpDelay)
	end
end

function ordinalNumber(number)
	local suffix = {
		[1] = "st",
		[2] = "nd",
		[3] = "rd",
		[11] = "th",
		[12] = "th",
		[13] = "th"
	}
	if (suffix[tonumber(string.sub(tostring(number), rawlen(tostring(number)) - 1))]) then
		return tostring(number) .. suffix[tonumber(string.sub(tostring(number), rawlen(tostring(number)) - 1))]
	elseif (suffix[tonumber(string.sub(tostring(number), rawlen(tostring(number))))]) then
		return tostring(number) .. suffix[tonumber(string.sub(tostring(number), rawlen(tostring(number))))]
	else
		return tostring(number) .. "th"
	end
end

function reconnect(world, doorID, x, y)
	if (getBot().status:lower() ~= "online") then
		Webhook("**" .. botName .. "** has been disconnected from the server","ALERT!","@everyone", index,init(botName).discordWebhookUrl,"-")
		while (getBot().status:lower() ~= "online") do
			sleep(reconnectDelay)
		end
		Webhook("**" .. botName .. "** has been connected to the server","ALERT!","@everyone", index,init(botName).discordWebhookUrl,"-")
		while (getBot().world:upper() ~= world:upper()) do
			joinRequest(world, doorID)
		end
		while (getTile(bot().x, bot().y).fg == 6) do
			joinRequest(world, doorID)
		end
		if (x and y) then
			findPath(x, y)
			sleep(findPathDelay)
		end
	end
end

function comeback(world, doorID, x, y)
if math.floor(getBot().x / 32) ~= x or math.floor(getBot().y / 32) ~= y then
        sendPacket(3, "action|quit_to_exit")
        sleep(100)
        joinRequest(world, doorID)
        sleep(2000)
        findPath(x,y)
        sleep(findPathDelay)
    end
end

function main()
	for index = 1, rawlen(init(botName).farmWorldName) do
		local farmWorldName = init(botName).farmWorldName
		local farmDoorID = init(botName).farmDoorID
		if (getBot().world:upper() ~= farmWorldName[index]:upper()) then
			joinRequest(farmWorldName[index], farmDoorID)
		end
		if (findTree(true, seed) > 0) then
			if (getTile(bot().x, bot().y).fg == 6) then
				joinRequest(farmWorldName[index], farmDoorID)
			end
			startTime = os.time()
			Webhook("**" .. botName .. "** has been started farming in the world named **" .. farmWorldName[index]:upper() .. "**","" .. botName .. "","", index,init(botName).discordWebhookUrl,"" .. ordinalNumber(index) .. " / " .. rawlen(farmWorldName) .. "")
			while (findTree(true, seed) > 0) do
				while (findItem(block) > 0) do
					if (findItem(seed) == 200) then
						collectSet(false,3)
						joinRequest(seedStorageWorldName, seedStorageDoorID)
						if (getTile(bot().x, bot().y).fg == 6) then
							joinRequest(seedStorageWorldName, seedStorageDoorID)
						end
						while (findItem(seed) >= seedDropMinimum) do
							move(1, 0)
							sleep(moveDelay)
							drop(seed)
							sleep(dropDelay)
							reconnect(seedStorageWorldName, seedStorageDoorID, bot().x, bot().y)
							comeback(seedStorageWorldName, seedStorageDoorID, bot().x, bot().y)
							if (findItem(seed) == 0) then
								Webhook("**" .. findObject(seed) .. " " .. getItem(seed).name .. "**","" .. botName .. "","", index,init(botName).discordWebhookUrl,"" .. ordinalNumber(index) .. " / " .. rawlen(farmWorldName) .. "")
								break
							end
							move(1, 0)
							sleep(moveDelay)
						end
						joinRequest(farmWorldName[index], farmDoorID)
						if (getTile(bot().x, bot().y).fg == 6) then
							joinRequest(farmWorldName[index], farmDoorID)
						end
					end
					if (bot().x == 49 and bot().y == 1) then
						for x = -2, putAndBreakTile - 3 do
							if (getTile(bot().x + x, bot().y - 1).fg == 0 and getTile(bot().x + x, bot().y - 1).bg == 0) then
								place(block, x, -1)
								sleep(putDelay)
								reconnect(farmWorldName[index], farmDoorID, 49, 1)
								comeback(farmWorldName[index], farmDoorID, 49, 1)
							end
						end
						for x = -2, putAndBreakTile - 3 do
							if (getTile(bot().x + x, bot().y - 1).fg ~= 0 or getTile(bot().x + x, bot().y - 1).bg ~= 0) then
								punch(x, -1)
								sleep(breakDelay)
								collectSet(true,3)
								reconnect(farmWorldName[index], farmDoorID, 49, 1)
								comeback(farmWorldName[index], farmDoorID, 49, 1)
							end
						end
					else
						findPath(49, 1)
						sleep(findPathDelay)
					end
					if (maxPlayer ~= 0) then
						if (findPlayer() > maxPlayer) then
							sendPacket(3, "action|quit_to_exit")
							sleep(leaveDelay)
							joinRequest(farmWorldName[index], farmDoorID)
							if (getTile(bot().x, bot().y).fg == 6) then
								joinRequest(farmWorldName[index], farmDoorID)
							end
						end
					end
					if (rawlen(itemTrashList) > 0) then
						if (findItemList(itemTrashList, ">=", itemTrashMinimum)) then
							for key, value in pairs(itemTrashList) do
								if (findItem(value) > itemTrashMinimum) then
									sendPacket(2, "action|trash\n|itemID|" .. value)
									sleep(trashDelay)
									sendPacket(2, "action|dialog_return\ndialog_name|trash_item\nitemID|" .. value .. "|\ncount|" .. findItem(value))
									sleep(trashDelay)
								end
							end
						end
					end
					if (getBot().slots == findInventory()) then
						sendPacket(2, "action|buy\nitem|upgrade_backpack")
						sleep(purchaseDelay)
					end
				end
				if (findItem(block) <= 180) then
					if (getBot().world:upper() ~= farmWorldName[index]:upper()) then
						joinRequest(farmWorldName[index], farmDoorID)
					end
					if (getTile(bot().x, bot().y).fg == 6) then
						joinRequest(farmWorldName[index], farmDoorID)
					end
					for key, value in pairs(getTiles()) do
						if (value.fg == seed and value.ready and findItem(block) <= 180) then
							while (getTile(value.x, value.y).fg ~= 0) do
								findPath(value.x, value.y, findPathDelay)
								sleep(findPathDelay)
								punch(0, 0)
								sleep(harvestDelay)
								collectSet(true,3)
								reconnect(farmWorldName[index], farmDoorID, value.x, value.y)
								comeback(farmWorldName[index], farmDoorID, value.x, value.y)
							end
						end
					end
				end
				if (findItem(seed) > 0) then
					if (getBot().world:upper() ~= farmWorldName[index]:upper()) then
						joinRequest(farmWorldName[index], farmDoorID)
					end
					if (getTile(bot().x, bot().y).fg == 6) then
						joinRequest(farmWorldName[index], farmDoorID)
					end
					for key, value in pairs(getTiles()) do
						if (value.fg == 0 and (getItem(getTile(value.x, value.y + 1).fg).collisionType == 1 or getItem(getTile(value.x, value.y + 1).fg).collisionType == 2) and findItem(seed) > 0) then
							while (getTile(value.x, value.y).fg == 0) do
								findPath(value.x, value.y, findPathDelay)
								sleep(findPathDelay)
								place(seed, 0, 0)
								sleep(plantDelay)
								reconnect(farmWorldName[index], farmDoorID, value.x, value.y)
								comeback(farmWorldName[index], farmDoorID, value.x, value.y)
							end
						end
					end
				end
				if (itemPurchaseName ~= "") then
					if (findItemList(itemDropList[1], ">=", itemDropMinimum[1])) then
						collectSet(false,3)
						joinRequest(itemStorageWorldName, itemStorageDoorID)
						if (getTile(bot().x, bot().y).fg == 6) then
							joinRequest(itemStorageWorldName, itemStorageDoorID)
						end
						move(-2, 0)
						sleep(moveDelay)
						for key, value in pairs(itemDropList[1]) do
							move(-1, 0)
							sleep(moveDelay)
							drop(value)
							sleep(dropDelay)
							reconnect(itemStorageWorldName, itemStorageDoorID, bot().x, bot().y)
							comeback(itemStorageWorldName, itemStorageDoorID, bot().x, bot().y)
							while (findItem(value) > 0) do
								move(0, -1)
								sleep(moveDelay)
								drop(value)
								sleep(dropDelay)
								reconnect(itemStorageWorldName, itemStorageDoorID, bot().x, bot().y)
								comeback(itemStorageWorldName, itemStorageDoorID, bot().x, bot().y)
							end
						end
						if (isCallable(getObjects)) then
							local object = ""
							for key, value in pairs(itemDropList[1]) do
								object = object .. findObject(value) .. " " .. getItem(value).name .. "\\n"
							end
							Webhook("**" .. object .. "**","" .. botName .. "","", index,init(botName).discordWebhookUrl,"" .. ordinalNumber(index) .. " / " .. rawlen(farmWorldName) .. "")
						end
						joinRequest(farmWorldName[index], farmDoorID)
						if (getTile(bot().x, bot().y).fg == 6) then
							joinRequest(farmWorldName[index], farmDoorID)
						end
					end
					if (findItem(112) >= itemPurchasePrice) then
						while (findItem(112) >= itemPurchasePrice) do
							if (getInventoryData().slot >= findInventory() + rawlen(itemDropList[1])) then
								sendPacket(2, "action|buy\nitem|" .. itemPurchaseName)
								sleep(purchaseDelay)
							else
								local slots = getInventoryData().slot
								sendPacket(2, "action|buy\nitem|upgrade_backpack")
								sleep(purchaseDelay)
								if (getInventoryData().slot == slots) then
									break
								end
							end
						end
					end
					if (findItemList(itemDropList[1], ">=", itemDropMinimum[1])) then
						collectSet(false,3)
						joinRequest(itemStorageWorldName, itemStorageDoorID)
						if (getTile(bot().x, bot().y).fg == 6) then
							joinRequest(itemStorageWorldName, itemStorageDoorID)
						end
						move(-2, 0)
						sleep(moveDelay)
						for key, value in pairs(itemDropList[1]) do
							move(-1, 0)
							sleep(moveDelay)
							drop(value)
							sleep(dropDelay)
							reconnect(itemStorageWorldName, itemStorageDoorID, bot().x, bot().y)
							comeback(itemStorageWorldName, itemStorageDoorID, bot().x, bot().y)
							while (findItem(value) > 0) do
								move(0, -1)
								sleep(moveDelay)
								drop(value)
								sleep(dropDelay)
								reconnect(itemStorageWorldName, itemStorageDoorID, bot().x, bot().y)
								comeback(itemStorageWorldName, itemStorageDoorID, bot().x, bot().y)
							end
						end
						if (isCallable(getObjects)) then
							local object = ""
							for key, value in pairs(itemDropList[1]) do
								object = object .. findObject(value) .. " " .. getItem(value).name .. "\\n"
							end
							Webhook("**" .. object .. "**","" .. botName .. "","", index,init(botName).discordWebhookUrl,"" .. ordinalNumber(index) .. " / " .. rawlen(farmWorldName) .. "")
						end
						joinRequest(farmWorldName[index], farmDoorID)
						if (getTile(bot().x, bot().y).fg == 6) then
							joinRequest(farmWorldName[index], farmDoorID)
						end
					end
				end
				if (rawlen(itemDropList[2]) > 0) then
					collectSet(false,3)
					if (findItemList(itemDropList[2], ">=", itemDropMinimum[2])) then
						joinRequest(itemStorageWorldName, itemStorageDoorID)
						if (getTile(bot().x, bot().y).fg == 6) then
							joinRequest(itemStorageWorldName, itemStorageDoorID)
						end
						if (itemStorageWorldName:upper() == seedStorageWorldName:upper()) then
							move(0, -1)
							sleep(moveDelay)
						end
						for key, value in pairs(itemDropList[2]) do
							move(1, 0)
							sleep(moveDelay)
							drop(value)
							sleep(dropDelay)
							reconnect(itemStorageWorldName, itemStorageDoorID, bot().x, bot().y)
							comeback(itemStorageWorldName, itemStorageDoorID, bot().x, bot().y)
							while (findItem(value) > 0) do
								move(0, -1)
								sleep(moveDelay)
								drop(value)
								sleep(dropDelay)
								reconnect(itemStorageWorldName, itemStorageDoorID, bot().x, bot().y)
								comeback(itemStorageWorldName, itemStorageDoorID, bot().x, bot().y)
							end
						end
						if (isCallable(getObjects)) then
							local object = ""
							for key, value in pairs(itemDropList[2]) do
								object = object .. findObject(value) .. " " .. getItem(value).name .. "\\n"
							end
							Webhook("**" .. object .. "**","" .. botName .. "","", index,init(botName).discordWebhookUrl,"" .. ordinalNumber(index) .. " / " .. rawlen(farmWorldName) .. "")
						end
						joinRequest(farmWorldName[index], farmDoorID)
						if (getTile(bot().x, bot().y).fg == 6) then
							joinRequest(farmWorldName[index], farmDoorID)
						end
					end
				end
			end
			Webhook("**" .. botName .. "** has been finished farming in the world named **" .. farmWorldName[index]:upper() .. "**","" .. botName .. "","", index,init(botName).discordWebhookUrl,"" .. ordinalNumber(index) .. " / " .. rawlen(farmWorldName) .. "")
		end
	end
	if (loop) then
		main()
	else
		os.exit()
	end
end

botName = getBot().name

local database = getContentRequest("https://raw.githubusercontent.com/CHEZZNAUFAL/Rotation/main/akun.lua")

local name = ""

if (getBot().world:upper() ~= verifyWorldName:upper()) then
	joinRequest(verifyWorldName, "")
end

for key, value in pairs(load(database)()) do
	if (value:lower() == ownerName:lower()) then
		name = value
	end
end

while (not getPlayer(name)) do
	sleep(5000)
end

main()
