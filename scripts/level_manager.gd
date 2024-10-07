extends Node2D

@onready var background: TileMapLayer = $Background
@onready var player: CharacterBody2D = $Player

@export var playerStartingPosition: Vector2 = Vector2(0,0)


const BG_TEXTURE: Array[String] = [
	"res://assets/Background/Blue.png",
	"res://assets/Background/Brown.png",
	"res://assets/Background/Gray.png",
	"res://assets/Background/Green.png",
	"res://assets/Background/Pink.png",
	"res://assets/Background/Purple.png",
	"res://assets/Background/Yellow.png"
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.position = playerStartingPosition
	background.tile_set.get_source(1).texture = load(BG_TEXTURE.pick_random())
