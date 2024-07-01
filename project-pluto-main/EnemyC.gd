extends Area2D

const speed = 2.5
var velocity = speed
var isDestroyed = true

func _ready():
	$Animation.self_modulate = Color(10,10,10,10)
	yield(get_tree().create_timer(0.6), "timeout")
	$Animation.self_modulate = Color(1,1,1,1)
	isDestroyed = false

func _process(_delta):
	position.x += velocity
	$Animation.play("fly")

func turn_around():
	velocity *= -1
	$Animation.flip_h = not $Animation.flip_h

func destroyed():
	set_process(false)
	get_parent().defeated += 1
	Global.death_count += 1
	Global.set_enemies_remaining()
	$ExplodeSound.play()
	isDestroyed = true
	$Animation.play("explode")
	yield($Animation, "animation_finished")
	queue_free()
