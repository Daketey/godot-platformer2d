extends State

@export var return_state : State
@export var air_state : State
@export var return_animation_node : String = "move"
@export var left_attack : String = "attack1"
@export var right_attack : String = "attack2"

@onready var timer : Timer = $Timer
@onready var air_timer : Timer = $AirTimer

var air_attack = false

func state_process(delta):
	if not character.is_on_floor() and air_attack:
		character.velocity.y = 0
	
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
		air_attack = false
		next_state = return_state
		playback.travel(return_animation_node)
		
