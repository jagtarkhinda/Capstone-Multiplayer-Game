move_towards_point(random_range(0,room_width), random_range(0,room_height), 5);

bb_hp = 1;

if(instance_exists(obj_server)){
	visible = false //remove the sprite duplication on the player host
}
