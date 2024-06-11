extends AnimatedSprite2D

signal on_item_signal

func _on_area_2d_mouse_entered():
	get_parent().get_parent().on_item = true
	print("currently on item...")


func _on_area_2d_mouse_exited():
	get_parent().get_parent().on_item = false
