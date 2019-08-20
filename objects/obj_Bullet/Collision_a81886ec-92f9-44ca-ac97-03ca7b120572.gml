//var i_id= obj_Wall.id;

//show_debug_message("id: " + string(other.id))
//var wall_cur_id = other.id
//instance_destroy(other.id,true)
other.monsterHp -= 20
show_debug_message("Shooted monster id: " + string(other.id))
show_debug_message("Shooted monster HP: " + string(other.monsterHp))

//SendWallUpdate(PACKET_BULLET_WALL, wall_cur_id, wall_hp, id)


instance_destroy();