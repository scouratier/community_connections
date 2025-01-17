extends CenterContainer

enum button_state 
{
	inactive,
	hovered,
	pressed,
	pressed_and_hovered
}

var theme_id = -1
var id = -1

var b_state = button_state.inactive
const card_size: Vector2 = Vector2(140, 90)

@onready var game_manager = get_node("/root/Control/game_manager")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	custom_minimum_size = card_size
	
	var color_rect = ColorRect.new()
	color_rect.color = Color(0.8, 0.8, 0.8)
	color_rect.custom_minimum_size = card_size
	color_rect.name = "color"
	color_rect.mouse_filter = Control.MOUSE_FILTER_PASS
	add_child(color_rect)
	
	var content = Label.new()
	content.name = "label"
	content.modulate = Color(0, 0, 0)
	content.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	content.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	content.custom_minimum_size = card_size
	add_child(content)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if b_state == button_state.hovered:
		$color.modulate = Color(0.7, 0.7, 0.7)
		
	if b_state == button_state.inactive:
		$color.modulate = Color(0.9, 0.9, 0.9)
		$label.modulate = Color(0, 0, 0)
		
	if b_state == button_state.pressed:
		$color.modulate = Color(0.1, 0.1, 0.1)
		$label.modulate = Color(0.9, 0.9, 0.9)
		
	if b_state == button_state.pressed_and_hovered:
		$color.modulate = Color(0.6, 0.6, 0.6)
		
func deselect():
	b_state = button_state.inactive
	$color.modulate = Color(0.9, 0.9, 0.9)
	$label.modulate = Color(0, 0, 0)
	game_manager.reset_guesses()
		
func _on_mouse_entered():
	if b_state == button_state.pressed:
		b_state = button_state.pressed_and_hovered
		return
	b_state = button_state.hovered
	
func _on_mouse_exited():
	if b_state == button_state.pressed:
		return
	if b_state == button_state.pressed_and_hovered:
		b_state = button_state.pressed
		return
	b_state = button_state.inactive
	
func _on_gui_input(event: InputEvent):
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			print("A left button was pressed on card " + $".".name)
		
	if event is InputEventMouseButton and event.is_released():
		if event.button_index == MOUSE_BUTTON_LEFT:
			# can we select this? out of guesses?
			
			if b_state == button_state.hovered or b_state == button_state.inactive:
				if (game_manager.at_four_guesses()):
					return
				game_manager.add_guess($".".id)
				b_state = button_state.pressed
				return
			if b_state == button_state.pressed or b_state == button_state.pressed_and_hovered:
				game_manager.remove_guess($".".id)
				b_state = button_state.hovered
				return
				
		
			
