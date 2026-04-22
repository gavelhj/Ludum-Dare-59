class_name SceneChangeComponent
# basically like creating a new type of node
# nodes are all just classes

extends Node
# inherit methods from the "Node" class
# (it also appears in the add new node menu now)

@export var button: TextureButton
@export var scene_path: String
# variables you can change in the editor outside code
# like when you add a texture to a button or a position

func open_menu():
	get_tree().change_scene_to_file(scene_path)

func _ready() -> void:
	button.pressed.connect(open_menu)
	
	if not "res://" in scene_path:
		scene_path = "res://" + scene_path
	if not ".tscn" in scene_path:
		scene_path = scene_path + ".tscn"
