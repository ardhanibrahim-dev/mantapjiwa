# MANTAPJIWA Cloudflare Pages Functions + D1

This is a prototype-only API. It contains synthetic data and read-only endpoints.

## Functions

- `/api/health`
- `/api/patients`
- `/api/sessions`

## D1 setup

1. Create a Cloudflare D1 database named `mantapjiwa-demo`.
2. Execute `schema.sql` against that database.
3. Bind the database to the Pages project with the binding name `DB`.
4. Deploy this repository as a Cloudflare Pages project.
5. Test `/api/health`, `/api/patients`, and `/api/sessions`.

No endpoint in this prototype creates, edits, or deletes patient data. Authentication, authorization, consent enforcement, audit enforcement, rate limiting, and production secrets remain required before any real patient data is used.
