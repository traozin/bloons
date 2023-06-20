extends TextureButton

var allowed_key = [];

func _pressed():
	var stage = load("res://scenes/stage_screen.tscn");
	var screen = stage.instantiate();
	screen.define_allowed_key(self.allowed_key);
	get_tree().change_scene_to_packed(stage);
