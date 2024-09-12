extends CanvasLayer

signal LoadingShown
signal LoadingHidden

@onready var animation_player : AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	HideLoading()
	pass
	
func HideLoading() -> void:
	get_tree().paused = false
	visible = false
	animation_player.stop()
	LoadingHidden.emit()
	
func ShowLoading() -> void:
	get_tree().paused = true
	visible = true
	animation_player.play("default")	
	LoadingShown.emit()

