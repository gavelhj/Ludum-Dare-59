extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.name == 'Player':
		body.no_signal = true


func _on_body_exited(body: Node2D) -> void:
	if body.name == 'Player':
		body.no_signal = false
