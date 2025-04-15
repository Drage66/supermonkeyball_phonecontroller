extends Node3D
@onready var track1 = %track1
## ISSUE: Some BS over here
## NOTE:We need to define the viewport from which we want to see the lines from otherwise it wont show unless its seen by active camera
@onready var viewport = %SubViewport


func _process(delta: float) -> void:
	transform.basis = track1.transform.basis
	var arrow_lines = DebugDraw3D.new_scoped_config().set_thickness(1.0).set_hd_sphere(true).set_center_brightness(0.2).set_viewport(viewport)
	DebugDraw3D.draw_ray(global_transform.origin, global_transform.basis.x, 2000,Color.RED)
	DebugDraw3D.draw_ray(global_transform.origin, global_transform.basis.y, 2000,Color.GREEN)
	DebugDraw3D.draw_ray(global_transform.origin, global_transform.basis.z, 2000,Color.BLUE)
	# DebugDraw3D.draw_gizmo(Transform3D(transform.basis * 2000, global_transform.origin))
