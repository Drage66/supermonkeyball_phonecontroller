extends Node3D
@onready var track1 = %track1


func _process(delta: float) -> void:
	transform.basis = track1.transform.basis
