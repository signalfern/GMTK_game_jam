extends Node2D


var speed: int  = 200
var can_see : bool = false
var can_chase : bool = true
@onready var Player = get_node("/root/game_node/player")
var state : String = "patrol"

@export_enum("loop","linear") var patrol_type : String ="linear"
@onready var path_follow: PathFollow2D = get_parent() as PathFollow2D
var direction = 1

func patrol(delta):
	if patrol_type =="loop":
		path_follow.progress += speed * delta
		if rotation_degrees !=0:
			rotation_degrees = lerp(rotation_degrees,0.0,0.2)
	else:
		if direction == 1:
			if path_follow.progress <= 1 :
				
				await get_tree().create_timer(0.5).timeout
				rotation_degrees = lerp(rotation_degrees,180.0,0.1)
				await get_tree().create_timer(1).timeout
				
				direction = 0
			else:
				path_follow.progress += speed * delta
		else:
			if path_follow.progress >= 0 :
				await get_tree().create_timer(0.3).timeout
				rotation_degrees = lerp(rotation_degrees , 0.0 ,0.1)
				await get_tree().create_timer(1).timeout
				direction = 1
			else :
				path_follow.progress -= speed * delta

func _physics_process(delta: float) -> void:
	if state == "patrol":
		patrol(delta)

func spots_player():
	print("player spotted!")


func _on_vision_cone_body_entered(body: CharacterBody2D) -> void:
	if body == Player:
		spots_player()
