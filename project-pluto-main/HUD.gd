extends CanvasLayer
var destroyed 

func _ready():
	load_hearts()
	Global.hud = self

func load_hearts():
	#print("Global Lives:",Global.lives)
	$HeartsFull.rect_size.x = Global.lives * 256
	$HeartsEmpty.rect_size.x = Global.max_lives * 256
	$HeartsEmpty.rect_position.x = $HeartsFull.rect_position.x 
	
func display_death_count():
	$EnemyCounter.text = "Enemies Remaining: " + str(Global.enemy_total - Global.death_count + 1)

# Redundancy in these two functions allowed for the toggling vis. implementataion of the powerup 
func toggle_powerup_display_player():
	$TripleUp.hide()

func toggle_powerup_display_powerup():
	$TripleUp.show()
