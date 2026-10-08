# Playing with ROCm

[English](README.md)

在 AMD ROCm 上跑通的开源项目目录。这里只做入口：代码在各自仓库，长文在 [技术笔记](https://github.com/rocPAI-Forge/tech-blog-pub) 和 [rocpai-forge.github.io](https://rocpai-forge.github.io/)。采集、仿真、训练、部署这条闭环画在 [技术全景](https://github.com/rocPAI-Forge/rocPAI-Forge.github.io/blob/main/content/overview.zh.md)。

| | 板块 | 你想找的是 |
| --- | --- | --- |
| 1 | [TOP 3](#top3) | 刚发布的 |
| 2 | [按机器](#by-machine) | Strix Halo、MI300X 或 Radeon 独显上先打开什么 |
| 3 | [Real2Sim](#real2sim) | 扫描、动态场景、立体深度 |
| 4 | [仿真](#simulation) | 遥操作、数据集、MuJoCo |
| 5 | [强化学习与 VLA](#rl-and-vla) | 会抓、会走、会跟速度的策略 |
| 6 | [机器人](#robots) | 能对话、能看、能拍照的桌面机器人 |
| 7 | [推理](#inference) | 可以自己编译的 HIP 引擎 |
| 8 | [上游 PR](upstream/README.md) | 送给其他项目、让它们能在 AMD GPU 上跑的改动 |
| 9 | [2024–2025](#earlier) | 更早的教程，2026-10 未复测 |

<a id="top3"></a>

## 1 · TOP 3

最多三条，新的在前。来了第四条，就去掉最旧的一条。有 LinkedIn 动态时，链在对应那条上。动态是英文。

**2026-10-07 · [h3-hip.c v0.15.0](https://github.com/alexhegit/h3-hip.c/releases/tag/v0.15.0)。** FastH3 路径默认关闭：`--fasth3-lora`（稠密 4 步 LoRA）、`--taeh3`（小视频解码器）、`--vsa`（稀疏视频注意力）。Prompt 1、1344×768、5 秒、单卡 MI300X：

| 路径 | 时间 |
| --- | --- |
| 稠密 50 步 | 668 秒 |
| FastH3 | 97 秒 |
| VSA + TAEH3 | 62 秒 |

FastH3 和 VSA+TAEH3 是 4 步，不是 NVIDIA 公布的 50 步方案。62 秒的单卡 MI300X 快过已公布的 RTX 5090 全优化（231 秒）和 4 卡 H100 基线（81 秒）。4 卡 H100 全优化仍然更快（23 秒）。这一版没有重测 gfx1151 和 gfx90a。账本：[MI300X 对比 NVIDIA，768p](https://github.com/alexhegit/h3-hip.c/blob/main/docs/perf-runs/MI300X_VS_NVIDIA_768P_2026-10-07.md)。[LinkedIn](https://www.linkedin.com/posts/alexhegit_amd-mi300x-rocm-activity-7513883671502974976-uY3n)。

**2026-08-29 · [UniLab 里的 MicroDuck 步态](https://github.com/Motphys/UniLab/pull/1368)。** Pollen Robotics 的 Hugging Face 小型双足。MuJoCo 上的速度任务，PPO 和 SAC。已合并。[LinkedIn](https://www.linkedin.com/posts/alexhegit_microduck-gait-rl-in-unilab-native-rocm-activity-7499461871222231040-HV_P)：在 Radeon Pro W7900 上，用 UniLab 自带的 ROCm 路径训练。

**2026-07-17 · [SO-101 SimStudio](https://github.com/rocPAI-Forge/so101-simstudio)。** 键盘、Joy-Con 或主臂遥操作，录成 LeRobot v3.0。采集版 v0.1.2。Ubuntu 24.04 + ROCm，面向 Ryzen AI 笔记本或 mini PC。[LinkedIn](https://www.linkedin.com/posts/alexhegit_so-101-simstudio-is-open-source-starting-activity-7483870972219957249-9Gt2)。

<a id="by-machine"></a>

## 2 · 按机器

| 机器 | 先打开 |
| --- | --- |
| Ryzen AI / Strix Halo（gfx1151，含 Radeon 8060S） | [FoundationStereo-hip.c](https://github.com/alexhegit/FoundationStereo-hip.c) · [h3-hip.c](https://github.com/alexhegit/h3-hip.c) · [SO-101 SimStudio](https://github.com/rocPAI-Forge/so101-simstudio) · [ROCm Robotics RL Lab](https://github.com/alexhegit/ROCm_Robotics_RL_Lab) · [Reachy Mini Chat](https://github.com/alexhegit/ReachyMiniChat) |
| Instinct MI300X | [h3-hip.c](https://github.com/alexhegit/h3-hip.c) · [OpenArm 轨迹](#simulation) · [OpenArm 抓取](#rl-and-vla) · [SO-101 Lab 01](https://github.com/rocPAI-Forge/tech-blog-pub/tree/main/PhysicalAI/so101-simstudio-lab01-pnp) · [4DGS](https://github.com/rocPAI-Forge/tech-blog-pub/tree/main/PhysicalAI/amd-4dgs-series-01) · [MicroDuck](https://github.com/rocPAI-Forge/microduck_rl_tutorial) |
| Radeon 独显 | 4DGS 观看端：Vulkan 渲染、VA-API 编码、WebRTC |

<a id="real2sim"></a>

## 3 · Real2Sim

扫描、视频和立体视觉，收成仿真能用的场景。

| 项目 | 做什么 | 验证于 |
| --- | --- | --- |
| [Scan2Sim](https://github.com/rocPAI-Forge/Scan2Sim) | 扫描 OBJ → 带碰撞体、质量和惯量的 MuJoCo 资产。仓库可运行。 | 网格处理管线，不跑 GPU 训练。 |
| [单目视频 → 4DGS](https://github.com/rocPAI-Forge/tech-blog-pub/tree/main/PhysicalAI/amd-4dgs-series-01) | 单目视频补出多视角，再建成可换视角的动态高斯场景。Phi Media Lab × rocPAI-Lab。[笔记](https://github.com/rocPAI-Forge/tech-blog-pub/blob/main/PhysicalAI/amd-4dgs-series-01/README.md)。121 帧 → 24 路观测 → 3 万步更新。 | 生成与重建在 MI300X + ROCm。观看端在 Radeon：Vulkan + VA-API + WebRTC，1280×720。 |
| [FoundationStereo-hip.c](https://github.com/alexhegit/FoundationStereo-hip.c) | FoundationStereo 的 HIP 移植，面向 Strix Halo。已发布 [v0.1.0](https://github.com/alexhegit/FoundationStereo-hip.c/releases/tag/v0.1.0)。 | gfx1151，ROCm 7.2。2448×2048、12 iter：PyTorch ROCm 约 426 秒，HIP 约 5.0 秒。 |

<a id="simulation"></a>

## 4 · 仿真

遥操作，以及这些操作产出的数据。

| 项目 | 做什么 | 验证于 |
| --- | --- | --- |
| [SO-101 SimStudio](https://github.com/rocPAI-Forge/so101-simstudio) | 键盘、Joy-Con 或主臂遥操作，录成 LeRobot v3.0。[介绍](https://github.com/rocPAI-Forge/tech-blog-pub/blob/main/PhysicalAI/so101-simstudio/README.md) · [详解](https://github.com/rocPAI-Forge/tech-blog-pub/blob/main/PhysicalAI/so101-simstudio/README-details.md)。采集版 v0.1.2。安装路径是 Ubuntu 24.04 + ROCm。 | Ubuntu 24.04 + ROCm，文档按 Ryzen AI 笔记本或 mini PC 来写。 |
| [SO-101 Lab 01](https://github.com/rocPAI-Forge/so101-simstudio) | 同一套示范，接 ACT / SmolVLA，再在 MuJoCo 里闭环评估。[笔记](https://github.com/rocPAI-Forge/tech-blog-pub/blob/main/PhysicalAI/so101-simstudio-lab01-pnp/README.md) · [详解](https://github.com/rocPAI-Forge/tech-blog-pub/blob/main/PhysicalAI/so101-simstudio-lab01-pnp/README-details.md)。v0.1.3。 | MI300X 上训过 50K 步检查点。 |
| [OpenArm 轨迹](https://github.com/alexhegit/openarm_mp_labs) | 用运动规划批量生成抓放示范，给后面的 VLA 训练。抓取可以是标定的顶视位姿，也可以是 GraspGenX 在 ROCm 上合成的 6-DoF 位姿。[笔记](https://github.com/rocPAI-Forge/tech-blog-pub/blob/main/PhysicalAI/openarm-traj-gen-for-vla/README.md) · [详解](https://github.com/rocPAI-Forge/tech-blog-pub/blob/main/PhysicalAI/openarm-traj-gen-for-vla/README-details.md)。数据引擎已跑通。回放在 CPU。 | MI300X，ROCm 7.2，容器内 torch 2.7.1+rocm7.2。 |
| [RoboSimLab](https://github.com/alexhegit/RoboSimLab) | SO-101 的 MuJoCo 场景，导出 LeRobot 3.0 episode。基础场景和脚本化导出已完成。IK、抓放和真机还在路线上。 | 目标平台：Linux + PyTorch + ROCm。 |
| [OpenArm Labs Hub](https://github.com/alexhegit/openarm_labs_hub) | OpenArm 仿真、强化学习、模仿学习和 ROS 的仓库地图与踩坑。实现代码在其他仓库。 | — |

<a id="rl-and-vla"></a>

## 5 · 强化学习与 VLA

VLA 训练从上面的 [SO-101 Lab 01](#simulation)（ACT / SmolVLA）和 [OpenArm 轨迹](#simulation) 进入。

| 项目 | 做什么 | 验证于 |
| --- | --- | --- |
| [OpenArm 抓取](https://github.com/rocPAI-Forge/tech-blog-pub/tree/main/PhysicalAI/openarm-rl-grasp) | 抓方块。策略练出了一种奖励里没有写明的抓法。MuJoCo 在 CPU，策略学习在 ROCm，训练栈是 [UniLab](https://github.com/Motphys/UniLab)。[笔记](https://github.com/rocPAI-Forge/tech-blog-pub/blob/main/PhysicalAI/openarm-rl-grasp/README.md) · [详解](https://github.com/rocPAI-Forge/tech-blog-pub/blob/main/PhysicalAI/openarm-rl-grasp/README-details.md)。rocPAI-Lab：Alex He、David Li、Andy Luo。 | MI300X / MI210 + ROCm。 |
| [MicroDuck](https://github.com/rocPAI-Forge/microduck_rl_tutorial) | 全向小车的 PPO 实验课：奖励、评估视频，再用键盘驱动。任务在 [microduck_rl_unilab](https://github.com/rocPAI-Forge/microduck_rl_unilab)。中英笔记本。 | 500×300 在 MI300X 上约 4 分钟。 |
| [Kudada](https://github.com/rocPAI-Forge/kudada_rl_unilab) | 10 自由度双足平地速度跟踪。FastSAC。四种已验收步态：走、蹲走、侧向走、踏步恢复。仓库里有评估视频。 | UniLab + MuJoCo。 |
| [ROCm Robotics RL Lab](https://github.com/alexhegit/ROCm_Robotics_RL_Lab) | robosuite 里的 Panda 抬方块，SAC / PPO。仿真渲染和 PyTorch 都在核显上。训练、评估和扫参脚本可用。 | Ryzen AI Max+ 395，Radeon 8060S，PyTorch ROCm 7.1。 |

<a id="robots"></a>

## 6 · 机器人

| 项目 | 做什么 | 验证于 |
| --- | --- | --- |
| [Reachy Mini Chat](https://github.com/alexhegit/ReachyMiniChat) | 仿真或真机对话：语音识别、Ollama、TTS、情绪动作和口型。可以完全离线。`emo_v1`–`emo_v8`，含 Piper TTS。 | Ryzen AI Max+ 395 + Ubuntu 24.04。也在带 Radeon 的 Ubuntu 上跑过。 |
| [ReachyBuddy](https://github.com/alexhegit/ReachyBuddy) | 同一台 Reachy Mini 的更多模式：语音拍照、Ollama 视觉模型巡视、对话，以及带工具调用的 Agent。 | — |
| [ReachyClaw](https://github.com/alexhegit/ReachyClaw) | 通过 OpenClaw 做对话和情绪动作。语言模型走 OpenClaw API。机器人侧是 MuJoCo 或真机。 | — |
| [VLM Demo](https://github.com/alexhegit/vlm-demo-rocm) | 浏览器摄像头，由 Qwen2.5-VL-3B-Instruct 看图回答。Web demo，2025-11。 | ROCm GPU。 |

<a id="inference"></a>

## 7 · 推理

| 项目 | 做什么 | 验证于 |
| --- | --- | --- |
| [h3-hip.c](https://github.com/alexhegit/h3-hip.c) | MiniMax-H3 的 HIP 移植。同一棵代码，用 `HIP_ARCH` 选择 GPU。持续更新。[v0.15.0](https://github.com/alexhegit/h3-hip.c)：单卡 MI300X、1344×768、5 秒视频，稠密 50 步约 668 秒，VSA+TAEH3 约 62 秒。 | gfx1151（Strix Halo）、gfx90a（MI210）、gfx942（MI300X）。 |
| [dsh-plugin-h3-hip](https://github.com/alexhegit/dsh-plugin-h3-hip) | 把 `h3 --serve` 接到 DeepSeek Harness。需要 h3-hip.c ≥ v0.12-exp。 | — |

<a id="upstream"></a>

## 8 · 上游 PR

送给其他项目、让它们能在 AMD GPU 上跑的 pull request。每条的 GitHub 状态记在 [上游页面](upstream/README.md)（英文）。

<a id="earlier"></a>

## 9 · 2024–2025

[History](history/README.zh.md) 保留更早的复现步骤：W7900 上的 LoRA / QLoRA、iGPU 780M 上的 Ollama、vLLM 容器、EchoMimic、CosyVoice、语音助手和 RAG。每条标了当时的 GPU 和 ROCm 版本。**2026-10 未复测。**

```
@misc{Playing with ROCm,
  author = {He Ye (Alex)},
  title = {Playing with ROCm},
  howpublished = {\url{https://github.com/alexhegit/Playing-with-ROCm}},
  year = {2024--2026}
}
```
