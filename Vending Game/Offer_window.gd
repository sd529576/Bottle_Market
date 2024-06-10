extends AcceptDialog

func _ready():
	get_parent().New_bottle_sig.connect(delivered_server_item_creation)
"""
func _process(delta):
	#print(get_parent().server_item_data_client)
	delivered_server_item_creation()
	"""
func delivered_server_item_creation():
	for i in len(get_parent().server_item_data_client):
		print(get_parent().server_item_data_client["fruit_sprite"+str(i+1)])
