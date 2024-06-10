extends Node2D

var default
var Bottle_dict = {}
var called = false
var number = 0
var bottle_list = []
var server_item_data_client = {}
signal New_bottle_sig

func _ready():
	$Background_animation.play("default")
#@rpc('any_peer',"call_local")
func host_animation():
	$Vending_Machine_anim.play("Main_Animation")
func _on_roll_pressed():
	host_animation()
	var random = RandomNumberGenerator.new()
	var random_num = random.randi_range(1,170)
	rpc_id(1,"testing",multiplayer.get_unique_id(),random_num)
	testing(multiplayer.get_unique_id(),random_num)
	#print(GameManager.Bottle_data)
func _physics_process(delta):
	#print(GameManager.Bottle_data)
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
	#print(bottle_list)
	#print(bottle_list)
	
@rpc("any_peer","call_local")
func testing(client_id,random_num):
	number = random_num
	bottle_list.append(number)
	GameManager.Bottle_data[client_id] = bottle_list[-1]

@rpc("any_peer","call_local")
func offer(server_item_data):
	server_item_data_client = server_item_data
	$RichTextLabel.text = "Server just offered you a item/items to trade!"
	print("server just offered you a item/items to trade!")
	print("Offered Items are " )
	#below are the offered items numbers
	"""
	for i in len(server_item_data):
		print(server_item_data["fruit_sprite"+str(i+1)])
		"""
	var offer_window = preload("res://Offer_window.tscn").instantiate()
	add_child(offer_window)
	New_bottle_sig.emit()
func _on_area_2d_body_entered(body):
	print(body)
