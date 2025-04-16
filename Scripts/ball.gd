extends RigidBody3D
@export var range_value = 10
@onready var range_indicator : MeshInstance3D = $RangeIndicator

func _process(delta: float) -> void:
	range_indicator.scale = Vector3(range_value,range_value,range_value) * 2.0
