extends Control
var ok1
var ok2
var ok3
var ok4

var scene_1 = load("res://controlscreen.tscn")
var scene_2 = load("res://credits.tscn")
var scene_3 = load("res://OpeningCutscene.tscn")
var scene_4 = load("res://colorcustom.tscn")
var seen_before = false

func _ready():
	$VBoxContainer/StartButton.grab_focus()
	$AnimatedSprite.play("default")
	$menumusic.play()


func _on_StartButton_pressed():
	$menumusic.stop()
	ok1 = get_tree().change_scene("res://OpeningCutscene.tscn")
	if get_tree().change_scene_to(scene_3) != ok1:
		print("an unexpected error occurred while switching scenes.")

func _on_QuitButton_pressed():
	$menumusic.stop()
	get_tree().quit()

func _on_ControlsButton_pressed():
	$menumusic.stop()
	ok2 = get_tree().change_scene("res://controlscreen.tscn")
	if get_tree().change_scene_to(scene_1) != ok2:
		print("an unexpected error occurred while switching scenes.")
	
func _on_CreditsButton_pressed():
	$menumusic.stop()
	ok3 = get_tree().change_scene("res://credits.tscn")
	if get_tree().change_scene_to(scene_2) != ok3:
		print("an unexpected error occurred while switching scenes.")
