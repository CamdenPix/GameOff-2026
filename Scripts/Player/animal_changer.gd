class_name AnimalChanger extends Node2D


signal horizontal_pushed_out_of_wall
signal vertical_pushed_out_of_floor
signal change_shape

@export var animals_list : Array[ChildStateMachine]

@export var bird: Bird
@export var sugar_bear: SugarBear

@export var bird_area_checker: Area2D
@export var bird_area_checker_collision_shape: CollisionShape2D

@export var sugar_bear_area_checker: Area2D
@export var sugar_bear_area_checker_collision_shape: CollisionShape2D

#@export var area_checker: Area2D
#@export var area_checker_collision_shape: CollisionShape2D
@export var hurtbox_collision_shape: CollisionShape2D
@export var player_collision_shape: CollisionShape2D
@export var horizontal_pixel_collison_margin: float = 3
@export var vertical_pixel_collsion_margin:float = 3

@export var right_cast: RayCast2D
@export var left_cast: RayCast2D
@export var up_cast: RayCast2D
@export var down_cast: RayCast2D

@export var parent: Player

var sugar_bear_area_bodies: Array[Node2D] = []
var bird_area_bodies: Array[Node2D] = []

enum body_possible_return_values {
	NONE,
	FLOOR,
	WALL,
	FLOOR_AND_WALL,
}

var tranistion_list: Array[AnimalTransition]


func _ready() -> void:
	for first_animal in animals_list:
		for second_animal in animals_list:
			if first_animal == second_animal:
				continue
			create_left_and_right_transition_area2d(first_animal, second_animal)

func find_animal_transition(start_animal: ChildStateMachine, end_animal: ChildStateMachine) -> AnimalTransition:
	
	for transition in tranistion_list:
		if transition.from_animal == start_animal and transition.from_animal == end_animal:
			return transition
	
	return null

func create_left_and_right_transition_area2d(start_animal: ChildStateMachine, end_animal: ChildStateMachine):
	if start_animal is Deactive:
		return 
	if end_animal is Deactive:
		return
	
	var start_animal_collision_shape: Shape2D = start_animal.animal_resource.shape
	var end_animal_collision_shape: Shape2D = end_animal.animal_resource.shape
	
	
	
	if start_animal_collision_shape == null:
		push_error(start_animal.name +' is misising an animal resourece collision shape. please put it in ')
		return false
	if end_animal == null:
		push_error(end_animal.name +' is misising an animal resourece collision shape. please put it in ')
		return false
	
	
	###
	### Gotta check if the collsion shape would move the player down or up
	var end_animal_shape_rect: Rect2 = end_animal_collision_shape.get_rect()
	var start_animal_shape_rect: Rect2 = start_animal_collision_shape.get_rect()
	
	var shape_difference: Vector2 = start_animal_shape_rect.size - end_animal_shape_rect.size 
	var horizontal_distance_away: float = shape_difference.x 
	
	var left_area : Area2D = Area2D.new()
	var right_area : Area2D = Area2D.new()
	
	add_child(left_area)
	add_child(right_area)
	
	var left_collision: CollisionShape2D = CollisionShape2D.new()
	var right_collision: CollisionShape2D = CollisionShape2D.new()
	
	left_area.add_child(left_collision)
	right_area.add_child(right_collision)
	
	left_collision.shape = end_animal.animal_resource.shape
	right_collision.shape = end_animal.animal_resource.shape
	
	left_area.position.x = -horizontal_distance_away
	right_area.position.x = horizontal_distance_away
	
	var animal_transition: AnimalTransition = AnimalTransition.new()
	
	add_child(animal_transition)
	tranistion_list.append(animal_transition)
	left_area.body_entered.connect(animal_transition.left_body_entered)
	left_area.body_exited.connect(animal_transition.left_body_exited)
	
	right_area.body_entered.connect(animal_transition.right_body_entered)
	right_area.body_exited.connect(animal_transition.right_body_exited)
	
	animal_transition.left_area = left_area
	animal_transition.right_area = right_area
	
	animal_transition.from_animal = start_animal
	animal_transition.to_animal = end_animal
	
	
	pass

func request_new_animal(current_animal: ChildStateMachine, new_animal: ChildStateMachine) -> bool:
	
	## this could be for cutscenes or some shit idfk 
	## its always important to be able to take control from the player
	if new_animal is Deactive:
		return true
	
	var new_animal_collision_shape: Shape2D = new_animal.animal_resource.shape
	var current_animal_collision_shape: Shape2D = current_animal.animal_resource.shape
	
	
	
	if new_animal_collision_shape == null:
		push_error(new_animal.name +' is misising an animal resourece collision shape. please put it in ')
		return false
	if current_animal == null:
		push_error(current_animal.name +' is misising an animal resourece collision shape. please put it in ')
		return false
	
	
	###
	### Gotta check if the collsion shape would move the player down or up
	var current_animal_shape_rect: Rect2 = current_animal_collision_shape.get_rect()
	var new_animal_shape_rect: Rect2 = new_animal_collision_shape.get_rect()
	
	var shape_difference: Vector2 = new_animal_shape_rect.size - current_animal_shape_rect.size 
	
	
	var check : body_possible_return_values = check_for_walls_floors()
	var transition:AnimalTransition = find_animal_transition(current_animal, new_animal)
	
	match check:
		### the player isnt touching ANYTHING
		body_possible_return_values.NONE:
			change_collision_shapes(new_animal_collision_shape)
			return true
			
		body_possible_return_values.FLOOR:
			change_collision_shapes(new_animal_collision_shape)
			parent.global_position.y += shape_difference.y
			return true
		body_possible_return_values.WALL:
			
			### Move the new animal shape to the left by shape difference x / 2
			## THEN check if its empty 
			pass
		body_possible_return_values.FLOOR_AND_WALL:
			pass
	
	

	
	
	return false

func change_collision_shapes(new_shape: Shape2D):
	hurtbox_collision_shape.shape = new_shape
	player_collision_shape.shape = new_shape
	

func check_for_walls_floors() -> body_possible_return_values:
	if parent.is_on_floor_only():
		return body_possible_return_values.FLOOR
	if parent.is_on_floor() and parent.is_on_wall():
		return body_possible_return_values.FLOOR_AND_WALL
	if parent.is_on_wall_only():
		return body_possible_return_values.WALL
	
	
	return body_possible_return_values.NONE


func shape_difference_check(shape_difference: Vector2) -> bool:
	
	## if the shape difference is positive then the new shape is bigger
	if shape_difference.x > 0:
		move_horizontal_raycasts_and_check(shape_difference.x)
			
			
	
	return false

func move_horizontal_raycasts_and_check(x_difference: float):
	var half_x_difference: float = x_difference / 2
	right_cast.position.x = half_x_difference
	left_cast.position.x = -half_x_difference
	
	right_cast.target_position.x = horizontal_pixel_collison_margin
	left_cast.target_position.x = -horizontal_pixel_collison_margin
	
	
	return false

func _on_sugar_bear_area_checker_body_entered(body: Node2D) -> void:
	sugar_bear_area_bodies.append(body)


func _on_sugar_bear_area_checker_body_exited(body: Node2D) -> void:
	sugar_bear_area_bodies.erase(body)


func _on_bird_area_checker_body_entered(body: Node2D) -> void:
	bird_area_bodies.append(body)


func _on_bird_area_checker_body_exited(body: Node2D) -> void:
	bird_area_bodies.erase(body)
