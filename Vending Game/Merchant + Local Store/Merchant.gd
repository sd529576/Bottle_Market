extends CharacterBody2D


const SPEED = 50
var Character_on = false
signal Local_store_clicked
var org_length = 0
var back_to_normal = false
#var item_counter = 0
func _ready():
	$AnimatedSprite2D.play("default")
	
func _physics_process(delta):
	velocity.x = -SPEED
	
	if back_to_normal == true:
		position.x = 1000
		back_to_normal = false
	move_and_slide()
	
	if Character_on == true and Input.is_action_just_pressed("left_click"):
		Local_store_clicked.emit()
		get_parent().get_node("Local_Store/Item1/Item1_sell_btn").disabled = false
		get_parent().get_node("Local_Store/Item2/Item2_sell_btn").disabled = false
		get_parent().get_node("Local_Store/Item3/Item3_sell_btn").disabled = false
		get_tree().root.get_node("Market/Local_Store_Screen").make_current()
		#if number of items in collection is between 1 to 3, list the number of items in a list only.
		if len(get_tree().root.get_node("Market").Collection) > 0 and len(get_tree().root.get_node("Market").Collection) < 4 and get_parent().get_node("Local_Store").re_stocking_needed == 3:
			for i in len(get_tree().root.get_node("Market").Collection):
				var selling_item = preload("res://description_sprite.tscn").instantiate()
				selling_item.frame = get_tree().root.get_node("Market").Collection[i]
				selling_item.scale = Vector2(1.5,1.5)
				selling_item.show()
				get_parent().get_node("Local_Store/Item"+str(i+1)).add_child(selling_item)
		#if number of items are more than 3, take the first 3 items from the collection and list them in local store.
		elif len(get_tree().root.get_node("Market").Collection)> 3:
			for i in 3:
				var selling_item = preload("res://description_sprite.tscn").instantiate()
				selling_item.frame = get_tree().root.get_node("Market").Collection[i]
				selling_item.scale = Vector2(1.5,1.5)
				selling_item.show()
				get_parent().get_node("Local_Store/Item"+str(i+1)).add_child(selling_item)
		price_display()
		"""
		for i in len(get_tree().root.get_node("Market").bottle_list):
			var selling_item = preload("res://description_sprite.tscn").instantiate()
			selling_item.frame = get_tree().root.get_node("Market").bottle_list[item_counter]
			selling_item.scale = Vector2(1.5,1.5)
			selling_item.show()
			get_parent().get_node("Local_Store/Item"+str(item_counter+1)).add_child(selling_item)
			item_counter += 1
			"""
		#get_parent().get_node("Local_Store").org_length = len(get_tree().root.get_node("Market").bottle_list)
"""
func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseMotion:
		print("wa???")
		if Input.is_action_just_pressed("left_click"):
			print("hmm?")
			get_tree().root.get_node("Market/Local_Store_Screen").make_current()
"""
func _on_area_2d_mouse_entered():
	Character_on = true




func _on_area_2d_mouse_exited():
	Character_on = false

func price_display():
	if len(get_parent().get_node("Local_Store/Item1").get_children()) >2 and len(get_parent().get_node("Local_Store").Price) == 0:
		var price1 = get_parent().get_node("Local_Store").Price_randomizer.randi_range(1,10)
		get_parent().get_node("Local_Store/Item1/Item1_Price").text += "$"+str(price1)
		get_parent().get_node("Local_Store/Item1/Item1_Price").show()
		get_parent().get_node("Local_Store").Price.append(price1)
	if len(get_parent().get_node("Local_Store/Item2").get_children()) > 2 and len(get_parent().get_node("Local_Store").Price) == 1:
		var price2 = get_parent().get_node("Local_Store").Price_randomizer.randi_range(1,10)
		get_parent().get_node("Local_Store/Item2/Item2_Price").text += "$"+str(price2)
		get_parent().get_node("Local_Store/Item2/Item2_Price").show()
		get_parent().get_node("Local_Store").Price.append(price2)
	if len(get_parent().get_node("Local_Store/Item3").get_children()) > 2 and len(get_parent().get_node("Local_Store").Price) == 2:
		var price3 = get_parent().get_node("Local_Store").Price_randomizer.randi_range(1,10)
		get_parent().get_node("Local_Store/Item3/Item3_Price").text += "$"+str(price3)
		get_parent().get_node("Local_Store/Item3/Item3_Price").show()
		get_parent().get_node("Local_Store").Price.append(price3)


func _on_visible_on_screen_notifier_2d_screen_exited():
	back_to_normal = true
	print("Working?")
	
