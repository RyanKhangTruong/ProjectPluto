extends Area2D

var direction = Vector2.ZERO
var isDestroyed = false

func boss_blast(Location, Orientation):
	position = Location 
	direction = Orientation
	rotation = Orientation.angle()

func _process(_delta):
	$Animation.play("bullet")
	position += 8 * direction

func destroyed():
	isDestroyed = true
	set_process(false)
	$Animation.play("bullet_pop")
	yield($Animation, "animation_finished")
	queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	destroyed()

func _on_Boss_Bullet_body_entered(body):
	if body.is_in_group("Player"):
		if body.has_signal("dying"):
			yield(get_tree(), "physics_frame")
		destroyed()
