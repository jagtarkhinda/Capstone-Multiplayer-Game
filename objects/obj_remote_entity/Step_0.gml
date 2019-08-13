/*
if(instance_exists(obj_boss) ){
	obj_boss.visible = false //remove the sprite duplication on the player host
}
*/

if(x > xprevious){
	image_xscale = 1
}

if(x < xprevious){
	image_xscale = -1
}