extends CharacterBody3D
## WASD to walk, mouse to look.

@export var speed: float = 4.0
@export var mouse_sensitivity: float = 0.002
const MAX_LOOK_ANGLE := deg_to_rad(80.0)  # how far up or down you can look

@onready var _camera: Camera3D = %"Player Camera"
@onready var _interactor: Interactor = %"Player Interactor"
@onready var _hud: HUD = %HUD


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	_interactor.target_changed.connect(_on_target_changed)
	visibility_changed.connect(func() -> void: _hud.visible = visible)
	_hud.show_prompt("")


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var mouse_motion := event as InputEventMouseMotion

		var turn := -mouse_motion.relative.x * mouse_sensitivity
		rotate_y(turn)

		var tilt := -mouse_motion.relative.y * mouse_sensitivity
		var new_pitch := _camera.rotation.x + tilt
		_camera.rotation.x = clampf(new_pitch, -MAX_LOOK_ANGLE, MAX_LOOK_ANGLE)


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	var input_dir := Input.get_vector(&"move_left", &"move_right", &"move_forward", &"move_back")

	var move_direction := transform.basis * Vector3(input_dir.x, 0.0, input_dir.y)

	velocity.x = move_direction.x * speed
	velocity.z = move_direction.z * speed

	move_and_slide()


func _on_target_changed(target: Interactable) -> void:
	_hud.show_prompt("" if target == null else "E  " + target.prompt)
