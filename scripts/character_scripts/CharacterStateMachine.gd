extends Node

class_name CharacterStateMachine

@export var character : CharacterBody2D
@export var animation_tree : AnimationTree
@export var current_state : State

var states : Array[State]


# Called when the node enters the scene tree for the first time.
func _ready():
	
	for child in get_children():
			if child is State:
				states.append(child)
				# Set state up with what they would need to function
				child.character = character
				child.playback = animation_tree["parameters/playback"]
				
				child.connect("interrupt_signal", on_state_interrput_state)
				
			else:
				push_warning("Child "+ child.name + " is not a CharacterStateMachine") 

func _physics_process(delta):
	if current_state.next_state != null:
		switch_states(current_state.next_state)
	current_state.state_process(delta)

func check_can_move():
	return current_state.can_move
	
func switch_states(new_state : State):
	# Advance logic with on_enter and on_exit for advance logic later on
		if current_state != null:
			current_state.on_exit()
			current_state.next_state = null
		current_state = new_state
		current_state.on_enter()
		
func on_state_interrput_state(new_state : State):
	switch_states(new_state)
		
func _input(event : InputEvent):
		current_state.state_input(event)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
