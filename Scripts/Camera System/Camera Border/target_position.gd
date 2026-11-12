class_name TargetPositionState extends CameraState

func enter(oldState: CameraState) -> void:
	#parent.animations.play(animation_name)
	camera_man.velocity.x = 0
	camera_man.velocity.y = 0
	camera_man.position 
	pass

func exit(newState: CameraState) -> void:
	pass

func process_frame(delta: float) -> CameraState:
	return null

func process_physics(delta: float) -> CameraState:
	return null
