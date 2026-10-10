extends Button
@export var scene_to_change_to: String

@onready var rooms = [
	"res://Rooms/outSide.tscn",
	"res://Rooms/insideHouse.tscn"

]

func _on_pressed() -> void:
	var save = getJsonAsDict("user://saveState.json")
	scene_to_change_to = rooms[save["room"]]
	#var scene_to_change_to = change_scene.resource_path
	print("dawdwad")
	print(scene_to_change_to)
	get_tree().change_scene_to_file(scene_to_change_to)

func getJsonAsDict(PATH: String):
	var file = FileAccess.open(PATH, FileAccess.READ)
	var json_string = file.get_as_text()
	var json = JSON.new()
	var error = json.parse(json_string)
	if error == OK:
		var data_received = json.data
		if typeof(data_received) == TYPE_DICTIONARY:
			return(data_received)
		else:
			print("Unexpected data")
	else:
		print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
