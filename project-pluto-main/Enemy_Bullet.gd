extends Area2D

var direction = Vector2.ZERO
var isDestroyed = false

func blast(Location, Orientation):
	position = Location + 20 * Orientation
	direction = Orientation

func _process(_delta):
	$Animation.play("bullet")
	position += 8 * direction

func _on_Enemy_Bullet_body_entered(_body):
	set_process(false)
	$Animation.play("bullet_pop")
	yield($Animation, "animation_finished")
	queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func destroyed():
	queue_free()
