extends Node2D

@onready var load_game: Button = $"VBoxContainer/Load Game"

func resetUserData():
	var save_template = FileAccess.open("res://User/saveState.json", FileAccess.READ)
	var file = FileAccess.open("user://saveState.json", FileAccess.READ)
	file = FileAccess.open("user://saveState.json", FileAccess.WRITE)
	file.store_string(save_template.get_as_text())
	load_game.disabled = true
	file.close()


func _ready():
	var save_template = FileAccess.open("res://User/saveState.json", FileAccess.READ)
	var file = FileAccess.open("user://saveState.json", FileAccess.READ)
	if file == null:
		resetUserData()
	
	#Check Store Version
	var saveFile = getJsonAsDict("user://saveState.json")
	var saveTemplateJson = getJsonAsDict("res://User/saveState.json")
	
	if saveFile.has("storeVersion"):
		if saveFile["storeVersion"] != saveTemplateJson["storeVersion"]:
			resetUserData()
	else:
		resetUserData()
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
