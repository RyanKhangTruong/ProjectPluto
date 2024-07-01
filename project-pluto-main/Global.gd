extends Node

var max_lives = 4
var lives = max_lives
var hud
var curr_level
var enemy_total
var death_count


# Declare member variables here. Examples:
var red 
var blue
var green
var black 


func start():
	hud.load_hearts()

func lose_life():
	#print('called')
	hud.load_hearts()

func set_red(color):
	Global.red = color

func set_black(color):
	Global.black = color

func set_blue(color):
	Global.blue = color

func set_green(color):
	Global.green = color
	
func set_enemies_remaining():
	hud.display_death_count()

func from_triple_powerup():
	hud.toggle_powerup_display_powerup()

func from_player_script():
	hud.toggle_powerup_display_player()
	
