# SupportGuide — AI Troubleshooting Assistant

A small L1/L2 support prototype for finding relevant guidance in a sample knowledge base. It retrieves source entries, explains which terms matched, offers practical checks, and reports when the available material is insufficient.

## Quick start (Windows)

1. Install Python 3.10 or newer. No Python packages are required.
2. Open PowerShell in this folder.
3. Run `python app.py` (or double-click `run.bat`).
4. Open [http://127.0.0.1:8000](http://127.0.0.1:8000) in a browser.
5. Try the built-in examples. Press `Ctrl+C` in the terminal to stop the server.

If `python` is not recognized, try `py app.py`. To use another port, set `$env:PORT=8001` before starting and open port 8001.

## Optional AI integration

The prototype works locally without an API key. In that mode it uses a fixed response template populated only from retrieved entries. To enable generated wording through OpenAI's Responses API, create a `.env` file in this folder with these settings, then start the app:

```text
OPENAI_API_KEY=your-key-here
OPENAI_MODEL=gpt-6.2-sol
```

The app loads `.env` at startup and does not override environment variables already set in the shell. `.env` is listed in `.gitignore`; keep it local and never commit or include it in a submission ZIP. The app sends the issue text and retrieved sample entries to the configured OpenAI-compatible Responses endpoint (`/v1/responses`) when a key is present. `OPENAI_BASE_URL` can point to a compatible provider endpoint if needed. Never enter production/customer data in this demo. Check the selected provider’s current model name, endpoint, and account access before presenting the optional AI mode. OpenAI recommends its Responses API for new integrations; its JSON mode returns machine-readable JSON, which this prototype parses into the interface. [Responses API overview](https://platform.openai.com/overview?lang=fr) · [Structured outputs guide](https://developers.openai.com/api/docs/guides/structured-outputs?api-mode=responses)

## How it works

1. `knowledge_base.json` stores eight sample support entries with symptoms, keywords, checks, escalation guidance, and limitations.
2. `app.py` normalizes words, applies a small explicit synonym map, and ranks entries by query-term overlap. The score is a simple overlap fraction, intended to be explainable rather than statistically sophisticated.
3. Entries scoring below 0.12 are not used. With no adequate match, the app asks for more details and suggests intake steps rather than a fix.
4. With a match and API key, the model receives the issue and retrieved entries with instructions to stay grounded. Without a key, a deterministic template uses the top entry.
5. The page displays source title, category, score, matched terms, checks, escalation, and cautions.

## Files

- `app.py` — local web server, retrieval, and optional model call.
- `index.html` — page structure and content.
- `styles.css` — responsive visual styling.
- `app.js` — browser interactions and display of analysis results.
- `knowledge_base.json` — simulated sample guidance; edit this to add or update entries.
- `run.bat` — Windows launcher.

## Assumptions and limitations

- This is an educational prototype using simulated guidance, not an approved company runbook.
- Retrieval is lexical and small-scale. It can miss paraphrases and may rank an imperfect match; the score is not a calibrated confidence probability.
- The optional AI provider can make mistakes. Source display and the prompt reduce risk but do not guarantee correctness; a human must verify operational steps.
- No authentication, persistent history, monitoring, ticketing, logging integration, or production-system access is implemented.
- The local demo server binds to `127.0.0.1`. Do not expose it to a public network.
- Escalation suggestions are sample routing guidance and should be replaced with the organization’s actual team names and process.

## AI use and individual contribution

OpenAI Codex assisted with the initial application and sample knowledge base. Before submitting, review the code, make changes you understand, and accurately describe the parts you personally changed and verified. Do not claim work you did not perform.

## Manual verification before submission

- Start the app and open the local page.
- Try the payment API, database timeout, and unsupported printer examples in the app.
- Confirm known issues show a relevant source and unsupported issues show no source and ask for details.
- If using AI mode, try one grounded example and one unsupported example; confirm the key is supplied only through the environment.
- Rehearse while sharing the browser and terminal, and keep a screenshot or short recording as a backup if the submission allows it.
