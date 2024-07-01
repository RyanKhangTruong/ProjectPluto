extends Node

const testing = false
var total_enemy_A = 0 
var total_enemy_B = 0 
var total_enemy_C = 0 
var total_triple = 0 
var defeated = 0 
const max_enemy_A = (-1 if testing else 10) # 10
const max_enemy_B = (-1 if testing else 3) # 3
const max_enemy_C = (-1 if testing else 2) # 2
const max_enemies = max_enemy_A + max_enemy_B + max_enemy_C + 3
const max_triple = 2
var ok 

func _ready():
	Global.curr_level = 1
	Global.enemy_total = max_enemies
	Global.death_count = 0
	Global.set_enemies_remaining()
	# has to be set so that upon restart the tree runs 
	get_tree().paused = false
	$MovingToLevel2/transition.hide()
	$LevelMusic1.play()
	randomize()
	$PauseScreen.hide()
	$"UnpauseButton/UnpauseButton".hide()

onready var ENEMY_A = preload("res://EnemyA.tscn")
onready var ENEMY_B = preload("res://EnemyB.tscn")
onready var ENEMY_C = preload("res://EnemyC.tscn")
onready var TRIPLE = preload("res://powerup_triple_bullet.tscn")
onready var MINIBOSS = preload("res://MiniBoss.tscn")

func _on_SpawnTimer_timeout():
	if total_enemy_A <= max_enemy_A:
		if (get_tree().get_nodes_in_group("Active_Enemy_A").size() < 8):
			var enemy_A = ENEMY_A.instance()
			var Spawn_A_nodes = get_tree().get_nodes_in_group("Spawn_A")
			var Spawn_A_node = Spawn_A_nodes[randi() % Spawn_A_nodes.size()]
			add_child(enemy_A)
			enemy_A.position = Spawn_A_node.position
			total_enemy_A += 1

	if total_enemy_B <= max_enemy_B:
		if (get_tree().get_nodes_in_group("Active_Enemy_B").size() < 2):
			var enemy_B = ENEMY_B.instance()
			var Spawn_B_nodes = get_tree().get_nodes_in_group("Spawn_B")
			var Spawn_B_node = Spawn_B_nodes[randi() % Spawn_B_nodes.size()]
			add_child(enemy_B)
			enemy_B.position = Spawn_B_node.position
			total_enemy_B += 1
			
	if total_enemy_C <= max_enemy_C:
		if (get_tree().get_nodes_in_group("Active_Enemy_C").size() < 1):
			var enemy_C = ENEMY_C.instance()
			var Spawn_C_nodes = get_tree().get_nodes_in_group("Spawn_C")
			var Spawn_C_node = Spawn_C_nodes[randi() % Spawn_C_nodes.size()]
			add_child(enemy_C)
			enemy_C.position = Spawn_C_node.position
			total_enemy_C += 1
			
	if total_triple <= max_triple:
		if (get_tree().get_nodes_in_group("triple").size() < 2):
			var triple = TRIPLE.instance()
			var Spawn_triple_nodes = get_tree().get_nodes_in_group("Spawn_triple")
			var Spawn_triple_node = Spawn_triple_nodes[randi() % Spawn_triple_nodes.size()]
			add_child(triple)
			triple.position = Spawn_triple_node.position
			total_triple += 1

	if defeated == max_enemies:
		$SpawnTimer.stop()
		var miniboss = MINIBOSS.instance()
		add_child(miniboss)
		miniboss.position = $MiniBossSpawn.position
		
func next_level():
	$MovingToLevel2/transition.show()
	$LevelMusic1.stop()
	$MovingToLevel2/transition.play("default")
	$bells.play()
	$"UnpauseButton/UnpauseButton".hide()
	$PauseButton.hide()
	yield(get_tree().create_timer(3),"timeout")
	ok = get_tree().change_scene("res://Level2.tscn")
	if get_tree().change_scene("res://Level2.tscn") != ok:
		print("error occurred while switching scenes")

func _on_PauseButton_pressed():
		get_tree().paused = true
		$PauseScreen.show()
		$"UnpauseButton/UnpauseButton".show()
		$PauseScreen.raise() # makes sure these are visible over all layer elements
		$"UnpauseButton/UnpauseButton".raise()  # makes sure these are visible over all layer elements
		#$Player.hide() # hides player so they aren't visible over the pause screen

# stops all enemies and processes from running
# so while the player flashes upon death they can't make them bounce around
func _on_UnpauseButton_pressed():
	$PauseScreen.hide()
	$"UnpauseButton/UnpauseButton".hide()
	#$Player.show() # makes player visible again after closing the pause screen
	get_tree().paused = false # resumes all previously paused gameplay functions such as music playing etc.
	


func _on_Player_dying():
	get_tree().paused = true
	$PlayerDeathTimer.start()


func _on_PlayerDeathTimer_timeout():
	get_tree().paused = false
