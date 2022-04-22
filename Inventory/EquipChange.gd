extends Node

func set_stats(item_name):
	if (JsonData.item_data[item_name]["Mspeed"] != null):
		print(get_node("/root/PlayerStats").crab_max_speed)
		print(JsonData.item_data[item_name]["Mspeed"])
		Stats.set_crab_max_speed(get_node("/root/PlayerStats").crab_max_speed + JsonData.item_data[item_name]["Mspeed"])
		print("EAT")
		print(get_node("/root/PlayerStats").crab_max_speed)
