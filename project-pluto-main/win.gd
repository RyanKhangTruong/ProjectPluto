extends Node2D

var ok 

func _ready():
		$AnimationPlayer.play("ending_cutscene")

func _on_Button_pressed():
	ok = get_tree().change_scene("res://MainMenu.tscn")
	if get_tree().change_scene("res://MainMenu.tscn") == ok:
		pass
	else:
		print("an error occurred while switching scenes!")
