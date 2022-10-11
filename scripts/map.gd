extends Node2D
var random = RandomNumberGenerator.new()

onready var tilemap: Node2D = get_node("floor")
var lifeTime = 0
export (int) var lifeSize = 60 * 10
var foods: Array = []

func _ready():
	#print(tilemap.cell_size)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if lifeTime >= 0:
		lifeTime -= 1
	else:
		if foods.size() > 0:
			for i in foods:
				deadFood(i[0], i[1])
			foods = []
		lifeTime = lifeSize
		random.randomize()
		var size_map = tilemap.get_used_cells_by_id(1)
		for i in 3:
			var x = random.randf_range(size_map[0][0], size_map[size_map.size() - 1][0])
			var y = random.randf_range(size_map[0][1], size_map[size_map.size() - 1][1])
			foods.append([x,y])
			growFood(x,y)
	
func growFood(x,y):
	var pos: Vector2 = Vector2(int(x),int(y))
	tilemap.set_cellv(pos, 0)
	
func deadFood(x,y):
	var pos: Vector2 = Vector2(int(x),int(y))
	tilemap.set_cellv(pos, 1)
