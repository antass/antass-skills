---
name: "grocery-weekly-ad"
description: "Pull a grocery store's current weekly ad (default Shaw's, East Boston 02128) via Flipp and turn it into an aisle-sorted deal list with standouts. Use for 'grab the weekly ad' or similar."
---

# Grocery Weekly Ad

Grab the current weekly ad and return a clean, scannable deal list. Defaults: **Shaw's**, postal code **02128** (East Boston store, 246 Border St). If the user names another store or zip, use that instead.

## Steps

1. **Find the flyer ID.** Use WebFetch on:
   `https://backflipp.wishabi.com/flipp/flyers?locale=en-us&postal_code=02128`
   Prompt: return id, name, valid_from and valid_to for every flyer from the target merchant.
   - Pick the flyer named **"Weekly Ad"** that covers today's date.
   - Note any other current flyers from that store (e.g. "Big Book of Savings") so you can mention them at the end. Don't pull them unless asked.

2. **Pull every item.** Use WebFetch on `https://backflipp.wishabi.com/flipp/flyers/<ID>`.
   Prompt: list EVERY item, no omissions, one per line, as name | price (keep pre_price_text like "2/" and post_price_text like "lb.") | sale_story or deal text | whether it's a coupon item. Group roughly by category.

3. **Fallback.** If the flyer endpoint fails, use WebFetch on
   `https://backflipp.wishabi.com/flipp/items/search?locale=en-us&postal_code=02128&q=<store>`
   and keep only items whose dates match the weekly ad. Warn that this list may be incomplete. Don't scrape the store's page: it's a cross-origin Flipp iframe, and page-text tools fail on it.

4. **Clean it up.** The fetch model often puts items in the wrong group, so fix those. Then:
   - Sort into these sections: Produce, Meat & Seafood, Deli, Dairy & Eggs, Frozen, Pantry, Bread, Beverages, Household & Personal Care, Seasonal.
   - Mark items that need the forU digital coupon with ★ (the flyer's "printed coupon" flag means this).
   - Keep conditions like "when you buy 5", limits, BOGO and spend thresholds.
   - Leave out baby formula and diapers, and drop entries that show no price and no deal.
   - Add a note that round prices like $5.00 or $6.00 are often "2 for" deals, because the flyer endpoint sometimes drops the "2/".

5. **Pick 5–8 standouts.** Choose the best value per unit: cheap proteins, staple produce, free-item offers, kid-friendly pantry items for Ash and Charlie, and stock-up household items.

6. **Deliver.** Write the list to `/mnt/user-data/outputs/<store>-weekly-ad-<valid_from YYYY-MM-DD>.md`:
   - Title with the store name and date range, then a line with the store location and the ★ legend.
   - A Standouts section, then the aisle sections.
   - In chat, give only the standouts in 3–6 bullets, then mention any other current flyer and offer to pull it.

## Style

Keep it short and scannable, with bold prices on the standouts. Don't recap these steps in the reply.