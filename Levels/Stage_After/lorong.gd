class_name Lorong extends Level

const OUTRO : String = "res://Global_Scripts/outro.tscn"

@onready var area_outro : Area2D = %AreaOutro
@onready var audio_ending : AudioStreamPlayer = $AudioEnding

@onready var music : AudioStream = preload("res://Assets/Audio/Heart of Nowhere - Kevin MacLeod - Audio Library - Free Music.wav")

func _ready() -> void:
	super._ready()
	ResourceLoader.load_threaded_request(OUTRO)
	area_outro.body_entered.connect(_on_body_entered)
	
func _on_body_entered(_b : Node2D) -> void:
	var outro = ResourceLoader.load_threaded_get(OUTRO)
	fade_out_audio(2.0)
	SceneTransition.FadeOut()
	await get_tree().process_frame
	SceneTransition.FadeIn() 
	await get_tree().process_frame
	if _b is Player:
		PlayerManager.player.queue_free()
	get_tree().change_scene_to_packed.call_deferred(outro)

func fade_out_audio(duration: float):
	var initial_volume = audio_ending.volume_db
	var fade_time = 0.0
	while fade_time < duration:
		await get_tree().create_timer(0.1).timeout
		fade_time += 0.1
		audio_ending.volume_db = initial_volume * (1.0 - fade_time / duration)
	audio_ending.stop()
