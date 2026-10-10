extends Node2D

var file = FileAccess.open("user://saveState.json", FileAccess.WRITE)
var save_template = FileAccess.open("res://User/saveState.json", FileAccess.READ)

func _ready():

	file.store_string(save_template.get_as_text())
	file.close()

	pass

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
