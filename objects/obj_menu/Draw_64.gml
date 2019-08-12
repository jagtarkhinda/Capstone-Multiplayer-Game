// code for selecting a font
//draw_set_font(fnt_main)
draw_set_font(fnt_roboto)
draw_set_halign(fa_center)

if(pick_name){
	draw_text(room_width/2, 300, "Pick Your Name")
	draw_text(room_width/2, 350, global.name)
}else{
	for(var i = 0; i < array_length_1d(menu); i++){
		draw_set_color(cur_index==i?c_green:c_white)
		//draw_text(room_width/2, 100+32*i, menu[i])
		//draw_text_transformed(room_width/2, 250+64*i, menu[i], 3,3,0)
		draw_text(room_width/2, 250+64*i, menu[i])
	}
}




draw_set_halign(fa_left)
	