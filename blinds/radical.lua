local blind = {
	loc_txt =  	{
        name = 'The Radical',
        text = { 'All enhanced cards',  'are debuffed' }
    },
    boss = { min = 2, max = 10 },
    boss_colour = HEX("54a74b"),
    atlas = "mathblinds",
    pos = { x = 0, y = 3},
}

blind.debuff_card = function(self, card, from_blind)
    if card.area ~= G.jokers then
        return card.config.center ~= G.P_CENTERS.c_base
    end
end

return blind