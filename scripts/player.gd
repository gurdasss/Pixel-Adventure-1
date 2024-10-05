extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var currentSkin: AnimatedSprite2D

func _ready() -> void:
	# instantiate the skin Manager that contains
	# all the skins for the player
	var skin_manager: Node2D = preload("res://scenes/skin_manager.tscn").instantiate()
	
	# generate a random child ID
	var childID: int = randi_range(0, skin_manager.get_child_count() - 1)
	
	# pick a random skin using child ID
	currentSkin = skin_manager.get_child(childID).duplicate()
	add_child(currentSkin)
	


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
