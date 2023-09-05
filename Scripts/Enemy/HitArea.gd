extends Area2D

signal attack_player(has_entered)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	emit_signal("attack_player", true)


func _on_body_exited(body):
	emit_signal("attack_player", false)
