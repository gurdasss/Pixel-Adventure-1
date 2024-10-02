extends Area2D

var animatedSprite: AnimatedSprite2D = null
var particle: CPUParticles2D = null

# number of hits different types of box can take
@export var numberOfHits: int = 1

func _ready() -> void:
	# get the child of each instance
	# AnimatedSprite2D (second last child) 
	animatedSprite = get_child(-2)
	
	# CPUParticles2D (last child)
	particle = get_child(-1)

func _on_body_entered(body: Node2D) -> void:
	if numberOfHits > 0:
		animatedSprite.play("hit")
		numberOfHits -= 1
	
	# numberOfHits is zero or negative
	if is_instance_valid(animatedSprite) and not numberOfHits:
		animatedSprite.queue_free()
		particle.emitting = true # start emitting particles
		# connect with CPUParticles2D's finished signal
		# and then call queue_free from self.
		particle.connect("finished", Callable(self, "queue_free"))

func _on_body_exited(body: Node2D) -> void:
	if is_instance_valid(animatedSprite):
		# retuen the box back to normal
		animatedSprite.play("idle")
