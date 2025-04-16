@tool
extends Camera3D

@onready var ball = %Ball 
@onready var cam_offset

func _ready() -> void:
	cam_offset = position
	pass

func _process(delta: float) -> void:
	if (!Engine.is_editor_hint()):
		position = (ball.global_position + cam_offset)

	look_at(ball.global_position)
	pass
