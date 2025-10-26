extends CharacterBody2D
class_name Player

@onready var mouse: Marker2D = %Mouse
@onready var sprite: AnimatedSprite2D = %Sprite
@onready var weapon: Node2D = %Weapon

var curr_state
var stamina_depleted = false

func _physics_process(_delta) -> void:
	mouse.global_position = get_global_mouse_position()
	move_and_slide()

func _process(_delta: float) -> void:
	#var dir = get_angle_to(mouse.global_position)
	#if dir > 1.5 or dir < -1.5:
		#weapon.position.x = -11
	#elif dir < 1.5 or dir > -1.5:
		#weapon.position.x = 11
	pass

func player(): #Used to check if it is the player
	pass
