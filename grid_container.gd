extends GridContainer

var card = preload("res://card.tscn")

const side_size: int = 120
const text_size: int = 100
var cards = Array()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cards.resize(16)
	
	for n in cards.size():
		var thing = card.instantiate()
		add_child(thing)
		cards[n] = thing
		thing.name = str(n)
		thing.get_child(1).text = str(n)
		
	shuffle_cards()
	
func shuffle_cards():
	for i in range(cards.size() - 1, 0, -1):
		print(i)
		var j = floor(randf() * (i + 1))
		print(j)
		var temp = cards[i]
		move_child(cards[j], i)
		cards[i] = cards[j]
		cards[j] = temp
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
