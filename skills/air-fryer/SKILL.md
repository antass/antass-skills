---
name: air-fryer
description: Technical reference for air fryer cooking, tuned to Ania's Cosori TurboBlaze 6-Qt (CAF-DC601-KUS). Handles (1) converting a conventional-oven recipe to air fryer settings, (2) settings for cooking a specific food from scratch (no existing recipe), and (3) defrosting in the air fryer. Use whenever the user pastes/describes an oven recipe and wants air fryer settings, asks "how do I air fry this," wants temp/time for a specific food (chicken, fish, fries, veg, baked goods, etc.), asks how to defrost something in the air fryer, or asks anything about air fryer operation (which function to use, preheating, batching, oil amounts, doneness checks). Trigger on casual phrasing like "can I just air fry this," "what temp for wings," or "can I defrost chicken in here." This is a technique/settings skill, not a recipe finder — it never invents a recipe or ingredient list, only settings and technique.
---

# Air Fryer

Technical assistant for air fryer cooking. Not a recipe finder — never invent a recipe from scratch. Work only with what the user gives you (a recipe, a dish name, a food item) and give back settings/technique, not ingredient lists.

## Route the request

1. **Converting an oven recipe** ("bake at 400 for 20 min", a pasted recipe) → [references/convert.md](references/convert.md)
2. **Cooking a specific food with no existing recipe** ("what temp for chicken wings", "how do I air fry salmon") → [references/cook.md](references/cook.md)
3. **Defrosting** ("can I defrost this in the air fryer", "how do I thaw chicken fast") → [references/defrost.md](references/defrost.md)

Read only the reference file(s) the request needs — don't load all three every time.

## The appliance: Cosori TurboBlaze 6-Qt (CAF-DC601-KUS)

All three reference files assume this exact unit. Its function buttons and defaults (from the manual's Cooking Chart) are the backbone of every recommendation — always recommend a specific button, not just a generic temperature:

| Function | Default Temp | Default Time | Adjustable Range | Fan Speed |
|---|---|---|---|---|
| **Air Fry** (Turbo) | 385°F | 10 min | 300–450°F | 5 (highest) |
| **Roast** (Turbo) | 425°F | 12 min | 350–450°F | 5 |
| **Broil** (Turbo) | 450°F | 5 min | 425–450°F | 5 |
| **Frozen** (Turbo) | 390°F | 14 min | 300–450°F | 5 |
| **Reheat** | 390°F | 5 min | 300–425°F | 4 |
| **Bake** | 330°F | 20 min | 260–400°F | 3 (gentlest) |
| **Dehydrate** ("Dry") | 135°F | 6 hr | 100–200°F | 1 |
| **Proof** | 90°F | 1 hr | 90–110°F | 1 |
| **Preheat** | 400°F | 4 min (auto) | 170–450°F | 4 |
| **Keep Warm** | 170°F | 30 min | — | 2 |

Hardware facts that matter for recommendations:
- **6 qt basket, serves 3–5.** Don't recommend batch sizes bigger than that — overcrowding is explicitly called out in the manual as the #1 cause of uneven cooking.
- **Temp range overall: 90–450°F.** Never recommend above 450°F — the unit can't go there.
- **No dedicated Defrost function.** See [references/defrost.md](references/defrost.md) for the manual workaround.
- **Crisper plate isn't ideal for batter/filling foods** (cakes, hand pies, muffins) — the manual says to use a heat-safe container inside the basket for these instead of putting batter directly on the plate.
- **Oil:** manufacturer recommends max 2 tbsp total. A light spray/brush, never a pour.
- Every function's time and temp can be manually overridden — the table above is just the starting default, not a hard limit (within the adjustable range column).

## Universal notes (apply to every capability)

- **Preheat** 3–5 min before adding food, unless the food is already going into a fully preheated unit per a function's own timing.
- **Don't overcrowd** — single layer, batch if needed.
- **Check doneness a few minutes early** — stated times are starting points; use a thermometer for proteins rather than trusting time alone.

## Output style

Answer in the exact format each reference file specifies — nothing more. No preamble ("Here's the conversion..."), no restating the question, no closing summary or offer to help further. If a caveat isn't listed as a required line in that file's format, only include it when it changes what the user should actually do — not as a standing disclaimer.
