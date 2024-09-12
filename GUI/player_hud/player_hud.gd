extends CanvasLayer

var hearts : Array[HeartGUI] = []

func _ready() -> void:
	for child in $Control/HFlowContainer.get_children():
		if child is HeartGUI:
			hearts.append(child)
			child.visible = false
	pass	

func UpdateHP(_hp : int, _max_hp: int) -> void:
	UpdateMaxHP(_max_hp)
	for i in range(len(hearts)):
		UpdateHeart(i, _hp)
		pass
	pass
	
func UpdateHeart(_index : int, _hp : int) -> void:
	var _value : int = clampi(_hp - _index * 2, 0, 2)
	hearts[_index].value = _value
	pass
	
func UpdateMaxHP(_max_hp : int) -> void:
	var _heart_count : int = round(_max_hp * 0.5) 
	for i in range(len(hearts)):
		if i < _heart_count:
			hearts[i].visible = true
		else:
			hearts[i].visible = false
	pass
