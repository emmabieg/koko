extends Area2D

signal score

func _on_Strawberry_body_entered(body):
	if body is Koko:
		hide()
		emit_signal("score")
