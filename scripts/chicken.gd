extends KinematicBody2D

export (int) var speed = 100
const GRAVITY = 200.0
var velocity = Vector2()

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

func _physics_process(delta):
	get_input()
	velocity = velocity * delta
	velocity = move_and_collide(velocity)
