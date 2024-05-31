local blind = {
	loc_txt =  	{
        name = 'The Bar',
        text = { 'Cards held in hand', 'are debuffed' }
    },
    boss = { min = 2, max = 10 },
    boss_colour = HEX("efde8b"),
    atlas = "mathblinds",
    pos = { x = 0, y = 7}
}

blind.press_play = function(self, blind)
    blind:wiggle()
    for i=1, #G.hand.cards do
        G.hand.cards[i]:set_debuff(true)
    end  
    for i=1, #G.hand.highlighted do
        G.hand.highlighted[i]:set_debuff(false)
    end  
end

blind.drawn_to_hand = function(self, blind)
    for i=1, #G.hand.cards do
        G.hand.cards[i]:set_debuff(false)
    end  
end

return blind