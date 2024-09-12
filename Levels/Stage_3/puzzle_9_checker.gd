class_name Puzzle9Checker extends Node2D

signal CorrectAnswer
signal IncorrectAnswer

@onready var pressure_plate = %PressurePlate
@onready var pressure_plate_2 = %PressurePlate2
@onready var pressure_plate_3 = %PressurePlate3
@onready var pushable_stone = %PushableStone
@onready var pushable_stone_2 = %PushableStone2
@onready var pushable_stone_3 = %PushableStone3
@onready var item_pickup = %ItemPickupNoInventory

var successful_matches : int = 0

func _ready() -> void:
	pressure_plate.StoneTrue.connect(_on_stone_true)
	pressure_plate.StoneFalse.connect(_on_stone_false)
	pressure_plate_2.StoneTrue.connect(_on_stone_true)
	pressure_plate_2.StoneFalse.connect(_on_stone_false)
	pressure_plate_3.StoneTrue.connect(_on_stone_true)
	pressure_plate_3.StoneFalse.connect(_on_stone_false)
	pass

func _on_stone_true(value : int) -> void:
	successful_matches += value
	_update_item_pickup()

func _on_stone_false(value : int) -> void:
	successful_matches += value
	_update_item_pickup()

func _update_item_pickup() -> void:
	if successful_matches >= 3:
		CorrectAnswer.emit()
	else:
		IncorrectAnswer.emit()
