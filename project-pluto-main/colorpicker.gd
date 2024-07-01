extends Node2D


#onready var other_scene = get_node("Player")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Red_pressed():
	get_node("/root/Global").red()


func _on_Blue_pressed():
	pass # Replace with function body.


func _on_Green_pressed():
	pass # Replace with function body.
