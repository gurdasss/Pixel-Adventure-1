extends Area2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

const BOOST: float = -300

func _on_body_entered(body: Node2D) -> void:
	animated_sprite.play("hit")
	body.velocity.y += BOOST


func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
