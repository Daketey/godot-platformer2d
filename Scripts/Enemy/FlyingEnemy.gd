extends CharacterBody2D


const SPEED = 80.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var player : CharacterBody2D
@export var tracking_area: Area2D
@export var body : Node2D

@onready var nav_agent = $Body/NavigationAgent2D

@onready var sprite : Sprite2D = $Body/Sprite2D
@onready var state_machine : CharacterStateMachine = $Body/CharacterStateMachine
@onready var animation_tree : AnimationTree = $Body/AnimationTree
@onready var timer : Timer = $Timer


signal facing_direction_changed(facing_right : bool)


var tracking = false
var childrens
var direction = Vector2.ZERO

func _ready():
	childrens  = get_all_children(self)
	tracking_area.connect("enter_player", track_player)
	animation_tree.active = true


func _physics_process(delta):
	if tracking:
		direction = to_local(nav_agent.get_next_path_position()).normalized()
		
	else:
		if timer.is_stopped():
			direction = Vector2(randi()%2 - randi()%2, randi()%2 - randi()%2)
			timer.start()
		
	if direction != Vector2.ZERO and state_machine.check_can_move():
			velocity = direction*SPEED
			direction_flip(direction)
		
	move_and_slide()

func track_player(is_in_area):
	tracking = is_in_area
	
func make_path():
	if tracking:
		nav_agent.target_position = player.global_position
	
func direction_flip(direction):
	if abs(direction.x) > 0:
		body.scale.x = sign(direction.x)

func _on_timer_timeout():
	make_path()

func get_all_children(in_node, arr:=[]):
	arr.push_back(in_node)
	for child in in_node.get_children():
		arr = get_all_children(child,arr)
	return arr
