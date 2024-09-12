class_name StatePush extends State

@onready var walk : State = $"../Walk"

func Enter() -> void:
	await get_tree().create_timer(0.1).timeout
	player.UpdateAnimation("push")
	pass
	
func Exit() -> void:
	pass
	
func Process(_delta : float) -> State:
	player.velocity = player.direction * walk.move_speed

	return null
	
func Physics(_delta : float) -> State:
	return null
	
func HandleInput(_event: InputEvent) -> State:
	return null
