class_name StateIdle extends State

var next_state : State = null
var active : bool = false

var item_data : ItemData

@onready var walk : State = $"../Walk"
@onready var run : State = $"../Run"
@onready var jump : State = $"../Jump"
@onready var hold_item = $"../Hold_Item"

func Init() -> void:
	Inventory.ItemChanged.connect(_item_changed)

func Enter() -> void:
	if DialogManager.is_dialog_active:
		state_machine.ChangeState(self)
		return
		
	active = true
	player.UpdateAnimation("idle")
	pass
	
func Exit() -> void:
	active = false
	next_state = null
	pass
	
func Process(_delta : float) -> State:
	if DialogManager.is_dialog_active:	
		state_machine.ChangeState(self)
		return
	
	player.velocity = Vector2.ZERO
	
	if player.direction != Vector2.ZERO:
		if Input.is_action_pressed("run"):
			return run
		return walk

	if next_state:
		return next_state

	return null
	
func Physics(_delta : float) -> State:
	return null
	
func HandleInput(_event: InputEvent) -> State:
	if _event.is_action_pressed("jump"):
		return jump
	if _event.is_action_pressed("run"):
		if player.direction != Vector2.ZERO:
			return run
			
	return null
	
func _item_changed(_item_data : ItemData) -> void:
	if not active:
		return
		
	if _item_data:
		item_data = _item_data
		next_state = hold_item
		player.on_arms_item.texture = _item_data.texture
		player.on_arms_item.visible = true
	else:
		next_state = self
