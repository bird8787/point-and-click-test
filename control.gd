extends Control
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
class Item:
	var name: String
	var quantity: int
	func _init(n,q):
		name = n
		quantity = q
var inventory = {"items":[
	Item.new("pillow",8),
	Item.new("tv",2348765)],
	"puzzlepieces":PuzzlePieces.new(0, 0).pieces
	}	

func _ready():
	var screenstuff = ""
	inventory.puzzlepieces = PuzzlePieces.new(0, inventory.puzzlepieces).pieces
	inventory.puzzlepieces = PuzzlePieces.new(2, inventory.puzzlepieces).pieces

	for item in inventory.items:
		#do stuff
		screenstuff = screenstuff + item.name + "\n"
	screenstuff = screenstuff + to_binary(inventory.puzzlepieces).lpad(8, "0") + "\n"
	$RichTextLabel.append_text(screenstuff)
