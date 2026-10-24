extends Button

@export var itemName: String
@export var number: int
@export var id: int
@export var gui_node: Control
@export var diologuePath: String
@export var imagePath: String


@onready var item: Dictionary = {
	"name":itemName,
	"imagePath":imagePath,
	"quantity":number,
}

func _on_pressed() -> void:
	item = {
		"name":itemName,
		"imagePath":imagePath,
		"quantity":number,
	}

	gui_node.addItemToInventory(item, id, diologuePath)
