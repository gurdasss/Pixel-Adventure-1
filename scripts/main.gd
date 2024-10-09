extends Node2D


func _on_level_1_tree_exited() -> void:
	var level2 = preload("res://scenes/Levels/level_2.tscn").instantiate()
	
	add_child(level2)


func _on_level_2_tree_exited() -> void:
	var level3 = preload("res://scenes/Levels/level_3.tscn").instantiate()
	
	add_child(level3)
