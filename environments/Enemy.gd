extends KinematicBody2D

var speed = 100
var movement = Vector2()
const GRAVITY = 800

var moving_left = true
var velocity = Vector2.ZERO
var started = false

onready var l_ray = $l_ray
onready var d_ray = $d_ray
onready var animated_sprite = $Sprite

func _physics_process(delta):
	
	if l_ray.is_colliding() or !d_ray.is_colliding():
		moving_left = !moving_left
		scale.x = -scale.x
		
	move()

func move():
	if started:
		movement.y +=GRAVITY
		movement.x = -speed if moving_left else speed
		movement = move_and_slide(movement,Vector2.UP)
		animated_sprite.play("fly")


func start():
	started = true


func _on_DieZone_body_entered(body):
	if body is Koko:
		queue_free()
