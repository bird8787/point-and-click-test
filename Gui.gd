extends Control

#inventory
@onready var inventoryLabel: RichTextLabel = $Inventory


#puzzlePieces
@onready var puzzlePiece1: ColorRect = $Inventory/GridContainer/ColorRect
@onready var puzzlePiece2: ColorRect = $Inventory/GridContainer/ColorRect2
@onready var puzzlePiece3: ColorRect = $Inventory/GridContainer/ColorRect3
@onready var puzzlePiece4: ColorRect = $Inventory/GridContainer/ColorRect4
#colors
@onready 	var colors = ["#00000000","#ffffffff"]
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

class PuzzlePieces:
	var mask
	var pieces
	func _init(index, p):
		pieces = int(p)
		mask = 1 << index
		if not pieces & mask:
			pieces = pieces | mask
func to_binary(intValue: int) -> String:
	var bin_str: String = ""
	while intValue > 0:
		bin_str = str(intValue & 1) + bin_str
		intValue = intValue >> 1
	return bin_str
	
func is_bit_active(index: int) -> bool:
	return (int(inventory["puzzlePieces"]) & (1 << index)) > 0
class Item:
	var name: String
	var quantity: int
	func _init(n,q):
		name = n
		quantity = q
var inventory = getJsonAsDict("res://saveState.json")["inventory"]

func _ready():
	var screenstuff = ""

	for item in inventory["items"]:
		#do stuff
		screenstuff = screenstuff + item["name"] + " x" + str(int(item["quantity"])) + "\n"
	#Render Puzzle Piece
	puzzlePiece1.color = colors[int(is_bit_active(0))]
	puzzlePiece2.color = colors[int(is_bit_active(1))]
	puzzlePiece3.color = colors[int(is_bit_active(2))]
	puzzlePiece4.color = colors[int(is_bit_active(3))]
	
	screenstuff = screenstuff + to_binary(inventory["puzzlePieces"]).lpad(8, "0") + "\n"
	inventoryLabel.append_text(screenstuff)


func _on_inventory_open() -> void:
	if inventoryLabel.visible: inventoryLabel.visible = false
	else: inventoryLabel.visible = true
	puzzlePiece1.color = colors[int(is_bit_active(0))]
	puzzlePiece2.color = colors[int(is_bit_active(1))]
	puzzlePiece3.color = colors[int(is_bit_active(2))]
	puzzlePiece4.color = colors[int(is_bit_active(3))]
