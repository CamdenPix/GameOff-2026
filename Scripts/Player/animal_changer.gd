class_name AnimalChanger extends Node2D


signal horizontal_pushed_out_of_wall
signal vertical_pushed_out_of_floor
signal change_shape

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
	
	match check:
		body_possible_return_values.NONE:
			pass
		body_possible_return_values.FLOOR:
			pass
		body_possible_return_values.WALL:
			pass
		body_possible_return_values.FLOOR_AND_WALL:
			pass
	
	match new_animal:
		bird:
			if bird_area_bodies.is_empty():
				pass
		sugar_bear:
			if sugar_bear_area_bodies.is_empty():
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
