extends Node2D

onready var tilemap: Node2D = get_node("floor")

func _ready():
	print(tilemap.cell_size)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

#func _input(event):
#	if event is InputEventMouseButton:
#		if event.button_index == BUTTON_LEFT and event.pressed:
#			print("Left button was clicked at ", event.position)
#			
#			var pos:Vector2 = event.position
#			var tile:Vector2 = world_to_map(pos)
#			var cell:int = get_cellv(tile)
#			print(cell)
#			set_cellv(tile, 3)
#			
#		if event.button_index == BUTTON_WHEEL_UP and event.pressed:
#			print("Wheel up")