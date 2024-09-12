class_name InventorySlotUI extends TextureButton

var slot_data : SlotData : set = SetSlotData

@onready var texture_rect : TextureRect = $TextureRect

func _ready() -> void:
	texture_rect.texture = null
	focus_entered.connect(ItemFocused)
	focus_exited.connect(ItemUnfocused)
	
func SetSlotData(value : SlotData) -> void:
	slot_data = value
	if slot_data == null:
		return
	texture_rect.texture = slot_data.item_data.texture
		
func ItemFocused() -> void:
	if slot_data != null:
		if slot_data.item_data != null:
			Inventory.ItemChanged.emit(slot_data.item_data)
	else:
		Inventory.ItemChanged.emit(null)
	pass
	
func ItemUnfocused() -> void:
	Inventory.ItemChangedUnfocused.emit()
	pass
