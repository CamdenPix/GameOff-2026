class_name CameraStateMachine extends Node

@export 
var debug_state_label : Label

@export
var no_debug_labels: bool = false


@export_category("State Machine Base States")
@export
var starting_state: CameraState

@export var base_state: CameraState
var localOldStateMachine: CameraState

var current_state: CameraState

func _ready() -> void:
	if debug_state_label == null and no_debug_labels == true:
		push_error(self.name + ': Hey man the debug state label or no debug label needs to be set')

func enter(oldStateMachine: CameraState) ->void:
	localOldStateMachine = oldStateMachine
	pass

func exit(newStateMachine: CameraState) ->void:
	pass

func init(camera: Camera2D, parent:Player, camera_man: CharacterBody2D) -> void:
	for child in get_children():
		child.camera = camera
		child.parent = parent
		child.camera_man = camera_man

	change_state(starting_state)

func change_state(new_state: CameraState) -> void:
	if current_state:
		current_state.exit(new_state)
	var old_state = current_state
	current_state = new_state
	
	if new_state == null:
		push_error('camera state machine: ' + self.name + 'had a new state be null. if this happened at start of the game check if starting state, deactive state and base state are set')
	if no_debug_labels == false:
		debug_state_label.text = new_state.to_string()
	current_state.enter(old_state)

func process_physics(delta: float) -> CameraState:
	
	var new_state = current_state.process_physics(delta)
	if new_state is CameraState:
		change_state(new_state)
	return

func process_frame(delta: float) -> CameraState:
	var new_state = current_state.process_frame(delta)
	if new_state is CameraState:
		change_state(new_state)
	return
