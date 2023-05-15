extends StaticBody2D

signal finished


func _on_Goal_body_entered(body):
	if body is Koko:
		emit_signal("finished")
		print("finsihed")
