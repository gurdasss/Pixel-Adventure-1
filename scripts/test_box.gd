extends StaticBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var noOfHits: int = 10
@onready var test_particle: CPUParticles2D = $"Test Particle"

func _on_area_2d_body_entered(body: Node2D) -> void:
	print("You are breaking some box")
	
	if is_instance_valid(animated_sprite) and noOfHits > 0:
		animated_sprite.play("hit")
		noOfHits -= 1


func _on_area_2d_body_exited(body: Node2D) -> void:
	if is_instance_valid(animated_sprite) and noOfHits > 0:
		animated_sprite.play("idle")
	
	if noOfHits == 0 and is_instance_valid(animated_sprite):
		test_particle.emitting = true
		animated_sprite.queue_free()
	

func _on_test_particle_finished() -> void:
	queue_free()
