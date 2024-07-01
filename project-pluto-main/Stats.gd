extends Node

export var max_health = 4
onready var health = max_health setget set_health, get_health

func _ready():
	health = max_health
	get_health()

func _on_Player_health_changed(value):
	Global.lose_life()
	set_health(value)

func set_health(value):
	health = value
	Global.lives = health
	#print(health)
	
func get_health():
	Global.lives = health
	return health
