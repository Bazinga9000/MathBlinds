local blind = {
	loc_txt =  	{
        name = 'The Witness',
        text = { '#1# ranks in deck', 'are debuffed' }
    },
    boss = {min = 1, max = 10 }, 
    boss_colour = HEX("ff898f"),
    atlas = "mathblinds",
    pos = { x = 0, y = 21},
    vars = {''..(G.GAME and get_debuff_count() or "25% of")}
}

local get_ranks = function()
    local present_ranks = {}
    for k, v in pairs(G.playing_cards) do
        if v.ability.effect ~= 'Stone Card' then
            present_ranks[v.base.value] = true
        end
    end 
    local out = {}
    for k, v in pairs(present_ranks) do
        out[(#out) + 1] = k
    end
    return out
end

local get_debuff_count = function()
    local ranks = get_ranks()
    return math.ceil(#ranks / 3)
end 

blind.loc_vars = function(self, blind)
    return {vars = {''..(G.GAME and get_debuff_count() or "33% of")}}
end

blind.set_blind = function(self, blind, reset, silent)
    blind.debuffed_ranks = {}
    local ranks = get_ranks()
    for i = 1, get_debuff_count() do
        local rank, k = pseudorandom_element(ranks, pseudoseed('witness'))
        blind.debuffed_ranks[rank] = true
        ranks[k] = nil
    end
end

blind.debuff_card = function(self, blind, card, from_blind)
    if card.area ~= G.jokers then
        if card.ability.effect ~= 'Stone Card' then
            return blind.debuffed_ranks[card.base.value] ~= nil
        else 
            return false
        end
    end
end

return blind