extends CharacterBody2D


const SPEED: float = 100.0
const JUMP_VELOCITY: float = -400.0
var flag: bool = true

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
		
		if is_on_wall():
			currentSkin.play("wall jump")
			velocity.y = SPEED
		
		if Input.is_action_just_pressed("jump") and flag:
			currentSkin.play("double jump")
			velocity.y = -250
			flag = false
		
		if not currentSkin.is_playing():
			currentSkin.play("fall")

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		currentSkin.play("jump")
		velocity.y = JUMP_VELOCITY
		flag = true

	var direction := Input.get_axis("moveLeft", "moveRight")
	
	if direction > 0:
		currentSkin.flip_h = false
	elif direction < 0:
		currentSkin.flip_h = true

	if direction:
		velocity.x = direction * SPEED
		if is_on_floor():
			currentSkin.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor():
			currentSkin.play("idle")

	move_and_slide()
