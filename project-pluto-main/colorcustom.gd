extends Node2D
var ok


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer.play()
	$Node2D.hide()
	$CloseScreen.hide()

func _on_InstructionsScreen_pressed():
	$Node2D.show()
	$CloseScreen.show()

func _on_CloseScreen_pressed():
	$Node2D.hide()
	$CloseScreen.hide()
