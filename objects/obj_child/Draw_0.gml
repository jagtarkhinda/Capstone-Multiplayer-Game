//draw_self();
draw_sprite(spr_child,0,x,y);

if(hp<maxHp) {
	draw_healthbar(x-50,y-50,x+50,y-40,(hp/maxHp)*100, c_black,c_red,c_green,0,true, true);
}

