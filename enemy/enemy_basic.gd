extends CharacterBody2D

class_name Enemy

@export var starting_move_direction : Vector2 = Vector2.LEFT
@export var hit_state : State

@onready var sprite : Sprite2D = $Sprite2D
@onready var state_machine : CharacterStateMachine = $CharacterStateMachine
@onready var animation_tree : AnimationTree = $AnimationTree

const SPEED = 30

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	animation_tree.active = true


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction : Vector2 = starting_move_direction
	if direction and state_machine.check_can_move():
		velocity.x = direction.x * SPEED
	elif state_machine.current_state != hit_state:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
