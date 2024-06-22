extends AnimatedSprite2D

var frame1 = 0
var name1 = ""
var File = "res://Item_Description.txt"
var Item_description = {}
#var Item_description1 = {0: "Solid Apple, so normal that it’s strange.",1: "Green Pear, might be a little sour to eat.",2: "Abundant Grape, can’t even count how many", 3: "BANANA, BANANANANA",4:"Single Banana, why would they only sell one single banana?",5:"Watermelon, might have to use a kitchen knife to cut it.",6:"One Slice of Watermelon, looks delicious enough.",7:"Watermelon and a HALF, this can definitely feed the whole family.",8:"Peach Lover, we do lovin peach peach",9:"A Persimmon, My dad loves this fruit.",10:"An Orange, Could potentially be really sour",11:"an Egg Plant, I can't eat this but some people love it.",12:"Cherry, looks really good on cocktails",13:"Yellow LemonLEmon, SOURRRRRrrrrr",14:"Green Lemon, this might actually be more sour than yellow lemon.",15:"KiWI, My favorite. seems to be "}
signal on_item_signal

func _on_area_2d_mouse_entered():
	if frame in GameManager.Price_Tracker.keys():
		pass
	elif frame not in GameManager.Price_Tracker.keys():
		GameManager.Price_Tracker[frame] = [0,0,0]
	get_tree().root.get_node("Market").on_item = true
	if get_tree().root.get_node("Market/Dictionary").dictionary_opened == true:
		var new = preload("res://description_sprite.tscn").instantiate()
		new.scale = Vector2(.7,.7)
		if get_tree().root.get_node("Market/Dictionary").screen_locked %2 == 0:
			new.frame = frame
			get_tree().root.get_node("Market/Dictionary/Description Tab/ItemDescribe2/Item_Pointer").add_child(new)
			get_tree().root.get_node("Market/Dictionary/Description Tab/Description").text = GameManager.Item_description[new.frame]
		new.show()
		frame1 = frame
		name1 = name
		#print(name)
		get_tree().root.get_node("Market/Dictionary/Description Tab").show()
func _on_area_2d_mouse_exited():
	get_tree().root.get_node("Market").on_item = false
	if get_tree().root.get_node("Market/Dictionary").dictionary_opened == true:
		if get_tree().root.get_node("Market/Dictionary").screen_locked %2 == 0:
			for i in get_parent().get_parent().get_parent().get_node("Description Tab/ItemDescribe2/Item_Pointer").get_children():
				i.queue_free()
			get_parent().get_parent().get_parent().get_node("Description Tab").hide()
		#screen_locked
		elif get_tree().root.get_node("Market/Dictionary").screen_locked %2 > 0:
			get_parent().get_parent().get_parent().get_node("Description Tab").show()

