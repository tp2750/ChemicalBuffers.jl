# ChemicalBuffers Theory

The computation is based on the method described in https://www.mdpi.com/2624-8549/3/2/34,
https://chemistry.stackexchange.com/questions/149282/how-to-numerically-model-a-phosphoric-acid-titration-curve/149285#149285, 
and used in https://www.egr.msu.edu/~scb-group-web/buffers/buffers.html

See also https://github.com/naikymen/titration

This works for phosphoric acid and similar buffers, but perhaps not generally?

* Given pH and pKa values, we can compute the relative ratios of the protonation species.
* This implies how much metal ion is needed to get net charge zero.
* Given the total buffer strength, determines the actual concentration of the salts.

Actually, it is the activities, not the pKa values, see https://www.mdpi.com/2624-8549/3/2/34

$$
Ka_i = {H+}{H_n-iA-}/{H_nA}
$$

