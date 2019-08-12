//send data about other players
for(var i = 0; i < instance_number(obj_Player); i++){
	var player = instance_find(obj_Player, i)
	
	for(var s = 0; s < ds_list_size(sockets); s++){
		var so = ds_list_find_value(sockets, s)
		SendRemoteEntity(so, CMD_X, player.id, player.x)
		SendRemoteEntity(so, CMD_Y, player.id, player.y)
		SendRemoteEntity(so, CMD_SPRITE, player.id, player.sprite_index)
	}
}