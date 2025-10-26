@icon("res://Sprites/class_icons/idle.png")
extends PlayerState

func enter(_previous_state_path: String, _data := {}) -> void:
	player.velocity.x = 0
	player.velocity.y = 0
	player.curr_state = PlayerState.IDLE
	player.sprite.play("Idle")

func update(_delta: float) -> void:
	var dir = player.get_angle_to(player.mouse.global_position)
	if dir > 1.5 or dir < -1.5:
		player.sprite.flip_h = true
	elif dir < 1.5 or dir > -1.5:
		player.sprite.flip_h = false
	
	if Input.is_action_just_pressed("left") or Input.is_action_just_pressed("right") or Input.is_action_just_pressed("up") or Input.is_action_just_pressed("down"):
		transitioned.emit(WALKING)
	elif Input.is_action_just_pressed("run"):
		transitioned.emit(RUNNING)
	elif Input.is_action_just_pressed("dash"):
		transitioned.emit(DASHING)
