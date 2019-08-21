with(other){
	wall_hp--
	if(wall_hp <= 0){
		instance_destroy();
	}
}
instance_destroy();