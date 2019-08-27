extends Control

export (NodePath) var start_button_path

onready var start_button = get_node(start_button_path)


func _ready():
	start_button.connect("pressed", self, "_on_start_button_pressed")


func _on_start_button_pressed():
	get_tree().change_scene("res://main.tscn")
