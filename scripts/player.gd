extends CharacterBody2D
class_name Player

@onready var mouse: Marker2D = %Mouse
@onready var sprite: AnimatedSprite2D = %Sprite
@onready var sprint_timer: Timer = $StateMachine/Running/NoStaminaTimer
@onready var weapon: Node2D = %Weapon

var curr_state
var stamina_depleted = false

func _physics_process(_delta) -> void:
	mouse.global_position = get_global_mouse_position()
	move_and_slide()

func _process(delta: float) -> void:
	#var dir = get_angle_to(mouse.global_position)
	#if dir > 1.5 or dir < -1.5:
		#weapon.position.x = -11
	#elif dir < 1.5 or dir > -1.5:
		#weapon.position.x = 11
#region Depletes Stamina
	if stamina_depleted:
		if PlayerStats.stamina >= PlayerStats.max_stamina:
			PlayerStats.stamina = PlayerStats.max_stamina
			stamina_depleted = false
			GlobalSignal.stamina_replenished.emit()
		PlayerStats.stamina += clamp(PlayerStats.stamina_regen * delta, 0, PlayerStats.max_stamina)
	match curr_state:
		#Running
		PlayerState.RUNNING:
			if PlayerStats.stamina > 0 and !stamina_depleted:
				PlayerStats.stamina -= PlayerStats.stamina_drain * delta
				sprint_timer.stop()
			elif PlayerStats.stamina > float(PlayerStats.max_stamina)/3.0 and stamina_depleted:
				stamina_depleted = false
				GlobalSignal.stamina_replenished.emit()
		#Any other state
		_:
			if sprint_timer.time_left == 0:
				if PlayerStats.stamina <= 0:
					PlayerStats.stamina = 0
					GlobalSignal.sprint_tween.emit()
					sprint_timer.start()
				elif PlayerStats.stamina <= PlayerStats.max_stamina:
					GlobalSignal.sprint_tween.emit()
					sprint_timer.start()
#endregion 

#HACK pretty sure idle timer aint work

func stamina_deplete():
	GlobalSignal.stamina_depleted.emit()
	stamina_depleted = true

func player(): #Used to check if it is the player
	pass
