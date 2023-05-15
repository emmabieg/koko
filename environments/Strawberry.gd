extends Area2D

var SCORE = 0
var hidden = false

onready var point = $Point

func _on_Strawberry_body_entered(body):
	if body is Koko:
		if !hidden:
			hide()
			hidden = true
			ScoreManager.score += 1
			point.play()
			print(ScoreManager.score)
