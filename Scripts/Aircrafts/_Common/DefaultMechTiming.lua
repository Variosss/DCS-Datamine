-- Default timing data for mechanical parts animation.

-- Entries with non-default indexes are deprecated,
--   please add any custom mech data into 'mech_timing' section of the aircraft db entry.

DefMechTimeIdx = 0

--------------------------------------------------------
-- The format:
-- the each end-table consists of pairs of values - animation stage and 
--    animation speed (units - arg values, [0..1] as a rule)

mech_timing = {}
mech_timing[DefMechTimeIdx] = {{0.0, 1 / 9}, -- CANOPY_OPEN_TIMES
							   {0.0, 1 / 6}  -- CANOPY_CLOSE_TIMES
							  }



function make_default_mech_animation(preset)
    if preset and preset == "WWIIFighter" then
        return {
        Door0 = {
            {Transition = {"Close", "Open"},  Sequence = {{C = {{"Arg", 38, "to", 0.9, "at", 0.8},},},}, Flags = {"Reversible"},},
            {Transition = {"Open", "Close"},  Sequence = {{C = {{"Arg", 38, "to", 0.0, "at", 1.4},},},}, Flags = {"Reversible", "StepsBackwards"},},
            {Transition = {"Any", "Bailout"}, Sequence = {{C = {{"TearCanopy", 0},},},},},
			{Transition = {"Any", "Ditch"},   Sequence = {{C = {{"Arg", 38, "to", 0.9, "at", 0.8},},},}, Flags = {"Reversible"},},
        }}
    end

    return {
        Door0 = {
            {Transition = {"Close", "Open"},  Sequence = {{C = {{"Arg", 38, "to", 0.9, "in", 9.0},},},}, Flags = {"Reversible"},},
            {Transition = {"Open", "Close"},  Sequence = {{C = {{"Arg", 38, "to", 0.0, "in", 6.0},},},}, Flags = {"Reversible", "StepsBackwards"},},
            {Transition = {"Any", "Bailout"}, Sequence = {{C = {{"JettisonCanopy", 0},},},},},
        },
        Door1 = {DuplicateOf = "Door0"},
    }
end

mechanimations = {
    ["WWIIFighter"] = make_default_mech_animation("WWIIFighter"),
    ["Default"]     = make_default_mech_animation(),
}

