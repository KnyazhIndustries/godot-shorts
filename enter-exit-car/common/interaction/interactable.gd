class_name Interactable
extends Node
## Attach as a child named "Interactable" to any body. The parent is what gets interacted with.

signal interacted(actor: Node3D)

@export var prompt: String = "Interact"
@export var enabled: bool = true


func interact(actor: Node3D) -> void:
	if enabled:
		interacted.emit(actor)
