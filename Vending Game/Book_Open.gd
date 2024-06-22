extends Node2D

var book_opened = false
var screen_locked = 0
var dictionary_opened = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$Book_Animation.frame = 0
	$Book_Animation/Next_Btn.hide()
	$Book_Animation/Back_Btn.hide()
	for i in $Book_Animation/Items.get_children():
		i.hide()
	get_parent().Book_Anim_sig.connect(default_anim)
		
func _process(delta):
	if Input.is_action_just_pressed("left_click") and get_tree().root.get_node("Market").on_item == true:
		screen_locked += 1
		print(screen_locked)
		
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
	get_parent().get_node("Host_Lobby").make_current()
	dictionary_opened = false
func default_anim():
	$Book_Animation.play("default")
	dictionary_opened = true
