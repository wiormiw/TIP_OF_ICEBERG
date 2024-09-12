class_name EnemyStateDestroy extends EnemyState

const PICKUP = preload("res://GUI/secret_note/secret_note_drops.tscn")

@export var anim_name : String = "destroy"
@export var knockback_speed : float = 200.0
@export var decelerate_speed : float = 10.0

@export_category("AI")

@export_category("Items Drops")
@export var drops : Array[DropData]

var _damage_position : Vector2
var _direction : Vector2

func Init() -> void:
	enemy.EnemyDestroyed.connect(_on_enemy_destroyed)
	pass
	
func Enter() -> void:
	enemy.invulnerable = true
	_direction = enemy.global_position.direction_to(_damage_position)
	enemy.SetDirection(_direction)
	enemy.velocity = _direction * -knockback_speed
	enemy.UpdateAnimation(anim_name)
	enemy.animation_player.animation_finished.connect(_on_animation_finished)
	DisableHurtbox()
	DropItems()
	pass
	
func Exit() -> void:
	pass
	
func Process(_delta : float) -> EnemyState:
	enemy.velocity -= enemy.velocity * decelerate_speed * _delta
	return null
	
func Physics(_delta : float) -> EnemyState:
	return null
	
func _on_enemy_destroyed(hurt_box : HurtBox) -> void:
	_damage_position = hurt_box.global_position
	state_machine.ChangeState(self)
	
func _on_animation_finished(_a : String) -> void:
	enemy.queue_free()
	
func DisableHurtbox() -> void:
	var hurt_box : HurtBox = enemy.get_node_or_null("HurtBox")
	if hurt_box:
		hurt_box.monitoring = false

func DropItems() -> void:
	if drops.size() == 0:
		return

	for i in drops.size():
		if drops[i] == null || drops[i].item == null:
			continue
		if SaveManager.IsItemCollected(drops[i].item.name):
			continue
		var drop : SecretNoteDrops = PICKUP.instantiate() as SecretNoteDrops
		
		drop.item_data = drops[i].item
		enemy.get_parent().call_deferred("add_child", drop)
		drop.global_position = enemy.global_position
		drop.velocity = enemy.velocity.rotated(randf_range(-1.5, 1.5)) * randf_range(0.5, 1.1)
		
