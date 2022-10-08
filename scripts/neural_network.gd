class_name Neural_Network

var weights_inputs: Array = []
var weights_output: Array = []

var bias: float = 1

func sigmoid(x):
	return 1 / (1 + exp(-x))

func start(size_inputs,size_hidden,size_output):
	randomArray(size_inputs,size_hidden,weights_inputs)
	randomArray(size_hidden,size_output,weights_output)
	
func think(id_tile_map):
	var inputs: Array = [id_tile_map]
	var hidden_layer = multiply(inputs,weights_inputs)
	var output = multiply(hidden_layer, weights_output)
	print(output)
	
	
func multiply(matrix1, matrix2):
	var arr: Array = []
	for i in matrix2:
		var temp: float
		for j in i.size():
			var value = i[j] * matrix1[j]
			temp += value
		arr.append(sigmoid(temp + bias))
	return arr
	
#criar matrix randomica
func randomArray(i_size, j_size, arr):
	
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	for i in j_size:
		var temp: Array = []
		for j in i_size:
			var random_number = rng.randf_range(-1,1)
			temp.append(random_number)
		arr.append(temp)

