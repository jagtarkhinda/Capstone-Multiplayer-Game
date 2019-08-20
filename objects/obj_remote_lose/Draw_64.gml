
camera_set_view_size(view_camera[0],4096,3072);

var cx = camera_get_view_width(view_camera[0])
var cy = camera_get_view_height(view_camera[0])

draw_set_halign(fa_center)
draw_set_color(c_gray)
draw_rectangle(0,0,room_width,room_height,false)
draw_set_font(fnt_roboto)
draw_set_halign(fa_center)


	draw_set_color(c_black)
	draw_text(500,200, "You Lose")
	draw_text(500,250, "All Players are Dead")
	if(instance_exists(obj_server))
	{
		draw_text(500,300, "Press R to Restart")
	}
	else{
	
	}
	
	draw_set_halign(fa_left)