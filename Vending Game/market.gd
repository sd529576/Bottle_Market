extends Node2D

var default
var Bottle_dict = {}
var called = false
var number = 0
var bottle_list = []

func _ready():
	$Background_animation.play("default")
	
func _on_button_pressed():
	pass
	# should revert back to the scene.

#@rpc('any_peer',"call_local")
func host_animation():
	$Vending_Machine_anim.play("Main_Animation")

func _on_roll_pressed():
	host_animation()
	var random = RandomNumberGenerator.new()
	var random_num = random.randi_range(1,4)
	number = random_num
	bottle_list.append(number)
	GameManager.Bottle_data[multiplayer.get_unique_id()] = bottle_list[0]
	print(GameManager.Bottle_data)
func _physics_process(delta):
	if $Vending_Machine_anim.frame > 255:
		$Vending_Machine_anim.frame = 0
		$Vending_Machine_anim.stop()
		$Window.show()
		$Window/Gatcha_Simulation.play("Big Bang explosion")
	if $Window/Gatcha_Simulation.frame > 99:
		$Window/Gatcha_Simulation.frame = 0
		if len(bottle_list) == 0:
			pass
		elif len(bottle_list) > 0:
			$Window/AnimatedSprite2D.frame = bottle_list[len(bottle_list)-1]
			$Window/AnimatedSprite2D.show()
			$Window/Gatcha_Simulation.hide()
	#print(bottle_list)
	#print(GameManager.Bottle_data)

func _on_window_close_requested():
	print("hmm?")