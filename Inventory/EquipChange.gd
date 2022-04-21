extends Node

func set_stats(item_name):
	if (JsonData.item_data[item_name]["Mspeed"] != null):
		$Crab.MAX_SPEED += JsonData.item_data[item_name]["Mspeed"]
		print("EAT")
