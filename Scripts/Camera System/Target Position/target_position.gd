@tool
class_name TargetPosition extends PlayerTrigger

@export var target: Target
signal control_camera( target_position:Vector2 )
var child_target: Target
var default_font : Font


func use_enter_trigger(body: Node2D) -> void:
	if target:
		body.target_camera_position(target.global_position)
	pass
func use_exit_trigger(body: Node2D) -> void:
	body.return_camera_state_machine_to_default()
	pass



###
###			This shit below is for rendering the line 
###



func _process(delta):
	if Engine.is_editor_hint():
		queue_redraw()

func _draw() -> void:
	default_font = ThemeDB.fallback_font
	draw_string(default_font, Vector2(-40, 20), "Target \nPosition", HORIZONTAL_ALIGNMENT_CENTER, 100, 10)
	if target:
		draw_line( to_local(global_position), to_local(target.global_position), Color.LIGHT_CORAL, 3.8)
	pass
	
