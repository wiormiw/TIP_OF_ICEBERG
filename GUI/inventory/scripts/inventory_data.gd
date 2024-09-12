class_name InventoryData extends Resource

@export var slots : Array[SlotData]

func AddItem(item: ItemData) -> bool:
	for s in slots:
		if s:
			if s.item_data == item:
				Inventory.SlotDataNotChanged.emit(slots.find(s, 0))
				return true
	
	for i in slots.size():
		if slots[i] == null:
			var new = SlotData.new()
			new.item_data = item
			slots[i] = new
			Inventory.SlotDataChanged.emit(new, i)
			return true
			
	var new_full = SlotData.new()
	new_full.item_data = item
	slots.pop_front()
	slots.push_back(new_full)
	Inventory.SlotDataChanged.emit(new_full, -1)
	return true
	
func GetSaveData() -> Array:
	var item_save : Array = []
	for i in slots.size():
		item_save.append(ItemToSave(slots[i]))
	return item_save
	
func ItemToSave(slot : SlotData) -> Dictionary:
	var result = { item = "", item_name = "" }
	if slot != null:
		if slot.item_data != null:
			result.item = slot.item_data.resource_path
			result.item_name = slot.item_data.name
	return result
	
func ParseSaveData(save_data : Array) -> void:
	var array_size = slots.size()
	slots.clear()
	slots.resize(array_size)
	for i in save_data.size():
		slots[i] = ItemFromSave(save_data[i])
	pass
	
func ItemFromSave(save_object : Dictionary) -> SlotData:
	if save_object.item == "":
		return null
	
	var new_slot : SlotData = SlotData.new()
	new_slot.item_data = load(save_object.item)
	
	return new_slot
