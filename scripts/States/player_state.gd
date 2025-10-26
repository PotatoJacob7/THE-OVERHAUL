extends State
class_name PlayerState

const IDLE = "Idle"
const WALKING = "Walking"
const RUNNING = "Running"
const DASHING = "Dashing"

var player : Player

func _ready() -> void:
	await owner.ready
	player = owner as Player
	assert(player != null, "The PlayerState state type must be used only in the player scene. It needs the owner to be a Player node.")
