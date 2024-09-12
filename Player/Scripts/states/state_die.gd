class_name StateDie extends State

signal PlayerDiedCompleted

var next_state : State = null
var active : bool = false
@onready var idle = $"../Idle"

func Init() -> void:
	player.PlayerDied.connect(_on_player_die)

func Enter() -> void:
	player.on_arms_item.visible = false
	player.UpdateAnimation("die")
	player.animation_player.animation_finished.connect(_animation_finished)
	pass
	
func Exit() -> void:
	next_state = null
	player.animation_player.animation_finished.disconnect(_animation_finished)
	player.PlayerDied.disconnect(_on_player_die)
	pass
	
func Process(_delta : float) -> State:
	player.velocity = Vector2.ZERO
	return next_state
	
func Physics(_delta : float) -> State:
	return null
	
func HandleInput(_event: InputEvent) -> State:
	return null
	
func _animation_finished(_a : String) -> void:
	PlayerDiedCompleted.emit()
	next_state = idle
	pass
	
func _on_player_die() -> void:
	state_machine.ChangeState(self)
