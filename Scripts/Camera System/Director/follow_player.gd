class_name FollowPlayerState extends CameraState

@export var lerp_timer: float = .3

func enter(oldState: CameraState) -> void:
	#parent.animations.play(animation_name)
	#var tween = get_tree().create_tween()
	#tween.tween_property(camera_man, "global_position", parent.global_position, lerp_timer).set_ease(Tween.EASE_IN_OUT)
	pass

func exit(newState: CameraState) -> void:
	pass

func process_frame(delta: float) -> CameraState:
	#camera_man.velocity = parent.velocity
	return null

func process_physics(delta: float) -> CameraState:
	camera_man.global_position = lerp(camera_man.global_position, parent.global_position, delta)
	return null
