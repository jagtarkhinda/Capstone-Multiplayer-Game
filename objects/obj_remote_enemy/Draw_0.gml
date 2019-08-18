draw_self();

if(monsterHp<monsterMaxHp) {
	draw_healthbar(x-50,y-50,x+50,y-40,(monsterHp/monsterMaxHp)*100, c_black,c_red,c_green,0,true, true);
}