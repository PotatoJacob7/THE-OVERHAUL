extends CharacterBody2D
class_name Player

@onready var mouse: Marker2D = %Mouse
@onready var sprite: AnimatedSprite2D = %Sprite
@onready var weapon: Marker2D = %Weapon
@onready var weapon_s: Sprite2D = %Weapon2

var curr_state
var stamina_depleted = false

func _physics_process(_delta) -> void:
	mouse.global_position = get_global_mouse_position()
	move_and_slide()

func _process(_delta: float) -> void:
	var dir = get_angle_to(mouse.global_position)
	weapon.rotation = dir
	if dir > 1.5 or dir < -1.5:
		weapon_s.flip_v = true
	elif dir < 1.5 or dir > -1.5:
		weapon_s.flip_v = false
	

func player(): #Used to check if it is the player
	pass
