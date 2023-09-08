extends CharacterBody2D


const SPEED = 80.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 0

@export var player : CharacterBody2D
@export var body : Node2D

@onready var animation_tree : AnimationTree = $Body/AnimationTree


var direction = Vector2.ZERO

func _ready():
	animation_tree.active = true

func _physics_process(delta):
	direction_flip()
	move_and_slide()

	
func direction_flip():
	if abs(velocity.x) > 0:
		body.scale.x = sign(velocity.x)
