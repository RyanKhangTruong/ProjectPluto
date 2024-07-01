extends Area2D

var direction = Vector2.ZERO
var notDestroyed = true

func blast(Location, Orientation):
	position = Location + 20 * Orientation
	direction = Orientation

func blast_triple(Location, Orientation, Number):
	position = Location + 20 * Orientation * Number
	direction = Orientation

func _process(_delta):
	$Animation.play("bullet")
	position += 8 * direction

func _on_Player_Bullet_area_entered(area):
	if area.is_in_group("Enemy") and notDestroyed:
		if not area.isDestroyed:
			notDestroyed = false
			set_process(false)
			area.destroyed()
			$Animation.play("bullet_pop")
			yield($Animation, "animation_finished")
			queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Player_Bullet_body_entered(body):
	if not body.is_in_group("Player"):
		notDestroyed = false
		set_process(false)
		$Animation.play("bullet_pop")
		yield($Animation, "animation_finished")
		queue_free()
