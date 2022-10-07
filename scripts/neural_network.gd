class_name Neural_Network

var weights_inputs: Array = []
var weights_outputs: Array = []

func start(size_inputs,size_hidden,size_output):
	randomArray(size_inputs,size_hidden,weights_inputs)
	randomArray(size_hidden,size_output,weights_outputs)
	
	#print(weights_inputs)
	#print(weights_outputs)
	
func think(pos: Vector2):
	pass

#criar matrix randomica
func randomArray(i_size, j_size, arr):
	
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	for i in i_size:
		var temp: Array = []
		for j in j_size:
			var random_number = rng.randf_range(0,1)
			temp.append(random_number)
		arr.append(temp)
