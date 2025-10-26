@icon("res://Sprites/class_icons/dash.png")
extends PlayerState

@onready var LenTimer: Timer = $LengthTimer
@onready var ReTimer: Timer = $RechargeTimer

var prev_state : String
var direction : Vector2

func enter(previous_state_path: String, _data := {}) -> void:
	prev_state = previous_state_path
	direction = (player.mouse.global_position - player.position).normalized()
	
	if PlayerStats.dash > 0.0:
		GlobalSignal.dash_used.emit()
		PlayerStats.dash -= 1.0
		player.sprite.play("Dash")
		LenTimer.start()
		ReTimer.start()
	else:
		transitioned.emit(prev_state)
		return
	
	var dir = player.get_angle_to(player.mouse.global_position)
	player.rotation = dir
	if dir > 1.5 or dir < -1.5:
		player.sprite.flip_v = true
		player.skew = 0.5
	elif dir < 1.5 or dir > -1.5:
		player.sprite.flip_v = false
		player.skew = -0.5

func physics_update(_delta : float) -> void:
	player.velocity = direction * PlayerStats.dash_length

func switch_state() -> void:
	player.velocity.x = 0
	player.velocity.y = 0
	player.rotation = 0
	player.sprite.flip_v = false
	player.sprite.flip_h = false
	player.skew = 0
	
	match prev_state:
		RUNNING:
			transitioned.emit(WALKING)
		_:
			transitioned.emit(prev_state)

func dash_used() -> void:
	GlobalSignal.dash_replenished.emit()
	if PlayerStats.dash >= PlayerStats.max_dash:
		return
	else:
		PlayerStats.dash += 1.0
	
