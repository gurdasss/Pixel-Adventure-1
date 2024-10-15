extends Area2D

var animatedSprite: AnimatedSprite2D = null
@onready var cpu_particles: CPUParticles2D = $CPUParticles2D

@export var texturePath: String = ""
@export var initialVelocityMin: float = 100.00
@export var initialVelocityMax: float = 150.00

# number of hits different types of box can take
@export var numberOfHits: int = 1

var fruitBasket: Array[PackedScene]

func generateRigidBody() -> RigidBody2D:
	var collisionShape: CircleShape2D = CircleShape2D.new()
	collisionShape.radius = 1
	
	var circleCollision: CollisionShape2D = CollisionShape2D.new()
	circleCollision.shape = collisionShape
	
	var rigidBody: RigidBody2D = RigidBody2D.new()
	rigidBody.add_child(circleCollision)
	
	return rigidBody

func generateFruit() -> RigidBody2D:
	var rigidBody: RigidBody2D = generateRigidBody()
	var randomFruit: Node2D = fruitBasket.pick_random().instantiate()
	
	rigidBody.add_child(randomFruit)
	
	return rigidBody
	

func dropFruits(amount: int) -> void:
	for i in range(amount):
		var test = generateFruit()
		get_parent().add_child(test)

func _ready() -> void:
	# get the last node from each instance of this node.
	# AnimatedSprite2D (last child)
	animatedSprite = get_child(-1)
	
	
	fruitBasket.append(preload("res://scenes/Fruits/apple.tscn"))
	fruitBasket.append(preload("res://scenes/Fruits/banana.tscn"))
	fruitBasket.append(preload("res://scenes/Fruits/cherry.tscn"))
	
	fruitBasket.append(preload("res://scenes/Fruits/kiwi.tscn"))
	fruitBasket.append(preload("res://scenes/Fruits/melon.tscn"))
	fruitBasket.append(preload("res://scenes/Fruits/orange.tscn"))
	
	fruitBasket.append(preload("res://scenes/Fruits/pineapple.tscn"))
	fruitBasket.append(preload("res://scenes/Fruits/strawberry.tscn"))
	
	# load the specified texturePath during runtime
	cpu_particles.texture = load(texturePath)
	
	cpu_particles.initial_velocity_min = initialVelocityMin
	cpu_particles.initial_velocity_max = initialVelocityMax
	

func _on_body_entered(body: Node2D) -> void:
	if numberOfHits > 0:
		animatedSprite.play("hit")
		numberOfHits -= 1
	
	# numberOfHits is zero
	if is_instance_valid(animatedSprite) and not numberOfHits:
		animatedSprite.queue_free()
		cpu_particles.emitting = true # start emitting particles
		
		dropFruits(5)

func _on_body_exited(body: Node2D) -> void:
	if is_instance_valid(animatedSprite):
		# return the box back to normal
		animatedSprite.play("idle")

# connect with CPUParticles2D's finished signal
# and then call queue_free from self.
func _on_cpu_particles_2d_finished() -> void:
	queue_free()
