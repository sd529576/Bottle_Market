extends Node2D

var default = -1


func _ready():
	$AnimatedSprite2D2.play("default")
	
func _on_button_pressed():
	pass
	# should revert back to the scene.

@rpc("any_peer",'call_local')
func animation():
	$AnimatedSprite2D.play("Main_Animation")

func _on_roll_pressed():
	var random = RandomNumberGenerator.new()
	var random_num = random.randi_range(1,10)
	default = 1
	animation.rpc()
	
func _physics_process(delta):
	print(default)
	if $AnimatedSprite2D.frame > 255 and default == 1:
		$Window.show()
		$Window/AnimatedSprite2D.play("Big Bang explosion")
	if $Window/AnimatedSprite2D.frame > 95:
		$Window/DrinkCaptures.frame = 1
		$Window/DrinkCaptures.show()
		$Window/AnimatedSprite2D.hide()
