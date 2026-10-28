class_name Interactor
extends RayCast3D
## Finds the Interactable under the crosshair and fires it on the "interact" action.

signal target_changed(target: Interactable)

var current: Interactable


func _physics_process(_delta: float) -> void:
	var found: Interactable = null
	if is_colliding():
		var collider := get_collider()
		if collider is Node:
			found = (collider as Node).get_node_or_null(^"Interactable") as Interactable
	if found != current:
		current = found
		target_changed.emit(current)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"interact") and current != null and current.enabled:
		current.interact(owner as Node3D)
