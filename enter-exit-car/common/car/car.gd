class_name Car
extends StaticBody3D
## Press E at the car to get in. Press E again to get out beside the first door that's clear.

@onready var _camera: Camera3D = %CarCamera
@onready var _exits: Array[Node] = %Exits.get_children()

var _driver: Node3D
var _driver_camera: Camera3D
var _wants_out: bool = false


func _ready() -> void:
	%Interactable.interacted.connect(_get_in)


func _get_in(player: Node3D) -> void:
	_driver = player
	_driver_camera = get_viewport().get_camera_3d()
	_driver.process_mode = Node.PROCESS_MODE_DISABLED  # no input, no movement, no collision
	_driver.hide()
	_camera.make_current()
	get_viewport().set_input_as_handled()


func _unhandled_input(event: InputEvent) -> void:
	if _driver != null and event.is_action_pressed(&"interact"):
		get_viewport().set_input_as_handled()
		_wants_out = true


func _physics_process(_delta: float) -> void:
	# the exit check asks the physics world, which the docs say is only safe in here
	if _wants_out:
		_wants_out = false
		_get_out()


func _get_out() -> void:
	for exit: Marker3D in _exits:
		if _is_clear(exit):
			_driver.global_transform = exit.global_transform
			_driver.process_mode = Node.PROCESS_MODE_INHERIT
			_driver.show()
			_driver_camera.make_current()
			_driver = null
			return


func _is_clear(exit: Marker3D) -> bool:
	var player_body := _driver as CollisionObject3D
	var owner_id := player_body.get_shape_owners()[0]
	var query := PhysicsShapeQueryParameters3D.new()
	query.shape = player_body.shape_owner_get_shape(owner_id, 0)
	query.transform = exit.global_transform * player_body.shape_owner_get_transform(owner_id)
	var space := get_world_3d().direct_space_state
	return space.intersect_shape(query, 1).is_empty()
