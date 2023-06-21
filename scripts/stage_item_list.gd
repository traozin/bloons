extends Control

func constructor(_stage_num, _stage_name, _allowed_keys):
	get_node("StageItemPanel/StageNameLbl").text = _stage_name;
	get_node("StageItemPanel/StageNumLbl").text = str(_stage_num);
	get_node("StageItemPanel/StartBtn").allowed_key = _allowed_keys;

