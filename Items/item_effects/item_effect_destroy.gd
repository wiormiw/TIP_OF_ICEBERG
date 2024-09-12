class_name ItemDestroy extends ItemEffect

@export var item_name_to_destroy : String

func Use() -> void:
	Global.item_to_destroy = item_name_to_destroy
	pass
	
