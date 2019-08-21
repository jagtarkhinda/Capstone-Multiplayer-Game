draw_self()
draw_set_color(c_white)
draw_set_halign(fa_center)
draw_set_font(fnt_roboto_extra_small)

//var xpos = x-camera_get_view_x(view_camera[0])
//var ypos = y-camera_get_view_y(view_camera[0])
draw_text(x, y-50, name)

var camX = camera_get_view_x(view_camera[0]);
var camY = camera_get_view_y(view_camera[0]);

draw_healthbar(camX+45, camY +40, camX + 200, camY + sprite_height + 20,
playerhp, $FF0000FF & $FFFFFF, $FF037F01 & $FFFFFF, $FF004C02 & $FFFFFF, 0, (($FF0000FF>>24) != 0),
(($FF000000>>24) != 0));
if(near_weapon){
	draw_text(x, y+20, "Buy Weapon by pressing\n'Space' on keyboard \n or O on controller")
}

draw_set_halign(fa_left)