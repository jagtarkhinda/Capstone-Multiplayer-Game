if (instance_exists(obj_Player)) {
	move_towards_point(obj_Player.x,obj_Player.y,spd);
}

image_angle = direction;


if(hp <= 0) instance_destroy();