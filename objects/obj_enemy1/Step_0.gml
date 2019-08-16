
//moving the enemy along the path

if (distance_to_object(obj_Player) < 200)
	
	{
		path_end();
		move_towards_point(obj_Player.x,obj_Player.y,1);
	}
	