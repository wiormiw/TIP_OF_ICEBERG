class_name PersistentDataHandler extends Node

signal DataLoaded()
var value : bool = false

func _ready() -> void:
	GetValue()
	pass
	
func SetValue() -> void:
	SaveManager.AddPersistentValue(_get_name())
	pass
	
func GetValue() -> void:
	value = SaveManager.CheckPersistentValue(_get_name())
	DataLoaded.emit()
	pass
	
func _get_name() -> String:
	
	return get_tree().current_scene.scene_file_path + "/" + get_parent().name + "/" + name
