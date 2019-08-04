if (instance_exists(obj_playerC)) {
	move_towards_point(obj_playerC.x,obj_playerC.y,spd);
}

image_angle = direction;


if(hp <= 0) instance_destroy();