extends CharacterBody2D


const SPEED = 50
var Character_on = false
signal Local_store_clicked
var org_length = 0
#var item_counter = 0
func _ready():
	$AnimatedSprite2D.play("default")
	
func _physics_process(delta):
	velocity.x = -SPEED
	
	move_and_slide()
	
	if Character_on == true and Input.is_action_just_pressed("left_click"):
		Local_store_clicked.emit()
		get_tree().root.get_node("Market/Local_Store_Screen").make_current()
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
