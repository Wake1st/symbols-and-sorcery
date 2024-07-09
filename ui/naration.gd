class_name Naration
extends Control

@onready var textBox = %TextBox


func add_text(t:String) -> void:
	textBox.text += "%s\n" % t
