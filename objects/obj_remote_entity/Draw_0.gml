draw_self()
draw_set_color(c_white)
draw_set_halign(fa_center)
draw_set_font(fnt_roboto_extra_small)

//var xpos = x-camera_get_view_x(view_camera[0])
//var ypos = y-camera_get_view_y(view_camera[0])
draw_text(x, y-50, name)

var camX = camera_get_view_x(view_camera[0]);
var camY = camera_get_view_y(view_camera[0]);

with(obj_remote_entity){
	draw_sprite(sprite_index, sprite_index, camX+60, camY+80);
}
draw_healthbar(camX+sprite_width+65, camY +40, camX + 300, camY + sprite_height + 50, 
playerMaxhp, $FF0000FF & $FFFFFF, $FF037F01 & $FFFFFF, $FF004C02 & $FFFFFF, 0, (($FF0000FF>>24) != 0),
(($FF000000>>24) != 0));




draw_set_halign(fa_left)