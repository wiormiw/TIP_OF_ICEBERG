class_name NameLabel extends RichTextLabel

const MAX_LENGTH : int = 34

@onready var display_text : String = ""
@onready var text_edit : TextEdit = $"../../Details/TextEdit"

func _ready() -> void:
	clear()
	set_process(true)

func _process(_delta) -> void:
	update_display_text()
	
func update_display_text() -> void:
	if display_text.length() > MAX_LENGTH:
		display_text = display_text.substr(0, MAX_LENGTH - 3) + "..."
	set_text("[center]" + display_text + "[/center]")

func _on_text_edit_text_changed() -> void:
	display_text = text_edit.get_text()
	if display_text == "":
		display_text = "PLEASE ENTER THE NAME!"
	update_display_text()
