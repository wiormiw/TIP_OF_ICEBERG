class_name Level extends Node2D

var emit_index : String = ""

var scene_to_index = {
	"StageIntro": "01",
	"Stage0": "02",
	"Stage1": "03",
	"Stage2": "04",
	"Stage3": "05",
	"Stage4": "06",
	"Stage5": "07",
	"Stage6": "08",
	"Stage7": "09",
	"Stage8": "10",
	"Stage9": "11",
	"Stage10": "12",
	"Stage11": "13",
	"ChestRoomA1": "14",
	"ChestRoomA2": "15",
	"ChestRoomA3": "16",
	"ChestRoomA4": "17",
	"ChestRoomA5": "18",
	"ChestRoomA6": "19",
	"ChestRoomA7": "20",
	"ChestRoomA8": "21",
	"ChestRoomA9": "22",
	"ChestRoomA10": "23",
	"ChestRoomA11": "24",
	"PreStage0-1": "25",
	"PreStage0-2": "26",
	"Lorong" : "27",
	"HallOfFame" : "28"
}

func _ready() -> void:
	Inventory.HideInventory()
	self.y_sort_enabled = true
	var scene_name = get_tree().current_scene.name
	emit_index = get_emit_index(scene_name)
	
	if emit_index:
		Global.current_stage = emit_index
		SaveManager.SaveGame(Global.default_position[emit_index])
		Global.GlobalPositionReset.emit(emit_index)
		if emit_index == "13":
			Inventory.ShowInventory()
			
	LevelManager.LevelLoadStarted.connect(_free_level)
	GameOver.FromGameOver.connect(_from_game_over)
	PlayerManager.SetAsParent(self)

func get_emit_index(scene_name: String) -> String:
	return scene_to_index.get(scene_name, Vector2.ZERO)

func _free_level() -> void:
	PlayerManager.UnparentPlayer(self)
	queue_free()
	
func _from_game_over() -> void:
	PlayerManager.AddPlayerInstance()
	PlayerManager.SetAsParent(self)
