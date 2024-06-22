extends Node2D

var Tier = 0
var Price = 0
var random = RandomNumberGenerator.new()
var Saved_Item = {}
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	#print(GameManager.Price_Tracker)
	if Tier == 9:
		$ItemDescribe2/Currency_Label.text = str(GameManager.Price_Tracker[$ItemDescribe2/Item_Pointer.get_children()[0].frame][0])
	elif Tier == 5:
		$ItemDescribe2/Currency_Label.text = str(GameManager.Price_Tracker[$ItemDescribe2/Item_Pointer.get_children()[0].frame][1])
	elif Tier == 3:
		$ItemDescribe2/Currency_Label.text = str(GameManager.Price_Tracker[$ItemDescribe2/Item_Pointer.get_children()[0].frame][2])
	else:
		$ItemDescribe2/Currency_Label.text = ""
func _on_best_price_mouse_entered():
	Tier = 9
	for i in $ItemDescribe2/Item_Pointer.get_children():
		if GameManager.Price_Tracker[i.frame][0] == 0 and Tier == 9:
			Price = random.randi_range(7,9)
			GameManager.Price_Tracker[i.frame][0] = Price
			
func _on_second_price_mouse_entered():
	Tier = 5
	for i in $ItemDescribe2/Item_Pointer.get_children():
		if GameManager.Price_Tracker[i.frame][1] == 0 and Tier == 5:
			Price = random.randi_range(4,6)
			GameManager.Price_Tracker[i.frame][1] = Price
func _on_third_price_mouse_entered():
	Tier = 3
	for i in $ItemDescribe2/Item_Pointer.get_children():
		if GameManager.Price_Tracker[i.frame][2] == 0 and Tier == 3:
			Price = random.randi_range(1,3)
			GameManager.Price_Tracker[i.frame][2] = Price
func _on_best_price_mouse_exited():
	Tier = 0


func _on_second_price_mouse_exited():
	Tier = 0


func _on_third_price_mouse_exited():
	Tier = 0
