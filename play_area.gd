extends GridContainer

var card = preload("res://card.tscn")
var cards = []
@onready var game_manager = %game_manager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cards.resize(16)
	var all_data = game_manager.get_all_cards()
	
	var i = 0
	for card_data in all_data:
		var thing = card.instantiate()
		add_child(thing)
		thing.name = card_data.label
		thing.get_node("label").text = card_data.label
		thing.theme_id = card_data.theme_id
		thing.id = card_data.id
		cards[i] = thing
		i += 1
		
	shuffle_cards()
	
func shuffle_cards():
	for i in range(cards.size() - 1, 0, -1):
		var j = floor(randf() * (i + 1))
		var temp = cards[i]
		move_child(cards[j], i)
		cards[i] = cards[j]
		cards[j] = temp
		
func deselect_all():
	for card in cards:
		card.deselect()
	
func delete_cards(theme_id):
	var children = get_children()
	for child in children:
		if child.theme_id == theme_id:
			remove_child(child)
			
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
