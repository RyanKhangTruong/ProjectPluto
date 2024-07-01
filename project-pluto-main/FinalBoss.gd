extends Area2D

onready var BOSS_BULLET = preload("res://Boss_Bullet.tscn")
onready var stats = $BossStats

var player = Vector2.ZERO
var orientation = Vector2.RIGHT
var isDestroyed = true

func _ready():
	$Explosion.hide()
	$ProgressBar.set_value(100)
	$ProgressBar.rect_position = global_position - Vector2(600, 2500)
	$ProgressBar.rect_scale = Vector2(30,30)
	$Animation.play("idle")
	$Animation.self_modulate = Color(10,10,10,10)
	yield(get_tree().create_timer(0.6), "timeout")
	$Animation.self_modulate = Color(1,1,1,1)
	isDestroyed = false
	#boss_blast()
	$ShootPause.start()
	
func _process(_delta):
	player = get_parent().get_node("Player").position
	if player.x >= 640:
		$Animation.flip_h = false
		$GunLocation.global_position = global_position + Vector2(90,15)
	else:
		$Animation.flip_h = true
		$GunLocation.global_position = global_position + Vector2(-90,15)
	orientation = (player - $GunLocation.global_position).normalized()

func destroyed():
	stats.health -= 1
	$ProgressBar.value -= 25
	$HurtSound.play()
	if stats.health <= 0:
		$ShootPause.stop()
		set_process(false)
		Global.death_count += 1
		Global.set_enemies_remaining()
		$ExplodeSound.play()
		$ProgressBar.queue_free()
		isDestroyed = true
		$Animation.hide()
		$Explosion.show()
		$Explosion.play("explosion")
		yield($Explosion, "animation_finished")
		$Explosion.hide()
		yield(get_tree().create_timer(0.4), "timeout")
		get_parent().next_level()
		queue_free()

func _on_ShootPause_timeout():
	boss_blast()
	
func boss_blast():
	$ShootPause.stop()
	for _i in  4:
		if not isDestroyed:
			boss_shot()
			$Animation.play("shoot")
			$ShootSound.play()
			yield($Animation, "animation_finished")
	
	$ShootPause.start()
	$Animation.play("idle")

func boss_shot():
	var boss_bullet = BOSS_BULLET.instance()
	boss_bullet.boss_blast($GunLocation.global_position, orientation)
	get_parent().call_deferred("add_child", boss_bullet)
