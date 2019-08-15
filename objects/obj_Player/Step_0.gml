// Movement of player
/*
if(keyboard_check(ord("A")) || keyboard_check(vk_left)) x = x - 4;
if(keyboard_check(ord("D")) || keyboard_check(vk_right)) x = x + 4; 
if(keyboard_check(ord("W")) || keyboard_check(vk_up)) y = y - 4;
if(keyboard_check(ord("S")) || keyboard_check(vk_down))	y = y + 4; 
*/

horizontalSpeed = walkingSpeed*(keys[KEY_RIGHT]-keys[KEY_LEFT])
verticalSpeed = walkingSpeed*(keys[KEY_DOWN]-keys[KEY_UP])

if(place_free(x+horizontalSpeed, y)){
	x+=horizontalSpeed
}else{
	horizontalSpeed = distance_to_object(obj_Wall)*sign(horizontalSpeed)
}

if(place_free(x, y+verticalSpeed)){
	y+=verticalSpeed
}else{
	verticalSpeed = distance_to_object(obj_Wall)*sign(verticalSpeed)
}

if(horizontalSpeed == 0){
	sprite_index = idle_sprite
}else{
	sprite_index = run_sprite
}


if(playerhp >= playerMaxhp){
	playerhp = playerMaxhp
}


