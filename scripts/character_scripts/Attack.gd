extends State

@export var return_state : State
@export var return_animation_node : String = "move"
@export var left_attack : String = "attack1"
@export var right_attack : String = "attack2"

@onready var timer : Timer = $Timer

func state_input(event : InputEvent):
	if event.is_action_pressed("attack"):
		timer.start()

func _on_animation_tree_animation_finished(anim_name):
	if anim_name == left_attack:
		if timer.is_stopped():
			next_state = return_state
			playback.travel(return_animation_node)
		else:
			playback.travel(right_attack)
		
	if anim_name == right_attack:
		next_state = return_state
		playback.travel(return_animation_node)
		
