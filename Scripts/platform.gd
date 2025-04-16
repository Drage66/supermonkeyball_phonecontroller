extends Node3D
@onready var ball : RigidBody3D = %Ball
@onready var vis_rep = %track2
@onready var range_orb : MeshInstance3D = $RangeOrb
@onready var ball_range = ball.range_value

func _process(delta: float) -> void:
	if ball.global_position.distance_to(range_orb.global_position) < ball_range:
		# transform.basis = vis_rep.transform.basis
		# transform.basis = transform.basis.slerp(vis_rep.transform.basis, 0.3)
		transform.basis = lerp(transform.basis, vis_rep.transform.basis,0.2)
		pass

