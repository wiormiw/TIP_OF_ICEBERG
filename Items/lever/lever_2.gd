class_name Lever2 extends Node2D

var is_used : bool = false

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var interaction_area : InteractionArea = $InteractionArea
@onready var speech_sfx : AudioStream = preload("res://Assets/Audio/text.wav")
@onready var is_used_data : PersistentDataHandler = $PersistentDataHandler
@onready var cell_door = $"../CellDoor"

var lines : Array[String] = [
	"Kita lihat HP-mu!",
]

func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")
	is_used_data.DataLoaded.connect(SetState)
	SetState()
	pass

func SetState() -> void:
	is_used = is_used_data.value
	if is_used:
		animation_player.play("used")
		interaction_area.monitoring = false
		return
	else:
		animation_player.play("default")

func _on_interact() -> void:
	animation_player.play("switch_on")
	if PlayerManager.player.hp < 4:
		lines.append("HP-mu dibawah 4!!!, silahkan kembali ke awal :)")
		DialogManager.StartDialog(global_position, lines, speech_sfx)
		await DialogManager.DialogFinished
		lines.pop_back()
		SceneTransition.FadeOut()
		await get_tree().process_frame
		animation_player.play("reverse_switch")
		SceneTransition.FadeIn()
		PlayerManager.SetPlayerPosition(Global.default_position["04"])
		PlayerManager.SetHealth(6, 6)
	else:
		lines.append("HP-mu tidak kurang dari 4!, Good JOB :)")
		DialogManager.StartDialog(global_position, lines, speech_sfx)
		await DialogManager.DialogFinished
		lines.pop_back()
		cell_door.OpenDoor()
		is_used_data.SetValue()

func LeverReset() -> void:
	animation_player.play("switch_reverse")
