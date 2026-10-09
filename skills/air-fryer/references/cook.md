# Cook a Specific Food (No Existing Recipe)

The user names a food, not a recipe — give them a starting point on the TurboBlaze, not an ingredient list. These are well-established starting settings; always frame them as a starting point to check early and adjust, not a guarantee.

## Step 1: Match the food to the closest row below

If the food doesn't match anything in the table, use the closest analog (e.g., "duck breast" → treat like a thick chicken breast/steak hybrid: Air Fry, similar temp, check internal temp) and say you're estimating from a similar food rather than presenting it as a known-good setting.

| Food | Function | Temp | Time | Notes |
|---|---|---|---|---|
| Chicken breast (boneless) | Air Fry | 375°F | 18–20 min | Flip halfway. Pull at 165°F internal. |
| Chicken thighs (bone-in) | Roast | 380°F | 22–25 min | Flip halfway. |
| Chicken wings | Air Fry | 380°F | 22–25 min | Shake basket 2×. |
| Whole chicken | Roast | 350°F | ~10 min/lb | Only if it fits the 6-qt basket (small bird, ~3–4 lb max) — otherwise this appliance can't do it. Flip once at the halfway point. |
| Salmon fillet | Air Fry | 380°F | 10–12 min | No flip needed. |
| Shrimp | Air Fry | 400°F | 7–8 min | Shake halfway. |
| Steak (1–1.5") | Broil or Air Fry | 400°F | 10–14 min | Flip halfway. Use a thermometer — time varies a lot by thickness and doneness target. |
| Pork chops | Air Fry | 375°F | 12–15 min | Flip halfway. Pull at 145°F internal. |
| Bacon | Air Fry | 350°F | 8–10 min | Single layer, no overlap — check at 6 min, fattier/thinner bacon cooks fast. |
| Roasted vegetables | Roast | 400°F | 12–15 min | Shake halfway. Cut uniformly. |
| Baked potato | Roast | 400°F | 35–40 min | Pierce skin first. No need to flip. |
| Frozen fries | Frozen | 400°F | 15–18 min | Shake 2×. |
| Frozen chicken nuggets/tenders | Frozen | 400°F | 10–12 min | Shake halfway. |
| Hard-boiled eggs | Air Fry | 270°F | 15–17 min | Straight into a cold water/ice bath right after. |
| Reheating leftovers (pizza, fried food) | Reheat | 375–390°F | 3–5 min | Check at 3 min — reheat is quick, easy to overdo. |
| Toast / frozen waffles | Air Fry | 350°F | 3–4 min | Watch closely, thin items burn fast. |

## Step 2: Output format

```
**[Food]** — [Function], [temp], [time]
- [technique note from the table, if any]
```

That's it. Skip the preheat/overcrowd reminders unless the food specifically needs them called out (e.g. bacon strips touching, a food prone to overcrowding). Don't add a recipe, seasoning suggestions, or ingredient list — out of scope.
