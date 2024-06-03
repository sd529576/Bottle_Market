extends Node2D

var default_port = 12345
@onready var text = $RichTextLabel
@export var host_scene : PackedScene
@export var client_scene : PackedScene
var host_pressed = false
var client_pressed = false
signal user_detected

func _ready():
	multiplayer.peer_connected.connect(Player_Connected)
	multiplayer.connected_to_server.connect(connected_to_server)
	
#gets called on the server and client
func Player_Connected(id):
	if multiplayer.get_unique_id() != 1:
		pass
		#$RichTextLabel.text = ("Player Connected" + str(multiplayer.get_unique_id()))
		#SendPlayerInformation($LineEdit.text,multiplayer.get_unique_id())
		#print("Player connected?")
#gets called only from clients
func connected_to_server():
	print("Connected to Server!")
	SendPlayerInformation.rpc($LineEdit.text,multiplayer.get_unique_id())
	print(GameManager.Players)
func _on_host_pressed():
	start_server()
	host_pressed = true
	client_pressed = false
	
func start_server():
	var port = default_port
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(port)
	multiplayer.multiplayer_peer = peer
	$RichTextLabel.text = "Server has started running.."
	#SendPlayerInformation($LineEdit.text,multiplayer.get_unique_id())
	print(GameManager.Players)
	#print(peer)
	#SendPlayerInformation.rpc($LineEdit.text,multiplayer.get_unique_id())
	#SendPlayerInformation($LineEdit.text,multiplayer.get_unique_id())

func _on_start_game_pressed():
	if host_pressed == true:
		start_game_host.rpc_id(1)
	elif client_pressed == true:
		start_game_client.rpc_id(not 1)
		
@rpc("any_peer",'call_local')
func start_game_host():
	if host_pressed == true:
		get_tree().root.add_child(host_scene.instantiate())
		self.hide()
		print("wat")
		host_pressed = false

@rpc("any_peer","call_local")
func start_game_client():
	if client_pressed == true:
		get_tree().root.add_child(client_scene.instantiate())
		self.hide()
		print("clicked?")
		GameManager.num_players += 1
		client_pressed = false
func _on_join_pressed():
	var peer = ENetMultiplayerPeer.new()
	peer.create_client("127.0.0.1",default_port)
	multiplayer.multiplayer_peer = peer
	$RichTextLabel.text = ("Joining Server")
	client_pressed = true
	host_pressed = false
	get_node("Join").disabled = true
	
@rpc("any_peer","call_local")
func SendPlayerInformation(name,id):
	if !GameManager.Players.has(id):
		GameManager.Players[id] = {
			"name" : name,
			"id" : id,
			"score": 0
		}
		user_detected.emit()
	"""
	if multiplayer.is_server():
		SendPlayerInformation.rpc_id(1,id)
		"""
