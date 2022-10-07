extends KinematicBody2D

var NeuralNetwork = preload("res://scripts/neural_network.gd")

onready var player := get_tree().get_root().get_node("Main").get_node("Map")

export (int) var speed = 100
var velocity = Vector2()
var neural

func _init():
	neural = NeuralNetwork.new()
	neural.start(4,4,4)

func _physics_process(delta):
	move(delta)
	#neural.think(get_transform()[2].normalized())
	
func move(delta):
	get_input()
	velocity = velocity * delta
	move_and_collide(velocity)

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("down"):
		velocity += Vector2(-1,0.5)
		$Sprite.set_frame(4)
	if Input.is_action_pressed("up"):
		velocity += Vector2(1,-0.5)
		$Sprite.set_frame(6)
	if Input.is_action_pressed("left"):
		velocity += Vector2(-1,-0.5)
		$Sprite.set_frame(7)
	if Input.is_action_pressed("right"):
		velocity += Vector2(1,0.5)
		$Sprite.set_frame(5)
	velocity = velocity.normalized() * speed
