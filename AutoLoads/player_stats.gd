extends Node

#Basic
var gold 		: int = 100

#Movement
var max_stamina		 = 100
var stamina 		 = max_stamina
var stamina_drain 	 = 30
var stamina_regen	 = 50
var walk_speed 		: int = 150
var run_speed 		: int = 300
var dash_length 	: int = 1000
var max_dash		 = 3
var dash			 = max_dash

#region Inventory
#enum equip_types {WEAPON, PASSIVE, ACTIVE, HEAD, CHEST, LEGS, FEET}
#var weapon: equip_types = equip_types.WEAPON
#var passive_1: equip_types = equip_types.PASSIVE
#var passive_2: equip_types = equip_types.PASSIVE
#var passive_3: equip_types = equip_types.PASSIVE
#var active_1: equip_types = equip_types.ACTIVE
#var active_2: equip_types = equip_types.ACTIVE
#var active_3: equip_types = equip_types.ACTIVE
#var head: equip_types = equip_types.HEAD
#var chest: equip_types = equip_types.CHEST
#var legs: equip_types = equip_types.LEGS
#var feet: equip_types = equip_types.FEET
#
#var inventory_dict : Dictionary = {
#"resources": [],
#"equipped": {weapon: WeaponItems,
			 #passive_1: equip_types.PASSIVE,
			 #passive_2: equip_types.PASSIVE,
			 #passive_3: equip_types.PASSIVE,
			 #active_1: equip_types.ACTIVE,
			 #active_2: equip_types.ACTIVE,
			 #active_3: equip_types.ACTIVE,
			 #head: equip_types.HEAD,
			 #chest: equip_types.CHEST,
			 #legs: equip_types.LEGS,
			 #feet: equip_types.FEET,
			 #}
#}
#endregion

#Health and Defense
var curr_health 	: float = max_health
var max_health 		: float = 100
var health_regen	: float = 5.0
var max_shield 		: float = 50
var shield 			: float = max_shield

#Levelling
var lvl 		: float = 1
var curr_exp 	: float = 0
var exp_req 	: float = 100

#Status effects
var crit_chance 	: float
var crit_mult 		: float
var burn_chance 	: float
var burn_time 		: float
var poison_chance 	: float
var poison_time 	: float
var stun_chance 	: float
var stun_time 		: float

#Damage types
var min_phys_dmg 	: int = 0
var max_phys_dmg 	: int = 10
var min_magic_dmg 	: int = 0
var max_magic_dmg 	: int = 10
var knockback 		: int = 50

#Mana
var max_mana : float = 100
var curr_mana : float = max_mana
var mana_regen : float = 5.0
#TODO Make the dual tile map for the floor
