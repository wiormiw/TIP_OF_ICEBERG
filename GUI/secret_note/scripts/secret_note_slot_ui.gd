class_name SecretNoteSlotUI extends TextureButton

const SECRET_NOTE = preload("res://GUI/secret_note/secret_notes_content.tscn")

var secret_note_slot_data : SlotData : set = SetSecretNoteSlotData

@onready var texture_rect = $TextureRect

func _ready() -> void:
	texture_rect.texture = null
	focus_entered.connect(SecretNoteFocused)
	focus_exited.connect(SecretNoteUnfocused)
	pressed.connect(SecretNoteContentShow)
	
func SetSecretNoteSlotData(value : SlotData) -> void:
	secret_note_slot_data = value
	if secret_note_slot_data == null:
		return
	texture_rect.texture = secret_note_slot_data.item_data.texture
	
func SecretNoteFocused() -> void:
	if secret_note_slot_data != null:
		if secret_note_slot_data.item_data != null:
			PauseMenu.UpdateSecretNoteDescription(secret_note_slot_data.item_data.description)
	pass
	
func SecretNoteUnfocused() -> void:
	PauseMenu.UpdateSecretNoteDescription("")
	pass
	
func SecretNoteContentShow() -> void:
	if secret_note_slot_data:
		if secret_note_slot_data.item_data:
			secret_note_slot_data.item_data.Use()
			var current_secret_note = SECRET_NOTE.instantiate()
			add_child(current_secret_note)
			if Global.secret_note_content_idx != "":
				current_secret_note._update_texture(Global.secret_note_collection[Global.secret_note_content_idx])
