draw_self()
draw_set_color(c_white)
draw_set_halign(fa_center)
draw_set_font(fnt_roboto_small)

draw_text(x+16, y-30, weapon_name)
draw_text(x+16, y+36, "$" + string(weapon_price))

draw_set_halign(fa_left)