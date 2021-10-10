local _G, _M = getfenv(0), {}
setfenv(1, setmetatable(_M, {__index=_G}))

CreateFrame('GameTooltip', 'SortBagsTooltip', nil, 'GameTooltipTemplate')

BAG_CONTAINERS = {0, 1, 2, 3, 4}
BANK_BAG_CONTAINERS = {-1, 5, 6, 7, 8, 9, 10}

function _G.SortBags()
	CONTAINERS = {unpack(BAG_CONTAINERS)}
	for i = #CONTAINERS, 1, -1 do
		if GetBagSlotFlag(i - 1, LE_BAG_FILTER_FLAG_IGNORE_CLEANUP) then
			tremove(CONTAINERS, i)
		end
	end
	Start()
end

function _G.SortBankBags()
	CONTAINERS = {unpack(BANK_BAG_CONTAINERS)}
	for i = #CONTAINERS, 1, -1 do
		if GetBankBagSlotFlag(i - 1, LE_BAG_FILTER_FLAG_IGNORE_CLEANUP) then
			tremove(CONTAINERS, i)
		end
	end
	Start()
end

function _G.GetSortBagsRightToLeft(enabled)
	return SortBagsRightToLeft
end

function _G.SetSortBagsRightToLeft(enabled)
	_G.SortBagsRightToLeft = enabled and 1 or nil
end

local function set(...)
	local t = {}
	local n = select('#', ...)
	for i = 1, n do
		t[select(i, ...)] = true
	end
	return t
end

local function arrayToSet(array)
	local t = {}
	for i = 1, #array do
		t[array[i]] = true
	end
	return t
end

local function union(...)
	local t = {}
	local n = select('#', ...)
	for i = 1, n do
		for k in pairs(select(i, ...)) do
			t[k] = true
		end
	end
	return t
end

local SPECIAL = set(5462, 13347, 11511, 38233, 9173)

local KEYS = set(9240, 11511, 17191, 13544, 12324, 16309, 12384, 20402)

local TOOLS = set(6218, 6339, 11130, 11145, 16207, 22461, 22462, 22463, 5060, 7005, 12709, 19727, 5956, 2901, 6219, 10498, 9149, 15846, 6256, 6365, 6366, 6367, 12225, 19022, 25978, 19970, 20815, 20824, 25978)

local CLASSES = {
	-- soul
	{
		containers = {22243, 22244, 21340, 21341, 21342},
		items = set(6265),
	},
	-- arrow
	{
		containers = {2101, 5439, 7278, 11362, 3573, 3605, 7371, 8217, 2662, 19319, 18714},
		items = set(2512, 2514, 2515, 3029, 3030, 3031, 3464, 9399, 10579, 11285, 12654, 18042, 19316, 24412, 24417, 28053, 28056, 30319, 30611, 31737, 31949, 32760, 33803, 34581),
	},
	-- bullet
	{
		containers = {2102, 5441, 7279, 11363, 3574, 3604, 7372, 8218, 2663, 19320},
		items = set(2516, 2519, 3033, 3465, 4960, 5568, 8067, 8068, 8069, 10512, 10513, 11284, 11630, 13377, 15997, 19317, 23772, 23773, 28060, 28061, 30612, 31735, 32761, 32882, 32883, 34582),
	},
	-- ench
	{
		containers = {22246, 22248, 22249},
		items = arrayToSet({6218, 6222, 6339, 6342, 6343, 6344, 6345, 6346, 6347, 6348, 6349, 6375, 6376, 6377, 10938, 10939, 10940, 10978, 10998, 11038, 11039, 11081, 11082, 11083, 11084, 11098, 11101, 11130, 11134, 11135, 11137, 11138, 11139, 11145, 11150, 11151, 11152, 11163, 11164, 11165, 11166, 11167, 11168, 11174, 11175, 11176, 11177, 11178, 11202, 11203, 11204, 11205, 11206, 11207, 11208, 11223, 11224, 11225, 11226, 11813, 14343, 14344, 16202, 16203, 16204, 16207, 16214, 16215, 16216, 16217, 16218, 16219, 16220, 16221, 16222, 16223, 16224, 16242, 16243, 16244, 16245, 16246, 16247, 16248, 16249, 16250, 16251, 16252, 16253, 16254, 16255, 17725, 18259, 18260, 19444, 19445, 19446, 19447, 19448, 19449, 20725, 20726, 20727, 20728, 20729, 20730, 20731, 20732, 20733, 20734, 20735, 20736, 20752, 20753, 20754, 20755, 20756, 20757, 20758, 22392, 22445, 22446, 22447, 22448, 22449, 22450, 22461, 22462, 22463, 22530, 22531, 22532, 22533, 22534, 22535, 22536, 22537, 22538, 22539, 22540, 22541, 22542, 22543, 22544, 22545, 22546, 22547, 22548, 22551, 22552, 22553, 22554, 22555, 22556, 22557, 22558, 22559, 22560, 22561, 22562, 22563, 22564, 22565, 24000, 24003, 25848, 25849, 28270, 28271, 28272, 28273, 28274, 28276, 28277, 28279, 28280, 28281, 28282, 33148, 33149, 33150, 33151, 33152, 33153, 33165, 33307, 34872, 35297, 35298, 35299, 35498, 35500, 35756, 186683, 7081, 12810, 7068, 7972, 12808, 7067, 7075, 7076, 7077, 7078, 7080, 7082, 12803, 21885, 22451, 22456, 22457, 22572, 22576, 22577, 22578, 23571, 23572, 21886, 22575, 21884, 22452, 22573, 22574}),
	},
	-- herb
	{
		containers = {22250, 22251, 22252},
		items = arrayToSet({765, 785, 1401, 2263, 2447, 2449, 2450, 2452, 2453, 3355, 3356, 3357, 3358, 3369, 3818, 3819, 3820, 3821, 4625, 5013, 5056, 5168, 8831, 8836, 8838, 8839, 8845, 8846, 11018, 11020, 11022, 11024, 11040, 11514, 11951, 11952, 13463, 13464, 13465, 13466, 13467, 13468, 16205, 16208, 17034, 17035, 17036, 17037, 17038, 17760, 18297, 19727, 22094, 22147, 22710, 22785, 22786, 22787, 22788, 22789, 22790, 22791, 22792, 22793, 22794, 22795, 22797, 23329, 23501, 23788, 24245, 24246, 24401, 31300, 32468, 34465, 8153, 10286, 19726, 21886, 22575}),
	},
}

do
	local f = CreateFrame'Frame'
	local lastUpdate = 0
	local function updateHandler()
		if GetTime() - lastUpdate > 1 then
			for _, container in pairs(BAG_CONTAINERS) do
				for position = 1, GetContainerNumSlots(container) do
					SetScanTooltip(container, position)
				end
			end
			for _, container in pairs(BANK_BAG_CONTAINERS) do
				for position = 1, GetContainerNumSlots(container) do
					SetScanTooltip(container, position)
				end
			end
			f:SetScript('OnUpdate', nil)
		end
	end
	f:SetScript('OnEvent', function()
		lastUpdate = GetTime()
		f:SetScript('OnUpdate', updateHandler)
	end)
	f:RegisterEvent'BAG_UPDATE'
	f:RegisterEvent'BANKFRAME_OPENED'
end

local model, itemStacks, itemClasses, itemSortKeys

do
	local f = CreateFrame'Frame'

	local process = coroutine.create(function() end);

	local suspended

	function Start()
		process = coroutine.create(function()
			while not Initialize() do
				coroutine.yield()
			end
			while true do
				suspended = false
				if InCombatLockdown() then
					return
				end
				local complete = Sort()
				if complete then
					return
				end
				Stack()
				if not suspended then
					coroutine.yield()
				end
			end
		end)
		f:Show()
	end

	f:SetScript('OnUpdate', function(_, arg1)
		if coroutine.status(process) == 'suspended' then
			suspended = true
			coroutine.resume(process)
		end
		if coroutine.status(process) == 'dead' then
			f:Hide()
		end
	end)
end

function LT(a, b)
	local i = 1
	while true do
		if a[i] and b[i] and a[i] ~= b[i] then
			return a[i] < b[i]
		elseif not a[i] and b[i] then
			return true
		elseif not b[i] then
			return false
		end
		i = i + 1
	end
end

function Move(src, dst)
	local texture, _, srcLocked = GetContainerItemInfo(src.container, src.position)
	local _, _, dstLocked = GetContainerItemInfo(dst.container, dst.position)

	if texture and not srcLocked and not dstLocked then
		ClearCursor()
		PickupContainerItem(src.container, src.position)
		PickupContainerItem(dst.container, dst.position)

		if src.item == dst.item then
			local count = min(src.count, itemStacks[dst.item] - dst.count)
			src.count = src.count - count
			dst.count = dst.count + count
			if src.count == 0 then
				src.item = nil
			end
		else
			src.item, dst.item = dst.item, src.item
			src.count, dst.count = dst.count, src.count
		end

		coroutine.yield()
		return true
	end
end

do
	local patterns = {}
	for i = 1, 10 do
		local text = gsub(format(ITEM_SPELL_CHARGES, i), '(-?%d+)(.-)|4([^;]-);', function(numberString, gap, numberForms)
			local singular, dual, plural
			_, _, singular, dual, plural = strfind(numberForms, '(.+):(.+):(.+)');
			if not singular then
				_, _, singular, plural = strfind(numberForms, '(.+):(.+)')
			end
			local i = abs(tonumber(numberString))
			local numberForm
			if i == 1 then
				numberForm = singular
			elseif i == 2 then
				numberForm = dual or plural
			else
				numberForm = plural
			end
			return numberString .. gap .. numberForm
		end)
		patterns[text] = i
	end

	function itemCharges(text)
		return patterns[text]
	end
end

function TooltipInfo(container, position)
	SetScanTooltip(container, position)

	local charges, usable, soulbound, quest, conjured, mount
	for i = 1, SortBagsTooltip:NumLines() do
		local text = getglobal('SortBagsTooltipTextLeft' .. i):GetText()

		local extractedCharges = itemCharges(text)
		if extractedCharges then
			charges = extractedCharges
		elseif strfind(text, '^' .. ITEM_SPELL_TRIGGER_ONUSE) then
			usable = true
		elseif text == ITEM_SOULBOUND then
			soulbound = true
		elseif text == ITEM_BIND_QUEST then -- TODO retail can maybe use GetItemInfo bind info instead
			quest = true
		elseif text == ITEM_CONJURED then
			conjured = true
		elseif text == MOUNT then
			mount = true
		end
	end

	return charges or 1, usable, soulbound, quest, conjured, mount
end

function SetScanTooltip(container, position)
	SortBagsTooltip:SetOwner(UIParent, 'ANCHOR_NONE')
	SortBagsTooltip:ClearLines()

	if container == BANK_CONTAINER then
		SortBagsTooltip:SetInventoryItem('player', BankButtonIDToInvSlotID(position))
	else
		SortBagsTooltip:SetBagItem(container, position)
	end
end

function Sort()
	local complete, moved
	repeat
		complete, moved = true, false
		for _, dst in ipairs(model) do
			if dst.targetItem and (dst.item ~= dst.targetItem or dst.count < dst.targetCount) then
				complete = false

				local sources, rank = {}, {}

				for _, src in ipairs(model) do
					if src.item == dst.targetItem
						and src ~= dst
						and not (dst.item and src.class and src.class ~= itemClasses[dst.item])
						and not (src.targetItem and src.item == src.targetItem and src.count <= src.targetCount)
					then
						rank[src] = abs(src.count - dst.targetCount + (dst.item == dst.targetItem and dst.count or 0))
						tinsert(sources, src)
					end
				end

				sort(sources, function(a, b) return rank[a] < rank[b] end)

				for _, src in ipairs(sources) do
					if Move(src, dst) then
						moved = true
						break
					end
				end
			end
		end
	until complete or not moved
	return complete
end

function Stack()
	for _, src in ipairs(model) do
		if src.item and src.count < itemStacks[src.item] and src.item ~= src.targetItem then
			for _, dst in ipairs(model) do
				if dst ~= src and dst.item and dst.item == src.item and dst.count < itemStacks[dst.item] and dst.item ~= dst.targetItem then
					if Move(src, dst) then
						return
					end
				end
			end
		end
	end
end

do
	local counts

	local function insert(t, v)
		if SortBagsRightToLeft then
			tinsert(t, v)
		else
			tinsert(t, 1, v)
		end
	end

	local function assign(slot, item)
		if counts[item] > 0 then
			local count
			if SortBagsRightToLeft and mod(counts[item], itemStacks[item]) ~= 0 then
				count = mod(counts[item], itemStacks[item])
			else
				count = min(counts[item], itemStacks[item])
			end
			slot.targetItem = item
			slot.targetCount = count
			counts[item] = counts[item] - count
			return true
		end
	end

	function Initialize()
		model, counts, itemStacks, itemClasses, itemSortKeys = {}, {}, {}, {}, {}

		for _, container in ipairs(CONTAINERS) do
			local class = ContainerClass(container)
			for position = 1, GetContainerNumSlots(container) do
				local slot = {container=container, position=position, class=class}
				local item = Item(container, position)
				if item then
					local _, count, locked = GetContainerItemInfo(container, position)
					if locked then
						return false
					end
					slot.item = item
					slot.count = count
					counts[item] = (counts[item] or 0) + count
				end
				insert(model, slot)
			end
		end

		local free = {}
		for item, count in pairs(counts) do
			local stacks = ceil(count / itemStacks[item])
			free[item] = stacks
			if itemClasses[item] then
				free[itemClasses[item]] = (free[itemClasses[item]] or 0) + stacks
			end
		end
		for _, slot in ipairs(model) do
			if slot.class and free[slot.class] then
				free[slot.class] = free[slot.class] - 1
			end
		end

		local items = {}
		for item in pairs(counts) do
			tinsert(items, item)
		end
		sort(items, function(a, b) return LT(itemSortKeys[a], itemSortKeys[b]) end)

		for _, slot in ipairs(model) do
			if slot.class then
				for _, item in ipairs(items) do
					if itemClasses[item] == slot.class and assign(slot, item) then
						break
					end
				end
			else
				for _, item in ipairs(items) do
					if (not itemClasses[item] or free[itemClasses[item]] > 0) and assign(slot, item) then
						if itemClasses[item] then
							free[itemClasses[item]] = free[itemClasses[item]] - 1
						end
						break
					end
				end
			end
		end
		return true
	end
end

function ContainerClass(container)
	if container ~= 0 and container ~= BANK_CONTAINER then
		local name = GetBagName(container)
		if name then
			for class, info in pairs(CLASSES) do
				for _, itemID in pairs(info.containers) do
					if name == GetItemInfo(itemID) then
						return class
					end
				end
			end
		end
	end
end

function Item(container, position)
	local link = GetContainerItemLink(container, position)
	if link then
        local _, _, itemID, enchantID, suffixID, uniqueID = strfind(link, 'item:(%d+):(%d*):::::(%d*):(%d*)')
		itemID = tonumber(itemID)
		local itemName, _, quality, _, _, _, _, stack, slot, _, sellPrice, classId, subClassId = GetItemInfo('item:' .. itemID)
		local charges, usable, soulbound, quest, conjured, mount = TooltipInfo(container, position)
		local sortKey = {}

		-- hearthstone
		if itemID == 6948 then
			tinsert(sortKey, 1)

		-- mounts
		elseif mount then
			tinsert(sortKey, 2)

		-- special items
		elseif SPECIAL[itemID] then
			tinsert(sortKey, 3)

		-- key items
		elseif KEYS[itemID] then
			tinsert(sortKey, 4)

		-- tools
		elseif TOOLS[itemID] then
			tinsert(sortKey, 5)

		-- soul shards
		elseif itemID == 6265 then
			tinsert(sortKey, 13)

		-- conjured items
		elseif conjured then
			tinsert(sortKey, 14)

		-- soulbound items
		elseif soulbound then
			tinsert(sortKey, 6)

		-- reagents
		elseif classId == 9 then
			tinsert(sortKey, 7)

		-- quest items
		elseif quest then
			tinsert(sortKey, 9)

		-- consumables
		elseif usable and classId ~= 1 and classId ~= 2 and classId ~= 8 or classId == 4 then
			tinsert(sortKey, 8)

		-- higher quality
		elseif quality > 1 then
			tinsert(sortKey, 10)

		-- common quality
		elseif quality == 1 then
			tinsert(sortKey, 11)
			tinsert(sortKey, -sellPrice)

		-- junk
		elseif quality == 0 then
			tinsert(sortKey, 12)
			tinsert(sortKey, sellPrice)
		end

		tinsert(sortKey, classId)
		tinsert(sortKey, slot)
		tinsert(sortKey, subClassId)
		tinsert(sortKey, -quality)
		tinsert(sortKey, itemName)
		tinsert(sortKey, itemID)
		tinsert(sortKey, (SortBagsRightToLeft and 1 or -1) * charges)
		tinsert(sortKey, suffixID)
		tinsert(sortKey, enchantID)
		tinsert(sortKey, uniqueID)

		local key = format('%s:%s:%s:%s:%s:%s', itemID, enchantID, suffixID, uniqueID, charges, (soulbound and 1 or 0))

		itemStacks[key] = stack
		itemSortKeys[key] = sortKey

		for class, info in pairs(CLASSES) do
			if info.items[itemID] then
				itemClasses[key] = class
				break
			end
		end

		return key
	end
end
