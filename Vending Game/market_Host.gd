extends Node2D

var player_number = 0
var player_tracker = []
var spacing = 200
var On_card = false
var bottle_list = []
var number = 0
var client_tester = 0

func _ready():
	$AnimatedSprite2D2.play("default")
	get_tree().root.get_node("World").user_detected.connect(New_user_window_creation)
func New_user_window_creation():
	#print(GameManager.Players)
	#print(GameManager.Players)
	player_number += 1
	if len(get_node("Window_container").get_children()) == 0:
		var window = Window.new()
		window.position.x = 200
		window.position.y = 200
		window.size = Vector2(400,400)
		window.name = str(GameManager.Players.keys()[player_number-1])
		window.title = ("player " + str(player_number) + " (" + str(GameManager.Players.keys()[player_number-1]) + ")")
		player_tracker.append([player_number,GameManager.Players.keys()[player_number-1]])
		get_node("Window_container").add_child(window)
		var text_box = RichTextLabel.new()
		text_box.scale.x = 2
		text_box.scale.y = 2
		text_box.z_index = 2
		text_box.size.x = 200
		text_box.size.y = 200
		window.add_child(text_box)
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
	#print(player_tracker)
	#print(GameManager.Bottle_data)
	"""
	if len(GameManager.Bottle_data) != 0:
		print(GameManager.Bottle_data[0])
		"""
	if On_card == true and Input.is_action_just_pressed("Rotate"):
		$AnimationPlayer.play("Flipping_anim")
	for i in $Window_container.get_children():
		"""
		print(i.name)
		print(GameManager.Players.keys())
		"""
		if i.name in str(GameManager.Players.keys()):
			for j in i.get_children():
				#print(j)
				if len(GameManager.Bottle_data) > 0:
					var hmm = int(str(i.name))
					j.text = str(GameManager.Bottle_data[hmm])
	#print(bottle_list)
func _on_area_2d_mouse_entered():
	print("hmmmmm?")
	On_card = true


func _on_area_2d_mouse_exited():
	print("out_of_it")
	On_card = false
	
@rpc("any_peer","call_local")
func testing(client_id,random_num):
	number = random_num
	bottle_list.append(number)
	GameManager.Bottle_data[client_id] = bottle_list[-1]
	print(GameManager.Bottle_data)
	print(bottle_list)
	if typeof(client_id) == TYPE_INT:
		print("inting")
