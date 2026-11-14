class_name TargetPositionState extends CameraState

var target_position: Vector2 

@export var lerp_timer: float = .3
var keep_in_place: bool = false
func enter(oldState: CameraState) -> void:
	#parent.animations.play(animation_name)

	if target_position:
		#camera_man.top_level = false
		var tween = get_tree().create_tween()
		tween.tween_property(camera_man, "global_position", target_position, lerp_timer).set_ease(Tween.EASE_IN_OUT)
		tween.tween_callback(can_keep_in_place)
	else:
		push_error('hey camera state machine didn find target position')
	pass

func exit(newState: CameraState) -> void:
	keep_in_place = false
	
	pass

func process_frame(delta: float) -> CameraState:
	return null

func process_physics(delta: float) -> CameraState:
	if keep_in_place:
		camera_man.global_position = target_position
	return null
	
func can_keep_in_place() -> void:
	keep_in_place = true
