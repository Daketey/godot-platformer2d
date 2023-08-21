extends Node

class_name State

@export var can_move : bool = true


var character : CharacterBody2D
var playback : AnimationNodeStateMachinePlayback
var next_state : State

signal interrupt_signal(new_state : State)

func state_process(delta):
	pass

func state_input(event : InputEvent):
	pass
	
func on_enter():
	# For extra functionality later on
	pass
	
func on_exit():
	# For extra functionality later on
	pass
