extends Area2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _on_body_entered(body: Node2D) -> void:
	animated_sprite.play("flag out")


func _on_animated_sprite_2d_animation_finished() -> void:
	animated_sprite.play("flag idle")
