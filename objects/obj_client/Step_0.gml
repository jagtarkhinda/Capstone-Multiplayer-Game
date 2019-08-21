if(!global.playerisdead)
{
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
		
		key_buy_pressed = keyboard_check_pressed(vk_space);
		//key_buy_released = keyboard_check_released(vk_space) || keyboard_check_released(vk_up);

		if(key_right_pressed || key_left_pressed || key_up_pressed || key_down_pressed || mouse_check_button(mb_left) || mouse_check_button(mb_right) || key_buy_pressed) {
			//show_debug_message("Controller 0")
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
			if(key_buy_pressed){
				for (var k = ds_map_find_first(entities); !is_undefined(k); k = ds_map_find_next(entities, k)) {
					var cur_client = entities[? k];
					if(cur_client.my_id == my_id && cur_client.near_box_id != -1){
						var weap = weapons_box[? cur_client.near_box_id];
						RequestBuyWeapon(cur_client.my_id, weap.wea_Uid)
					}
				}
			}
		}
		#endregion
		#region gamepad control
		// GAME PAD CONTROLS
		//gamepad control left 
		if(abs(gamepad_axis_value(0, gp_axislh)) >= 0.5 || abs(gamepad_axis_value(0, gp_axisrh)) >= 0.5 || abs(gamepad_axis_value(0, gp_axislv)) >= 0.5 
		|| abs(gamepad_axis_value(0, gp_axisrv)) >= 0.5 || abs(gamepad_button_check(0,gp_shoulderrb)) || gamepad_button_check_pressed(0,gp_face2) 
		|| gamepad_button_check(0,gp_shoulderl)) {
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

			if(gamepad_button_check_pressed(0,gp_face2)){
				for (var k = ds_map_find_first(entities); !is_undefined(k); k = ds_map_find_next(entities, k)) {
					var cur_client = entities[? k];
					if(cur_client.my_id == my_id && cur_client.near_box_id != -1){
						var weap = weapons_box[? cur_client.near_box_id];
						RequestBuyWeapon(cur_client.my_id, weap.wea_Uid)
					}
				}
			}
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

		if (mouse_check_button(mb_left) || gamepad_button_check(0,gp_shoulderr)) && (cooldown < 1) {
			cooldown = 10;
			SendNewBullet(PACKET_NEW_BULLET, mouse_x, mouse_y)
		}
		if ((mouse_check_button(mb_right) || gamepad_button_check(0,gp_shoulderl)) && (cooldown < 1)) {
			cooldown = 10;
			SendSpecialAbility(PACKET_SPECIAL_ABILITY, mouse_x, mouse_y)
		}
		cooldown = cooldown - 1;

		#region Delete coins client
		var c_number = instance_number(obj_remote_coin)
		for (var k = ds_map_find_first(coin_map); !is_undefined(k); k = ds_map_find_next(coin_map, k)) {
			var found_coin = false
			for(var c = 0; c < c_number; c++)
			{
				var rem_coin = instance_find(obj_remote_coin, c)

				var v = coin_map[? k];
				if(v == undefined){
					ds_map_delete(coin_map,k)
					continue
				} 
				
				if(!instance_exists(v)){//dont know if is working
					ds_map_delete(coin_map,k)
				}else{
					if(v.id == rem_coin.id){
						found_coin = true
					}
				}
			}
			if(!found_coin){
				ds_map_delete(coin_map,k)
			}
		}
		#endregion Delete coins
	
		#region Buy weapons
		var weapon_closer = noone //near weapon
		var distance = 50 // max distance
		for (var v = ds_map_find_first(entities); !is_undefined(v); v = ds_map_find_next(entities, v)) {
			var cur_client = entities[? v];
			for (var k = ds_map_find_first(weapons_box); !is_undefined(k); k = ds_map_find_next(weapons_box, k)) {
				var wea = weapons_box[? k];
				if(cur_client.my_id == my_id){
					with(wea)
					{
						if (distance_to_object(cur_client) < distance) //checks the current min distance
						{
							weapon_closer = wea.wea_Uid
							cur_client.near_box_id = wea.wea_Uid //fill client variable so store the near box
						}
					}
				}
			}
			if(weapon_closer != noone){
				cur_client.near_weapon = true;
			}else{
				cur_client.near_weapon = false;
				cur_client.near_box_id = -1
			}
			weapon_closer = noone
		}
		#endregion Buy weapons
		
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
}else{
	if(keyboard_check_pressed(vk_space) || gamepad_button_check_pressed(0,gp_face3)){
		//change spectating camera
		targetCount ++
		
		if(targetCount < instance_number(obj_remote_entity)){
			var e = instance_find(obj_remote_entity, targetCount)
		}else{
			targetCount = 0
			var e = instance_find(obj_remote_entity, targetCount)
		}
		target = e


		if(target != noone){
			camera_set_view_target(view_camera[0], e)
			camera_set_view_border(view_camera[0], view_wport[0]/2, view_hport[0]/2)
		}
	}
	

}