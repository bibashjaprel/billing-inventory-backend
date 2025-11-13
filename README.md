# Billing Inventory Backend (Gin + GORM)

## Quickstart (local with Docker)

1. Copy `.env` and edit values if needed.
2. Run:
   ```bash
   docker-compose up --build
   ```
3. API health: http://localhost:8080/api/v1/health

## CI/CD

This repo includes a GitHub Actions workflow `.github/workflows/deploy.yml` that builds tests and deploys to your VPS via SSH. Configure secrets:
- `VPS_HOST`
- `VPS_USER`
- `VPS_PRIVATE_KEY` (private key content)
- `DB_URL` (production DB URL)

