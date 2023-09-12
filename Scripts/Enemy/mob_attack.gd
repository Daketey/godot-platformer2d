extends CharacterBody2D

class_name MobEnemy

@export var body : Node2D
@export var player : CharacterBody2D

@onready var sprite : Sprite2D = $Body/Sprite2D
@onready var state_machine : CharacterStateMachine = $Body/CharacterStateMachine
@onready var animation_tree : AnimationTree = $Body/AnimationTree


const SPEED = 60

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 120

func _ready():
	animation_tree.active = true


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity
	
	update_flip_direction()
	move_and_slide()
	
func update_flip_direction():
	if abs(velocity.x) > 0:
		body.scale.x = sign(velocity.x)
			
