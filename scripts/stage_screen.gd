extends Node2D

var _stage_num = 0;
var _allowed_keys = [];
var _current_baloons = [];

var _hits = 0;
var _lifes = 5;

func _ready():
	pass 

func _process(delta):
	pass

func _input(event):
	if !(event is InputEventKey) or !event.is_pressed():
		return;
	var letter = event.as_text();
	print(letter)
	if !_allowed_keys.has(letter) && !_current_baloons.has(letter):
		_handle_error(letter);
		return;
	_handle_hit(letter);
		
func _handle_hit(pressed_key):
	_hits = _hits + 1;
	pass;
func _handle_error(pressed_key):
	_lifes = _lifes - 1;
	_update_life(_lifes)
	pass

func _update_life(lifes):
	var hearts = $HBoxContainer.get_children();
	var i = 0
	for h in hearts:
		if i > lifes:
			h.texture = load("res://resources/icons/outline-heart.png")
		i+=1


func define_allowed_key(allowed_keys):
	self._allowed_keys = allowed_keys
