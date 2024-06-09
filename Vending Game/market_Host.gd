extends Node2D

var player_number = 0
var player_tracker = []
var spacing = 200
var card_detected = false
var bottle_list = []
var number = 0
var client_tester = 0
var re_roll_balance = 10
var Item_count = 0
#var on_item = false
var once = false
var held = false
var card_formed = false
var hmm = false
var new_sprite = preload("res://new_sprite.tscn").instantiate()
func _ready():
	$Lobby_bg.play("default")
	get_tree().root.get_node("World").user_detected.connect(New_user_window_creation)
	$Camera2D.zoom = Vector2(0.945,0.945)
	for i in range(0,10):
		$OptionButton.add_item("$ " + str(i), i)
	$Bunny_Sprite.play("default")
	$Re_Roll_balance.text = ("Re-Roll-Balance: " + str(re_roll_balance))
func New_user_window_creation():
	player_number += 1
	if len(get_node("Window_container").get_children()) == 0:
		var window = Window.new()
		window.position.x = 200
		window.position.y = 200
		window.size = Vector2(400,400)
		window.name = str(GameManager.Players.keys()[player_number-1])
		var player_inserted_name = str(GameManager.Players[GameManager.Players.keys()[player_number-1]]['name'])
		window.title = ("player " + player_inserted_name + " (" + str(GameManager.Players.keys()[player_number-1]) + ")")
		player_tracker.append([player_number,GameManager.Players.keys()[player_number-1]])
		get_node("Window_container").add_child(window)
		var sprite = preload("res://new_sprite.tscn").instantiate()
		
		window.add_child(sprite)
		
	# Client Players Creation
	elif len(get_node("Window_container").get_children()) < len(GameManager.Players.keys()):
		var window = Window.new()
		window.position.x = get_node("Window_container").get_children()[-1].position.x + 200
		window.position.y = 200
		window.size = Vector2(400,400)
		window.name = str(GameManager.Players.keys()[player_number-1])
		var player_inserted_name = str(GameManager.Players[GameManager.Players.keys()[player_number-1]]['name'])
		window.title = ("player: " + player_inserted_name + " (" + str(GameManager.Players.keys()[player_number-1]) + ")")
		player_tracker.append([player_number,GameManager.Players.keys()[player_number-1]])
		get_node("Window_container").add_child(window)
		var sprite = preload("res://new_sprite.tscn").instantiate()
		window.add_child(sprite)
func _process(delta):
	
	window_text_live_updates()
	#print(player_tracker)
	#print(GameManager.Bottle_data)
	"""
	if len(GameManager.Bottle_data) != 0:
		print(GameManager.Bottle_data[0])
		"""
	if card_detected == true and Input.is_action_just_pressed("left_click") and card_formed == false:
		Item_count += 1
		var card_sprite = preload("res://new_sprite.tscn").instantiate()
		card_sprite.name = "fruit_sprite" + str(Item_count)
		card_sprite.position = Vector2(0,0)
		get_node("Item_Container").add_child(card_sprite)
		card_formed = true
		$AnimationPlayer.play("Flipping_anim")
	elif card_formed == true and Input.is_action_just_pressed("left_click") and card_detected == true:
		$AnimationPlayer.play("Flipping_anim")
	"""
	if on_item == true and Input.is_action_just_pressed("left_click"):
		held = true
	elif Input.is_action_just_released("left_click"):
		held = false
	
	if held == true:
		for i in $GoldCard.get_children():
			if i.name == "fruit_sprite":
				var pos = get_viewport().get_mouse_position()
				i.position.x = pos.x + 1550
				i.position.y = pos.y
	elif held == false:
		for i in $GoldCard.get_children():
			if i.name == "fruit_sprite":
				i.position.x = 2100
				i.position.y = 400
				"""
	#print(bottle_list)
	#print(GameManager.Bottle_data)
	#print($OptionButton.selected)
	#print(GameManager.Players)
	#print(on_item)
	if GameManager.on_item and Input.is_action_just_pressed("left_click"):
		held = true
	elif Input.is_action_just_released("left_click") and GameManager.on_item:
		held = false
		for i in $Item_Container.get_children():
			if i.name == "fruit_sprite" + str(Item_count):
				i.position = Vector2(0,0)
	if held == true:
		for i in $Item_Container.get_children():
			if i.name == "fruit_sprite" + str(Item_count):
				var pos = get_global_mouse_position()
				i.global_position = pos
func _on_area_2d_mouse_entered():
	print("hmmmmm?")
	card_detected = true


func _on_area_2d_mouse_exited():
	print("out_of_it")
	card_detected = false
	
@rpc("any_peer","call_local")
func testing(client_id,random_num):
	number = random_num
	bottle_list.append(number)
	GameManager.Bottle_data[client_id] = bottle_list[-1]
	print(GameManager.Bottle_data)
	print(bottle_list)
	if typeof(client_id) == TYPE_INT:
		print("inting")


# this code needs an optimization (UGLY CODE)
func window_text_live_updates():
	for wdow_id in $Window_container.get_children():
		# if assigned client id in window is in Player's keys,
		if wdow_id.name in str(GameManager.Players.keys()):
			#iterate through the children of those ids -> should be label on individual window as a child
			for label in wdow_id.get_children():
				var integer_wdow_name = int(str(wdow_id.name))
				#if len bottle data is same as the connected players from the server, 
				for i in len(GameManager.Bottle_data.keys()):
					if GameManager.Bottle_data.keys()[i] == integer_wdow_name:
						# "String Name" type is converted into integer + add text on individual windows
						# Text should currently show the corresponding bottle that player rolled.
						label.frame = GameManager.Bottle_data[integer_wdow_name]
						label.show()

func _on_button_2_pressed():
	$Camera2D2.make_current()
	if len($Window_container.get_children()) >0:
		for wdow in $Window_container.get_children():
			wdow.hide()
	else:
		pass

func _on_trading_back_btn_pressed():
	$Camera2D.make_current()
	if len($Window_container.get_children()) >0:
		for wdow in $Window_container.get_children():
			wdow.show()
	else:
		pass

func re_roll():
	var random = RandomNumberGenerator.new()
	var random_num = random.randi_range(1,170)
	for i in $Item_Container.get_children():
		if i.name == "fruit_sprite" + str(Item_count):
			i.frame = random_num
			i.show()


func _on_area_2d_body_entered(body):
	print(body)



func _on_first_area_area_entered(area):
	card_formed = false
	for i in $Item_Container.get_children():
		if i.name == "fruit_sprite"+str(Item_count):
			i.global_position = $Item_Position_Container/First_Item_space.global_position


func _on_second_area_area_entered(area):
	card_formed = false
	for i in $Item_Container.get_children():
		if i.name == "fruit_sprite" + str(Item_count):
			i.global_position = $Item_Position_Container/Second_Item_space.global_position
