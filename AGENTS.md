# Updating this catalog

This repo is a map of open-source projects that were actually run on AMD ROCm. Code stays in each project repo. Long write-ups stay in [tech-blog-pub](https://github.com/rocPAI-Forge/tech-blog-pub) and on [rocpai-forge.github.io](https://rocpai-forge.github.io/).

English `README.md` is the GitHub default. `README.zh.md` is the twin. Edit both in the same change, same section order, same anchors.

## Where to look

Check recent hands-on work before editing:

- https://github.com/alexhegit
- https://github.com/rocPAI-Forge
- Notes under `rocPAI-Forge/tech-blog-pub` (`PhysicalAI/`)

Confirm a repo was practiced, not merely cloned. `gh api repos/<owner>/<repo>` (`.fork`, `.parent`) and a compare against the parent. A fork with `ahead 0` stays out. A CUDA-only repo stays out. A dependency (UniLab is the training stack, not a catalog project) is named inside the row that uses it.

## Which page

| Kind of update | Edit |
| --- | --- |
| Last year's work a developer can open and run | `README.md` and `README.zh.md` |
| Older local notes or scripts that were really run | `history/README.md` and `history/README.zh.md`, plus the files |
| A pull request that makes someone else's project run on AMD GPUs | `upstream/README.md` only |

History is for reproduction steps, not for link dumps, empty rows, or wish lists. Each history entry records the window: when, which GPU, which ROCm or image. End with **Not retested in YYYY-MM.** using the month you archived it. Do not change that month unless you retest.

Upstream is one English page. Both READMEs link to `upstream/README.md`. Do not add `upstream/README.zh.md`. Include only pull requests authored by [alexhegit](https://github.com/alexhegit) that add an AMD ROCm path on a third-party repo. Leave out own-repo pull requests, mesh or gripper edits, and benchmark-only reports. The state column uses GitHub's words: `merged`, `open`, `closed`. `closed` means not merged. A merge is not a later retest of their default branch. Old pull-request records stay on this page.

## Page shape

Numbered jump table first, then one section per row. Put `<a id="..."></a>` before each heading. GitHub's heading slugs are unreliable for Chinese, so both languages share these ids: `by-machine`, `real2sim`, `simulation`, `rl-and-vla`, `robots`, `inference`, `upstream`, `earlier`.

Front-page project tables have three columns: project, one sentence, verified hardware. Name the GPU and the ROCm or image tag when they are known. Use `—` when the machine was not recorded. History links stay in the same language. The upstream link always points at the English page; the Chinese README says that page is in English.

```markdown
<a id="real2sim"></a>

## 2 · Real2Sim

| Project | What | Verified on |
| --- | --- | --- |
| [Name](https://github.com/owner/repo) | One sentence a developer can act on. | gfx942 (MI300X), ROCm 7.2. |
```

When a front-page item goes stale and the steps live in this repo, move the files under `history/`, fix links to relative paths, and add the window plus the not-retested line. If it was never run, delete the row.

`Reference/` is not part of the catalog. Leave it alone. Commit or push only when asked.
