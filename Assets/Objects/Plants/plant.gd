class_name Plant extends Node2D

signal Destroyed

var is_destroyed : bool = false

@onready var sprite : Sprite2D = $Sprite2D
@onready var is_destroyed_data : PersistentDataHandler = $PersistentDataHandler

# Called when the node enters the scene tree for the first time.
func _ready():
	$HitBox.Damaged.connect(TakeDamage)
	is_destroyed_data.DataLoaded.connect(SetState)
	SetState()
	
func SetState() -> void:
	is_destroyed = is_destroyed_data.value
	if is_destroyed:
		queue_free()

func TakeDamage(_damage : HurtBox) -> void:
	Destroyed.emit()
	queue_free()
	pass
	
