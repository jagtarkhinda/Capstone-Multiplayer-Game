with(other){
	wall_hp-=20
	if(wall_hp <= 0){
		instance_destroy();
	}
}
	
	bb_hp = 0;
	//instance_destroy();