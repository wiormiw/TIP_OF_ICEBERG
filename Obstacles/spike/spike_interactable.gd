class_name SpikeInteractable extends Node2D

var inventory_item_data : ItemData

@onready var interaction_area : InteractionArea = $InteractionArea
@onready var sprite_2d = $Sprite2D
@onready var audio_stream_player_2d : AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var spike_hurt_box = %SpikeHurtBox
@onready var spike_hurt_box_collision = $SpikeHurtBox/CollisionShape2D
@onready var animation_player = $AnimationPlayer

func _ready() -> void:
	spike_hurt_box_collision.disabled = true
	spike_hurt_box.monitoring = false
	interaction_area.interact = Callable(self, "_on_interact")
	
func _on_interact() -> void:
	spike_hurt_box_collision.disabled = false
	spike_hurt_box.monitoring = true
	animation_player.play("default")
	pass
