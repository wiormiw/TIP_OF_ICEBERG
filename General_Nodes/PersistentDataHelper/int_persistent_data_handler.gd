class_name IntPersistenDataHandler extends Node

signal IntDataLoaded()
var int_value : Dictionary = {}

func _ready() -> void:
	GetIntValue()
	pass

func SetIntValue(key: String, value: int) -> void:
	SaveManager.AddIntPersistentValue(key, value)
	pass

func GetIntValue() -> void:
	int_value = SaveManager.GetIntPersistentValue()
	IntDataLoaded.emit()
	pass

func GetIntValueByKey(key: String) -> int:
	return SaveManager.GetIntPersistentValueByKey(key)
