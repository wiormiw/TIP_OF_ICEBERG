class_name SecretNoteUI extends Control

const SECRET_NOTE_SLOT = preload("res://GUI/pause_menu/secret_note_ui/secret_note_slot.tscn")

@export var data : SecretNoteData

func _ready() -> void:
	PauseMenu.Shown.connect(UpdateSecretNote)
	PauseMenu.Hidden.connect(ClearSecretNote)
	Global.DoneAccessSecretNote.connect(SetFocusBack)
	ClearSecretNote()
	pass
	
func ClearSecretNote() -> void:
	for c in get_children():
		c.queue_free()
		
func UpdateSecretNote() -> void:
	for s in data.slots:
		var new_slot = SECRET_NOTE_SLOT.instantiate()
		add_child(new_slot)
		new_slot.secret_note_slot_data = s 
		
	get_child(0).grab_focus()
	
func SetFocusBack() -> void:
	get_child(0).grab_focus()

	

