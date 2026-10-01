extends CanvasLayer

func change_text(text):
	$RichTextLabel.clear()
	$RichTextLabel.append_text(text)
