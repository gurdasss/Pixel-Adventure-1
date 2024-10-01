extends Area2D

@onready var collect_animation: AnimatedSprite2D = $CollectAnimation
var fruitAnimation: AnimatedSprite2D = null

func _ready() -> void:
	# get the last node from each instance of this node.
	fruitAnimation = get_child(-1)

func _on_body_entered(body: Node2D) -> void:
	
	if is_instance_valid(fruitAnimation):
		fruitAnimation.queue_free()
		collect_animation.play()

# delete the instance once the collect animation is over.
func _on_collect_animation_animation_finished() -> void:
	queue_free()
