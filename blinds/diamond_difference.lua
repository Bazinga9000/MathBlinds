local DIAMOND_DIFFERENCE_ODDS = 5
local blind = {
	loc_txt =  	{
        name = 'Diamond Difference',
        text = { '#1# in #2# cards shift', 'by 1 rank each draw' }
    },
    dollars = 8,
    config = {extra = {odds = DIAMOND_DIFFERENCE_ODDS}},
    --boss = {min = 1, max = 10 }, -- for testing purposes
    boss = {showdown = true, min = 10, max = 10 },
    boss_colour = HEX("bbf8fa"),
    atlas = "mathblinds",
    pos = { x = 0, y = 4},
    vars = {''..(G.GAME and G.GAME.probabilities.normal or 1), DIAMOND_DIFFERENCE_ODDS}
}

blind.loc_vars = function(self, blind)
    return {vars = {''..(G.GAME and G.GAME.probabilities.normal or 1), self.config.extra.odds}}
end

blind.process_loc_text = function(self)
    self.super.process_loc_text(self)
    self.vars = {''..(G.GAME and G.GAME.probabilities.normal or 1), DIAMOND_DIFFERENCE_ODDS}
end

blind.drawn_to_hand = function(self, blind)
    for k, card in ipairs(G.hand.cards) do
        if pseudorandom(pseudoseed('diamond_difference')) < G.GAME.probabilities.normal/self.config.extra.odds then
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                play_sound('tarot1')
                return true end }))
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() card:flip();play_sound('card1', percent);card:juice_up(0.3, 0.3);return true end }))
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    local _card = card
                    local suit_data = SMODS.Suits[_card.base.suit]
                    local suit_prefix = suit_data.card_key
                    local rank_data = SMODS.Ranks[_card.base.value]
                    local behavior = rank_data.strength_effect or { fixed = 1, ignore = false, random = false }
                    local rank_suffix = ''
                    local next_data = rank_data.next
                    blind:wiggle()
                    if pseudorandom(pseudoseed('diamond_difference_shift')) < 1/2 then
                        -- going down
                        -- we must iterate through all ranks to see which ranks point to this rank 
                        next_data = {}
                        for prev_key, r in pairs(SMODS.Ranks) do
                            if r.next then
                                for next_key, next_rank in pairs(r.next) do
                                    if next_rank == rank_data.key then 
                                        table.insert(next_data, prev_key)
                                        break
                                    end
                                end
                            end
                        end
                    end
                    sendInfoMessage("Diamond Difference - Sending "..rank_data.key.." to "..next_data[1].." (length ".. #next_data .. ")")
                    if behavior.ignore or not next(next_data) then
                        return true
                    elseif behavior.random then
                        local r = pseudorandom_element(next_data, pseudoseed('strength'))
                        rank_suffix = SMODS.Ranks[r].card_key
                    else
                        local ii = (behavior.fixed and next_data[behavior.fixed]) and behavior.fixed or 1
                        rank_suffix = SMODS.Ranks[next_data[ii]].card_key
                    end
                    _card:set_base(G.P_CARDS[suit_prefix .. '_' .. rank_suffix])
                    return true
                end
            }))
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() card:flip();play_sound('tarot2', percent, 0.6);card:juice_up(0.3, 0.3);return true end }))
        end
    end
end

return blind