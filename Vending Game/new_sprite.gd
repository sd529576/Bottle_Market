extends AnimatedSprite2D

signal on_item_signal

func _on_area_2d_mouse_entered():
	GameManager.on_item = true

