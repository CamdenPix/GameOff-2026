class_name FollowPlayerState extends CameraState

func enter(oldState: CameraState) -> void:
	#parent.animations.play(animation_name)
	
	pass

func exit(newState: CameraState) -> void:
	pass

func process_frame(delta: float) -> CameraState:
	return null

func process_physics(delta: float) -> CameraState:
	camera_man.velocity = parent.velocity
	return null
