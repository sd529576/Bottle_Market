extends Node2D

var Home_Btn = false
var Price_randomizer = RandomNumberGenerator.new()
var org_length = null
var Price = []
var item_counter = 1
var selling_item = preload("res://description_sprite.tscn").instantiate()
var re_stocking_needed = 3

func _physics_process(delta):
	if Home_Btn == true and Input.is_action_just_pressed("left_click"):
		get_tree().root.get_node("Market/Main_Lobby").make_current()
		if re_stocking_needed == 0:
			re_stocking_needed = 3
			get_parent().item_counter = 0
	#[1,3]
	print(len(get_tree().root.get_node("Market").bottle_list))
	
func _on_area_2d_mouse_entered():
	Home_Btn = true


func _on_area_2d_mouse_exited():
	Home_Btn = false

func price_display():
	print($Item1.get_children())
	print(Price)
#Local_Store/Item1/Description_Sprite

func _on_item_1_sell_btn_pressed():
	org_length = len(get_tree().root.get_node("Market").bottle_list) # 2 -> [24,35] this is to store the original length of the bottle list.
	for j in $Item1.get_children():
		if j.name == "Description_Sprite":
			for i in org_length:
				if org_length == len(get_tree().root.get_node("Market").bottle_list):
					if j.frame == get_tree().root.get_node("Market").bottle_list[i]:
						get_tree().root.get_node("Market").bottle_list.remove_at(i)
						$Item1/Item1_sell_btn.disabled = true
						get_tree().root.get_node("Market").balance += Price[0]
						re_stocking_needed -=1
						j.hide()
						$Item1/Item1_Price.hide()
func _on_item_2_sell_btn_pressed():
	org_length = len(get_tree().root.get_node("Market").bottle_list) # 1 -> [24,67]
	for j in $Item2.get_children():
		if j.name == "Description_Sprite":
			for i in org_length:
				if org_length == len(get_tree().root.get_node("Market").bottle_list):
					if j.frame == get_tree().root.get_node("Market").bottle_list[i]:
						get_tree().root.get_node("Market").bottle_list.remove_at(i)
						$Item2/Item2_sell_btn.disabled = true
						get_tree().root.get_node("Market").balance += Price[1]
						re_stocking_needed -=1
						j.hide()
						$Item2/Item2_Price.hide()
func _on_item_3_sell_btn_pressed():
	org_length = len(get_tree().root.get_node("Market").bottle_list) # 1 -> [24,67]
	for j in $Item3.get_children():
		if j.name == "Description_Sprite":
			for i in org_length:
				if org_length == len(get_tree().root.get_node("Market").bottle_list):
					if j.frame == get_tree().root.get_node("Market").bottle_list[i]:
						print("hm??")
						get_tree().root.get_node("Market").bottle_list.remove_at(i)
						$Item3/Item3_sell_btn.disabled = true
						get_tree().root.get_node("Market").balance += Price[2]
						re_stocking_needed -=1
						j.hide()
						$Item3/Item3_Price.hide()
