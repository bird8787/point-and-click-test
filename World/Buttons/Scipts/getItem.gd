extends Button

@export var itemName: String
@export var number: int
@export var id: int
@export var gui_node: Control
@export var diologuePath: String
@export var imagePath: String
@export var look_diologue_path: String

@onready var item: Dictionary = {
	"name":itemName,
	"imagePath":imagePath,
	"quantity":number,
	"look": look_diologue_path
}

func _on_pressed() -> void:
	item = {
		"name":itemName,
		"imagePath":imagePath,
		"quantity":number,
		"look": look_diologue_path
	}

	gui_node.addItemToInventory(item, id, diologuePath)
