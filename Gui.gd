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
	print(json_string)
	var json = JSON.new()
	var error = json.parse(json_string)
	if error == OK:
		var data_received = json.data
		print(typeof(data_received))
		if typeof(data_received) == TYPE_DICTIONARY:
			print(data_received) # Prints the array.
		else:
			print("Unexpected data")
	else:
		print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())

class PuzzlePieces:
	var mask
	var pieces
	func _init(index, p):
		pieces = p
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
	return (inventory.puzzlepieces & (1 << index)) > 0
class Item:
	var name: String
	var quantity: int
	func _init(n,q):
		name = n
		quantity = q
var inventory = {"items":[
	
	
	Item.new("pillow",8),
	Item.new("tv",2348765)],
	"puzzlepieces":0
	}	

func _ready():
	print(getJsonAsDict("res://saveState.json"))
	var screenstuff = ""
	inventory.puzzlepieces = PuzzlePieces.new(0, inventory.puzzlepieces).pieces
	inventory.puzzlepieces = PuzzlePieces.new(3, inventory.puzzlepieces).pieces

	for item in inventory.items:
		#do stuff
		screenstuff = screenstuff + item.name + "\n"
	#Render Puzzle Piece
	print(inventory.puzzlepieces & 3)
	puzzlePiece1.color = colors[int(is_bit_active(0))]
	puzzlePiece2.color = colors[int(is_bit_active(1))]
	puzzlePiece3.color = colors[int(is_bit_active(2))]
	puzzlePiece4.color = colors[int(is_bit_active(3))]
	
	screenstuff = screenstuff + to_binary(inventory.puzzlepieces).lpad(8, "0") + "\n"
	inventoryLabel.append_text(screenstuff)


func _on_inventory_open() -> void:
	if inventoryLabel.visible: inventoryLabel.visible = false
	else: inventoryLabel.visible = true
	puzzlePiece1.color = colors[int(is_bit_active(0))]
	puzzlePiece2.color = colors[int(is_bit_active(1))]
	puzzlePiece3.color = colors[int(is_bit_active(2))]
	puzzlePiece4.color = colors[int(is_bit_active(3))]
