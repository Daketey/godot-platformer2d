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
var direction : Vector2 = Vector2.ZERO


signal facing_direction_changed(facing_right : bool)

func _ready():
	animation_tree.active = true
	direction = starting_move_direction
	velocity.x = direction.x * SPEED


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Get the input direction and handle the movement/deceleration.
	if direction and state_machine.check_can_move():
		velocity.x = direction.x * SPEED

	move_and_slide()
	
func update_flip_direction():
	if direction.x > 0:
			sprite.flip_h = true
	elif direction.x < 0:
			sprite.flip_h = false
			
	emit_signal("facing_direction_changed", sprite.flip_h)
	

func _on_check_bounds_flip_signal(direction_sign : int):
	direction.x = -1 * direction.x
	update_flip_direction()
