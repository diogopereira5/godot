extends KinematicBody2D

var NeuralNetwork = preload("res://scripts/neural_network.gd")
onready var Map := get_tree().get_root().get_node("Main").get_node("Map")
var random = RandomNumberGenerator.new()
var foodPos = -1

export (int) var speed = 100
var velocity = Vector2()
var inputs: Array
var neural

func _init():
	neural = NeuralNetwork.new()
	neural.start(5,10,4)
	random.randomize()

func _physics_process(delta):
	# pegar atributos para a rede neural
	var pos = get_transform()[2]
	var tilemap = Map.get_node("floor")
	var tile:Vector2 = tilemap.world_to_map(pos)
	var cell_id:int = tilemap.get_cellv(tile)
	var food = tilemap.get_used_cells_by_id(0)


	if food.size() > 0:
		#var map_size = tilemap.cell_size
		print(cell_id)
		print(tile)
		print(food[0])
		inputs = neural.think(cell_id, tile[0], tile[1], food[0][0], food[0][1])
		if cell_id >= 0:
			move(delta)
	
func move(delta):
	
	velocity = Vector2()
	
	if inputs.size() > 0:
		
		var count = 0
		var max_value = 0
		var max_value_pos = 0
		
		# pegar o maior valor da rede neural
		for i in inputs:
			if count == 0:
				max_value = i
				max_value_pos = count
			elif i > max_value:
				max_value = i
				max_value_pos = count
			count += 1
		
		match max_value_pos:
			0:
				if max_value >= 0.5:
					velocity += Vector2(1,-0.5)
					$Sprite.set_frame(6)
			1:
				if max_value >= 0.5:
					velocity += Vector2(1,0.5)
					$Sprite.set_frame(5)
			2:
				if max_value >= 0.5:
					velocity += Vector2(-1,0.5)
					$Sprite.set_frame(4)
			3:
				if max_value >= 0.5:
					velocity += Vector2(-1,-0.5)
					$Sprite.set_frame(7)
		
	inputs = []
	velocity = velocity * speed
	#velocity = velocity * delta
	move_and_slide(velocity)
