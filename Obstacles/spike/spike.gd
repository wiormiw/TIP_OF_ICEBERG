class_name Spike extends Node2D

var inventory_item_data : ItemData

@onready var sprite_2d = $Sprite2D
@onready var audio_stream_player_2d : AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var spike_hurt_box = %SpikeHurtBox
@onready var spike_hurt_box_collision = $SpikeHurtBox/CollisionShape2D
@onready var animation_player = $AnimationPlayer

func _ready() -> void:
	animation_player.play("loop")
	await animation_player.animation_finished
	spike_hurt_box_collision.disabled = false
	spike_hurt_box.monitoring = true
