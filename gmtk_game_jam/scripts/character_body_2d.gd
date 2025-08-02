extends CharacterBody2D

#movement
@export var Speed = 300.0

func get_input():
	var input_direction = Input.get_vector("left","right","up","down")
	velocity = input_direction * Speed

func _physics_process(delta: float) -> void:
	get_input()
	move_and_slide()
