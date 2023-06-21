extends Control

var stage_item_list = preload("res://scenes/stage_item_list.tscn")

func _toStageItemList(current_stage):
	var stage = stage_item_list.instantiate();
	stage.constructor(current_stage["number"], "Fase", current_stage["letters"])
	return stage
	
func _readStagesListFromFile():
	var file = FileAccess.open("res://resources/configs/stages.json", FileAccess.READ);
	var file_lines = "";
	var json = JSON.new();

	while file.get_position() < file.get_length():
		file_lines += file.get_line()
		
	var parse_result = json.parse(file_lines);
	if not parse_result == OK:
		print("JSON Parse Error: ", json.get_error_message(), " in ", file_lines, " at line ", json.get_error_line())
		return [];
	return json.get_data()

func _listAllStages(stages_json):
	var grid = $ScrollContainer/GridContainer
	grid.set_columns(5);

	for current_stage_dict in stages_json:
		var stage = _toStageItemList(current_stage_dict);
		grid.add_child(stage);
		

func _ready():
	_listAllStages(_readStagesListFromFile());
