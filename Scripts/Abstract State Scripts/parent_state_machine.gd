@abstract
class_name ParentStateMachine extends Node
@export 
var debug_state_machine_label : Label


@export
var no_debug_labels: bool = false

@export
var starting_state_machine: ChildStateMachine

var current_state_machine: ChildStateMachine



@export var deactive_state: ChildStateMachine
@export var base_state: ChildStateMachine

func init(parent: Player) -> void:
	for child in get_children():
		print(child)
	change_state_machine(starting_state_machine)

func change_state_machine(new_state_machine: ChildStateMachine) -> void:
	if current_state_machine:
		current_state_machine.exit(new_state_machine)
	var old_state_machine = current_state_machine
	current_state_machine = new_state_machine
	if no_debug_labels == false:
		debug_state_machine_label.text = new_state_machine.to_string()
	current_state_machine.enter(old_state_machine)


func process_physics(delta: float) -> void:
	
	var new_state_machine = current_state_machine.process_physics(delta)
	if new_state_machine:
		change_state_machine(new_state_machine)

func process_input(event: InputEvent) -> void:
	
	var new_state_machine = current_state_machine.process_input(event)

	if new_state_machine:
		change_state_machine(new_state_machine)

func process_frame(delta: float) -> void:
	var new_state_machine = current_state_machine.process_frame(delta)
	if new_state_machine:
		change_state_machine(new_state_machine)
