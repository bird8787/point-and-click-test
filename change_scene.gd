extends Button
@export var scene_to_change_to: String
@export var gui_node: Control
func _on_pressed() -> void:
	#var scene_to_change_to = change_scene.resource_path
	print("dawdwad")
	print(scene_to_change_to)
	gui_node.autoSave()
	get_tree().change_scene_to_file(scene_to_change_to)
