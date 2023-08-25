extends State

class_name GroundState

@export var jump_velocity = -900.0
@export var air_state : State
@export var jump_animation : String = "jump"
@export var attack_state : State
@export var attack_node : String = "attack1"
@export var wall_state : State

@onready var coyote_timer : Timer = $Coyote

var coyote_time_start = false
var condition = false


func state_process(delta):

	if character.is_on_floor():
		if character.jump_buffer:
			jump()

	if not character.is_on_floor() and not coyote_time_start:
		coyote_timer.start()
		coyote_time_start = true
		
	if coyote_timer.is_stopped() and coyote_time_start:
		next_state = air_state
		coyote_time_start = false
	

func state_input(event : InputEvent):
	
	if Input.is_action_just_pressed("jump"):
		jump()
		
	if event.is_action_pressed("attack"):
		attack()
		
		
func jump():
	character.velocity.y = jump_velocity
	next_state = air_state
	playback.travel(jump_animation)
	
func attack():
	next_state = attack_state
	playback.travel(attack_node)

# Called when the node enters the scene tree for the first time.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_jump_buffer_timeout():
	character.jump_buffer = false
