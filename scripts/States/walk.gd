@icon("res://Sprites/class_icons/walk.png")
extends PlayerState

var look_dir

func enter(_previous_state_path: String, _data := {}) -> void:
	player.curr_state = PlayerState.WALKING
	player.sprite.play("Walk")

func physics_update(_delta : float):
	# Movement
	var direction = Input.get_vector("left", "right", "up", "down")
	player.velocity = direction * PlayerStats.walk_speed
	
	#Flips sprite and sets look dir
	var dir = player.get_angle_to(player.mouse.global_position)
	if dir > 1.5 or dir < -1.5:
		player.sprite.flip_h = true
		look_dir = -1
	elif dir < 1.5 or dir > -1.5:
		player.sprite.flip_h = false
		look_dir = 1
	
	#Sets Anim
	if look_dir > 0 and player.velocity.x > 0 or look_dir < 0 and player.velocity.x < 0:
		player.sprite.play("Walk")
	elif look_dir > 0 and player.velocity.x < 0 or look_dir < 0 and player.velocity.x > 0:
		player.sprite.play_backwards("Walk")
	elif is_equal_approx(player.velocity.x, 0.0) and is_equal_approx(player.velocity.y, 0.0):
		player.sprite.play("Idle")
	else:
		player.sprite.play("Walk")
	
	#Switch to idle
	if is_equal_approx(player.velocity.x, 0.0) and is_equal_approx(player.velocity.y, 0.0) and Input.is_action_just_released("move"):
		transitioned.emit(IDLE)
	#Switch to Run
	elif Input.is_action_just_pressed("run"):
		transitioned.emit(RUNNING)
	#Switch to dash
	elif Input.is_action_just_pressed("dash"):
		transitioned.emit(DASHING)
