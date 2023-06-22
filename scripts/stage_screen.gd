extends Node2D

var _stage_num = 0;
var _allowed_keys = [];
var _current_baloons = [];

var bloon_scene = preload("res://scenes/bloon.tscn");

var _hits = 0;
var _lifes = 5;

var interval = 1

var rules = []


func getTextureByColor(color):
	return load("res://resources/images/bloon-"+color+".png")

func getRandomLetter():
	var randomIndex = randi() % _allowed_keys.size()
	return self._allowed_keys[randomIndex]

func add_new_bloon():
	var current_letter = getRandomLetter();
	var bloon_color = getBloonColorByLetter(current_letter)
	var pos = generatePositions();
	var bloon = bloon_scene.instantiate();
	bloon.letter = current_letter;	
	bloon.get_child(0).texture = getTextureByColor(bloon_color);
	bloon.position = pos;
	_current_baloons.append(bloon)
	add_child(bloon)

func update_bloon_position():
	for bloon in _current_baloons:
		bloon.position += Vector2(0, -1)

func read_array():
	var file = FileAccess.open("res://resources/configs/current_stage.txt", FileAccess.READ);
	return file.get_var()

func check_bloon_pos():
	var i = 0;
	for bloon in _current_baloons:
		if(bloon.position.y <= 100):
			_lifes = _lifes - 1;
			_update_life(_lifes)
			_current_baloons.remove_at(i)
			bloon.queue_free()
		i+=1
		
func _ready():
	_allowed_keys = read_array()
	rules = _readBloonColorRulesFromFile();
	get_node("hit").text = "Acertos: " + str(_hits)
	get_node("lastKey").text = "Last key:"

func _process(delta):
	interval = interval - delta;
	if(interval <= 0):
		add_new_bloon();
		interval = 3
	check_bloon_pos()		
	update_bloon_position()
	
func map_key(key):
	if(key == "period"):
		return "."
	if(key == "apostrophe"):
		return "'"
	if(key == "comma"):
		return ","
	if(key == "semicolon"):
		return ";"
	return key
		
func _input(event):
	if !(event is InputEventKey) or !event.is_pressed():
		return;
	var letter = map_key(event.as_text().to_lower());
	get_node("lastKey").text = "Last key:" + letter
	
	if !_allowed_keys.has(letter) && !_current_baloons.has(letter):
		_handle_error(letter);
		return;
	_handle_hit(letter);
		
func _handle_hit(pressed_key):
	var i = 0;
	for b in _current_baloons:
		print("blloon l: ", b.letter)
		if(b.letter == pressed_key):
			print("removendo")
			_current_baloons.remove_at(i)
			b.queue_free()
			_hits = _hits + 1;
			get_node("hit").text = "Acertos: " + str(_hits)
		i += 0

func _handle_error(pressed_key):
	_lifes = _lifes - 1;
	_update_life(_lifes)
	if(_lifes == 0):
		print("GAME OVER")

func _update_life(lifes):
	var hearts = $HBoxContainer.get_children();
	var i = 0
	for h in hearts:
		if i > lifes:
			h.texture = load("res://resources/icons/outline-heart.png")
		i+=1
		
func generatePositions():
	var y = 680
	var xPos = randi() % int(get_viewport().get_visible_rect().size.x - 30);
	return Vector2(xPos, y)
	
func getBloonColorByLetter(letter):
	for rule in rules:
		if letter in rule["letters"]:
			return rule["color"]
			
func _readBloonColorRulesFromFile():
	var file = FileAccess.open("res://resources/configs/bloons.json", FileAccess.READ);
	var file_lines = "";
	var json = JSON.new();
	
	while file.get_position() < file.get_length():
		file_lines += file.get_line()
		
	var parse_result = json.parse(file_lines);
	if not parse_result == OK:
		print("JSON Parse Error: ", json.get_error_message(), " in ", file_lines, " at line ", json.get_error_line())
		return [];
	return json.get_data()

func define_allowed_key(allowed_keys):
	_allowed_keys = allowed_keys
