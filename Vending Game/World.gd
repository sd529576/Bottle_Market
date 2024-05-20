extends Node2D

var default_port = 12345
@onready var text = $RichTextLabel
@export var client_scene : PackedScene


func _ready():
	multiplayer.peer_connected.connect(self._peer_connected)
	
func start_server():
	var port = default_port
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(port)
	multiplayer.multiplayer_peer = peer
	$RichTextLabel.text = "Server has started running.."
	print(peer)

func _peer_connected(id:int)-> void:
	$RichTextLabel.text = ("Peer %s connected." % id)
	
func _on_host_pressed():
	start_server()

func _on_join_pressed():
	var peer = ENetMultiplayerPeer.new()
	peer.create_client("127.0.0.1",default_port)
	multiplayer.multiplayer_peer = peer
	$RichTextLabel.text = ("Joining Server")

func _on_start_game_pressed():
	start_game.rpc()
	
@rpc("any_peer",'call_local')
func start_game():
	var game_scene = preload("res://market.tscn").instantiate()
	get_tree().root.add_child(game_scene)	
	self.hide()

