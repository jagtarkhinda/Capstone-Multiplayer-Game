if(playing){
	#region keyboard control
	
	key_right_pressed = keyboard_check_pressed(ord("D")) || keyboard_check_pressed(vk_right);
	key_left_pressed = keyboard_check_pressed(ord("A")) || keyboard_check_pressed(vk_left);
	key_down_pressed = keyboard_check_pressed(ord("S")) || keyboard_check_pressed(vk_down);
	key_up_pressed = keyboard_check_pressed(ord("W")) || keyboard_check_pressed(vk_up);

	key_right_released = keyboard_check_released(ord("D")) || keyboard_check_released(vk_right);
	key_left_released = keyboard_check_released(ord("A")) || keyboard_check_released(vk_left);
	key_down_released = keyboard_check_released(ord("S")) || keyboard_check_released(vk_down);
	key_up_released = keyboard_check_released(ord("W")) || keyboard_check_released(vk_up);

	if(key_right_pressed || key_left_pressed || key_up_pressed || key_down_pressed || mouse_check_button(mb_left)) {
		show_debug_message("Controller 0")
		controller = 0;
	}
	
	if(controller == 0) {
		if(key_left_pressed){
			SendMovement(KEY_LEFT, true)
		}
		if(key_left_released){
			SendMovement(KEY_LEFT, false)
		}
	
		if(key_right_pressed){
			SendMovement(KEY_RIGHT, true)
		}
		if(key_right_released){
			SendMovement(KEY_RIGHT, false)
		}
	
		if(key_down_pressed){
			SendMovement(KEY_DOWN, true)
		}
		if(key_down_released){
			SendMovement(KEY_DOWN, false)
		}
	
		if(key_up_pressed){
			SendMovement(KEY_UP, true)
		}
		if(key_up_released){
			SendMovement(KEY_UP, false)
		}
	}
	#endregion
	#region gamepad control
	// GAME PAD CONTROLS
	//gamepad control left 
	if(abs(gamepad_axis_value(0, gp_axislh)) >= 0.5 || abs(gamepad_axis_value(0, gp_axisrh)) >= 0.5 || abs(gamepad_axis_value(0, gp_axislv)) >= 0.5 || abs(gamepad_axis_value(0, gp_axisrv)) >= 0.5 || abs(gamepad_button_check(0,gp_shoulderrb))) {
		show_debug_message("lv : " + string(gamepad_axis_value(0, gp_axislv)))
		show_debug_message("lh : " + string(gamepad_axis_value(0, gp_axislh)))
		show_debug_message("rv : " + string(gamepad_axis_value(0, gp_axisrv)))
		show_debug_message("rh : " + string(gamepad_axis_value(0, gp_axisrh)))
		show_debug_message("Controller 1")
		controller = 1
	}
	if(controller == 1){
		if(gamepad_axis_value(0, gp_axislh) < -0.7){
			SendMovement(KEY_LEFT, true)
		}
		else {
			SendMovement(KEY_LEFT, false)
		}
		//gamepad control right
		if(gamepad_axis_value(0, gp_axislh) > 0.7) {
			SendMovement(KEY_RIGHT, true)
		}
		else {
			SendMovement(KEY_RIGHT, false)
		}
		//gamepad control up
		if(gamepad_axis_value(0, gp_axislv) < -0.7){
			SendMovement(KEY_UP, true)
		}
		else {
			SendMovement(KEY_UP, false)
		}
		//gamepad control down
		if(gamepad_axis_value(0, gp_axislv) > 0.7) {
			SendMovement(KEY_DOWN, true)
		}
		else {
			SendMovement(KEY_DOWN, false)
		}
		/*if(gamepad_axis_value(0, gp_axislv) == 0 && gamepad_axis_value(0, gp_axislh) == 0) {
			SendMovement(KEY_LEFT, false)
			SendMovement(KEY_RIGHT, false)
			SendMovement(KEY_DOWN, false)
			SendMovement(KEY_UP, false)
		}*/
	}
	#endregion
	
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
 
	if (mouse_check_button(mb_left) || gamepad_button_check(0,gp_shoulderr)) && (cooldown < 1) {
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
		var found_coin = false
		for(var c = 0; c < c_number; c++)
		{
			var rem_coin = instance_find(obj_remote_coin, c)

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
	if(keyboard_check_pressed(vk_left) || gamepad_button_check_pressed(0,gp_padl)){
		char -- 
	}
	if(keyboard_check_pressed(vk_right) || gamepad_button_check_pressed(0,gp_padr)){
		char ++
	}
	
	if(keyboard_check_pressed(vk_up) || gamepad_button_check_pressed(0,gp_padu)){
		char -= 3 
	}
	if(keyboard_check_pressed(vk_down) || gamepad_button_check_pressed(0,gp_padd)){
		char += 3
	}
	
	if(keyboard_check_pressed(vk_enter) || gamepad_button_check_pressed(0,gp_face1)){
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