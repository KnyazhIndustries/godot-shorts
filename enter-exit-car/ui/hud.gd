class_name HUD
extends CanvasLayer
## The crosshair, and the prompt under it.

@onready var _prompt: Label = %Prompt


func show_prompt(text: String) -> void:
	_prompt.text = text
