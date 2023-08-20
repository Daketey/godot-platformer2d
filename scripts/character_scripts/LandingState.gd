extends State

class_name LandingState

@export var landing_animation : String = "RESET"
@export var ground_state : State



func _on_animation_tree_animation_finished(anim_name):
	if anim_name == landing_animation:
		next_state = ground_state
