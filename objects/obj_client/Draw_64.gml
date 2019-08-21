draw_set_font(fnt_roboto)
draw_set_halign(fa_center)
if(!playing){
	
	draw_set_color(c_gray)
	draw_rectangle(0, 0, room_width, room_height, false)
	//draw the character select menu
	draw_set_color(c_white)
	draw_text(room_width/2, 50, "Character Selection")
	
	var sp = spr_Tank_1
	
	

	for(var i = 0; i <= TANK_CHARACTER_YELLOW; i++){
		switch(i){
			case TANK_CHARACTER_RED :
				sp = spr_Tank_1
			break
			case TANK_CHARACTER_GREEN :
				sp = spr_Tank_2
			break
			case TANK_CHARACTER_BLUE :
				sp = spr_Tank_3
			break
			case TANK_CHARACTER_YELLOW :
				sp = spr_Tank_4
			break
		}
		
		var indicator_color = c_green 

		draw_sprite_ext(sp, 0, 300+128*i, 300, 4, 4, 0, c_white, 1)
		if(i == char){
			if (picked[i] == true){
				indicator_color = c_red
				draw_set_color(c_red)
				draw_set_font(fnt_roboto_small)
				draw_text(300+128*i, 300-50, "PICKED")
			}
			else{
				indicator_color = c_green
			}
			
			draw_sprite_ext(spr_indicator, 0, 300+128*i, 300, 4, 4, 0, indicator_color, 1)
		}
		
		
	/*	var indicator_color = c_red 

		draw_sprite_ext(sp, 0, 300+128*i, 300, 4, 4, 0, c_white, 1)
		if(i == char){
			if (picked[i] == true){
				indicator_color = c_green
				
			}
			
			if indicator_color == c_red {
				draw_set_color(c_red)
				draw_set_font(fnt_roboto_small)
				draw_text(300+128*i, 300-50, "PICKED")
			}
			draw_sprite_ext(spr_indicator, 0, 300+128*i, 300, 4, 4, 0, indicator_color, 1)
		}*/
	}

}

draw_set_halign(fa_left)