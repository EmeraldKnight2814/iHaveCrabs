extends Node2D

var rng = RandomNumberGenerator.new()
var first_room

func _ready():
	rng.randomize()
	first_room = rng.randi_range(1, 4)
	if first_room == 1:
		room3_ready()
	elif first_room == 2:
		room7_ready()
	elif first_room == 3:
		room1_ready()
	elif first_room == 4:
		room2_ready()
	else:
		room3_ready()

func room1_ready():
	#Disable Collision Shape
	$Room1/RoomShape/RectColl.disabled = true
	#Spawn Enemies
	$Room1.room_ready()

func room2_ready():
	#Disable Collision Shape
	$Room2/RoomShape/RectColl.disabled = true
	#Spawn Enemies
	#insert

func room3_ready():
	#Disable Collision Shape
	$Room3/RoomShape/RectColl.disabled = true
	#Spawn Enemies
	#insert

func room4_ready():
	#Disable Collision Shape
	$Room4/RoomShape/RectColl.disabled = true
	#Spawn Enemies
	#insert

func room5_ready():
	#Disable Collision Shape
	$Room5/RoomShape/RectColl.disabled = true
	#Spawn Enemies
	#insert

func room6_ready():
	#Disable Collision Shape
	$Room6/RoomShape/RectColl.disabled = true
	#Spawn Enemies
	#insert

func room7_ready():
	#Disable Collision Shape
	$Room7/RoomShape/RectColl.disabled = true
	#Spawn Enemies
	#insert

func corner_room1_ready():
	#Disable Collision Shape
	$CornerRoom1/RoomShape/RectColl.disabled = true
	#Spawn Enemies
	#insert

func corner_room2_ready():
	#Disable Collision Shape
	$CornerRoom2/RoomShape/RectColl.disabled = true
	#Spawn Enemies
	#insert

func single_room1_ready():
	#Disable Collision Shape
	$SingleRoom1/RoomShape/RectColl.disabled = true
	#Spawn Enemies
	#insert

func single_room2_ready():
	#Disable Collision Shape
	$SingleRoom1/RoomShape/RectColl.disabled = true
	#Spawn Enemies
	#insert

func single_room3_ready():
	#Disable Collision Shape
	$SingleRoom1/RoomShape/RectColl.disabled = true
	#Spawn Enemies
	#insert

func linear_room1_ready():
	#Disable Collision Shape
	$LinearRoom1/RoomShape/RectColl.disabled = true
	#Spawn Enemies
	#insert

func boss_room_ready():
	#Disable Collision Shape
	$BossRoomTop/RoomShape/RectColl.disabled = true
	#Spawn Enemies
	#insert
