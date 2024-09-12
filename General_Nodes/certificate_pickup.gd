class_name CertificatePickup extends Node2D

const CERTIFICATE = preload("res://General_Nodes/certificate.tscn")

@onready var interaction_area = $InteractionArea2

func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")
	
func _on_interact() -> void:
	var certificate = CERTIFICATE.instantiate()
	add_child(certificate)
