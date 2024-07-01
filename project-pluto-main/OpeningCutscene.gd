extends Node2D
var ok 
func _ready():
	$AnimationPlayer.play("New Anim")
	if yield($AnimationPlayer, "animation_finished"):
		transition()
	
func transition():
	ok = get_tree().change_scene("res://colorcustom.tscn")
	if get_tree().change_scene("res://colorcustom.tscn") == ok:
		pass
	else:
		print("error occurred while switching scenes")

func _on_SkipButton_pressed():
	ok = get_tree().change_scene("res://colorcustom.tscn")
	if get_tree().change_scene("res://colorcustom.tscn") == ok:
		pass
	else:
		print("error occurred while switching scenes")
