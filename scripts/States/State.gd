extends Node
class_name  State

@warning_ignore("unused_signal")
signal transitioned(_next_state_path: String, _data: Dictionary)

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass

func enter(_previous_state_path: String, _data := {}) -> void:
	pass

func exit() -> void:
	pass
