extends State

class_name LandingState

@export var landing_animation : String = "RESET"
@export var ground_state : State

@onready var jump_timer : Timer = $JumpBuffer

func on_enter():
	jump_timer.start()

func state_input(event : InputEvent):
	if event.is_action_pressed("jump"):
		character.jump_buffer = true


func _on_animation_tree_animation_finished(anim_name):
	if anim_name == landing_animation:
		next_state = ground_state
