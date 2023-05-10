extends KinematicBody2D

var speed = 100
var movement = Vector2()
const GRAVITY = 800

var moving_left = true
var velocity = Vector2.ZERO
var started = false

onready var l_ray = $l_ray

func _physics_process(delta):
	
	if l_ray.is_colliding():
		moving_left = !moving_left
		scale.x = -scale.x
	
	move()

func move():
	if started:
		movement.y +=GRAVITY
		movement.x = -speed if moving_left else speed
		movement = move_and_slide(movement,Vector2.UP)


func _on_Hurtbox_body_entered(body):
	if body is Koko:
		queue_free()

func start():
	started = true
