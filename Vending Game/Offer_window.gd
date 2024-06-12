extends Window

func _ready():
	get_parent().get_parent().New_bottle_sig.connect(delivered_server_item_creation)
	$AnimatedSprite2D.play("default")
"""
func _process(delta):
	#print(get_parent().server_item_data_client)
	delivered_server_item_creation()
	"""
func delivered_server_item_creation():
	print(GameManager.offer_number)
	if name == "Offer Window "+ str(GameManager.offer_number):
		$Speech_Bubble_text.text = "We Offer you $" +str(get_parent().get_parent().money_offered) + " for these items."
		GameManager.offer_number += 1
		GameManager.item_spacing = 20
		for i in len(get_parent().get_parent().server_item_data_client):
			var new_sprite = preload("res://new_sprite.tscn").instantiate()
			new_sprite.frame = get_parent().get_parent().server_item_data_client["fruit_sprite"+str(i+1)]
			new_sprite.position.x += GameManager.item_spacing
			new_sprite.position.y += 30
			new_sprite.show()
			add_child(new_sprite)
			GameManager.item_spacing = GameManager.item_spacing + 50
		get_parent().get_parent().server_item_data_client = {}

func _on_accept_btn_pressed():
	print("Accepted Offer")


func _on_reject_btn_pressed():
	queue_free()
