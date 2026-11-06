class_name AnimalChanger extends Node



@export var bird_area_checker: Area2D
@export var bird_area_checker_collision_shape: CollisionShape2D

@export var sugar_bear_area_checker: Area2D
@export var sugar_bear_area_checker_collision_shape: CollisionShape2D

#@export var area_checker: Area2D
#@export var area_checker_collision_shape: CollisionShape2D

@export var player_collision_shape: CollisionShape2D
@export var debug_view: bool



func request_new_animal(current_animal: ChildStateMachine, new_animal: ChildStateMachine) -> bool:
	
	## this could be for cutscenes or some shit idfk 
	## its always important to be able to take control from the player
	if new_animal is Deactive:
		return true
	
	var new_animal_collision_shape: Shape2D = new_animal.animal_resource.shape
	if new_animal_collision_shape == null:
		push_error(new_animal.name +' is misising an animal resourece collision shape. please put it in ')
		return false
		
	###
	### Gotta check if the collsion shape would move the player down or up
	var current_animal_shape_rect: Rect2 = current_animal.animal_resource.shape.get_rect()
	var new_animal_shape_rect: Rect2 = new_animal.animal_resource.shape.get_rect()
	var shape_difference: Vector2 = current_animal_shape_rect.size - new_animal_shape_rect.size
	
	if new_animal is Bird:
		
		pass
	if new_animal is SugarBear:
		pass
	
	return false
