extends YSort

const chicken = preload("res://scenes/characters/player.tscn")
onready var Map := get_tree().get_root().get_node("Main").get_node("Map")
var random = RandomNumberGenerator.new()

export (int) var populationSize = 1


func _ready():
	random.randomize()
	
	var tilemap = Map.get_node("floor")
	var size_map = tilemap.get_used_cells_by_id(1)
	
	for i in populationSize:
		var x: int = random.randf_range(size_map[0][0], size_map[size_map.size() - 1][0])
		var y: int = random.randf_range(size_map[0][1], size_map[size_map.size() - 1][1])
		var pos_world = tilemap.map_to_world(Vector2(x,y)) + tilemap.cell_size / 2
		
		var chickenInstance = chicken.instance()
		chickenInstance.position = Vector2(pos_world[0], pos_world[1])
		print(chickenInstance.transform)
		add_child(chickenInstance)
