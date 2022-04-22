extends Node

func set_stats(item_name):
	if (JsonData.item_data[item_name]["Mspeed"] != null):
		print(get_node("/root/PlayerStats").crab_max_speed)
		print(JsonData.item_data[item_name]["Mspeed"])
		Stats.set_crab_max_speed(get_node("/root/PlayerStats").crab_max_speed + JsonData.item_data[item_name]["Mspeed"])
		print("EAT")
		print(get_node("/root/PlayerStats").crab_max_speed)
		
	if (JsonData.item_data[item_name]["Sneaky"] != null):
		print(get_node("/root/PlayerStats").crab_zone_of_truth_radius)
		print(JsonData.item_data[item_name]["Sneaky"])
		Stats.set_crab_zone_of_truth(get_node("/root/PlayerStats").crab_zone_of_truth_radius + JsonData.item_data[item_name]["Sneaky"])
		print("NOM")
		print(get_node("/root/PlayerStats").crab_zone_of_truth_radius)
