local blind = {
	loc_txt =  	{
        name = 'The Floor',
        text = { '$0 blind reward' }
    },
    dollars = 0,
    boss = { min = 2, max = 10 },
    boss_colour = HEX("8befc5"),
    atlas = "mathblinds",
    pos = { x = 0, y = 16},
}

blind.disable = function(self, blind, silent)
    blind.dollars = 5
    G.GAME.current_round.dollars_to_be_earned = string.rep(localize('$'), blind.dollars)..''
    G.HUD_blind:get_UIE_by_ID("dollars_to_be_earned").config.object:pop_in(0)
    G.HUD_blind.alignment.offset.y = 0
end

return blind