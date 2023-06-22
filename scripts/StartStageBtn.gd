extends TextureButton

var allowed_key = [];

func _pressed():
	var stage = load("res://scenes/stage_screen.tscn");
	var screen = stage.instantiate();
	save_array(allowed_key)
	get_tree().change_scene_to_packed(stage);



func save_array(array):
	print("salvando")
	var file = FileAccess.open("res://resources/configs/current_stage.txt", FileAccess.WRITE);
	file.store_var(array);
