# FrameFind VIN / Chassis Decoder

Standalone vehicle research web app. This repository is separate from the invoice and valuation projects.

## Included
- Responsive browser UI for VIN / chassis searches
- Cloudflare Worker API
- Neon Postgres schema for saved vehicles, search history, and source evidence
- Source/status labels for every specification

## Current decoder behavior
- Searches records already saved in the FrameFind Neon database.
- For standard 17-character VINs, also queries the public NHTSA vPIC decoder.
- Market-specific frame numbers (including many Japanese chassis formats) require trusted catalogue sources or verified saved records.
- Unknown fields remain unavailable; AI is not treated as proof of vehicle specifications.

## Deploy overview
1. Deploy the `public/` folder as a Cloudflare Pages static site.
2. Deploy `src/worker.js` as a Cloudflare Worker using Wrangler.
3. Set Worker secret `DATABASE_URL` to a restricted Neon connection string.
4. Set Worker variable `ALLOWED_ORIGIN` to the deployed Pages origin.
5. Update `public/config.js` with the deployed Worker URL.
6. Review `sql/schema.sql` and run it on the intended FrameFind Neon database if required.

Do not commit API keys, database URLs, passwords, or `.env` files.
