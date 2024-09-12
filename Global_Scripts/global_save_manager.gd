extends Node

const SAVE_PATH = "res://"

const PLAYER_CREATION = preload("res://Character_Creation/player_creation.tscn")

signal GameLoaded
signal GameSaved

var current_save : Dictionary = {
	scene_path = "",
	player = {
		hp = 1,
		max_hp = 1,
		pos_x = 0,
		pos_y = 0
	},
	player_data = {
		player_name = "",
		selected_body = "",
		selected_eyes = "",
		selected_hair = "",
		selected_uniform = "",
		selected_pants = "",
		selected_shoes = "",
		selected_arms = "",
		selected_sleeves = "",
		selected_body_color = "",
		selected_hair_color = "",
		selected_eyes_color = ""
	},
	items = [],
	inventory_items = [],
	persistence = [],
	int_persistence = {},
}

func HasEmptyValues(data: Dictionary) -> bool:
	for key in data.keys():
		if typeof(data[key]) == TYPE_STRING and data[key].strip_edges() == "":
			return true
	return false

func SaveGame(position : Vector2 = Vector2.ZERO) -> void:
	UpdatePlayerData(position)
	UpdateScenePath()
	UpdatePlayerSpriteData()
	UpdateItemData()
	if Global.current_stage == "13":
		UpdateStage13Data()
	var file := FileAccess.open(SAVE_PATH + "toi_save.sav", FileAccess.WRITE)
	var save_json = JSON.stringify(current_save)
	file.store_line(save_json)
	file.close()
	GameSaved.emit()
	pass
	
func SaveOnGameOver(position_index : String) -> void:
	UpdatePlayerDataOnGameOver(position_index)
	UpdateScenePath()
	UpdateItemData()
	if Global.current_stage == "13":
		UpdateStage13Data()
	var file := FileAccess.open(SAVE_PATH + "toi_save.sav", FileAccess.WRITE)
	var save_json = JSON.stringify(current_save)
	file.store_line(save_json)
	file.close()
	GameSaved.emit()
	pass
	
func LoadGame() -> void:
	var save_file_path = SAVE_PATH + "toi_save.sav"
	
	if not FileAccess.file_exists(save_file_path):
		SceneTransition.FadeOut()
		await get_tree().process_frame
		SceneTransition.FadeIn() 
		await get_tree().process_frame
		get_tree().change_scene_to_packed(PLAYER_CREATION)
		return
		
	var file := FileAccess.open(SAVE_PATH + "toi_save.sav", FileAccess.READ)
		
	var json = JSON.new()
	json.parse(file.get_line())
	file.close()
	var save_dict : Dictionary = json.get_data() as Dictionary
	current_save = save_dict
	
	if HasEmptyValues(current_save.player_data):
		SceneTransition.FadeOut()
		await get_tree().process_frame
		SceneTransition.FadeIn() 
		await get_tree().process_frame
		get_tree().change_scene_to_packed(PLAYER_CREATION)
		return

	Global.player_name = current_save.player_data.player_name
	Global.selected_body = current_save.player_data.selected_body
	Global.selected_eyes = current_save.player_data.selected_eyes
	Global.selected_hair = current_save.player_data.selected_hair
	Global.selected_uniform = current_save.player_data.selected_uniform
	Global.selected_pants = current_save.player_data.selected_pants
	Global.selected_shoes = current_save.player_data.selected_shoes
	Global.selected_arms = current_save.player_data.selected_arms
	Global.selected_sleeves = current_save.player_data.selected_sleeves
	Global.selected_body_color = current_save.player_data.selected_body_color
	Global.selected_hair_color = current_save.player_data.selected_hair_color
	Global.selected_eyes_color = current_save.player_data.selected_eyes_color
	
	LevelManager.LoadNewLevel(current_save.scene_path, "", Vector2.ZERO) 
	await LevelManager.LevelLoadStarted
	if not PlayerManager.player:
		PlayerManager.AddPlayerInstance()
	if Vector2(current_save.player.pos_x,current_save.player.pos_y) != Vector2.ZERO:
		PlayerManager.SetPlayerPosition(Vector2(current_save.player.pos_x,current_save.player.pos_y))
	elif current_save.scene_path != "":
		PlayerManager.SetPlayerPosition(Global.default_position[Global.default_scene_idx[current_save.scene_path]])
	PlayerManager.SetHealth(current_save.player.hp, current_save.player.max_hp)
	PlayerManager.SECRET_NOTE_DATA.ParseSaveData(current_save.items)
	await LevelManager.LevelLoaded
	GameLoaded.emit()
	pass
	
func UpdatePlayerData(position : Vector2 = Vector2.ZERO) -> void:
	var p : Player = PlayerManager.player
	if p:
		current_save.player.hp = p.hp
		current_save.player.max_hp = p.max_hp
		if position != Vector2.ZERO:
			current_save.player.pos_x = position.x
			current_save.player.pos_y = position.y
			return
			
		current_save.player.pos_x = p.global_position.x
		current_save.player.pos_y = p.global_position.y
		
func UpdatePlayerDataOnGameOver(position_index : String) -> void:
	var p : Player = PlayerManager.player
	if p:
		current_save.player.hp = p.hp
		current_save.player.max_hp = p.max_hp
		current_save.player.pos_x = Global.default_position[position_index].x
		current_save.player.pos_y = Global.default_position[position_index].y
	
func UpdatePlayerSpriteData() -> void:
	current_save.player_data = {
		player_name = Global.player_name,
		selected_body = Global.selected_body,
		selected_eyes = Global.selected_eyes,
		selected_hair = Global.selected_hair,
		selected_uniform = Global.selected_uniform,
		selected_pants = Global.selected_pants,
		selected_shoes = Global.selected_shoes,
		selected_arms = Global.selected_arms,
		selected_sleeves = Global.selected_sleeves,
		selected_body_color = Global.color_to_hex(Global.selected_body_color),
		selected_hair_color = Global.color_to_hex(Global.selected_hair_color),
		selected_eyes_color = Global.color_to_hex(Global.selected_eyes_color)	
	}

func UpdateScenePath() -> void:
	var p : String = ""
	for c in get_tree().root.get_children():
		if c is Level:
			p = c.scene_file_path
	current_save.scene_path = p
	
func UpdateItemData() -> void:
	current_save.items = PlayerManager.SECRET_NOTE_DATA.GetSaveData()
	
func UpdateStage13Data() -> void:
	current_save.inventory_items = PlayerManager.INVENTORY_DATA.GetSaveData()
	
func IsItemCollected(item_name: String) -> bool:
	for item in current_save.items:
		if item.has("item_name") and item["item_name"] == item_name:
			return true
	return false
	
func ItemCount() -> int:
	var item_count : int = 0
	for item in current_save.items:
		if item.has("item_name") and item.item_name != "":
			item_count += 1
	return item_count

func AddPersistentValue(value : String) -> void:
	if CheckPersistentValue(value) == false:
		current_save.persistence.append(value)
	
func CheckPersistentValue(value : String) -> bool:
	var p = current_save.persistence as Array
	return p.has(value)
	
func AddIntPersistentValue(key: String, value: int) -> void:
	current_save["int_persistence"][key] = value

func GetIntPersistentValue() -> Dictionary:
	return current_save["int_persistence"]

func GetIntPersistentValueByKey(key: String) -> int:
	if current_save["int_persistence"].has(key):
		return current_save["int_persistence"][key]
	return 0
