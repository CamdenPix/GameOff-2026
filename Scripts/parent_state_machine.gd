@abstract
class_name ParentStateMachine extends Node
@export 
var debug_state_label : Label

@export
var debug_input_label : Label

@export
var no_debug_labels: bool = false

@export
var starting_state_machine: ChildStateMachine

var current_state_machine: ChildStateMachine



@export var deactive_state: ChildStateMachine
@export var base_state: ChildStateMachine

func init(parent: Player) -> void:
	for child in get_children():
		child.parent = parent

	# Initialize to the default state
	change_state_machine(starting_state_machine)

func change_state_machine(new_state_machine: ChildStateMachine) -> void:
	if current_state_machine:
		current_state_machine.exit(new_state_machine)
	var old_state_machine = current_state_machine
	current_state_machine = new_state_machine
	if no_debug_labels == false:
		debug_state_label.text = new_state_machine.to_string()
	current_state_machine.enter(old_state_machine)
	

func request_state_change(newState:State) ->void:
	if newState == null:
		return
	pass


func process_physics(delta: float) -> void:
	
	var new_state = current_state_machine.process_physics(delta)
	if new_state:
		change_state(new_state)

func process_input(event: InputEvent) -> void:
	
	var new_state = current_state_machine.process_input(event)
	if no_debug_labels == false:
		debug_input_label.text = event.to_string()
	if new_state:
		change_state(new_state)

func process_frame(delta: float) -> void:
	var new_state = current_state_machine.process_frame(delta)
	if new_state:
		change_state(new_state)
