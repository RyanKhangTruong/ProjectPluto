extends Node2D
var ok
var main = load("res://MainMenu.tscn")

func _ready():
	$AudioStreamPlayer.play()


func _on_Button_pressed():
	$AudioStreamPlayer.stop()
	yield(get_tree().create_timer(0.2), "timeout")
	ok = get_tree().change_scene("res://MainMenu.tscn")
	if get_tree().change_scene_to(main) != ok:
		print("error occurred while switching screens")
