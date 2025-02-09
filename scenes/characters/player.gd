class_name Player
extends CharacterBody2D

@export var animated_sprite_2d: AnimatedSprite2D

var input_dir
var moving = false
const tile_size = 64

func _physics_process(_delta : float) -> void:
	input_dir = Vector2.ZERO
	if Input.is_action_just_pressed("ui_down"):
		animated_sprite_2d.play("walk_front")
		input_dir = Vector2(0,1)
		move()
	elif Input.is_action_just_pressed("ui_up"):
		animated_sprite_2d.play("walk_back")
		input_dir = Vector2(0,-1)
		move()
	elif Input.is_action_just_pressed("ui_right"):
		animated_sprite_2d.play("walk_right")
		input_dir = Vector2(1,0)
		move()
	elif Input.is_action_just_pressed("ui_left"):
		animated_sprite_2d.play("walk_left")
		input_dir = Vector2(-1,0)
		move()

func move():
	if input_dir: 
		if moving == false:
			moving = true
			var tween = create_tween()
			tween.tween_property(self, "position", position + input_dir * tile_size, 0.35)
			tween.tween_callback(move_false)

func move_false():
	moving = false
