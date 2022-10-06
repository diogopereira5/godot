extends TileMap

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
