extends CanvasLayer

signal Shown
signal Hidden
signal ItemChanged (_item_data : ItemData)
signal SlotDataChanged (_slot_data : SlotData, idx : int)
signal SlotDataNotChanged (idx : int)
signal ItemChangedUnfocused

func _ready() -> void:
	PauseMenu.Shown.connect(HideInventory)
	PauseMenu.Hidden.connect(ShowInventory)
	HideInventory()
			
func ShowInventory() -> void:
	if Global.current_stage == "13":
		visible = true
		Shown.emit()
	
func HideInventory() -> void:
	visible = false
	Hidden.emit()
