class_name AnimalChanger extends Node2D


signal horizontal_pushed_out_of_wall
signal vertical_pushed_out_of_floor
signal change_shape

@export var animals_list : Array[ChildStateMachine]

@export var bird: Bird
@export var sugar_bear: SugarBear


#@export var area_checker: Area2D
#@export var area_checker_collision_shape: CollisionShape2D
@export var hurtbox_collision_shape: CollisionShape2D
@export var player_collision_shape: CollisionShape2D
@export var horizontal_wall_collison_margin: float = 3

@export var right_wall_cast: RayCast2D
@export var left_wall_cast: RayCast2D


@export var parent: Player



enum body_possible_return_values {
	NONE,
	FLOOR,
	WALL,
	FLOOR_AND_WALL,
}
enum wall_possible_return_values {
	LEFT,
	RIGHT,
	NONE,
	BOTH
}
var tranistion_list: Array[AnimalTransition]

	

func _ready() -> void:
	#pass
	#request_new_animal(bird, sugar_bear)
	for first_animal in animals_list:
		for second_animal in animals_list:
			if first_animal == second_animal:
				continue
			create_transition_area2d(first_animal, second_animal)

func find_animal_transition(start_animal: ChildStateMachine, end_animal: ChildStateMachine) -> AnimalTransition:
	
	for transition in tranistion_list:
		if transition.from_animal == start_animal and transition.from_animal == end_animal:
			return transition
	
	return null

func create_transition_area2d(start_animal: ChildStateMachine, end_animal: ChildStateMachine):
	if start_animal is Deactive:
		return 
	if end_animal is Deactive:
		return
	
	var start_animal_collision_shape: Shape2D = start_animal.animal_resource.shape
	var end_animal_collision_shape: Shape2D = end_animal.animal_resource.shape
	
	
	
	if start_animal_collision_shape == null:
		push_error(start_animal.name +' is misising an animal resourece collision shape. please put it in ')
		return
	if end_animal == null:
		push_error(end_animal.name +' is misising an animal resourece collision shape. please put it in ')
		return
	
	
	###
	### Gotta check if the collsion shape would move the player down or up
	var end_animal_shape_rect: Rect2 = end_animal_collision_shape.get_rect()
	var start_animal_shape_rect: Rect2 = start_animal_collision_shape.get_rect()
	
	var shape_difference: Vector2 = start_animal_shape_rect.size - end_animal_shape_rect.size 
	
	
	### if the start animal is smaller than the end animal in both ways who fucking cares
	if shape_difference.x >= 0 and shape_difference.y >= 0:
		return
	
	var horizontal_distance_away: float = abs(shape_difference.x ) / 2
	
	var area : Area2D = Area2D.new()
	var raycast_distance_away_from_ground : RayCast2D = RayCast2D.new()
	
	
	raycast_distance_away_from_ground.target_position.x = 0
	raycast_distance_away_from_ground.target_position.y = abs(shape_difference.y) / 2 
	
	
	area.name ="transition from " +  start_animal.name + " to " + end_animal.name
	
	add_child(area)
	
	var collision: CollisionShape2D = CollisionShape2D.new()
	
	area.add_child(collision)
	
	add_child(raycast_distance_away_from_ground)
	collision.shape = end_animal.animal_resource.shape
	
	
	var animal_transition: AnimalTransition = AnimalTransition.new()
	
	animal_transition.vertical_difference = abs(shape_difference.y ) / 2
	animal_transition.raycast_distance_away_from_ground = raycast_distance_away_from_ground
	animal_transition.parent = parent
	animal_transition.area = area
	animal_transition.from_animal = start_animal
	animal_transition.to_animal = end_animal
	
	add_child(animal_transition)
	tranistion_list.append(animal_transition)
	area.body_entered.connect(animal_transition.body_entered)
	area.body_exited.connect(animal_transition.body_exited)
	
	
	
	
	
	
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
	
	
	#######
	###			If shape difference is bigger than that mean the new animal's size is bigger. 
	
	##			So if the player is touching the floor or the fucking wall we gotta move em a bit to compensate
	######
	var check : body_possible_return_values = check_for_walls_floors()
	var transition:AnimalTransition = find_animal_transition(current_animal, new_animal)
	print(body_possible_return_values.find_key(check),", from: ", current_animal.name + ', to: '+ new_animal.name)
	match check:
		### the player isnt touching ANYTHING
		body_possible_return_values.NONE:
			
			
			change_collision_shapes(new_animal_collision_shape, shape_difference)
			return true
			
		body_possible_return_values.FLOOR:
			
			if shape_difference.y > 0:
				parent.global_position.y -= shape_difference.y/2
			if shape_difference.y < 0:
				parent.global_position.y -= shape_difference.y/2
			change_collision_shapes(new_animal_collision_shape, shape_difference)
			
			return true
		body_possible_return_values.WALL:
			
			if shape_difference.x > 0:
				var wall_side : wall_possible_return_values = check_wall_side()
				match  wall_side:
					wall_possible_return_values.NONE:
						push_error('EH in request_new_animal the character is touching a wall and the raycast didnt get it')
						return false
				
					wall_possible_return_values.LEFT:
						parent.global_position.x += shape_difference.x / 2
					
					wall_possible_return_values.RIGHT:
						parent.global_position.x -= shape_difference.x / 2
					
					wall_possible_return_values.BOTH:
						push_warning('AYYYY in request_new_animal the character is touching two walls!! is this intentional?')
						return false
				
			change_collision_shapes(new_animal_collision_shape, shape_difference)
			
		
			return true
		body_possible_return_values.FLOOR_AND_WALL:
			if shape_difference.y > 0:
				parent.global_position.y -= shape_difference.y/2
			if shape_difference.x > 0:
				parent.global_position.x += shape_difference.x / 2
			change_collision_shapes(new_animal_collision_shape, shape_difference)
			return true
	
	

	
	
	return false

func check_wall_side() -> wall_possible_return_values:
	var right_collider = right_wall_cast.get_collider()
	var left_collider = left_wall_cast.get_collider()
	
	if left_collider is TileMapLayer and right_collider == null:
		return wall_possible_return_values.LEFT
		
	if right_collider is TileMapLayer and left_collider == null:
		return wall_possible_return_values.RIGHT
	if right_collider is TileMapLayer and left_collider is TileMapLayer:
		return wall_possible_return_values.BOTH
		
	return wall_possible_return_values.NONE
	

func change_collision_shapes(new_shape: Shape2D, shape_difference: Vector2):

	
	hurtbox_collision_shape.set_shape(new_shape) 
	
	player_collision_shape.set_shape(new_shape)
	var new_shape_fucking_uh_horizontal: float = new_shape.get_rect().size.x/2
	right_wall_cast.target_position.x = new_shape_fucking_uh_horizontal + horizontal_wall_collison_margin
	left_wall_cast.target_position.x = (new_shape_fucking_uh_horizontal+ horizontal_wall_collison_margin) * -1
	

func check_for_walls_floors() -> body_possible_return_values:
	if parent.is_on_floor_only():
		return body_possible_return_values.FLOOR
	if parent.is_on_floor() and parent.is_on_wall():
		return body_possible_return_values.FLOOR_AND_WALL
	if parent.is_on_wall_only():
		return body_possible_return_values.WALL
	
	
	return body_possible_return_values.NONE


	
