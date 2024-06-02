local blind = {
	loc_txt =  	{
        name = 'The Approach',
        text = { 'If chips are 90-100% of the blind',  'after play, increase blind by 25%' }
    },
    boss = {min = 2, max = 10 }, 
    boss_colour = HEX("e5c3ed"),
    atlas = "mathblinds",
    pos = { x = 0, y = 10}
}

blind.set_blind = function(self, blind, reset, silent)
    if not blind.disabled then
        blind.backup_chips = blind.chips
    end
end


blind.press_play = function(self, blind)
    blind.prepped = true
end

local RATIO_THRESHOLD = 0.9
blind.drawn_to_hand = function(self, blind)
    if blind.prepped then
        local ratio = G.GAME.chips / blind.chips
        -- talisman compat
        if type(ratio) == "table" then
            ratio = ratio:to_number()
        end
        if ratio > RATIO_THRESHOLD and ratio < 1.0 then
            local new_chips = math.floor(blind.chips * 1.25)
            blind:wiggle()
            G.E_MANAGER:add_event(Event({
                trigger = 'ease',
                blocking = false,
                ref_table = blind,
                ref_value = 'chips',
                ease_to = new_chips,
                delay =  0.5,
                func = (function(t)     blind.chip_text = number_format(blind.chips); return math.floor(t) end)
            }))
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.5,
                func = function()
                    blind.chip_text = number_format(blind.chips)
                    return true
                end
            }))
        end
    end
end

blind.disable = function(self, blind, silent)
    blind.chips = blind.backup_chips
    blind.chip_text = number_format(blind.chips)
    blind.backup_chips = nil
end

return blind