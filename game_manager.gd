extends Node

class connection:
	var id = -1
	var theme = ""
	var theme_id = -1
	var label = ""
	var selected = false
	
	func _init(in_id, in_theme_id, in_theme, in_label):
		self.id = in_id
		self.theme = in_theme
		self.theme_id = in_theme_id
		self.label = in_label
				
var connections = Array()
var guesses = 0
@onready var play_area = get_node("/root/Control/game_area/play_area")
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var test_group1 = ["Sudafed", "Lemsip", "Tissue", "Robotussin"]
	var test_group2 = ["Orlando", "Veinna", "New York", "San Francisco"]
	var test_group3 = ["Clermont Ferrand", "Houston", "Svannah", "Lyons"]
	var test_group4 = ["Khal", "Robert", "Jaime", "Robb"]
	
	add_group("Cold Meds", test_group1)
	add_group("Conference Cities", test_group2)
	add_group("Familly Cities", test_group3)
	add_group("Dead of Thrones", test_group4)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func get_all_cards():
	return connections
	
func at_four_guesses():
	if guesses == 4:
		return true
	return false

func add_guess(id):
	print("Added a guess " + str(id))
	for con in connections:
		if con.id == id:
			con.selected = true
	guesses += 1
	
func remove_guess(id):
	print("Removed guess " + str(id))
	for con in connections:   
		if con.id == id:
			con.selected = false
	guesses -= 1

func reset_guesses():
	for con in connections:
		con.selected = false	
	guesses = 0
	
func check_guesses():
	if guesses == 4:
		print("Checking guesses")
		var theme_id_checker = -1
		for con in connections:
			if con.selected:
				if theme_id_checker == -1:
					theme_id_checker = con.theme_id
					continue
				if theme_id_checker != con.theme_id:
					print("WRONG")
					return false
				print(con.label + " " + str(con.id) + " " + str(con.theme_id) + " "+ str(con.selected))
		print("FOUND A MATCH!")
		play_area.delete_cards(theme_id_checker)
		reset_guesses()
		return true
	print("You need to select 4 cards before guessing")
	return false

func add_group(theme, labels):
	var theme_id = connections.size() / 4
	var i = 0
	for label in labels:
		var id = theme_id * 10 + i
		connections.append(connection.new(id, theme_id, theme, label))
		i += 1
	

	
