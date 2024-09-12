class_name StateJump extends State

var gravity : float = 9.8
var latest_direction : Vector2 = Vector2.ZERO

@export var is_in_air : bool = false
@export var invulnerable_duration : float = 1.2
@export var jump_sound : AudioStream
@onready var audio : AudioStreamPlayer2D = $"../../Audio/AudioStreamPlayer2D"
@onready var floor_check_down : RayCast2D = $"../../RayCast2DDOWN"
@onready var floor_check_up : RayCast2D = $"../../RayCast2DUP"
@onready var floor_check_right : RayCast2D = $"../../RayCast2DRIGHT"
@onready var floor_check_left : RayCast2D = $"../../RayCast2DLEFT"
@onready var animation_player : AnimationPlayer = $"../../AnimationPlayer"
@onready var hurt_box = %JumpHurtBox
@onready var hurt_box_collision = $"../../Skeleton/JumpHurtBox/CollisionShape2D"

@onready var idle : State = $"../Idle"
@onready var walk : State = $"../Walk"
@onready var run : State = $"../Run"

func Enter() -> void:
	if Global.current_stage == "11":
		if player.cardinal_direction == Vector2.ZERO:
			state_machine.ChangeState(idle)
			return
		if Input.is_action_pressed("run"):
			state_machine.ChangeState(run)
			return
		state_machine.ChangeState(walk)
		return
	
	if DialogManager.is_dialog_active:
		player.velocity = Vector2.ZERO
		player.UpdateAnimation("idle")
		hurt_box.monitoring = false
		hurt_box_collision.disabled = true
		state_machine.ChangeState(idle)
		return
		
	player.direction = latest_direction
	player.UpdateAnimation("jump", 1.5)
	player.MakeInvulnerable(invulnerable_duration)
	audio.stream = jump_sound
	audio.pitch_scale = randf_range(0.9, 1.1)
	audio.play()
	await get_tree().create_timer(0.075).timeout
	pass

func Exit() -> void:
	is_in_air = false
	hurt_box.monitoring = false
	hurt_box_collision.call_deferred("set_disabled", true) 
	pass
	
func Process(_delta : float) -> State:
	if Global.current_stage == "11":
		if player.cardinal_direction == Vector2.ZERO:
			return idle
		if Input.is_action_pressed("run"):
			return run
		return walk
	
	if DialogManager.is_dialog_active:
		player.velocity = Vector2.ZERO
		player.UpdateAnimation("idle")
		state_machine.ChangeState(idle)
		return
	
	if is_in_air:
		if latest_direction != Vector2.ZERO:
			player.cardinal_direction = latest_direction
		player.UpdateAnimation("jump", 1.5)
			
	else:
		if player.cardinal_direction == Vector2.ZERO:
			return idle
		if Input.is_action_pressed("run"):
			return run
		return walk
	
	return null
	
func Physics(_delta : float) -> State:
	if is_in_air && player.direction != Vector2.ZERO:
		if Input.is_action_pressed("run"):
			player.velocity = player.cardinal_direction * (walk.move_speed * 1.5)
		else:
			player.velocity = player.cardinal_direction * walk.move_speed
	else:
		player.velocity = Vector2.ZERO
		
	if not is_in_air:
		player.velocity = Vector2.ZERO
		
	return null
	
func HandleInput(_event: InputEvent) -> State:
	if _event.is_action_pressed("run") && player.direction != Vector2.ZERO:
		return run
	return null
