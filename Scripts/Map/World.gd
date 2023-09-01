extends Node2D

#var borders = Rect2(1, 1, 38, 21)

var spike = preload("res://Scenes/spike.tscn")

@onready var player : CharacterBody2D = $Player
@onready var enemy : CharacterBody2D = $enemy
@onready var tileMap = $TileMap

var starting_postiion

func _ready():
	randomize()
	generate_level()


func generate_level():
	
	var map_details = {}
	var selected_cells = {}
	var starting_postiion
	var start1 = 1
	var start2 = 1
		
	var borders = Rect2(start1, start2 , 38 , 21)
	var walker = Walker.new(Vector2(start1, start2), borders, tileMap)
	var map = walker.walk(600)
	starting_postiion = map.front()
	var end_position = walker.get_end_room().position
	walker.queue_free()

	tileMap.set_cells_terrain_connect(0, map, 0, -1)
	var rooms = walker.return_rooms()
	for room in rooms:
		for r in room.room:
			if randi()%2 == 1:
				selected_cells[r] = 1 #Select Cells randomly
				
	var al = walker.get_rooms()
	var al_room = []
	var count = 0
	for room in al:
		al_room.append(room.position)
		
		
	for i in range(al_room.size()+1):
		if al_room[i].x ==  al_room[i+1].x:
			for j in range(al_room[i].y, al_room[i+1].y+1):
				al_room.append(Vector2(al_room[i].x, j))
		if al_room[i].y ==  al_room[i+1].y:
			for j in range(al_room[i].x, al_room[i+1].x+1):
				al_room.append(Vector2(j,al_room[i].y))
				
	for i in al_room:
		selected_cells[i] = 0
				
#	tileMap.set_cells_terrain_connect(0, al_room, 0, -1)
	
	for i in map_details.keys():
		if (map_details[i].left and map_details[i].right) and map_details[i].down and not map_details[i].up:
			var scene_instance = spike.instantiate()
			add_child(scene_instance)
			scene_instance.position = (i + Vector2(0.75,0.5))* 32
#			tileMap.set_cell(0, i, 1, Vector2(0 , 5))
#			scene_instance.position = i*32
	var x = randi()%20 +4
#	player.position = starting_postiion*32
#		tileMap.set_cell(0, starting_postiion, 3, Vector2(14 , 4)) #use this somehow	
#		tileMap.set_cell(0, end_position, 3, Vector2(12 , 4)) #use this somehow	

func reload_level():
	get_tree().reload_current_scene()
	
func _input(event):
	if event.is_action_pressed("enter"):
		reload_level()

