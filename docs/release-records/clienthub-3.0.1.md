# ClientHub release record: 3.0.0 feature release and 3.0.1 hotfix (Chapter 11 lab)

Disposable lab environment, synthetic traffic only. Web app `clienthub-lab-z80b7` (`rg-ralltheory-digital`), slots: production and `staging`.

| Version | Commit / tag | Delivery run | Approver | Result |
|---|---|---|---|---|
| 1.0.0 | `608b4a3` / `clienthub-v1.0.0` | Direct baseline deploy (Part B) | n/a | Production baseline |
| 2.0.0 | `bf89ea8` / `clienthub-v2.0.0` | clienthub-cd run 2; ADO ch11-clienthub-cd 20261006.1 | aandersonaz400; Casey Chen | Swapped and verified |
| 3.0.0 | `7cef0a4` / `clienthub-v3.0.0` | clienthub-cd run 5 (run 4 blocked at staging) | aandersonaz400 | Flag `EnhancedClientSummary` shipped off |
| 3.0.1 | `fbed8ef` / `clienthub-v3.0.1` | clienthub-cd run 6 from `release/clienthub-3.0` | aandersonaz400 (expedited) | Hotfix live; merged back by PR #11 |

## 1. Additive schema change and compatible reads/writes

Expand only: nullable `GivenName` and `FamilyName` added to `release_lab.Customer`; `DisplayName` kept and still written by old code. Old read (`DisplayName`) and new read (`COALESCE(NULLIF(CONCAT(GivenName, ' ', FamilyName), ' '), DisplayName)`) both returned `Example Customer` for the unbackfilled row. Mixed-version writes and a backfill were **not** tested against a real application model.

## 2. Idempotent migration artifact and single owner

Owner: the `ExpandDatabase` stage of `ch11-clienthub-cd`, using the dedicated `clienthub-db-migrator` principal (`clienthub-db-wif`) with only `ALTER`/`SELECT`/`UPDATE` on schema `release_lab`. Runs 20261006.3 and 20261006.4 both succeeded; the second added no duplicate columns. Run 20261006.2 failed at the database stage (no network route yet) and Stage/Promote did not run.

## 3. Dependency order

Expand (DB stage) -> deploy with flag disabled (3.0.0, `standard`) -> verify -> expose (flag on gave `enhanced` within ~18 s, off gave `standard` within ~16 s, version unchanged) -> contract (drop `DisplayName`) only after the rollback window and all old consumers end. Contract is **not** scheduled.

## 4. Backup/restore and roll-forward

Required before any destructive step: point-in-time restore of the database into a separate database, with measured restore duration and write reconciliation after the recovery point. Acceptable data-loss window for this lab: none for destructive changes, so destructive changes are blocked until a restore rehearsal exists. **Not executed** in this lab. For the additive change, the decision is roll-forward: an application swap does not remove the new nullable columns, and old code ignores them.

## 5. Hotfix

Baseline: deployed tag `clienthub-v3.0.0` (production verified 3.0.0). Branch `hotfix/clienthub-lab` -> PR #10 into protected `release/clienthub-3.0` (ruleset: PR required, no deletion or force-push). Mandatory checks: staging health and version 3.0.1, production baseline 3.0.0 check, approval, post-swap verification. Temporary environment allowance for exactly `release/clienthub-3.0` was added for run 6 and removed afterwards. Merge-back: PR #11 into `main`.

## 6. Recovery actions

| Situation | Action |
|---|---|
| Staging check fails | Do not approve. Production is untouched; fix forward and redeploy to staging (run 4 was blocked this way). |
| Failed canary | Set `staging=0`, clear routing cookies, verify production version. A pinned `x-ms-routing-name=staging` cookie still reached staging after reset. |
| Confirmed swap, failed verification | Automation reverse-swaps once and the run stays failed (run 3: verification failed, restore swap succeeded, production back to 1.0.0). |
| Uncertain swap status | Do not swap again. Read both `/version` endpoints, then decide manually (manual reverse swap took 144 s). |
| Corrupt data | Stop releases, restore into a separate database, reconcile writes, then roll forward. A slot swap does not reverse a migration. |
