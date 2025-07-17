# Discord Webhook Notifier

This Python script allows you to send messages (including alerts, logs, and notifications) to a Discord channel via a webhook. It supports auto-mentioning users and intelligently splits long messages into multiple parts to avoid hitting Discord's character limits.

---

## Features

- Send messages with additional context or source info.
- Supports mentions via user IDs defined in the `.env` file.
- Automatically splits long messages into multiple parts (max 1800 characters each).
- Supports switching between multiple webhook URLs (e.g., `default` vs. `login` mode).

---

## Setup

### 1. Install Dependencies

requirements 

```text
requests
python-dotenv
```

### 2. Create a `.env` file

Create a `.env` file in the same directory with the following content:

```env
WEBHOOK_URL=https://discord.com/api/webhooks/your_default_webhook

WEBHOOK_URL_LOGIN=https://discord.com/api/webhooks/your_login_webhook

USER_IDS=123456789012345678,987654321098765432
```

> Replace the webhook URLs with actual Discord webhook URLs.
> User IDs should be Discord user IDs you want to mention (comma-separated).
> used if condition to match/select your correct url.

---

## Usage

it takes three arguments as input 
 1) message. This is the main content of your request
 2) message info . A breif context why this message was sent 
 3) which webhook url to use (read line 26-30 once)
 
```python
ping_discord("...", "...", "login")
```

---

## Output

If the message is too long (>1800 characters), the script will split it into chunks and send them as numbered parts.

---

