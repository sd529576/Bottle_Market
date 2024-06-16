extends AnimatedSprite2D

var frame1 = 0
var name1 = ""
var Item_description = {0: "Solid Apple, so normal that it’s strange.",1: "Green Pear, might be a little sour to eat.",2: "Abundant Grape, can’t even count how many", 3: "BANANA, BANANANANA",4:"Single Banana, why would they only sell one single banana?"}
signal on_item_signal

func _on_area_2d_mouse_entered():
	get_tree().root.get_node("Market").on_item = true
	var new = preload("res://description_sprite.tscn").instantiate()
	new.scale = Vector2(.7,.7)
	if get_tree().root.get_node("Market/Dictionary").screen_locked %2 == 0:
		new.frame = frame
		get_parent().get_parent().get_parent().get_node("Description Tab/ItemDescribe2/Item_Pointer").add_child(new)
		get_parent().get_parent().get_parent().get_node("Description Tab/Description").text = Item_description[new.frame]
	new.show()
	frame1 = frame
	name1 = name
	#print(name)
	get_parent().get_parent().get_parent().get_node("Description Tab").show()
func _on_area_2d_mouse_exited():
	if get_tree().root.get_node("Market/Dictionary").screen_locked %2 == 0:
		for i in get_parent().get_parent().get_parent().get_node("Description Tab/ItemDescribe2/Item_Pointer").get_children():
			i.queue_free()
		get_parent().get_parent().get_parent().get_node("Description Tab").hide()
	#screen_locked
	elif get_tree().root.get_node("Market/Dictionary").screen_locked %2 > 0:
		get_parent().get_parent().get_parent().get_node("Description Tab").show()
	get_tree().root.get_node("Market").on_item = false
