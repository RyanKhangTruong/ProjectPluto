extends Area2D

const speed = 1.5
var velocity = speed
var isDestroyed = true

onready var ENEMY_BULLET = preload("res://Enemy_Bullet.tscn")
onready var stats = $EnemyStats

func _ready():
	$ProgressBar.set_value(100)
	$Animation.self_modulate = Color(10,10,10,10)
	yield(get_tree().create_timer(0.6), "timeout")
	$Animation.self_modulate = Color(1,1,1,1)
	isDestroyed = false

func _process(_delta):
	position.x += velocity
	$Animation.play("walk")

func turn_around():
	velocity *= -1
	$Animation.flip_h = not $Animation.flip_h
	$PlayerDetection.scale.x *= -1

func destroyed():
	stats.health -= 1
	$ProgressBar.set_value(50)
	if stats.health <= 0:
		set_process(false)
		get_parent().defeated += 1
		Global.death_count += 1
		Global.set_enemies_remaining()
		$ExplodeSound.play()
		$ProgressBar.queue_free()
		isDestroyed = true
		$Animation.play("explode")
		yield($Animation, "animation_finished")
		queue_free()

func _on_PlayerDetection_body_entered(body):
	if body.is_in_group("Player") and not isDestroyed:
		var enemy_bullet = ENEMY_BULLET.instance()
		var orientation = Vector2(velocity / abs(velocity), 0)
		enemy_bullet.blast($Location.global_position, orientation)
		get_parent().call_deferred("add_child", enemy_bullet)
		$ShootSound.play()
		$ShootTimer.start()
