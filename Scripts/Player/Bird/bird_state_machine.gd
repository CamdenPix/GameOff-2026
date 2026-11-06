@icon("res://assets/animal-footprint-svgrepo-com.svg")

class_name Bird extends ChildStateMachine


@export var sugar_bear: SugarBear

func animal_process_physics(delta:float) -> ChildStateMachine:
	return
func animal_process_input(event: InputEvent) -> ChildStateMachine:
	
	if Input.is_action_just_pressed("down"):
		if animal_changer.request_new_animal(self, sugar_bear):
			return sugar_bear
	return
func animal_process_frame(delta: float ) -> ChildStateMachine:
	return
