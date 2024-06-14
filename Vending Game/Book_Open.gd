extends Node2D

var book_opened = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$Book_Animation.frame = 0
	$Book_Animation/Next_Btn.hide()
	$Book_Animation/Back_Btn.hide()
	for i in $Book_Animation/Items.get_children():
		i.hide()
		
func _process(delta):
	if Input.is_action_just_pressed("Enter"):
		$Book_Animation.play("default")
	if Input.is_action_just_pressed("left_click") and get_tree().root.get_node("Market").on_item == true:
		print("Testing123")
		
	show_sprite()
func show_sprite():
	if book_opened == false:
		if $Book_Animation.frame == 194:
			for i in $Book_Animation/Items.get_children():
				i.show()
			$Book_Animation/Next_Btn.show()
			$Book_Animation/Back_Btn.show()
			book_opened = true
# [0,39] -> [40, 79] -> [80,119] -> [120,159] -> [160, ?]
func _on_next_btn_pressed():
	$Book_Animation/Back_Btn.disabled = false
	if $Book_Animation.frame == 194:
		for i in $Book_Animation/Items.get_children():
			if i.frame + 40 > 171:
				i.hide()
				$Book_Animation/Next_Btn.disabled = true
			else:
				#i.show()
				i.frame += 40


func _on_back_btn_pressed():
	$Book_Animation/Next_Btn.disabled = false
	if $Book_Animation.frame == 194:
		for i in $Book_Animation/Items.get_children():
			if i.frame - 40 < 0:
				$Book_Animation/Back_Btn.disabled = true
			else:
				i.show()
				i.frame -= 40


func _on_back_to_lobby_pressed():
	get_parent().get_node("Camera2D").make_current()
