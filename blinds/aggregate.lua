local AGGREGATE_ODDS = 5
local blind = {
	loc_txt =  	{
        name = 'The Aggregate',
        text = { '#1# in #2# chance to', 'debuff each played card' }
    },
    config = {extra = {odds = AGGREGATE_ODDS}},
    boss = {min = 2, max = 10 }, 
    boss_colour = HEX("e26c5a"),
    atlas = "mathblinds",
    pos = { x = 0, y = 13},
    vars = {''..(G.GAME and G.GAME.probabilities.normal or 1), AGGREGATE_ODDS}   
}

blind.loc_vars = function(self, blind)
    return {vars = {''..(G.GAME and G.GAME.probabilities.normal or 1), self.config.extra.odds}}
end

blind.press_play = function(self, blind)
    for _, card in ipairs(G.hand.highlighted) do
        if pseudorandom(pseudoseed('aggregate')) < G.GAME.probabilities.normal/self.config.extra.odds then
            card:set_debuff(true)
            blind:wiggle()
            blind.triggered = true
        end
    end
end

return blind