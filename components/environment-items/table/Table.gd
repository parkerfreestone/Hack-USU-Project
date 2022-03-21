extends Node2D

func _on_Area2D_body_entered(body:Node):
	if body.name == "Player":
		body.can_hide = true
		$Light2D.energy = 1
	
		
func _on_Area2D_body_exited(body:Node):
	if body.name == "Player":
		$Light2D.energy = 0
		body.can_hide = false