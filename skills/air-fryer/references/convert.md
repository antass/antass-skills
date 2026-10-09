# Oven → Air Fryer Conversion

## Step 1: Get the required inputs

You need three things:
1. **Oven temperature**
2. **Oven cook time**
3. **Food type/category** (see table below — determines technique notes and which TurboBlaze function to use)

If the user gives a full recipe (pasted text), extract these directly. If any of the three is missing or ambiguous, ask only for what's missing.

## Step 2: Apply the conversion

**Temperature:** subtract 25°F (or ~20°C) from the oven temp. Cap at 450°F — the TurboBlaze can't go higher.

**Time:** cut by 20–25%. Use 25% for smaller/thinner items (nuggets, fries, thin cutlets, veg) and 20% for larger/denser items (whole chicken pieces, roasts, baked goods) — when in doubt, use 20% as the safer default so the user checks before undercooking.

Round temp to the nearest 5°F/°C and time to the nearest minute.

## Step 3: Pick the category, function, and technique notes

| Category | Examples | TurboBlaze function | Key notes |
|---|---|---|---|
| **Proteins** | Chicken pieces, fish, steak, pork chops | Air Fry, or Roast for larger/bone-in cuts | Flip halfway through. Use a thermometer for doneness (165°F chicken, 145°F fish/pork, per taste for steak) rather than relying on time alone. |
| **Vegetables** | Roasted veg, fries | Roast (or Air Fry for smaller-cut veg) | Shake the basket halfway through. Cut pieces uniformly so they cook evenly. |
| **Frozen/breaded** | Nuggets, fries, mozzarella sticks, breaded cutlets | Frozen | Don't add oil the package/recipe doesn't call for. If recipe says to fry in oil, cut it to a light spray/brush only (2 tbsp max per the manual). Shake or flip halfway. |
| **Baked goods** | Cakes, muffins, banana bread, pastries, breads | Bake (gentlest function — fan speed 3, tops the oven at 400°F) | Use a heat-safe container in the basket — the crisper plate isn't meant for batter/filling foods per the manual. Check browning early since the enclosed space runs hotter-feeling than an oven at the same temp. Don't flip. Doneness check (toothpick, color, flake) 3–5 min before the converted time is up. If your converted temp is above 400°F, cap it at 400°F (Bake's max) and add a couple minutes instead. |

Always add:
- **Preheat 3–5 minutes.**
- **Don't overcrowd** — single layer, batch if needed (6-qt basket, serves 3–5).

## Step 4: Output format

Always use this exact structure:

```
| | Oven (original) | Air Fryer (TurboBlaze) |
|---|---|---|
| Temp | [X]°F | [X-25]°F |
| Time | [X] min | [~20-25% less] min |

**Function:** [Air Fry / Roast / Broil / Frozen / Bake]
- [1-2 technique notes specific to this category, from the table]
```

That's it — table plus a couple of notes max. No preamble, no restating the recipe, no closing summary, no generic preheat/overcrowd reminders unless this particular food needs them flagged.

## Edge cases

- **Recipe involves deep frying or a large amount of oil** (not just "oven" cooking): still convert temp/time, but add an explicit note that oil should be cut to a light coating.
- **User gives a range** (e.g., "375–400°F, 20–25 min"): convert both ends the same way, keep the output as a range.
- **User asks for a non-oven conversion** (slow cooker, Instant Pot, etc.): out of scope — say so rather than guessing at unrelated ratios.
