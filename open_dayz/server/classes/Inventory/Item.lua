-- ****************************************************************************
-- *
-- *  PROJECT:     Open MTA:DayZ
-- *  FILE:        server/classes/Item.lua
-- *  PURPOSE:     Item class
-- *
-- ****************************************************************************
Item = inherit(Object)

function Item:constructor(itemid)
	self.m_ItemId = itemid
	self.m_Data = {}
	self.m_InventoryInfo = {}
end

function Item:getName()
	return Items[self.m_ItemId].Name
end

function Item:setInventory(inv, slot, index)
	self.m_InventoryInfo = { inv, slot, index }
end

function Item:dataField(name, sync, clientchange, default)
	self.m_Data[name] = { sync = sync, cc = clientchange, value = default }
end

function Item:get(name)
	return self.m_Data[name]
end

function Item:set(name, value)
	self.m_Data[name] = value
	self:change()
end

function Item:change()
	self.m_InventoryInfo[1]:change(self.m_InventoryInfo[2], self.m_InventoryInfo[3])
end

function Item:syncdata()
	local sdata = {}
	for k, v in pairs(self.m_Data) do
		if v.sync then
			sdata[k].cc = v.cc
			sdata[k].value = v.value
		end
	end
	sdata.id = self.m_ItemId
	return sdata
end

function Item:dbdata()
	local ddata = {}
	for k, v in pairs(self.m_Data) do
		ddata[k] = v.value
	end
	ddata.id = self.m_ItemId
	return ddata
end

function Item:use(player)
	-- Implement this function in derived classes
	-- By default this resolves to "no action"
end