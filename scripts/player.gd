extends KinematicBody2D

var NeuralNetwork = preload("res://scripts/neural_network.gd")
onready var Map := get_tree().get_root().get_node("Main").get_node("Map")

export (int) var speed = 100
var velocity = Vector2()
var inputs: Array
var neural

func _init():
	neural = NeuralNetwork.new()
	neural.start(3,10,4)

func _physics_process(delta):
	# pegar atributos para a rede neural
	var pos = get_transform()[2]
	var tilemap = Map.get_node("floor")
	var tile:Vector2 = tilemap.world_to_map(pos)
	var cell_id:int = tilemap.get_cellv(tile)
	var food = tilemap.get_used_cells_by_id(0)
	
	if(cell_id >= 0 && food.size() > 0):
		var food_x = food[0][0]
		var food_y = food[0][1]	
		var map_size = tilemap.cell_size
		inputs = neural.think(cell_id, food_x, food_y, tile[0], tile[1], map_size[0], map_size[1])
		#print(inputs)
		move(delta)
	
func move(delta):
	
	velocity = Vector2()
	
	if inputs.size() > 0:
		
		if inputs[0] >= 0.5: #up
			velocity += Vector2(1,-0.5)
			$Sprite.set_frame(6)
		if inputs[1] >= 0.5: #down
			velocity += Vector2(-1,0.5)
			$Sprite.set_frame(4)
		if inputs[2] >= 0.5: #right
			velocity += Vector2(1,0.5)
			$Sprite.set_frame(5)
		if inputs[3] >= 0.5: #left
			velocity += Vector2(-1,-0.5)
			$Sprite.set_frame(7)
		
	inputs = []
	velocity = velocity.normalized() * speed * delta
	#velocity = velocity * delta
	move_and_collide(velocity)
