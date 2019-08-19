if(pick_name){
	global.name = keyboard_string
	
	if(keyboard_check_pressed(vk_enter) || gamepad_button_check(0,gp_face1)){
		pick_name = false
	}
}else{
	if(keyboard_check_pressed(vk_down) || gamepad_button_check(0,gp_padd)){
		cur_index ++
	}

	if(keyboard_check_pressed(vk_up) || gamepad_button_check(0,gp_padu)){
		cur_index --
	}

	cur_index = clamp(cur_index, 0, array_length_1d(menu)-1)

	if(keyboard_check_pressed(vk_enter) || gamepad_button_check(0,gp_face1)){
		switch(cur_index){
			case 0:
				//create a game
				instance_create_layer(0, 0, "Instances", obj_server)
				room_goto_next()
			break
		
			case 1:
				//join a game
				room_goto_next()
			break
		
			case 2:
				game_end()
			break
		}
	}
}


