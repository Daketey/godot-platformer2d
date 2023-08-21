extends CharacterBody2D

class_name Player

@export var speed : float = 200.0
@export var hit_state : State

@onready var sprite : Sprite2D = $Sprite2D
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine : CharacterStateMachine = $CharacterStateMachine

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction : Vector2 = Vector2.ZERO

signal facing_direction_changed(facing_right : bool)

func _ready():
		animation_tree.active = true

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

			
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("left", "right", "up", "down")
	if direction.x != 0 and state_machine.check_can_move():
		velocity.x = direction.x * speed
	elif state_machine.current_state != hit_state:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	move_and_slide()
	update_animation()
	update_flip_direction()
	
func update_animation():
	animation_tree.set("parameters/move/blend_position", direction.x)

func update_flip_direction():
	if direction.x > 0:
			sprite.flip_h = false
	elif direction.x < 0:
			sprite.flip_h = true
			
	emit_signal("facing_direction_changed", sprite.flip_h)
