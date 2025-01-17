extends GridContainer

const side_size: int = 120
const text_size: int = 100

@onready var game_manager = get_node("/root/Control/game_manager")
@onready var play_area = get_node("/root/Control/game_area/play_area")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var shuffle = Button.new()
	add_child(shuffle)
	shuffle.text = "Shuffle"
	shuffle.custom_minimum_size = Vector2(100, 60)
	shuffle.pressed.connect(play_area.shuffle_cards)
	
	var submit = Button.new()
	add_child(submit)
	submit.text = "Submit"
	submit.pressed.connect(game_manager.check_guesses)
	submit.custom_minimum_size = Vector2(120, 90)
	
	var deselect = Button.new()
	add_child(deselect)
	deselect.text = "Deselect All"
	deselect.pressed.connect(play_area.deselect_all)
	deselect.custom_minimum_size = Vector2(100, 60)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
