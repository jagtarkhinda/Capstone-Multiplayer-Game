
with(other){
	wall_hp-=2
	if(wall_hp <= 0){
		instance_destroy();
	}
}
instance_destroy();