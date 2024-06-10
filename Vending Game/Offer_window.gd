extends AcceptDialog
var offer_number = 1

func _ready():
	get_parent().get_parent().New_bottle_sig.connect(delivered_server_item_creation)
"""
func _process(delta):
	#print(get_parent().server_item_data_client)
	delivered_server_item_creation()
	"""
func delivered_server_item_creation():
	if len(get_parent().get_children()) == get_parent().get_parent().Offer_number:
		for i in len(get_parent().get_parent().server_item_data_client):
			var new_sprite = preload("res://new_sprite.tscn").instantiate()
			new_sprite.frame = get_parent().get_parent().server_item_data_client["fruit_sprite"+str(i+1)]
			new_sprite.position.x += 30
			new_sprite.position.y += 30
			new_sprite.show()
			add_child(new_sprite)
