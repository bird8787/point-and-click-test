extends Button

@onready var new_game_conform: PanelContainer = $"../../NewGameConform"
@onready var conferm: Button = $"../../NewGameConform/VBoxContainer/HBoxContainer/Conferm"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	var save = getJsonAsDict("user://saveState.json")
	
	if save["New"]:
		conferm._on_pressed()
	else:
		new_game_conform.visible = true
		
		pass
	
	pass # Replace with function body.

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
