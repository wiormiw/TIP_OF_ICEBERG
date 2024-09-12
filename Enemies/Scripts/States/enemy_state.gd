class_name EnemyState extends Node

# Reference to enemy this state belong to.
var enemy : Enemy
var state_machine : EnemyStateMachine

func Init() -> void:
	pass
	
func Enter() -> void:
	pass
	
func Exit() -> void:
	pass
	
func Process(_delta : float) -> EnemyState:
	return null
	
func Physics(_delta : float) -> EnemyState:
	return null
