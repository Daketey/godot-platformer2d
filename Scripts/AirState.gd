extends State

class_name  AirState

@export var landing_state : State
@export var double_jump_velocity : float = -200
@export var attack_state : State
@export var attack_node : String = "attack1"

var double_jumped : bool = false

func state_process(delta):
	if character.is_on_floor():
		next_state = landing_state
		
func state_input(event : InputEvent):
	if event.is_action_pressed("jump") and !double_jumped:
		double_jump()
	if event.is_action_pressed("attack"):
		attack()
		
func on_exit():
	if next_state == landing_state:
		playback.travel("RESET")
		double_jumped = false
	
func double_jump():
	character.velocity.y = double_jump_velocity
	double_jumped = true

func attack():
	next_state = attack_state
	playback.travel(attack_node)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
