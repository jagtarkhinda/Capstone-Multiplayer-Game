/*if(keyboard_check(ord("A")) || keyboard_check(vk_left)){
	SendMovement(0, true)
}
if(keyboard_check(ord("D")) || keyboard_check(vk_right)){
	SendMovement(1, true)
}
if(keyboard_check(ord("W")) || keyboard_check(vk_up)){
	SendMovement(2, true)
}
if(keyboard_check(ord("S")) || keyboard_check(vk_down)){
	SendMovement(3, true)
}
***********************************

if(keyboard_check(ord("A")) || keyboard_check(vk_left)) x = x - 4;
if(keyboard_check(ord("D")) || keyboard_check(vk_right)) x = x + 4; 
if(keyboard_check(ord("W")) || keyboard_check(vk_up)) y = y - 4;
if(keyboard_check(ord("S")) || keyboard_check(vk_down))	y = y + 4; 


*/

if(playing){
	if(keyboard_check_pressed(vk_left)){
		SendMovement(KEY_LEFT, true)
	}
	if(keyboard_check_released(vk_left)){
		SendMovement(KEY_LEFT, false)
	}
	
	if(keyboard_check_pressed(vk_right)){
		SendMovement(KEY_RIGHT, true)
	}
	if(keyboard_check_released(vk_right)){
		SendMovement(KEY_RIGHT, false)
	}
	
	if(keyboard_check_pressed(vk_down)){
		SendMovement(KEY_DOWN, true)
	}
	if(keyboard_check_released(vk_down)){
		SendMovement(KEY_DOWN, false)
	}
	
	if(keyboard_check_pressed(vk_up)){
		SendMovement(KEY_UP, true)
	}
	if(keyboard_check_released(vk_up)){
		SendMovement(KEY_UP, false)
	}
	
	//loop players
	for(var i = 0; i < instance_number(obj_remote_entity); i++){
		var e = instance_find(obj_remote_entity, i)
		if(my_id == e.my_id){
			target = e
			break
		}
	}

	if(target != noone){
		camera_set_view_target(view_camera[0], e)
		camera_set_view_border(view_camera[0], view_wport[0]/2, view_hport[0]/2)
	}
	
	// Shotting
	//image_angle = point_direction(e.x,e.y,mouse_x,mouse_y);
	//show_debug_message("mouse_x: " + string(mouse_x));
	//show_debug_message("mouse_y: " + string(mouse_y));show_debug_message("mouse_y: " + string(mouse_y));
 
	if (mouse_check_button(mb_left)) && (cooldown < 1) {
		cooldown = 10;
		SendNewBullet(PACKET_NEW_BULLET, mouse_x, mouse_y)
	}
	cooldown = cooldown - 1;
	
	
	//making enemies follow the player -JSK
			
					
		/*			for(var en = 0; en < ds_list_size(enemies1); en++)
					{
						var enemy_i = ds_list_find_value(enemies1, en)
						with(enemy_i)
						{
							if (distance_to_object(obj_Player) < 200)
							{
								path_end();
								move_towards_point(obj_Player.x,obj_Player.y,1);
								SendFollow(PACKET_ENEMY1_POSITION,enemy_i.x,enemy_i.y)	
							}
						}
					
					}
	*/
	///////////////////////////////////
	
}else{
	if(keyboard_check_pressed(vk_left)){
		char -- 
	}
	if(keyboard_check_pressed(vk_right)){
		char ++
	}
	
	if(keyboard_check_pressed(vk_up)){
		char -= 3 
	}
	if(keyboard_check_pressed(vk_down)){
		char += 3
	}
	
	if(keyboard_check_pressed(vk_enter)){
		SendTankCharacter(char)
	}
}

char = clamp(char, 0, TANK_CHARACTER_YELLOW)

