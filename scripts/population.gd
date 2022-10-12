extends YSort

const chicken = preload("res://scenes/characters/player.tscn")
onready var Map := get_tree().get_root().get_node("Main").get_node("Map")
var random = RandomNumberGenerator.new()

export (int) var populationSize = 1
export (int) var layers_input_size = 5
export (int) var layers_hidden_size = 10
export (int) var layers_output_size = 4
export (int) var speedGlobal = 100
export (int) var healthGlobal = 300

var players: Array = []
var newPlayers: Array = []

func _ready():
	createPopualtion()
	var button = Button.new()
	button.text = "New Generation"
	button.connect("pressed", self, "new_generation")
	add_child(button)
	
func new_generation():
	var sizeGlobal = get_node("players").get_child_count()
	players = []
	for i in sizeGlobal:
		var child = get_node("players").get_child(i)
		players.append([child.id,child.timeLive, child.weigths_input, child.weigths_output])
		if child.isLive == false:
			child.queue_free()
			
	createNewGeration()
	
func createPopualtion():
	
	for i in populationSize:
		var wi = randomArray(layers_input_size, layers_hidden_size)
		var wo = randomArray(layers_hidden_size, layers_output_size)
		createIndividuo(i, wi, wo)
		
func createIndividuo(id, weigths_i, weigths_o):
	
	random.randomize()
	var tilemap = Map.get_node("floor")
	var size_map = tilemap.get_used_cells_by_id(1)
	var x: int = random.randf_range(size_map[0][0], size_map[size_map.size() - 1][0])
	var y: int = random.randf_range(size_map[0][1], size_map[size_map.size() - 1][1])
	var pos_world = tilemap.map_to_world(Vector2(x,y)) + tilemap.cell_size / 2
	
	var chickenInstance = chicken.instance()
	chickenInstance.position = Vector2(pos_world[0], pos_world[1])
	chickenInstance.weigths_input = weigths_i
	chickenInstance.weigths_output = weigths_o
	chickenInstance.id = id
	chickenInstance.speed = speedGlobal
	chickenInstance.health = healthGlobal
	get_node("players").add_child(chickenInstance)
		
			
func createNewGeration():
	
	#ordena os melhores players
	if players.size() > 0:
		
		newPlayers = []
		
		var father = players[0]
		var monther = players[0]
		var fatherTimeLive = 0
		var montherTimeLive = 0
		
		for player in players:
			if player[1] > fatherTimeLive:
				fatherTimeLive = player[1]
				father = player
		
		for player in players:
			if player[0] != father[0]:
				if player[1] > montherTimeLive:
					montherTimeLive = player[1]
					monther = player
		
		newPlayers.append([father[2], father[3]])
		newPlayers.append([monther[2], monther[3]])
		
		for i in (populationSize - 2) / 2:
			var children = crossing(father,monther)
			newPlayers.append([children[0][2], children[0][3]])
			newPlayers.append([children[1][2], children[1][3]])
			
		newPlayers = mutation(newPlayers)
		for i in newPlayers.size():
			createIndividuo(i, newPlayers[i][0], newPlayers[i][1])

func crossing(a,b):
	var playerA = a
	var playerB = b
	
	#inputs
	var temp_input_a = []
	var temp_input_b = []
	for i in a[2].size():
		if i < a[2].size() / 2:
			temp_input_a.append(a[2][i])
			temp_input_b.append(b[2][i])
		else:
			temp_input_a.append(b[2][i])
			temp_input_b.append(a[2][i])
		
	#outputs
	var temp_output_a = []
	var temp_output_b = []
	for i in a[3].size():
		if i < a[3].size() / 2:
			temp_output_a.append(a[3][i])
			temp_output_b.append(b[3][i])
		else:
			temp_output_a.append(b[3][i])
			temp_output_b.append(a[3][i])
			
	playerA[2] = temp_input_a
	playerA[3] = temp_output_a
	playerB[2] = temp_input_b
	playerB[3] = temp_output_b
	
	return [playerA, playerB]
	
func mutation(arr):
	random.randomize()
	
	var temp = []
	for player in arr:
		var position_input: int = random.randf_range(0, player[0].size())
		var position_input_value: int = random.randf_range(0, player[0][position_input].size())
		player[0][position_input][position_input_value] = random.randf_range(-1,1)
		
		var position_output: int = random.randf_range(0, player[1].size())
		var position_output_value: int = random.randf_range(0, player[1][position_output].size())
		player[1][position_output][position_output_value] = random.randf_range(-1,1)
		temp.append(player)
	
	return temp

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
