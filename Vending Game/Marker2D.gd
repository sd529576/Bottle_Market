extends Marker2D

@export var damage_node : PackedScene

func popup():
	var damage = damage_node.instantiate()
	damage.global_position = Vector2(position.x+ 140,position.y + 340)
	get_tree().root.get_node("Market").add_child(damage)
	damage.get_node("Label").text = (str(get_parent().re_roll_gain))
	print(damage.global_position)
	print(get_global_mouse_position())
	print("working?")
