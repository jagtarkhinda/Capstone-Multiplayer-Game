/// @description Insert description here
// You can write your code in this editor


if(!boss_moving){
	var random_x= irandom_range(0,room_width);
	var random_y= irandom_range(0,room_height);

	move_towards_point(random_x,random_y,0.5);
	boss_moving = true
}
