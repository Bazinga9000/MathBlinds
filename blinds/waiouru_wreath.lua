local blind = {
	loc_txt =  	{
        name = 'Waiouru Wreath',
        text = { 'Play only one hand,',  'normal blind size' }
    },
    dollars = 8,
    --boss = {min = 1, max = 10 }, -- for testing purposes
    boss = {showdown = true, min = 10, max = 10 },
    boss_colour = HEX("363c0d"),
    atlas = "mathblinds",
    pos = { x = 0, y = 18}
}

blind.set_blind = function(self, reset, silent)
    if not G.GAME.blind.disabled then
        G.GAME.blind.hands_sub = G.GAME.round_resets.hands - 1
        ease_hands_played(-G.GAME.blind.hands_sub)
    end
end

blind.disable = function(self, silent)
    ease_hands_played(G.GAME.blind.hands_sub)
    G.GAME.blind.hands_sub = 0
end

return blind