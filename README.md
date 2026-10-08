# Playing with ROCm

[中文](README.zh.md)

Open-source projects that actually run on AMD ROCm. This page is the map. Code stays in each project repo. Longer write-ups stay in the [rocPAI-Forge tech notes](https://github.com/rocPAI-Forge/tech-blog-pub) and on [rocpai-forge.github.io](https://rocpai-forge.github.io/).

Each entry has one sentence, the machine it was verified on, and a link to the repo or the note.

The 2024–2025 fine-tuning, vLLM, and digital-human work is in [History](history/README.md). Those steps were **not retested in 2026-10**.

## Start from your machine

| Machine | Open these first |
| --- | --- |
| Ryzen AI / Strix Halo (gfx1151, including Radeon 8060S) | [FoundationStereo-hip.c](https://github.com/alexhegit/FoundationStereo-hip.c), [h3-hip.c](https://github.com/alexhegit/h3-hip.c), [SO-101 SimStudio](https://github.com/rocPAI-Forge/so101-simstudio), [ROCm Robotics RL Lab](https://github.com/alexhegit/ROCm_Robotics_RL_Lab), [Reachy Mini Chat](https://github.com/alexhegit/ReachyMiniChat) |
| Instinct MI300X | [h3-hip.c](https://github.com/alexhegit/h3-hip.c), OpenArm trajectories and grasp RL, [SO-101 Lab 01](https://github.com/rocPAI-Forge/tech-blog-pub/tree/main/PhysicalAI/so101-simstudio-lab01-pnp), [4DGS](https://github.com/rocPAI-Forge/tech-blog-pub/tree/main/PhysicalAI/amd-4dgs-series-01), [MicroDuck tutorial](https://github.com/rocPAI-Forge/microduck_rl_tutorial) |
| Radeon dGPU | 4DGS viewer (Vulkan render, VA-API encode, WebRTC) |

The org line of work is one loop: capture on a real robot, simulate, train with RL or a VLA, then deploy back to the robot, with the compute on ROCm. The diagram is on the [overview](https://github.com/rocPAI-Forge/rocPAI-Forge.github.io/blob/main/content/overview.en.md).

## Real2Sim and 3D scenes

**[Scan2Sim](https://github.com/rocPAI-Forge/Scan2Sim)** — Turns a scanned OBJ into a MuJoCo asset with a collision mesh, mass, and inertia.

- Verified: mesh pipeline, no GPU training
- Status: repo runs

**[Monocular video to 4DGS](https://github.com/rocPAI-Forge/tech-blog-pub/tree/main/PhysicalAI/amd-4dgs-series-01)** — Builds extra viewpoints from one video, then a dynamic Gaussian scene you can re-render from new angles. Joint work by Phi Media Lab and rocPAI-Lab.

- Verified: generation and reconstruction on Instinct MI300X + ROCm; the viewer runs on Radeon with Vulkan + VA-API + WebRTC at 1280×720
- Try it: [note](https://github.com/rocPAI-Forge/tech-blog-pub/blob/main/PhysicalAI/amd-4dgs-series-01/README.md)
- Status: one end-to-end path has been run (121 frames → 24 viewpoint streams → 30,000 Gaussian updates)

**[FoundationStereo-hip.c](https://github.com/alexhegit/FoundationStereo-hip.c)** — HIP port of FoundationStereo for Strix Halo.

- Verified: gfx1151, ROCm 7.2. At 2448×2048 and 12 iterations, official PyTorch ROCm takes about 426 s; the HIP mean is about 5.0 s ([v0.1.0](https://github.com/alexhegit/FoundationStereo-hip.c/releases/tag/v0.1.0))
- Status: released

## Simulation, teleoperation, and data

**[SO-101 SimStudio](https://github.com/rocPAI-Forge/so101-simstudio)** — SO-101, MuJoCo, and LeRobot v3.0. Teleoperate with a keyboard, Joy-Con, or leader arm and record expert trajectories.

- Verified: Ubuntu 24.04 + ROCm. The docs are written for a Ryzen AI laptop or mini PC
- Try it: [intro](https://github.com/rocPAI-Forge/tech-blog-pub/blob/main/PhysicalAI/so101-simstudio/README.md) · [deep dive](https://github.com/rocPAI-Forge/tech-blog-pub/blob/main/PhysicalAI/so101-simstudio/README-details.md)
- Status: v0.1.2 for collection. The install path covers Ubuntu 24.04 + ROCm

**[SO-101 Lab 01 pick-and-place](https://github.com/rocPAI-Forge/so101-simstudio)** — The same sim demonstrations, then ACT / SmolVLA training, then closed-loop eval in MuJoCo.

- Verified: a 50K-step checkpoint was trained on MI300X
- Try it: [note](https://github.com/rocPAI-Forge/tech-blog-pub/blob/main/PhysicalAI/so101-simstudio-lab01-pnp/README.md) · [deep dive](https://github.com/rocPAI-Forge/tech-blog-pub/blob/main/PhysicalAI/so101-simstudio-lab01-pnp/README-details.md)
- Status: v0.1.3

**[OpenArm expert trajectories](https://github.com/alexhegit/openarm_mp_labs)** — Motion planning in MuJoCo produces OpenArm pick-and-place trajectories as demonstration data for later VLA training. Grasp poses can be a calibrated top-down grasp, or a 6-DoF grasp synthesized by GraspGenX on ROCm.

- Verified: Instinct MI300X, ROCm 7.2 (torch 2.7.1+rocm7.2 inside the container). Trajectory replay itself runs on CPU
- Try it: [note](https://github.com/rocPAI-Forge/tech-blog-pub/blob/main/PhysicalAI/openarm-traj-gen-for-vla/README.md) · [deep dive](https://github.com/rocPAI-Forge/tech-blog-pub/blob/main/PhysicalAI/openarm-traj-gen-for-vla/README-details.md)
- Status: the data engine has been run

**[RoboSimLab](https://github.com/alexhegit/RoboSimLab)** — An SO-101 MuJoCo scene that exports LeRobot 3.0 trajectories.

- Verified: the target platform is Linux + PyTorch + ROCm
- Status: the base scene and scripted episode export are done; IK, pick-and-place, and the real robot are still on the roadmap

**[OpenArm Labs Hub](https://github.com/alexhegit/openarm_labs_hub)** — Notes for OpenArm simulation, reinforcement learning, imitation learning, and ROS. Implementation stays in the individual repos. This one keeps the repo map and the pitfalls.

## Learning: RL and VLA

**[OpenArm grasp RL](https://github.com/rocPAI-Forge/tech-blog-pub/tree/main/PhysicalAI/openarm-rl-grasp)** — A cube-grasping task. The policy grew a grip the reward never spelled out. Physics runs in MuJoCo on CPU, policy learning runs on ROCm, and the training stack is [UniLab](https://github.com/Motphys/UniLab).

- Verified: Instinct MI300X / MI210 + ROCm
- Try it: [note](https://github.com/rocPAI-Forge/tech-blog-pub/blob/main/PhysicalAI/openarm-rl-grasp/README.md) · [deep dive](https://github.com/rocPAI-Forge/tech-blog-pub/blob/main/PhysicalAI/openarm-rl-grasp/README-details.md)
- Authors: rocPAI-Lab (Alex He, David Li, Andy Luo)

**[MicroDuck velocity tracking](https://github.com/rocPAI-Forge/microduck_rl_tutorial)** — A PPO lab for an omnidirectional robot: reward design, an eval video, then keyboard control of a single-robot policy. Task definitions live in [microduck_rl_unilab](https://github.com/rocPAI-Forge/microduck_rl_unilab).

- Verified: the tutorial times the 500×300 run at about 4 minutes on MI300X
- Status: Chinese and English notebooks

**[Kudada biped gaits](https://github.com/rocPAI-Forge/kudada_rl_unilab)** — Velocity tracking for a 10-DoF biped on flat ground. FastSAC, with four accepted gaits: walk, crouch-walk, lateral walk, and march-recover.

- Verified: UniLab + MuJoCo
- Status: the repo includes eval videos

**[ROCm Robotics RL Lab](https://github.com/alexhegit/ROCm_Robotics_RL_Lab)** — Panda lift-cube in robosuite with SAC / PPO. On the laptop, both sim rendering and PyTorch run on the iGPU.

- Verified: Ryzen AI Max+ 395, Radeon 8060S, PyTorch ROCm 7.1
- Status: train, eval, and sweep scripts are usable

VLA training starts from SO-101 Lab 01 (ACT / SmolVLA) and the OpenArm expert trajectories above.

## Embodied interaction

**[Reachy Mini Chat](https://github.com/alexhegit/ReachyMiniChat)** — Conversation with a simulated or real Reachy Mini: speech recognition, Ollama, TTS, emotion motion, and lip sync. It can run fully offline.

- Verified: developed on Ryzen AI Max+ 395 + Ubuntu 24.04; also run on Ubuntu with a Radeon GPU
- Status: `emo_v1` through `emo_v8`, including offline Piper TTS

**[ReachyBuddy](https://github.com/alexhegit/ReachyBuddy)** — Several modes on the same Reachy Mini: voice-triggered photos, patrol with an Ollama vision model, chat, and an agent with tool calls.

**[ReachyClaw](https://github.com/alexhegit/ReachyClaw)** — Reachy Mini conversations and emotion motion through OpenClaw. The language model uses the OpenClaw API. The robot side is MuJoCo or the real robot.

**[VLM Demo](https://github.com/alexhegit/vlm-demo-rocm)** — A browser camera feed answered by Qwen2.5-VL-3B-Instruct.

- Verified: a ROCm GPU
- Status: web demo (2025-11)

## Inference engines

**[h3-hip.c](https://github.com/alexhegit/h3-hip.c)** — HIP port of MiniMax-H3. One tree; set `HIP_ARCH` for the GPU you compile for.

- Verified: Strix Halo gfx1151, MI210 gfx90a, MI300X gfx942. On one MI300X, a 1344×768, 5-second video takes about 668 s for dense 50-step and about 62 s for VSA+TAEH3 ([v0.15.0](https://github.com/alexhegit/h3-hip.c))
- Status: actively updated

**[dsh-plugin-h3-hip](https://github.com/alexhegit/dsh-plugin-h3-hip)** — Connects `h3 --serve` to DeepSeek Harness. Requires h3-hip.c ≥ v0.12-exp.

## Earlier work

[History](history/README.md) keeps the 2024–2025 reproduction steps: LoRA / QLoRA on the W7900, Ollama on iGPU 780M, vLLM containers, EchoMimic, CosyVoice, the voice assistant, and RAG. Each entry records the GPU and ROCm version from that time. **Not retested in 2026-10.**

```
@misc{Playing with ROCm,
  author = {He Ye (Alex)},
  title = {Playing with ROCm},
  howpublished = {\url{https://github.com/alexhegit/Playing-with-ROCm}},
  year = {2024--2026}
}
```
