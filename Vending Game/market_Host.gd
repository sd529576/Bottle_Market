extends Node2D

var player_number = 0
var player_tracker = []
var spacing = 200
var card_detected = false
var bottle_list = []
var number = 0
var client_tester = 0
var re_roll_balance = 10
var re_roll_gain = 0
var Item_count = 0
var on_item = false
var once = false
var held = false
var card_formed = false
var hmm = false
var new_sprite = preload("res://new_sprite.tscn").instantiate()
var market = preload("res://market.tscn").instantiate()
var item_placed = false
signal Book_Anim_sig
func _ready():
	get_tree().root.get_node("World").user_detected.connect(New_user_window_creation)
	$Host_Lobby.zoom = Vector2(0.945,0.945)
	for i in range(0,10):
		$OptionButton.add_item("$ " + str(i), i)
	$Bunny_Sprite.play("default")
	
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
	#print("server_item_data: " + str(GameManager.Server_item_data))
	#print("reroll balance " + str(re_roll_balance))
	#print(GameManager.Shiny_Container)
	#print(GameManager.Server_item_data)
	if Input.is_action_just_pressed("re_roll_coin"):
		get_node("Marker2D").popup()
	"""
	print("length of server_item_data: " + str(len(GameManager.Server_item_data)))
	print("Item_count: " + str(Item_count))
	print(card_formed)
	"""
	window_text_live_updates()
	card_shuffle()
	Item_mouse_movement()
	
	if $Host_Lobby.is_current():
		if len($Window_container.get_children()) >0:
			for wdow in $Window_container.get_children():
				wdow.show()
	else:
		if len($Window_container.get_children()) >0:
			for wdow in $Window_container.get_children():
				wdow.hide()
				
	$Re_Roll_balance.text = ("Re-Roll-Balance: " + str(re_roll_balance))
func _on_area_2d_mouse_entered():
	card_detected = true


func _on_area_2d_mouse_exited():
	card_detected = false
	
@rpc("any_peer","call_local")
func testing(client_id,random_num):
	number = random_num
	bottle_list.append(number)
	GameManager.Bottle_data[client_id] = bottle_list[-1]


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
						label.position = Vector2(200,100)
						label.show()

func _on_trade_pressed():
	$Trade_Lobby.make_current()

func _on_trading_back_btn_pressed():
	$Host_Lobby.make_current()
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

func card_shuffle():
	if card_detected == true and Input.is_action_just_pressed("left_click") and card_formed == false and re_roll_balance > 0:
		Item_count += 1
		var card_sprite = preload("res://new_sprite.tscn").instantiate()
		card_sprite.name = "fruit_sprite" + str(Item_count)
		card_sprite.position = Vector2(0,0)
		get_node("Item_Container").add_child(card_sprite)
		card_formed = true
		$AnimationPlayer.play("Flipping_anim")
		re_roll_balance = re_roll_balance-1
		randomizer()
func Item_mouse_movement():
	if Input.is_action_just_pressed("left_click") and on_item == true:
		held = true
	elif Input.is_action_just_released("left_click"):
		held = false
		
	if held == true:
		for i in $Item_Container.get_children():
			if i.name == i.self_name:
				var pos = get_global_mouse_position()
				i.global_position = pos
				
	if len(GameManager.Server_item_data) == 0 and Item_count > len(GameManager.Server_item_data):
		for i in $Item_Container.get_children():
			if Item_count < len($Item_Container.get_children()):
				i.name = "fruit_sprite" + str(Item_count)
				Item_count += 1
			elif Item_count == len($Item_Container.get_children()):
				i.name = "fruit_sprite"+ str(Item_count)
				
func _on_area_2d_body_entered(body):
	print(body)



func _on_first_area_area_entered(area):
	card_formed = false
	for i in $Item_Container.get_children():
		if i.name == "fruit_sprite1":
			i.global_position = $Item_Position_Container/First_Item_space.global_position
			GameManager.Server_item_data[i.name] = i.frame
func _on_second_area_area_entered(area):
	card_formed = false
	for i in $Item_Container.get_children():
		if i.name == "fruit_sprite2":
			i.global_position = $Item_Position_Container/Second_Item_space.global_position
			GameManager.Server_item_data[i.name] = i.frame
			
func _on_third_area_area_entered(area):
	card_formed = false
	for i in $Item_Container.get_children():
		if i.name == "fruit_sprite3":
			i.global_position = $Item_Position_Container/Third_Item_Space.global_position
			GameManager.Server_item_data[i.name] = i.frame
			
func _on_fourth_area_area_entered(area):
	card_formed = false
	for i in $Item_Container.get_children():
		if i.name == "fruit_sprite4":
			i.global_position = $Item_Position_Container/Fourth_Item_Space.global_position
			GameManager.Server_item_data[i.name] = i.frame
@rpc("any_peer","call_local")
func offer(Server_item_data,money,shiny_container):
	pass
		
func _on_offer_button_pressed():
	if len(GameManager.Server_item_data) > 0:
		for i in GameManager.Server_item_data.keys():
			for j in $Item_Container.get_children():
				if i == str(j.name) and len(j.get_children()) == 1:
					j.queue_free()
				elif i == str(j.name) and len(j.get_children()) == 2:
					GameManager.Shiny_Container.append([str(i),"True"])
					j.queue_free()
				#elif i == str(j.name) and j.
		#length of server item data gives the remainder of the items left for the server after offering.
		if len(GameManager.Players.keys()) == 1:
			$Player1_Offer.disabled = false
		elif len(GameManager.Players.keys()) == 2:
			$Player1_Offer.disabled = false
			$Player2_Offer.disabled = false
	#print(GameManager.Server_item_data)
	#GameManager.Server_item_data = {}
# only show to player1 at the current moment by unabling the player 1 button.
# still need to figure out how to get an option to choose which player to offer.

func _on_player_1_offer_pressed():
	rpc_id(GameManager.Players.keys()[0],"offer",GameManager.Server_item_data,$OptionButton.selected,GameManager.Shiny_Container)
	Item_count -= len(GameManager.Server_item_data)
	GameManager.Server_item_data = {}
	GameManager.Shiny_Container = []
	$Player1_Offer.disabled = true
func _on_player_2_offer_pressed():
	rpc_id(GameManager.Players.keys()[1],"offer",GameManager.Server_item_data,$OptionButton.selected,GameManager.Shiny_Container)
	Item_count -= len(GameManager.Server_item_data)
	GameManager.Server_item_data = {}
	GameManager.Shiny_Container = []
	$Player2_Offer.disabled = true
func _on_timer_timeout():
	var random = RandomNumberGenerator.new()
	var random_num = random.randi_range(1,3)
	if random_num == 1:
		$SpeechBubble/RichTextLabel.text = "Click Trade button to offer player some items!"
	elif random_num == 2:
		$SpeechBubble/RichTextLabel.text = "Welcome to the Host Lobby!"
	elif random_num == 3:
		$SpeechBubble/RichTextLabel.text = "Check out the Sprite Dictionary to see what's worth it!"
	#print($Timer.time_left)

@rpc("any_peer","call_local")
func shiny_Identification(shiny_container):
	pass

@rpc("any_peer","call_local")
func moneyandreroll_transaction(money):
	if money > 4:
		re_roll_gain = 2
		re_roll_balance += re_roll_gain
	elif money < 5:
		re_roll_gain = 1
		re_roll_balance += re_roll_gain
	get_node("Marker2D").popup()
func randomizer():
	var random = RandomNumberGenerator.new()
	var random_num = random.randi_range(1,4)
	if random_num == 3:
		var particle = preload("res://Rare_Item_Particle.tscn").instantiate()
		get_node("Item_Container/fruit_sprite" + str(Item_count)).add_child(particle)


func _on_dictionary_btn_pressed():
	$Dictionary/Dictionary_Lobby.make_current()
	Book_Anim_sig.emit()
	
