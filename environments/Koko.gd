extends KinematicBody2D
class_name Koko

var speed : int = 400 
var jump_speed : int = 600
var gravity : int = 1100
var velocity = Vector2()

var started = false

export var knockback=7000
export var knockup=1000

onready var animated_sprite = $AnimatedSprite

#This is a fuction for player movement 
func get_input(delta): 
	velocity.x = 0 
	#This is for the player to move right
	if Input.is_action_pressed("right"):
		velocity.x += speed
		animated_sprite.scale.x = 0.3
		animated_sprite.play("run")
	#This is for the player to move left
	if Input.is_action_pressed("left"):
		velocity.x -= speed
		animated_sprite.play("runleft")
	#This is for the player to jump 
	if Input.is_action_just_pressed("jump"):
		#Checks to see if player is on the ground or not 
		if ( is_on_floor()):
			velocity.y -=jump_speed
	
	if (is_on_floor() == false):
		animated_sprite.stop()


	if Input.get_vector("left","right","jump","ui_down").x == 0:
		animated_sprite.play("idle")
		
	# gravity 
	velocity.y += gravity * delta 
	velocity = move_and_slide(velocity, Vector2.UP)
	pass 


#Process the physics?
func _physics_process(delta):
	if Input.is_action_just_pressed("jump"):
		if !started:
			start()
	get_input(delta)


func start():
	if started: return
	started = true



func _on_Hurtbox_area_entered(area):
	if area.is_in_group("hitbox"):
		velocity.x -= lerp(velocity.x,knockback,0.5)
		velocity.y = lerp(0,-knockup,0.6)
		velocity = move_and_slide(velocity,Vector2.UP)
