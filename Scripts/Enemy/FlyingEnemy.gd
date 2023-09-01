extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var player : CharacterBody2D


func _physics_process(delta):
	# Add the gravity.
	look_at(player.global_position)

	move_and_slide()
