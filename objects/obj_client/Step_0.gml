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
	
	
	/*---------------- enemies -------------------------*/
	/*
	var e_number = instance_number(obj_remote_enemy)
	for(var en = 0; en < e_number; en++)
	{
		var rem_enemy = instance_find(obj_remote_enemy, en)
		with(rem_enemy)
		{
			if (monsterHp <= 0)
			{
				SendEnemyKilled(PACKET_ENEMY1_DESTROIED, rem_enemy.enemy_Uid, rem_enemy.x, rem_enemy.y)
				
				//instance_destroy()
			}
		}		
	}
	*/
	/*---------------- end enemies -------------------------*/

	var c_number = instance_number(obj_remote_coin)
	for (var k = ds_map_find_first(coin_map); !is_undefined(k); k = ds_map_find_next(coin_map, k)) {
		//var v = coin_map[? k];
		/* Use k, v here */
		for(var c = 0; c < c_number; c++)
		{
			var rem_coin = instance_find(obj_remote_coin, c)
			//instance_destroy(c)
			var found_coin = false
			var v = coin_map[? k];
			if(v.id == rem_coin.id){
				found_coin = true
			}
		}
		
		if(!found_coin){
			ds_map_delete(coin_map,k)
		}
	}
	
	
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

/*
var c_number = instance_number(obj_remote_coin)
	for (var k = ds_map_find_first(coin_map); !is_undefined(k); k = ds_map_find_next(coin_map, k)) {
		//var v = coin_map[? k];
		/* Use k, v here 
		for(var c = 0; c < c_number; c++)
		{
			var rem_coin = instance_find(obj_remote_coin, c)
			//instance_destroy(c)
			var found_coin = false
			var v = coin_map[? k];
			if(v.id == rem_coin.id){
				found_coin = true
			}
		}
		
		if(!found_coin){
			ds_map_delete(coin_map,k)
		}
	}
*//*
	var b_number = instance_number(obj_remote_boss_bullet)
	for (var k = ds_map_find_first(boss_bullets); !is_undefined(k); k = ds_map_find_next(boss_bullets, k)) {
		var found_bullet = false
		for(var c = 0; c < b_number; c++)
		{
			var b_bullet = instance_find(obj_remote_boss_bullet, c)
			//instance_destroy(c)
			var v = boss_bullets[? k];
			if(v.id == b_bullet.id){
				found_bullet = true
			}
		}
		
		if(!found_bullet){
			ds_map_delete(boss_bullets,k)
		}
	}*/