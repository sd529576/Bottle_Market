extends Node2D

var default
var Bottle_dict = {}
var called = false
var number = 0
var bottle_list = []
var server_item_data_client = {} # organizes offered items into fruit_sprite# = sprite_number
var offer_list_with_values = {} # organizes the number of offer and sprites that belong to each offer #
var Offer_number = 0
var money_offered = 0
var Shiny_container = []
var item_counter = 0
var balance = 20
var offer_counter = 0
var Collection = []
signal New_bottle_sig

func _ready():
	$Background_animation.play("default")
	$Main_Lobby.make_current()
#@rpc('any_peer',"call_local")
func host_animation():
	$Vending_Machine_anim.play("Main_Animation")
func _on_roll_pressed():
	if balance - 3 > 0:
		host_animation()
		var random = RandomNumberGenerator.new()
		var random_num = random.randi_range(1,170)
		rpc_id(1,"testing",multiplayer.get_unique_id(),random_num)
		testing(multiplayer.get_unique_id(),random_num)
		"""
		var selling_item = preload("res://description_sprite.tscn").instantiate()
		#[1,3]
		if len(bottle_list) > 0 and item_counter <3:
			selling_item.frame = bottle_list[item_counter]
			selling_item.scale = Vector2(1.5,1.5)
			selling_item.show()
			get_node("Local_Store/Item"+str(item_counter+1)).add_child(selling_item)
		item_counter += 1
		"""
		balance -= 3
	#print(GameManager.Bottle_data)
func _physics_process(delta):
	#print(GameManager.Bottle_data)
	#print(bottle_list)
	#print(item_counter)
	#print(server_item_data_client)
	print(Collection)
	if $Vending_Machine_anim.frame > 255:
		$Vending_Machine_anim.frame = 0
		$Vending_Machine_anim.stop()
		$Window.show()
		$Window/Gatcha_Simulation.play("Big Bang explosion")
	if $Window/Gatcha_Simulation.frame > 99:
		$Window/Gatcha_Simulation.frame = 0
		if len(bottle_list) == 0:
			pass
		elif len(bottle_list) > 0:
			$Window/AnimatedSprite2D.frame = bottle_list[len(bottle_list)-1]
			$Window/AnimatedSprite2D.show()
			$Window/Gatcha_Simulation.hide()
			
	$Client_Balance.text = "Balance: $ " +str(balance)
	$Client_Balance_Local.text = "Balance: $ " +str(balance)
	#print(bottle_list)
	#print(bottle_list)
	
@rpc("any_peer","call_local")
func testing(client_id,random_num):
	number = random_num
	bottle_list.append(number)
	GameManager.Bottle_data[client_id] = bottle_list[-1]
	Collection.append(bottle_list[-1])
@rpc("any_peer","call_local")
func offer(server_item_data,Money,shiny_container):
	offer_counter += 1
	server_item_data_client = server_item_data
	money_offered = Money
	Shiny_container = shiny_container
	#print(Shiny_container)
	var list_of_server_values = Array(server_item_data.values())
	list_of_server_values.append(Money)
	offer_list_with_values[offer_counter] = list_of_server_values
	GameManager.Server_item_data = {}
	GameManager.Shiny_Container = []
	#print(server_item_data_client)
	#print(offer_list_with_values) #Last value of the element is Money.
	"""
	$RichTextLabel.text = "Server just offered you a item/items to trade!"
	print("server just offered you a item/items to trade!")
	print("Offered Items are " )
	"""
	#below are the offered items numbers
	"""
	for i in len(server_item_data):
		print(server_item_data["fruit_sprite"+str(i+1)])
		"""
	var offer_window = preload("res://Offer_window.tscn").instantiate()
	offer_window.name = "Offer Window " + str(GameManager.offer_number)
	offer_window.title = "Offer " + str(GameManager.offer_number) 
	get_node("Offer_window_container").add_child(offer_window)
	New_bottle_sig.emit()
	GameManager.offer_number += 1
	print("Offer_number from Market Script: " + str(GameManager.offer_number))
	
@rpc("any_peer","call_local")
func shiny_Identification(shiny_container):
	Shiny_container = shiny_container
	
@rpc("any_peer","call_local")
func moneyandreroll_transaction(money):
	pass

func _on_timer_timeout():
	if len(Collection) >= 3:
		for i in len(Collection):
			var selling_item = preload("res://description_sprite.tscn").instantiate()
			selling_item.frame = Collection[i]
			selling_item.scale = Vector2(1.5,1.5)
			selling_item.show()
			get_node("Local_Store/Item"+str(i+1)).add_child(selling_item)


func _on_visible_on_screen_notifier_2d_screen_exited():
	pass # Replace with function body.
