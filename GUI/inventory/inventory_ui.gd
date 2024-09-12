class_name InventoryUI extends Control

const INVENTORY_SLOT = preload("res://GUI/inventory/inventory_slot.tscn")

var previously_focused_node: Node = null

@export var data : InventoryData = PlayerManager.INVENTORY_DATA

func _ready() -> void:
	Inventory.Shown.connect(UpdateInventory)
	Inventory.Hidden.connect(ClearInventory)
	Inventory.SlotDataChanged.connect(UpdateSlotDataInventory)
	Inventory.SlotDataNotChanged.connect(FocusToExistData)
	SaveManager.GameLoaded.connect(FocusToZero)
	ClearInventory()
	
func ClearInventory() -> void:
	for c in get_children():
		c.queue_free()
		
func UpdateInventory() -> void:
	for s in data.slots:
		var new_slot = INVENTORY_SLOT.instantiate()
		add_child(new_slot)
		new_slot.slot_data = s
	get_child(0).grab_focus()
	
func UpdateSlotDataInventory(_slot_data : SlotData, idx : int) -> void:
	if idx == -1:
		remove_child(get_child(0))
		var new_slot = INVENTORY_SLOT.instantiate()
		add_child(new_slot)
		new_slot.slot_data = _slot_data
	else:
		var slot_node = get_child(idx)
		if slot_node:
			slot_node.slot_data = _slot_data
	
	get_child(idx).grab_focus()
	
func FocusToExistData(idx : int) -> void:
	get_child(idx).grab_focus()
	
func FocusToZero() -> void:
	if Inventory.visible == true:
		get_child(0).grab_focus()
	
	
