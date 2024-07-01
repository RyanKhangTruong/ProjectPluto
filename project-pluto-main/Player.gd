extends KinematicBody2D

var velocity = Vector2.ZERO
const SPEED = 250
const GRAVITY = 50
const JUMPHEIGHT = -1100
var orientation = Vector2.RIGHT
var notHurt = true
var changed
onready var mat  = get_node("AnimatedSprite").get_material()
onready var BULLET = preload("res://Player_Bullet.tscn")
onready var stats = PlayerStats
signal health_changed
signal triple_no_more
signal dying
var ok
var powered_up
var is_triple = 0
var no_health = load("res://GameOver.tscn")

func _ready():
	stats.set_health(stats.max_health)
	##pls do not remove: this is required to display
	## the correct number of full hearts when the game starts/is reloaded 
	Global.lives = stats.max_health
	Global.start() # sets hearts in HUD
	mat.set_shader_param("black",Global.black)
	mat.set_shader_param("blue",Global.blue)
	mat.set_shader_param("green",Global.green)
	mat.set_shader_param("red",Global.red)
	get_node("AnimatedSprite").set_material(mat)

func _physics_process(_delta): 
	if notHurt:
		if Input.is_action_pressed("move_right"):
			if Input.is_action_pressed("shoot") and is_on_floor():
				$AnimatedSprite.play("shoot")
				if $ShootTimer.is_stopped():
					if is_triple > 0:
						powered_up = true
						shoot_triple_bullet()
						is_triple -= 1
					else:
						emit_signal("triple_no_more")
						shoot_bullet()
			else:
				$AnimatedSprite.play("walk")
				
			velocity.x = SPEED
			$AnimatedSprite.flip_h = false
			orientation = Vector2.RIGHT
			
		elif Input.is_action_pressed("move_left"):
			if Input.is_action_pressed("shoot") and is_on_floor():
				$AnimatedSprite.play("shoot")
				if $ShootTimer.is_stopped():
					if is_triple > 0:
						powered_up = true
						shoot_triple_bullet()
						is_triple -= 1
					else:
						emit_signal("triple_no_more")
						shoot_bullet()
			else:
				$AnimatedSprite.play("walk")
			
			velocity.x = -SPEED
			$AnimatedSprite.flip_h = true
			orientation = Vector2.LEFT

		elif Input.is_action_pressed("shoot"): 
			if is_on_floor():
				$AnimatedSprite.play("shoot")
			if $ShootTimer.is_stopped():
				if is_triple > 0:
					powered_up = true
					shoot_triple_bullet()
					is_triple -= 1
				else:
					emit_signal("triple_no_more")
					shoot_bullet()
		else:
			$AnimatedSprite.play("idle")

		if not is_on_floor():
			$AnimatedSprite.play("jump")
		
		if (is_on_floor() and velocity == Vector2.ZERO 
		and Input.is_action_pressed("crouch")):
			$AnimatedSprite.play("crouch")

		velocity.y += GRAVITY

		if Input.is_action_just_pressed("move_up") and is_on_floor():
			velocity.y = JUMPHEIGHT

		velocity = move_and_slide(velocity, Vector2.UP)
		velocity.x = lerp(velocity.x, 0, 1)
	
	else:
		$AnimatedSprite.modulate = Color(1, 0.7, 0.7)
		velocity.y += GRAVITY
		velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)
		velocity.x = lerp(velocity.x, 0, 0.05)
		
		if abs(velocity.x) < 100:
			$AnimatedSprite.modulate = Color(1, 1, 1)
			notHurt = true
	

func shoot_bullet():
	var bullet = BULLET.instance()
	bullet.blast($Location.global_position, orientation)
	get_owner().add_child(bullet)
	$ShootTimer.start()
	$ShootSound.play()

func _on_HurtBox_area_entered(area):
	if area.is_in_group("Enemy"):
		if not area.isDestroyed:
			$AnimatedSprite.play("hurt")
			notHurt = false
			velocity = Vector2(600 * sign(position.x - area.position.x), 0)
			$HurtSound.play()
			
			stats.health -= 1
			emit_signal("health_changed", stats.health)
			if stats.get_health() <= 0:
				emit_signal("health_changed", stats.health)
				# lines 129-127 allow the player to flash upon dying and then transition to 
				# the game over screen 
				emit_signal("dying")
				$AnimatedSprite.modulate = Color(1,0,0)
				yield(get_tree().create_timer(0.2), 'timeout')
				$AnimatedSprite.modulate = Color(1,1,1)
				yield(get_tree().create_timer(0.2), 'timeout')
				$AnimatedSprite.modulate = Color(1,0,0)
				yield(get_tree().create_timer(0.2), 'timeout')
				yield(get_tree().create_timer(0.6), 'timeout')
				game_over()
	
	elif area.is_in_group("triple") and area.not_taken:
		is_triple += 3
		area.destroyed()

func game_over():
	ok = get_tree().change_scene("res://GameOver.tscn")
	if get_tree().change_scene_to(no_health) == ok:
		pass
	else:
		print("Error when switching scenes!")
	
func shoot_triple_bullet():
	var bullet1 = BULLET.instance()
	var bullet2 = BULLET.instance()
	var bullet3 = BULLET.instance()
	bullet1.blast_triple($Location.global_position, orientation, 1)
	bullet2.blast_triple($Location.global_position, orientation, 2)
	bullet3.blast_triple($Location.global_position, orientation, 3)
	get_owner().add_child(bullet1)
	get_owner().add_child(bullet2)
	get_owner().add_child(bullet3)
	$ShootTimer.start()
	$ShootSound.play()

func _on_Player_triple_no_more():
	if powered_up:
		Global.from_player_script()
		powered_up = false
