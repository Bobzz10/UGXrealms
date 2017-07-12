local function kill_node(pos, node, puncher)
	if puncher:get_wielded_item():get_name() == "maptools:pick_admin" then
		if not minetest.check_player_privs(
				puncher:get_player_name(), {worldedit = true}) then
			puncher:set_wielded_item("")
			minetest.log("action", puncher:get_player_name() ..
			" tried to use an Admin Pick!")
			return
		end

		local nn = minetest.get_node(pos).name
		if nn == "air" then return end
		minetest.log("action", puncher:get_player_name() ..
			" digs " .. nn ..
			" at " .. minetest.pos_to_string(pos) ..
			" using an Admin Pick!")
		local node_drops = minetest.get_node_drops(nn, "maptools:pick_admin")
		for i=1, #node_drops do
			local add_node = puncher:get_inventory():add_item("main", node_drops[i])
			if add_node then minetest.add_item(pos, add_node) end
		end
	end
end