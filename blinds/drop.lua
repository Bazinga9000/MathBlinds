local HAND_DELTA = 5
local blind = {
	loc_txt =  	{
        name = 'The Drop',
        text = { '-1 hand size',  'each hand played' }
    },
    boss = {min = 2, max = 10 },
    boss_colour = HEX("561847"),
    atlas = "mathblinds",
    pos = { x = 0, y = 17}
}

blind.set_blind = function(self, reset, silent)
    if not blind.disabled then
        blind.hands_sub = 0
    end
end

blind.disable = function(self)
    G.hand:change_size(G.GAME.blind.hands_sub)
    --G.FUNCS.draw_from_deck_to_hand(blind.hands_sub)
    G.GAME.blind.hands_sub = 0
end

blind.defeat = function(self, silent)
    G.hand:change_size(G.GAME.blind.hands_sub)
end

blind.press_play = function(self)
    sendInfoMessage(G.hand.config.card_limit)
    sendInfoMessage(G.GAME.blind.hands_sub)
    if G.hand.config.card_limit > 1 then
        G.hand:change_size(-1)
        G.GAME.blind.hands_sub = G.GAME.blind.hands_sub + 1 -- size removed
        G.GAME.blind:wiggle()
    end
end



return blind