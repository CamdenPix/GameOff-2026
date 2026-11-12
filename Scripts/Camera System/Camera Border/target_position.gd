class_name TargetPositionState extends CameraState

var target_position: Vector2 

func enter(oldState: CameraState) -> void:
	#parent.animations.play(animation_name)
	camera_man.velocity.x = 0
	camera_man.velocity.y = 0
	if target_position:
		camera_man.global_position = target_position
	else:
		push_error('hey camera state machine didn find target position')
	pass

func exit(newState: CameraState) -> void:
	pass

func process_frame(delta: float) -> CameraState:
	return null

func process_physics(delta: float) -> CameraState:
	return null
