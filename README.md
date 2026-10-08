# Playing with ROCm

[中文](README.zh.md)

Open-source projects that run on AMD ROCm. This page is only the map: code stays in each repo, longer write-ups stay in the [tech notes](https://github.com/rocPAI-Forge/tech-blog-pub) and on [rocpai-forge.github.io](https://rocpai-forge.github.io/). The loop — capture, simulate, train, deploy — is drawn on the [overview](https://github.com/rocPAI-Forge/rocPAI-Forge.github.io/blob/main/content/overview.en.md).

| | Section | Open this if you want |
| --- | --- | --- |
| 1 | [TOP 3](#top3) | what just shipped |
| 2 | [By machine](#by-machine) | a short list for Strix Halo, MI300X, or a Radeon dGPU |
| 3 | [Real2Sim](#real2sim) | scans, dynamic scenes, stereo depth |
| 4 | [Simulation](#simulation) | teleoperation, datasets, MuJoCo |
| 5 | [RL and VLA](#rl-and-vla) | a policy that grasps, walks, or tracks velocity |
| 6 | [Robots](#robots) | a desktop robot that talks, sees, or takes a photo |
| 7 | [Inference](#inference) | a HIP engine you can compile |
| 8 | [Upstream PRs](upstream/README.md) | patches sent so other projects run on AMD GPUs |
| 9 | [2024–2025](#earlier) | older guides, not retested in 2026-10 |

<a id="top3"></a>

## 1 · TOP 3

Three newest releases, newest first. A fourth one replaces the oldest. A LinkedIn post, when there is one, is linked on that item.

**2026-10-07 · [h3-hip.c v0.15.0](https://github.com/alexhegit/h3-hip.c/releases/tag/v0.15.0).** FastH3 paths are opt-in and off by default: `--fasth3-lora` (dense 4-step LoRA), `--taeh3` (tiny video decoder), `--vsa` (sparse video attention). Prompt 1 at 1344×768, 5 seconds, one MI300X:

| Path | Time |
| --- | --- |
| dense 50-step | 668 s |
| FastH3 | 97 s |
| VSA + TAEH3 | 62 s |

FastH3 and VSA+TAEH3 are 4-step, not the published NVIDIA 50-step stack. At 62 s, one MI300X is faster than the published RTX 5090 full-opt cell (231 s) and the H100×4 baseline (81 s). Four H100s at full opt are still faster (23 s). gfx1151 and gfx90a were not re-timed for this tag. Ledger: [MI300X vs NVIDIA, 768p](https://github.com/alexhegit/h3-hip.c/blob/main/docs/perf-runs/MI300X_VS_NVIDIA_768P_2026-10-07.md). [LinkedIn](https://www.linkedin.com/posts/alexhegit_amd-mi300x-rocm-activity-7513883671502974976-uY3n).

**2026-08-29 · [MicroDuck gait in UniLab](https://github.com/Motphys/UniLab/pull/1368).** Pollen Robotics' Hugging Face mini biped. Velocity task on MuJoCo, PPO and SAC. Merged. [LinkedIn](https://www.linkedin.com/posts/alexhegit_microduck-gait-rl-in-unilab-native-rocm-activity-7499461871222231040-HV_P): trained on a Radeon Pro W7900 with UniLab's native ROCm path.

**2026-07-17 · [SO-101 SimStudio](https://github.com/rocPAI-Forge/so101-simstudio).** Teleop with a keyboard, Joy-Con, or leader arm, recorded as LeRobot v3.0. Collection release v0.1.2. Ubuntu 24.04 + ROCm, for a Ryzen AI laptop or mini PC. [LinkedIn](https://www.linkedin.com/posts/alexhegit_so-101-simstudio-is-open-source-starting-activity-7483870972219957249-9Gt2).

<a id="by-machine"></a>

## 2 · By machine

| Machine | Start here |
| --- | --- |
| Ryzen AI / Strix Halo (gfx1151, including Radeon 8060S) | [FoundationStereo-hip.c](https://github.com/alexhegit/FoundationStereo-hip.c) · [h3-hip.c](https://github.com/alexhegit/h3-hip.c) · [SO-101 SimStudio](https://github.com/rocPAI-Forge/so101-simstudio) · [ROCm Robotics RL Lab](https://github.com/alexhegit/ROCm_Robotics_RL_Lab) · [Reachy Mini Chat](https://github.com/alexhegit/ReachyMiniChat) |
| Instinct MI300X | [h3-hip.c](https://github.com/alexhegit/h3-hip.c) · [OpenArm trajectories](#simulation) · [OpenArm grasp RL](#rl-and-vla) · [SO-101 Lab 01](https://github.com/rocPAI-Forge/tech-blog-pub/tree/main/PhysicalAI/so101-simstudio-lab01-pnp) · [4DGS](https://github.com/rocPAI-Forge/tech-blog-pub/tree/main/PhysicalAI/amd-4dgs-series-01) · [MicroDuck](https://github.com/rocPAI-Forge/microduck_rl_tutorial) |
| Radeon dGPU | 4DGS viewer: Vulkan render, VA-API encode, WebRTC |

<a id="real2sim"></a>

## 3 · Real2Sim

Scans, video, and stereo, turned into something a simulator can use.

| Project | What | Verified on |
| --- | --- | --- |
| [Scan2Sim](https://github.com/rocPAI-Forge/Scan2Sim) | Scanned OBJ → MuJoCo asset with collision mesh, mass, and inertia. Repo runs. | Mesh pipeline. No GPU training. |
| [Monocular video → 4DGS](https://github.com/rocPAI-Forge/tech-blog-pub/tree/main/PhysicalAI/amd-4dgs-series-01) | One video → extra viewpoints → a dynamic Gaussian scene. Phi Media Lab × rocPAI-Lab. [Note](https://github.com/rocPAI-Forge/tech-blog-pub/blob/main/PhysicalAI/amd-4dgs-series-01/README.md). 121 frames → 24 viewpoint streams → 30,000 updates. | Build on MI300X + ROCm. Viewer on Radeon: Vulkan + VA-API + WebRTC, 1280×720. |
| [FoundationStereo-hip.c](https://github.com/alexhegit/FoundationStereo-hip.c) | HIP port of FoundationStereo for Strix Halo. Released [v0.1.0](https://github.com/alexhegit/FoundationStereo-hip.c/releases/tag/v0.1.0). | gfx1151, ROCm 7.2. 2448×2048, 12 iterations: about 426 s in PyTorch ROCm, about 5.0 s in HIP. |

<a id="simulation"></a>

## 4 · Simulation

Teleoperation and the data those runs produce.

| Project | What | Verified on |
| --- | --- | --- |
| [SO-101 SimStudio](https://github.com/rocPAI-Forge/so101-simstudio) | Keyboard, Joy-Con, or leader-arm teleop into LeRobot v3.0. [Intro](https://github.com/rocPAI-Forge/tech-blog-pub/blob/main/PhysicalAI/so101-simstudio/README.md) · [deep dive](https://github.com/rocPAI-Forge/tech-blog-pub/blob/main/PhysicalAI/so101-simstudio/README-details.md). Collection release v0.1.2. Install path is Ubuntu 24.04 + ROCm. | Ubuntu 24.04 + ROCm, written for a Ryzen AI laptop or mini PC. |
| [SO-101 Lab 01](https://github.com/rocPAI-Forge/so101-simstudio) | Same demonstrations, then ACT / SmolVLA, then closed-loop eval in MuJoCo. [Note](https://github.com/rocPAI-Forge/tech-blog-pub/blob/main/PhysicalAI/so101-simstudio-lab01-pnp/README.md) · [deep dive](https://github.com/rocPAI-Forge/tech-blog-pub/blob/main/PhysicalAI/so101-simstudio-lab01-pnp/README-details.md). v0.1.3. | 50K-step checkpoint trained on MI300X. |
| [OpenArm trajectories](https://github.com/alexhegit/openarm_mp_labs) | Motion-planned pick-and-place demos for later VLA training. Grasp is either a calibrated top-down pose or a 6-DoF GraspGenX pose from ROCm. [Note](https://github.com/rocPAI-Forge/tech-blog-pub/blob/main/PhysicalAI/openarm-traj-gen-for-vla/README.md) · [deep dive](https://github.com/rocPAI-Forge/tech-blog-pub/blob/main/PhysicalAI/openarm-traj-gen-for-vla/README-details.md). Data engine has been run. Replay is on CPU. | MI300X, ROCm 7.2, torch 2.7.1+rocm7.2 in the container. |
| [RoboSimLab](https://github.com/alexhegit/RoboSimLab) | SO-101 MuJoCo scene that exports LeRobot 3.0 episodes. Base scene and scripted export are done. IK, pick-and-place, and the real robot are still on the roadmap. | Target platform: Linux + PyTorch + ROCm. |
| [OpenArm Labs Hub](https://github.com/alexhegit/openarm_labs_hub) | Repo map and pitfalls for OpenArm sim, RL, imitation learning, and ROS. Code stays in the other repos. | — |

<a id="rl-and-vla"></a>

## 5 · RL and VLA

VLA training starts from [SO-101 Lab 01](#simulation) (ACT / SmolVLA) and the [OpenArm trajectories](#simulation) above.

| Project | What | Verified on |
| --- | --- | --- |
| [OpenArm grasp RL](https://github.com/rocPAI-Forge/tech-blog-pub/tree/main/PhysicalAI/openarm-rl-grasp) | Cube grasp. The policy grew a grip the reward never spelled out. MuJoCo on CPU, policy learning on ROCm, training stack [UniLab](https://github.com/Motphys/UniLab). [Note](https://github.com/rocPAI-Forge/tech-blog-pub/blob/main/PhysicalAI/openarm-rl-grasp/README.md) · [deep dive](https://github.com/rocPAI-Forge/tech-blog-pub/blob/main/PhysicalAI/openarm-rl-grasp/README-details.md). rocPAI-Lab: Alex He, David Li, Andy Luo. | MI300X / MI210 + ROCm. |
| [MicroDuck](https://github.com/rocPAI-Forge/microduck_rl_tutorial) | PPO lab for an omnidirectional robot: reward, eval video, then keyboard control. Tasks live in [microduck_rl_unilab](https://github.com/rocPAI-Forge/microduck_rl_unilab). Chinese and English notebooks. | 500×300 timed at about 4 minutes on MI300X. |
| [Kudada](https://github.com/rocPAI-Forge/kudada_rl_unilab) | 10-DoF biped velocity tracking on flat ground. FastSAC. Four accepted gaits: walk, crouch-walk, lateral walk, march-recover. Eval videos are in the repo. | UniLab + MuJoCo. |
| [ROCm Robotics RL Lab](https://github.com/alexhegit/ROCm_Robotics_RL_Lab) | Panda lift-cube in robosuite, SAC / PPO. Sim rendering and PyTorch both use the iGPU. Train, eval, and sweep scripts are usable. | Ryzen AI Max+ 395, Radeon 8060S, PyTorch ROCm 7.1. |

<a id="robots"></a>

## 6 · Robots

| Project | What | Verified on |
| --- | --- | --- |
| [Reachy Mini Chat](https://github.com/alexhegit/ReachyMiniChat) | Sim or real Reachy Mini: speech recognition, Ollama, TTS, emotion motion, lip sync. Can run fully offline. `emo_v1`–`emo_v8`, including Piper TTS. | Ryzen AI Max+ 395 + Ubuntu 24.04. Also run on Ubuntu with a Radeon GPU. |
| [ReachyBuddy](https://github.com/alexhegit/ReachyBuddy) | Same robot, more modes: voice photo, patrol with an Ollama vision model, chat, and an agent with tool calls. | — |
| [ReachyClaw](https://github.com/alexhegit/ReachyClaw) | Conversation and emotion motion through OpenClaw. The language model uses the OpenClaw API. The robot side is MuJoCo or the real robot. | — |
| [VLM Demo](https://github.com/alexhegit/vlm-demo-rocm) | Browser camera answered by Qwen2.5-VL-3B-Instruct. Web demo, 2025-11. | A ROCm GPU. |

<a id="inference"></a>

## 7 · Inference

| Project | What | Verified on |
| --- | --- | --- |
| [h3-hip.c](https://github.com/alexhegit/h3-hip.c) | HIP port of MiniMax-H3. One tree; set `HIP_ARCH` for the GPU. Actively updated. [v0.15.0](https://github.com/alexhegit/h3-hip.c): on one MI300X, a 1344×768, 5-second video is about 668 s dense 50-step, about 62 s with VSA+TAEH3. | gfx1151 (Strix Halo), gfx90a (MI210), gfx942 (MI300X). |
| [dsh-plugin-h3-hip](https://github.com/alexhegit/dsh-plugin-h3-hip) | Connects `h3 --serve` to DeepSeek Harness. Needs h3-hip.c ≥ v0.12-exp. | — |

<a id="upstream"></a>

## 8 · Upstream PRs

Pull requests sent to other projects so they can run on AMD GPUs. The list, with each pull request's GitHub state, is on the [upstream page](upstream/README.md).

<a id="earlier"></a>

## 9 · 2024–2025

[History](history/README.md) keeps the older reproduction steps: LoRA / QLoRA on the W7900, Ollama on iGPU 780M, vLLM containers, EchoMimic, CosyVoice, the voice assistant, and RAG. Each entry records the GPU and ROCm version from that time. **Not retested in 2026-10.**

```
@misc{Playing with ROCm,
  author = {He Ye (Alex)},
  title = {Playing with ROCm},
  howpublished = {\url{https://github.com/alexhegit/Playing-with-ROCm}},
  year = {2024--2026}
}
```
