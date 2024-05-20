extends Node2D


var default_port = 12345
@onready var text = $RichTextLabel


func _ready():
	multiplayer.connected_to_server.connect(self.join_as_client)
	join_server()
	
func join_server() -> void:
	var peer = ENetMultiplayerPeer.new()
	peer.create_client("127.0.0.1",default_port)
	multiplayer.multiplayer_peer = peer
	$RichTextLabel.text = ("Joining Server")

func join_as_client() -> void:
	$RichTextLabel.text += ("Connection established,calling to spawn player")
	var client_id: int = multiplayer.get_unique_id()
	var player_name: String = "Test_player1"
	rpc_id(1,"server_spawn_player", client_id,player_name)

@rpc("any_peer")
func server_spawn_player(client_id:int,player_name:String) -> void:
	pass
	
@rpc
func create_player_node() -> void:
	$RichTextLabel.text += ("Actually running the code to create the player here")

