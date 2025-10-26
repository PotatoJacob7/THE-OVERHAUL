@icon("res://Sprites/class_icons/run.png")
extends PlayerState

var look_dir
var prev_state
var stamina_depleted = false

func _init() -> void:
	GlobalSignal.stamina_depleted.connect(stamina_deplete)
	GlobalSignal.stamina_replenished.connect(stamina_replenish)

func enter(previous_state_path: String, _data := {}) -> void:
	prev_state = previous_state_path
	player.curr_state = PlayerState.RUNNING
	player.sprite.play("Idle")

func update(_delta: float) -> void:
	if PlayerStats.stamina <= 0:
		match prev_state:
			DASHING:
				transitioned.emit(WALKING)
			_:
				transitioned.emit(prev_state)
	elif PlayerStats.stamina < float(PlayerStats.max_stamina)/3.0 and stamina_depleted:
		match prev_state:
			DASHING:
				transitioned.emit(WALKING)
			_:
				transitioned.emit(prev_state)

func physics_update(_delta : float) -> void:
	# Movement
	var direction = Input.get_vector("left", "right", "up", "down")
	player.velocity = direction * PlayerStats.run_speed
	
	#Flips sprite and sets look dir
	var dir = player.get_angle_to(player.mouse.global_position)
	if dir > 1.5 or dir < -1.5:
		player.sprite.flip_h = true
		look_dir = -1
	elif dir < 1.5 or dir > -1.5:
		player.sprite.flip_h = false
		look_dir = 1
	#HACK update this once anims are completed
	#Sets Anim
	if look_dir > 0 and player.velocity.x > 0 or look_dir < 0 and player.velocity.x < 0:
		player.sprite.play("Run")
	elif look_dir > 0 and player.velocity.x < 0 or look_dir < 0 and player.velocity.x > 0:
		player.sprite.play("Run")
	elif is_equal_approx(player.velocity.x, 0.0) and is_equal_approx(player.velocity.y, 0.0):
		player.sprite.play("Idle")
	else:
		player.sprite.play("Run")
	
	#Switch to idle
	if is_equal_approx(player.velocity.x, 0.0) and is_equal_approx(player.velocity.y, 0.0) and Input.is_action_just_released("run"):
		transitioned.emit(IDLE)
	#Switch to Run
	elif Input.is_action_just_released("run"):
		transitioned.emit(WALKING)
	#Switch to dash
	elif Input.is_action_just_pressed("dash"):
		transitioned.emit(DASHING)

func stamina_deplete():
	stamina_depleted = true

func stamina_replenish():
	stamina_depleted = false
