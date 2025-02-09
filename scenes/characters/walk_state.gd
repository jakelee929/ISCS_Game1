extends NodeState

@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D

func _on_process(_delta : float) -> void:
	pass

func _on_physics_process(_delta : float) -> void:
	self.input_dir = Vector2.ZERO
	if Input.is_action_just_pressed("ui_down"):
		animated_sprite_2d.play("walk_front")
		self.player_direction = Vector2(0,1)
		move()
	elif Input.is_action_just_pressed("ui_up"):
		animated_sprite_2d.play("walk_back")
		self.player_direction = Vector2(0,-1)
		move()
	elif Input.is_action_just_pressed("ui_right"):
		animated_sprite_2d.play("walk_right")
		self.player_direction = Vector2(1,0)
		move()
	elif Input.is_action_just_pressed("ui_left"):
		animated_sprite_2d.play("walk_left")
		self.player_direction = Vector2(-1,0)
		move()

func move():
	if self.player_direction: 
		if self.moving == false:
			self.moving = true
			var tween = create_tween()
			tween.tween_property(self, "position", self.position + self.player_direction * self.tile_size, 0.35)
			tween.tween_callback(move_false)

func move_false():
	transition.emit("Idle")
	self.moving = false

func _on_next_transitions() -> void:
	if !GameInputEvents.is_movement_input():
		transition.emit("Idle")

func _on_enter() -> void:
	pass

func _on_exit() -> void:
	animated_sprite_2d.stop()
