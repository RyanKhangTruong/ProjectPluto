extends Node2D

func _ready():
	$GameOverSound.play()

func _on_QuitButton_pressed():
	$GameOverSound.stop()
	get_tree().paused = false
	if get_tree().change_scene("res://MainMenu.tscn") != 0:
		print("Error when switching scenes!")

func _on_RestartButton_pressed():
	$GameOverSound.stop()
	yield(get_tree().create_timer(0.2), "timeout")
	if Global.curr_level == 1:
		if get_tree().change_scene("res://Level1.tscn") != 0:
			print("Error when switching scenes!")
	
	if Global.curr_level == 2:
		if get_tree().change_scene("res://Level2.tscn") != 0:
			print("Error when switching scenes!")
	
	if Global.curr_level == 3:
		if get_tree().change_scene("res://Level3.tscn") != 0:
			print("Error when switching scenes!")
