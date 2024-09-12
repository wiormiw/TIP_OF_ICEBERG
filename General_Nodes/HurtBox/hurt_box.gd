class_name HurtBox extends Area2D

@export var damage : int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect(AreaEntered)
	pass # Replace with function body.


func AreaEntered(a : Area2D) -> void:
	if a is HitBox:
		a.TakeDamage(self)
	pass
