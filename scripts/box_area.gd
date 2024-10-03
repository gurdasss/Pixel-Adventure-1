extends Area2D

var animatedSprite: AnimatedSprite2D = null
@onready var cpu_particles: CPUParticles2D = $CPUParticles2D

@export var texturePath: String = ""
@export var initialVelocityMin: float = 100.00
@export var initialVelocityMax: float = 150.00

# number of hits different types of box can take
@export var numberOfHits: int = 1

func _ready() -> void:
	# get the last node from each instance of this node.
	# AnimatedSprite2D (last child)
	animatedSprite = get_child(-1)
	
	# load the specified texturePath during runtime
	cpu_particles.texture = load(texturePath)
	
	cpu_particles.initial_velocity_min = initialVelocityMin
	cpu_particles.initial_velocity_max = initialVelocityMax
	

func _on_body_entered(body: Node2D) -> void:
	if numberOfHits > 0:
		animatedSprite.play("hit")
		numberOfHits -= 1
	
	# numberOfHits is zero or negative
	if is_instance_valid(animatedSprite) and not numberOfHits:
		animatedSprite.queue_free()
		cpu_particles.emitting = true # start emitting particles
		# connect with CPUParticles2D's finished signal
		# and then call queue_free from self.
		cpu_particles.connect("finished", Callable(self, "queue_free"))

func _on_body_exited(body: Node2D) -> void:
	if is_instance_valid(animatedSprite):
		# retuen the box back to normal
		animatedSprite.play("idle")
