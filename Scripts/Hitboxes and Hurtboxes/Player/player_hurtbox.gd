class_name Player_Hurtbox extends Hurtbox


func _on_body_entered(body: Node2D) -> void:
	if body is not Bad_Guy_Hitbox:
		return
	if iframe == false:
		hit.emit(body.hitbox_stats.health_damage)
		iframe_timer.start()
		iframe = true
	pass
	#if body is 


func _on_timer_timeout() -> void:
	iframe = false
	pass # Replace with function body.




func swap_form() -> void:
	iframe_timer.start()
	iframe = true
