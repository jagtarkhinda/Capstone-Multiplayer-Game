var camX = camera_get_view_x(view_camera[0]);
var camY = camera_get_view_y(view_camera[0]);

var camW = camera_get_view_width(view_camera[0]);

draw_set_font(fnt_roboto);
if(global.cli_money != undefined){
	draw_text(camX+camW-40, camY+15, string(global.cli_money));
	draw_sprite(spr_coin,spr_coin,camX+camW-65-sprite_width, camY+25);
}