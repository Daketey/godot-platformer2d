extends CharacterBody2D

class_name Enemy

@export var starting_move_direction : Vector2 = Vector2.LEFT
@export var hit_state : State
@export var raycast : RayCast2D
@export var check_pit : RayCast2D
@export var body : Node2D

@onready var sprite : Sprite2D = $Body/Sprite2D
@onready var state_machine : CharacterStateMachine = $Body/CharacterStateMachine
@onready var animation_tree : AnimationTree = $Body/AnimationTree


const SPEED = 60

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 120
var direction : Vector2 = Vector2.ZERO


signal facing_direction_changed(facing_right : bool)
var childrens

func _ready():
	childrens  = get_all_children(self)
	animation_tree.active = true
	direction = starting_move_direction
	velocity.x = direction.x * SPEED


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if raycast.is_colliding() or not check_pit.is_colliding():
		direction.x = -1 * direction.x
		update_flip_direction()
	
	# Get the input direction and handle the movement/deceleration.
	if direction and state_machine.check_can_move():
		velocity.x = direction.x * SPEED

	move_and_slide()
	
func update_flip_direction():
	if abs(direction.x) > 0:
		body.scale.x = sign(direction.x)
			

func _on_check_bounds_flip_signal(direction_sign : int):
	direction.x = -1 * direction.x
	update_flip_direction()
	
func get_all_children(in_node, arr:=[]):
	arr.push_back(in_node)
	for child in in_node.get_children():
		arr = get_all_children(child,arr)
	return arr
