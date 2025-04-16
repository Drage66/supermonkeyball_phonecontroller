extends Node3D

# PackedVector3 Array that should contain 2 elements that we cycle through to get the relative frame data
var frame_containers = PackedVector3Array([Vector3.ZERO,Vector3.ZERO])
#NOTE: Should be a main node with the object model to be rotated as children
# We calibrate the models to be adjusted to the phones formation
# Refer to the phone's axis as it uses a different coordinate system, than I would intuit
# The URL we will connect to.
# @export var websocket_url = "ws://10.0.0.14:8081"
@export var websocket_url = "ws://192.168.8.192:8081"

# Used to get the orientation of device
var _orientation_path = "/sensor/connect?type=android.sensor.rotation_vector"
## NOTE: Rotation Vector gets the device orientation relative to magnetic field
## Try using game_rotation_vector instead as it uses some other reference
# Used to get the acceleration of device

# Our WebSocketClient instance.
var _orientation_socket = WebSocketPeer.new()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
# Initiate connection to the given URL.
	_orientation_socket.connect_to_url("%s%s"%[websocket_url,_orientation_path])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	# transform.origin = Vector3(randf_range(0,10),randf_range(0,10),randf_range(0,10))
	# var arrow_lines = DebugDraw3D.new_scoped_config().set_thickness(0.02).set_hd_sphere(true).set_center_brightness(1)
	# DebugDraw3D.draw_arrow_ray(global_position,transform.basis.x,2,Color.RED,0.05)
	# DebugDraw3D.draw_arrow_ray(global_position,transform.basis.y,2,Color.GREEN,0.05)
	# DebugDraw3D.draw_arrow_ray(global_position,transform.basis.z,2,Color.BLUE,0.05)
	
	# Call this in _process or _physics_process. Data transfer and state updates
	# will only happen when calling this function.
	_orientation_socket.poll()

	# get_ready_state() tells you what state the socket is in.
	var _orientation_state = _orientation_socket.get_ready_state()

	## Orientation State
	# WebSocketPeer.STATE_OPEN means the socket is connected and ready
	# to send and receive data.
	if _orientation_state == WebSocketPeer.STATE_OPEN:
		while _orientation_socket.get_available_packet_count():
			#The data is received as a string so we have to parse it into a dict type
			#So far acceloremeter option are:
			#data["values"]
			#data["timestamp"]
			#data["accuracy"]
			var data = JSON.parse_string(_orientation_socket.get_packet().get_string_from_utf8())
			orientation(data)
			
			#print("Got data from server: ", socket.get_packet().get_string_from_utf8())
	# WebSocketPeer.STATE_CLOSING means the socket is closing.
	# It is important to keep polling for a clean close.
	elif _orientation_state == WebSocketPeer.STATE_CLOSING:
		pass
	# WebSocketPeer.STATE_CLOSED means the connection has fully closed.
	# It is now safe to stop polling.
	elif _orientation_state == WebSocketPeer.STATE_CLOSED:
		# The code will be -1 if the disconnection was not properly notified by the remote peer.
		var code = _orientation_socket.get_close_code()
		print("WebSocket closed with code: %d. Clean: %s" % [code, code != -1])
		set_process(false) # Stop processing.


func orientation(orientation_data):
	var phone_basis = Basis(Quaternion(-orientation_data["values"][0],-orientation_data["values"][2],orientation_data["values"][1],-orientation_data["values"][3]))
	# print(orientation_data)
	transform.basis = phone_basis
	#NOTE: Test the slerp weights values and see if i can make it relative to the gyroscope rotation speed
	# transform.basis = transform.basis.slerp(phone_basis,0.1)
	# var distance = transform.basis.distance_to(phone_basis)

