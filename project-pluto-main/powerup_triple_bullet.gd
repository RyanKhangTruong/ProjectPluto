extends Area2D

var not_taken = false

func _ready():
	$AnimatedSprite.play("spawn")
	yield($AnimatedSprite, "animation_finished")
	$AnimatedSprite.play("default")
	not_taken = true

func destroyed():
	not_taken = false
	Global.from_triple_powerup()
	$AnimatedSprite.hide()
	$powerup_sound.play()
	yield($powerup_sound, "finished")
	queue_free()
