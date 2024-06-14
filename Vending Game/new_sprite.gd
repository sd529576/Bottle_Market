extends AnimatedSprite2D

signal on_item_signal

func _on_area_2d_mouse_entered():
	get_tree().root.get_node("Market").on_item = true
	print("currently on item...")
	print(name)
func _on_area_2d_mouse_exited():
	get_tree().root.get_node("Market").on_item = false

