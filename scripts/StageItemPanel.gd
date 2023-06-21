extends Panel


func constructor(_stage_num, _stage_name, _allowed_keys):
	get_node("StageNameLbl").text = _stage_name;
	get_node("StageNumLbl").text = str(_stage_num);
	get_node("StartBtn").allowed_key = _allowed_keys;
