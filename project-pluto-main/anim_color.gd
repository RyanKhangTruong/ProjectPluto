extends AnimatedSprite
var ok

func _ready():
	pass

func _on_Button_pressed():
	ok = get_tree().change_scene("res://Level1.tscn")
	if get_tree().change_scene("res://Level1.tscn") == ok:
		pass
	else:
		print("error occurred while switching scenes!")

func _on_ColorPickerButton_color_changed(color):
	material.set("shader_param/red",color)
	Global.set_red(color)

func _on_ColorPickerButton2_color_changed(color):
	material.set("shader_param/green",color)
	Global.set_green(color)

func _on_ColorPickerButton3_color_changed(color):
	material.set("shader_param/blue",color)
	Global.set_blue(color)


func _on_colorpickerbutton1_color_changed(color):
	material.set("shader_param/black",color)
	Global.set_black(color)
