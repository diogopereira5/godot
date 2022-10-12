extends YSort

const chicken = preload("res://scenes/characters/player.tscn")
onready var Map := get_tree().get_root().get_node("Main").get_node("Map")
var random = RandomNumberGenerator.new()

export (int) var populationSize = 1
export (int) var layers_input_size = 5
export (int) var layers_hidden_size = 5
export (int) var layers_output_size = 4
export (int) var speedGlobal = 100
export (int) var healthGlobal = 300

var players: Array = []

func _ready():
	createPopualtion()
			
func _process(delta):
	var sizeGlobal = get_child_count()
	var sizeDead = 0
	for i in get_child_count():
		var child = get_child(i)
		if child.isLive == false:
			sizeDead += 1
	
	print(sizeGlobal)
	print(sizeDead)
	
	if sizeGlobal == sizeDead:
		for i in get_child_count():
			var child = get_child(i)
			players.append([child.id,child.timeLive, child.weigths_input, child.weigths_output])
			child.queue_free()
			createPopualtion()
	
func createPopualtion():
	
	random.randomize()
	var tilemap = Map.get_node("floor")
	var size_map = tilemap.get_used_cells_by_id(1)
	
	for i in populationSize:
		var x: int = random.randf_range(size_map[0][0], size_map[size_map.size() - 1][0])
		var y: int = random.randf_range(size_map[0][1], size_map[size_map.size() - 1][1])
		var pos_world = tilemap.map_to_world(Vector2(x,y)) + tilemap.cell_size / 2
		
		var chickenInstance = chicken.instance()
		chickenInstance.position = Vector2(pos_world[0], pos_world[1])
		chickenInstance.weigths_input = randomArray(layers_input_size, layers_hidden_size)
		chickenInstance.weigths_output = randomArray(layers_hidden_size, layers_output_size)
		chickenInstance.id = i
		chickenInstance.speed = speedGlobal
		chickenInstance.health = healthGlobal
		
		add_child(chickenInstance)
			
#criar matrix randomica
func randomArray(i_size, j_size):
	
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var arr: Array = []
	
	for i in j_size:
		var temp: Array = []
		for j in i_size:
			var random_number = rng.randf_range(-1,1)
			temp.append(random_number)
		arr.append(temp)
		
	return arr
