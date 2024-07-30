class_name Naration
extends Control

@onready var textBox:TextEdit = %TextBox


func add_text(t:String) -> void:
	textBox.text += "%s\n\n" % t
	textBox.set_line_as_last_visible(textBox.get_line_count()-1)
