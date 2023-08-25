extends CharacterBody2D

class_name Player

@export var speed : float = 150.0
@export var hit_state : State
@export var wall_state : State

@onready var sprite : Sprite2D = $Sprite2D
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine : CharacterStateMachine = $CharacterStateMachine

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction : Vector2 = Vector2.ZERO
var acceleration = 50
var friction = 0.2
const MAX_VELOCITY = 160
const gravity = 150
var air_time = 0.0
var jump_buffer = false

@export var jump_height : float
@export var jump_time_to_peak : float
@export var jump_time_to_descent : float

@onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0


signal facing_direction_changed(facing_right : bool)

func _ready():
		animation_tree.active = true

func _physics_process(delta):
	# Add the gravity.
	direction= Vector2.ZERO
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction.x = Input.get_axis("left", "right")
	direction = direction.normalized()
	if direction != Vector2.ZERO:
		add_acceleration(direction)
		velocity.x = clamp(velocity.x, -MAX_VELOCITY, MAX_VELOCITY)
		update_animation(direction.x)
	else:
		add_friction(friction)
		update_animation(0)
		
	move_and_slide()
	
#	velocity.y = clamp(velocity.y, -MAX_VELOCITY, gravity)
#	velocity = velocity.normalized()
	velocity.y += get_gravity() * delta
	update_flip_direction()
	
func add_acceleration(direction):
		velocity.x += direction.x*speed
#		velocity = velocity.move_toward(speed*direction , acceleration)
		
func add_friction(friction):
		velocity.x = lerp(velocity.x, 0.0 , friction)

func update_animation(direction):
	animation_tree.set("parameters/move/blend_position", direction)
	

func get_gravity() :
	return jump_gravity if velocity.y < 0.0 else fall_gravity


func update_flip_direction():
	if direction.x > 0:
			sprite.flip_h = false
	elif direction.x < 0:
			sprite.flip_h = true
			
	emit_signal("facing_direction_changed", sprite.flip_h)
