class_name ItemSecretNote extends ItemEffect

@export var secret_note_content_idx : String

func Use() -> void:
	Global.secret_note_content_idx = secret_note_content_idx
	pass
	
