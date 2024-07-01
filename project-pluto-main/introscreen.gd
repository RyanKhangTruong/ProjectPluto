extends Node2D
var ok
var next_scene = preload("res://MainMenu.tscn")

func _ready():
	$AnimationPlayer.play('fade in')
	yield(get_tree().create_timer(4), "timeout")
	$AnimationPlayer.play("fade out")
	yield(get_tree().create_timer(3), 'timeout')
	ok = get_tree().change_scene_to(next_scene)
	
	if get_tree().change_scene_to(next_scene) != ok:
		print("an unexpected error occurred while switching scenes.")
	
