extends CharacterBody2D


const SPEED = 150

func _ready():
	$AnimatedSprite2D.play("default")
	
func _physics_process(delta):
	velocity.x = -SPEED
	
	move_and_slide()

func _on_area_2d_input_event(viewport, event, shape_idx):
	print(event)
