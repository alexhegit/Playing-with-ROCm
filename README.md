# Playing with ROCm

Open-source projects that actually run on AMD ROCm. This page is the map. Code stays in each project repo. Longer write-ups stay in [rocPAI-Forge tech notes](https://github.com/rocPAI-Forge/tech-blog-pub) and on [rocpai-forge.github.io](https://rocpai-forge.github.io/).

在 AMD ROCm 上亲手跑通的开源项目目录。这里只做入口：一条项目一句说明、验证过的机器、以及仓库或笔记链接。

2024–2025 的微调、vLLM 和数字人实践在 [History](history/README.md)。那些步骤 **2026-10 没有复测**。

## 按机器往下看

| 机器 | 适合先打开 |
| --- | --- |
| Ryzen AI / Strix Halo（gfx1151，含 Radeon 8060S） | [FoundationStereo-hip.c](https://github.com/alexhegit/FoundationStereo-hip.c)、[h3-hip.c](https://github.com/alexhegit/h3-hip.c)、[SO-101 SimStudio](https://github.com/rocPAI-Forge/so101-simstudio)、[ROCm Robotics RL Lab](https://github.com/alexhegit/ROCm_Robotics_RL_Lab)、[Reachy Mini Chat](https://github.com/alexhegit/ReachyMiniChat) |
| Instinct MI300X | [h3-hip.c](https://github.com/alexhegit/h3-hip.c)、OpenArm 轨迹与抓取、[SO-101 Lab 01](https://github.com/rocPAI-Forge/tech-blog-pub/tree/main/PhysicalAI/so101-simstudio-lab01-pnp)、[4DGS](https://github.com/rocPAI-Forge/tech-blog-pub/tree/main/PhysicalAI/amd-4dgs-series-01)、[MicroDuck 教程](https://github.com/rocPAI-Forge/microduck_rl_tutorial) |
| Radeon 独显 | 4DGS 观看端（Vulkan 渲染、VA-API 编码、WebRTC） |

组织主线是一条闭环：真机采集、仿真、强化学习 / VLA、再部署回真机，计算放在 ROCm 上。全景图在 [技术全景](https://github.com/rocPAI-Forge/rocPAI-Forge.github.io/blob/main/content/overview.zh.md)。

## Real2Sim 与三维场景

**[Scan2Sim](https://github.com/rocPAI-Forge/Scan2Sim)** — 把扫描得到的 OBJ 收成带碰撞体、质量和惯量的 MuJoCo 资产。

- 验证：网格处理管线，不依赖 GPU 训练
- 状态：仓库可运行

**[单目视频 → 4DGS](https://github.com/rocPAI-Forge/tech-blog-pub/tree/main/PhysicalAI/amd-4dgs-series-01)** — 用单目视频补出多视角，再建可换视角的动态高斯场景。Phi Media Lab 与 rocPAI-Lab 一起做的。

- 验证：生成与重建在 Instinct MI300X + ROCm；观看端在 Radeon 上用 Vulkan + VA-API + WebRTC，输出 1280×720
- 动手：[笔记](https://github.com/rocPAI-Forge/tech-blog-pub/blob/main/PhysicalAI/amd-4dgs-series-01/README.md)
- 状态：一条端到端路径已跑通（121 帧 → 24 路观测 → 3 万步高斯更新）

**[FoundationStereo-hip.c](https://github.com/alexhegit/FoundationStereo-hip.c)** — FoundationStereo 的 HIP 移植，面向 Strix Halo。

- 验证：gfx1151，ROCm 7.2。2448×2048、12 iter，官方 PyTorch ROCm 约 426 秒，HIP 均值约 5.0 秒（[v0.1.0](https://github.com/alexhegit/FoundationStereo-hip.c/releases/tag/v0.1.0)）
- 状态：已发布

## 仿真、遥操作与数据

**[SO-101 SimStudio](https://github.com/rocPAI-Forge/so101-simstudio)** — SO-101、MuJoCo、LeRobot v3.0。键盘、Joy-Con 或主臂遥操作，录成专家轨迹。

- 验证：Ubuntu 24.04 + ROCm。文档按 Ryzen AI 笔记本或 mini PC 来写
- 动手：[项目介绍](https://github.com/rocPAI-Forge/tech-blog-pub/blob/main/PhysicalAI/so101-simstudio/README.md) · [详解](https://github.com/rocPAI-Forge/tech-blog-pub/blob/main/PhysicalAI/so101-simstudio/README-details.md)
- 状态：v0.1.2 采集。安装路径只写了 Ubuntu 24.04 + ROCm

**[SO-101 Lab 01 抓取放置](https://github.com/rocPAI-Forge/so101-simstudio)** — 同一套仿真示范，接上 ACT / SmolVLA 训练，再在 MuJoCo 里闭环评估。

- 验证：MI300X 上训过 50K 步检查点
- 动手：[笔记](https://github.com/rocPAI-Forge/tech-blog-pub/blob/main/PhysicalAI/so101-simstudio-lab01-pnp/README.md) · [详解](https://github.com/rocPAI-Forge/tech-blog-pub/blob/main/PhysicalAI/so101-simstudio-lab01-pnp/README-details.md)
- 状态：v0.1.3

**[OpenArm 专家轨迹](https://github.com/alexhegit/openarm_mp_labs)** — 用运动规划在 MuJoCo 里批量生成 OpenArm 抓放轨迹，给后面的 VLA 训练当示范数据。抓取位姿可以是标定的顶视抓取，也可以用 GraspGenX 在 ROCm 上合成的 6-DoF 抓取。

- 验证：Instinct MI300X，ROCm 7.2（容器内 torch 2.7.1+rocm7.2）。轨迹回放本身在 CPU
- 动手：[笔记](https://github.com/rocPAI-Forge/tech-blog-pub/blob/main/PhysicalAI/openarm-traj-gen-for-vla/README.md) · [详解](https://github.com/rocPAI-Forge/tech-blog-pub/blob/main/PhysicalAI/openarm-traj-gen-for-vla/README-details.md)
- 状态：数据引擎已跑通

**[RoboSimLab](https://github.com/alexhegit/RoboSimLab)** — SO-101 的 MuJoCo 场景，并导出 LeRobot 3.0 轨迹。

- 验证：目标平台是 Linux + PyTorch + ROCm
- 状态：基础场景和脚本化 episode 导出已完成；IK、抓放和真机还在路线上

**[OpenArm Labs Hub](https://github.com/alexhegit/openarm_labs_hub)** — OpenArm 仿真、强化学习、模仿学习和 ROS 的笔记中枢。实现代码在各个仓库里，这里记仓库地图和踩坑。

## 学习：强化学习与 VLA

**[OpenArm 抓取强化学习](https://github.com/rocPAI-Forge/tech-blog-pub/tree/main/PhysicalAI/openarm-rl-grasp)** — 抓方块任务。策略练出了一种奖励里没有写明的抓法。物理仿真在 CPU 上的 MuJoCo，策略学习在 ROCm 上，训练栈是 [UniLab](https://github.com/Motphys/UniLab)。

- 验证：Instinct MI300X / MI210 + ROCm
- 动手：[笔记](https://github.com/rocPAI-Forge/tech-blog-pub/blob/main/PhysicalAI/openarm-rl-grasp/README.md) · [详解](https://github.com/rocPAI-Forge/tech-blog-pub/blob/main/PhysicalAI/openarm-rl-grasp/README-details.md)
- 作者：rocPAI-Lab（Alex He, David Li, Andy Luo）

**[MicroDuck 速度跟踪](https://github.com/rocPAI-Forge/microduck_rl_tutorial)** — 全向小车的 PPO 实验课：从奖励设计练到评估视频，再用键盘驱动单机策略。任务定义在 [microduck_rl_unilab](https://github.com/rocPAI-Forge/microduck_rl_unilab)。

- 验证：教程里 500×300 的训练计时写的是 MI300X 上约 4 分钟
- 状态：中英笔记本

**[Kudada 双足步态](https://github.com/rocPAI-Forge/kudada_rl_unilab)** — 10 自由度双足在平地上做速度跟踪。FastSAC，四种已验收步态：走、蹲走、侧向走、踏步恢复。

- 验证：UniLab + MuJoCo
- 状态：仓库带评估视频

**[ROCm Robotics RL Lab](https://github.com/alexhegit/ROCm_Robotics_RL_Lab)** — robosuite 里的 Panda 抬方块，SAC / PPO，在笔记本上把仿真渲染和 PyTorch 都跑在核显上。

- 验证：Ryzen AI Max+ 395，Radeon 8060S，PyTorch ROCm 7.1
- 状态：训练、评估和扫参脚本可用

VLA 训练入口见上面的 SO-101 Lab 01（ACT / SmolVLA）和 OpenArm 专家轨迹。

## 具身交互

**[Reachy Mini Chat](https://github.com/alexhegit/ReachyMiniChat)** — Reachy Mini 的仿真或真机对话：语音识别、Ollama、TTS，情绪动作和口型。可以完全离线。

- 验证：开发机是 Ryzen AI Max+ 395 + Ubuntu 24.04；也在带 Radeon 的 Ubuntu 上跑过
- 状态：`emo_v1` 到 `emo_v8`，含 Piper 离线 TTS

**[ReachyBuddy](https://github.com/alexhegit/ReachyBuddy)** — 同一台 Reachy Mini 上的几种模式：语音拍照、用 Ollama 视觉模型巡视、对话，以及带工具调用的 Agent。

**[ReachyClaw](https://github.com/alexhegit/ReachyClaw)** — Reachy Mini 接 OpenClaw 做对话和情绪动作。语言模型走 OpenClaw 的 API，机器人侧是 MuJoCo 仿真或真机。

**[VLM Demo](https://github.com/alexhegit/vlm-demo-rocm)** — 浏览器里打开摄像头，用 Qwen2.5-VL-3B-Instruct 看图回答。

- 验证：ROCm GPU
- 状态：Web demo（2025-11）

## 推理引擎

**[h3-hip.c](https://github.com/alexhegit/h3-hip.c)** — MiniMax-H3 的 HIP 移植。同一棵代码用 `HIP_ARCH` 编给不同卡。

- 验证：Strix Halo gfx1151、MI210 gfx90a、MI300X gfx942。单卡 MI300X、1344×768、5 秒视频：稠密 50 步约 668 秒，VSA+TAEH3 约 62 秒（[v0.15.0](https://github.com/alexhegit/h3-hip.c)）
- 状态：持续更新

**[dsh-plugin-h3-hip](https://github.com/alexhegit/dsh-plugin-h3-hip)** — 把 `h3 --serve` 接到 DeepSeek Harness。需要 h3-hip.c ≥ v0.12-exp。

## 更早的实践

[History](history/README.md) 保留 2024–2025 年写下来的复现步骤：W7900 上的 LoRA / QLoRA、iGPU 780M 上的 Ollama、vLLM 容器、EchoMimic、CosyVoice、语音助手和 RAG。每条标了当时的 GPU 和 ROCm 版本。**2026-10 未复测。**

```
@misc{Playing with ROCm,
  author = {He Ye (Alex)},
  title = {Playing with ROCm},
  howpublished = {\url{https://github.com/alexhegit/Playing-with-ROCm}},
  year = {2024--2026}
}
```
