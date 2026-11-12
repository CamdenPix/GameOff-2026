@tool
class_name TargetPosition extends Area2D

@export var target: Target
#@export var target_position_string: Vector2 
signal control_camera( target_position:Vector2 )
var child_target: Target
var default_font : Font

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		pass
	pass # Replace with function body.


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		pass
	pass # Replace with function body.

###
###			This shit below is for rendering the line 2d for the target. if you understand it i applaud you lol
###

func _ready() -> void:
	
	set_collision_mask_value(1, false)
	set_collision_layer_value(1, false)
	set_collision_mask_value(2, true)


func _process(delta):
	if Engine.is_editor_hint():
		queue_redraw()

func _draw() -> void:
	default_font = ThemeDB.fallback_font
	draw_string(default_font, Vector2(-40, 20), "Target \nPosition", HORIZONTAL_ALIGNMENT_CENTER, 100, 10)
	if target:
		draw_line( to_local(global_position), to_local(target.global_position), Color.LIGHT_CORAL, 3.8)
	pass
	
#
#
#func _on_child_entered_tree(node: Node) -> void:
	##for child in get_children():
		##if child is Target:
			##pass
	#if node is Target:
		#child_target = node
		#target = node
		##if line == null:
		#var gradient = Gradient.new()
		#gradient.set_color( 0,   Color.MINT_CREAM )
		#gradient.set_color( 1,   Color.WEB_GRAY )
		#line = Line2D.new()
			##var position1 = line.to_local(global_position)
		#var position2 = line.to_local(child_target.global_position)
		#line.add_point(position)
		#line.add_point(position2)
			#
			##add_child(line)
		#line.set_gradient(gradient)
		#line.width = 3.0
			##line.width_curve
		#add_fucking_line.call_deferred(line)
		#
#
#func add_fucking_line(line:Line2D):
	#add_child(line)
	#line.owner = get_tree().edited_scene_root
#
#
#func _on_child_exiting_tree(node: Node) -> void:
	#if node == target:
		#child_target = null
		#target = null
		##if line:
			##line.queue_free()
	#if node == line:
		#line = null
		##line = null
	##line = null
