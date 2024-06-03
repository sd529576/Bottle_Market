extends Node2D

var player_number = 0
var player_tracker = []
var spacing = 200
var On_card = false

func _ready():
	$AnimatedSprite2D2.play("default")
	get_tree().root.get_node("World").user_detected.connect(New_user_window_creation)
func New_user_window_creation():
	#print(GameManager.Players)
	player_number += 1
	if len(get_node("Window_container").get_children()) == 0:
		var window = Window.new()
		window.position.x = 200
		window.position.y = 200
		window.size = Vector2(400,400)
		window.title = ("player " + str(player_number) + " (" + str(GameManager.Players.keys()[player_number-1]) + ")")
		player_tracker.append([player_number,GameManager.Players.keys()[player_number-1]])
		get_node("Window_container").add_child(window)
	# Client Players Creation
	elif len(get_node("Window_container").get_children()) < len(GameManager.Players.keys()):
		var window = Window.new()
		window.position.x = get_node("Window_container").get_children()[-1].position.x + 200
		window.position.y = 200
		window.size = Vector2(400,400)
		window.title = ("player " + str(player_number) + " (" + str(GameManager.Players.keys()[player_number-1]) + ")")
		player_tracker.append([player_number,GameManager.Players.keys()[player_number-1]])
		get_node("Window_container").add_child(window)
"""
	for i in GameManager.Players.keys():
		if i == 1:
			var window = Window.new()
			window.position.x = 200
			window.position.y = 200
			window.size = Vector2(400,400)
			player_number += 1
			window.title = ("player " + "1")
			get_node("Window_container").add_child(window)
		else:
			var window = Window.new()
			window.position.x = get_node("Window_container").get_children()[-1].position.x + 200
			window.position.y = 200
			window.size = Vector2(400,400)
			player_number += 1
			window.title = ("player " + str(i))
			get_node("Window_container").add_child(window)
	print(GameManager.Players, "??")
	
	
	if player_number == 1:
		window.title = ("player " + str(player_number))
		player_tracker.append(("player " + str(player_number)),GameManager.players[1])
	#Still need to figure out how to label rest of the players, first player was easy since it was already labeled as first
	else:
		window.title = ("player " + player_number)
		player_tracker.append([("player " + str(player_number)),GameManager.Players[player_number-1]])
	get_node("Window_container").add_child(window)
	print(player_tracker)
"""
func _process(delta):
	"""
	if len(GameManager.Bottle_data) != 0:
		print(GameManager.Bottle_data[0])
		"""
	if On_card == true and Input.is_action_just_pressed("Rotate"):
		$AnimationPlayer.play("Flipping_anim")
	
func _on_area_2d_mouse_entered():
	print("hmmmmm?")
	On_card = true


func _on_area_2d_mouse_exited():
	print("out_of_it")
	On_card = false
	
