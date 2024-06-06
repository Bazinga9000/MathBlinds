local blind = {
	loc_txt =  	{
        name = 'The Bottom',
        text = { 'All low cards', 'are debuffed' }
    },
    boss = { min = 1, max = 10 },
    boss_colour = HEX("897e61"),
    atlas = "mathblinds",
    pos = { x = 0, y = 2},
}

blind.debuff_card = function(self, blind, card, from_blind)
    if card.area ~= G.jokers then
        return card.ability.effect ~= 'Stone Card' and card.base.nominal < 7 -- for inter-mod compat
    end
end

return blind