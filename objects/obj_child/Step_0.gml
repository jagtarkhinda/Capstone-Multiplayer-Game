/*for (i = 0; i < instance_number(obj_child); i += 1){
	enemy[i] = instance_find(obj_child,i);
	//moving enemy 1
	if(obj_id == 0)
	{
		 if (point_distance(x,y,400,400) > 2 && obj_flag == true)
		 {
			move_towards_point(400,400,spd)
		}
		else{
			obj_flag = false;
			mask_index = 1;
			spd = 0;
		}
	}
		//moving enemy 2
	if(obj_id == 1)
	{
		 if (point_distance(x,y,300,300) > 2)
		 {
			move_towards_point(300,300,spd)
		}
		else{
			mask_index = 1;
			spd = 0;
		}
	}
		//moving enemy 3
	if(obj_id == 2)
	{
		 if (point_distance(x,y,300,150) > 2)
		 {
			move_towards_point(300,150,spd)
		}
		else{
			mask_index = 1;
			spd = 0;
		}
	}
		//moving enemy 4
	if(obj_id == 3)
	{
		 if (point_distance(x,y,100,500) > 2)
		 {
			move_towards_point(100,500,spd)
		}
		else{
			mask_index = 1;
			spd = 0;
		}
	}
		//moving enemy 5
	if(obj_id == 4)
	{
		 if (point_distance(x,y,500,500) > 2)
		 {
			move_towards_point(500,500,spd)
		}
		else{
			mask_index = 1;
			spd = 0;
		}
	}
}

 
if (distance_to_object(spr_Player) < 500 && place_free(x,y))
{
	
		mask_index = 1;
	
	
	move_towards_point(spr_Player.x,spr_Player.y,2);
}


bullet_delay += delta_time;

// Auto shoot when close to the player
if distance_to_object(spr_Player) < range
{
	if (bullet_delay >= 2 * 1000000) {
	instance_create_layer(x, y, "bullet_Layer", obj_Bullet);
	bullet_delay = 0;
	}
}

image_angle = direction;
*/

if(hp <= 0)
{
	obj_boss.enemy_count -= 1;
	instance_destroy();
}

