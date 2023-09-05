extends Area2D

signal enter_player(has_entered)

@onready var timer = $Timer2

var enter = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _on_body_entered(body):
	emit_signal("enter_player", true)
	enter = true


func _on_body_exited(body):
	enter = false
	timer.start()


func _on_timer_2_timeout():
	if not enter:
		emit_signal("enter_player", false)
