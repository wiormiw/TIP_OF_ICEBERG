extends CanvasLayer

const GAME_OVER = preload("res://Assets/Audio/game_over.wav")

signal FromGameOver

var max_hp : int

@onready var texture_button = $Panel/TextureButton
@onready var audio_stream_player = $AudioStreamPlayer	

func _ready() -> void:
	HideGameOverMenu()
	pass

func _on_texture_button_pressed() -> void:
	HideGameOverMenu()
	FromGameOver.emit()
	Loading.ShowLoading()
	LevelManager.LoadNewLevel(SaveManager.current_save.scene_path, "", Vector2.ZERO) 
	await LevelManager.LevelLoadStarted
	PlayerManager.SetPlayerPosition(Vector2(SaveManager.current_save.player.pos_x,SaveManager.current_save.player.pos_y))
	PlayerManager.SetHealth(6, 6)
	await get_tree().process_frame
	Loading.HideLoading()
	if Inventory.visible == false:
		Inventory.visible = true
	pass

func SaveOnGameOver(reset_position_index : String) -> void:
	SaveManager.SaveOnGameOver(reset_position_index)
	
func _on_game_over(reset_position_index : String) -> void:
	ShowGameOverMenu()
	if SaveManager.current_save.scene_path == "" \
	&& Vector2(SaveManager.current_save.player.pos_x, SaveManager.current_save.player.pos_y) == Vector2.ZERO:
		SaveOnGameOver(reset_position_index)
	if Inventory.visible == true:
		Inventory.HideInventory()
	texture_button.disabled = true
	audio_stream_player.stream = GAME_OVER
	audio_stream_player.play(0)
	await audio_stream_player.finished
	texture_button.disabled = false

func ShowGameOverMenu() -> void:
	get_tree().paused = true
	visible = true
	
func HideGameOverMenu() -> void:
	get_tree().paused = false
	visible = false
