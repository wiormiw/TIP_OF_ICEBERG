extends Area2D

@onready var push = $"../StateMachine/Push"
@onready var walk = $"../StateMachine/Walk"
@onready var run = $"../StateMachine/Run"
@onready var idle = $"../StateMachine/Idle"
@onready var jump = $"../StateMachine/Jump"

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
func _on_body_entered(b : Node2D) -> void:
	if b is PushableStone:
		b.push_direction = PlayerManager.player.direction
		PlayerManager.player.state_machine.ChangeState(push)
	pass
	
func _on_body_exited(b : Node2D) -> void:
	if b is PushableStone:
		b.push_direction = Vector2.ZERO
		if PlayerManager.player.direction != Vector2.ZERO:
			if Input.is_action_pressed("run"):
				PlayerManager.player.state_machine.ChangeState(run)
			PlayerManager.player.state_machine.ChangeState(walk)
		PlayerManager.player.state_machine.ChangeState(idle)
	pass
