extends Window
var credit = 0

func _ready():
	get_parent().get_parent().New_bottle_sig.connect(delivered_server_item_creation)
	$AnimatedSprite2D.play("default")
"""
func _process(delta):
	print(get_parent().get_parent().Shiny_container)
	"""
func delivered_server_item_creation():
	#print(get_parent().get_parent().Shiny_container)
	#print(get_parent().get_parent().Shiny_container[0][0])
	#print(GameManager.offer_number)
	if name == "Offer Window "+ str(GameManager.offer_number):
		$Speech_Bubble_text.text = "We Offer you $" +str(get_parent().get_parent().money_offered) + " for these items."
		GameManager.item_spacing = 20
		for i in len(get_parent().get_parent().server_item_data_client):
			var new_sprite = preload("res://new_sprite.tscn").instantiate()
			new_sprite.frame = get_parent().get_parent().server_item_data_client["fruit_sprite"+str(i+1)]
			new_sprite.name = str(("fruit_sprite")+str(i+1))
			new_sprite.position.x += GameManager.item_spacing
			new_sprite.position.y += 30
			new_sprite.show()
			add_child(new_sprite)
			Shiny_detector(new_sprite)
			if len(get_parent().get_parent().Shiny_container) >0:
				for j in get_parent().get_parent().Shiny_container:
					print(j[0])
					if new_sprite.name == j[0]:
						var shiny = preload("res://Rare_Item_Particle.tscn").instantiate()
						new_sprite.add_child(shiny)
			GameManager.item_spacing = GameManager.item_spacing + 50
		get_parent().get_parent().server_item_data_client = {}

func _on_accept_btn_pressed():
	# This is when you don't have money to accept the offer.
	if get_tree().root.get_node("Market").balance < get_parent().get_parent().money_offered:
		print("you don't have enough money..")
	# This is when you have enough money to accept the offer scenario.
	elif get_tree().root.get_node("Market").balance >= get_parent().get_parent().money_offered:
		get_tree().root.get_node("Market").balance -= get_parent().get_parent().money_offered
		print("you accepted the offer!")
				#to only get values from the list.
		for i in len(get_tree().root.get_node("Market").offer_list_with_values[GameManager.offer_number])-1:
			print(i)
			get_tree().root.get_node("Market").Collection.append(get_tree().root.get_node("Market").offer_list_with_values[GameManager.offer_number][i])
		
		get_tree().root.get_node("Market").moneyandreroll_transaction.rpc_id(1,get_parent().get_parent().money_offered)
		queue_free()
func _on_reject_btn_pressed():
	queue_free()

func Shiny_detector(new_sprite):
	if len(get_parent().get_parent().Shiny_container) >0:
		for j in get_parent().get_parent().Shiny_container:
			print(j[0])
			if new_sprite.name == j[0]:
				var shiny = preload("res://Rare_Item_Particle.tscn").instantiate()
				new_sprite.add_child(shiny)
