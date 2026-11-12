class_name Director extends Node2D
@export var parent: Player
@export var camera: Camera2D
@export var camera_state_machine: CameraStateMachine
@export var camera_man: CameraMan

func _ready() -> void:
	if parent and camera and camera_man and camera_state_machine:
		camera_state_machine.init(camera, parent, camera_man)
		camera_man.global_position = parent.global_position
		
func _physics_process(delta: float) -> void:
	camera_state_machine.process_physics(delta)
	
func _process(delta: float) -> void:
	camera_state_machine.process_frame(delta)
