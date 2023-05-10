extends KinematicBody2D
class_name Koko

var speed : int = 400 
var jump_speed : int = 600
var gravity : int = 1100
var velocity = Vector2()

onready var animated_sprite = $AnimatedSprite

#This is a fuction for player movement 
func get_input(delta): 
	velocity.x = 0 
	#This is for the player to move right
	if Input.is_action_pressed("right"):
		velocity.x += speed
		animated_sprite.stop()
		animated_sprite.play("run")
	#This is for the player to move left
	if Input.is_action_pressed("left"):
		velocity.x -= speed
		animated_sprite.stop()
		animated_sprite.play("run")
	#This is for the player to jump 
	if Input.is_action_just_pressed("jump"):
		#Checks to see if player is on the ground or not 
		if ( is_on_floor()):
			velocity.y -=jump_speed
	else:
		animated_sprite.play("idle")
		
	# gravity 
	velocity.y += gravity * delta 
	velocity = move_and_slide(velocity, Vector2.UP)
	pass 


#Process the physics?
func _physics_process(delta):
	get_input(delta)
