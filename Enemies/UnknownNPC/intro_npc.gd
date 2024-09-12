class_name IntroNPC extends CharacterBody2D

@onready var speech_sfx : AudioStream = preload("res://Assets/Audio/text.wav")

@export var lines : Array[String] = [
	"Senang bertemu denganmu!",
	"Pertemuan kita adalah takdir",
	"Di tempat ini,",
	"Kamu akan mendapatkan",
	"Sesuatu yang berharga....",
	"..Seperti mimpi bukan?",
	"Tidak perlu membuang waktu lagi",
	"Ayo berpetualang di TOI-WORLD!!!!",
	"Jangan lupa lewat UTARA ya..."
]

@export var door_to_open : HiddenDoor

@onready var npc_interaction_area : InteractionArea = %NPCInteractionArea


func _ready() -> void:
	if Global.player_name != "":
		lines.push_front("Hello " + Global.player_name + "!")
	else:
		lines.push_front("Hello Player!")
	npc_interaction_area.interact = Callable(self, "_on_interact")
	
	
func _on_interact() -> void:
	DialogManager.StartDialog(global_position + Vector2(0,10), lines, speech_sfx)
	lines.pop_at(0)
	await DialogManager.DialogFinished
	door_to_open.OpenDoor()
