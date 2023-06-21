extends Node2D

var letter = '';

func _ready():
	get_node("BloonSprite/letterLbl").text = letter;
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
