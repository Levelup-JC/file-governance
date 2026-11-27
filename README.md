<p align="center">
  <img src="assets/brand/banner-dark.png#gh-dark-mode-only" width="640" alt="file-governance">
  <img src="assets/brand/banner.png#gh-light-mode-only" width="640" alt="file-governance">
</p>

<p align="center">
  把 AI 堆出来的文件，收拾成<b>一份正本</b>、<b>一份日志</b>、<b>一份公共资产</b>。
</p>

---

AI 很会写代码，也很会堆文件——`讲稿final.md`、`讲稿final-v2.md`、`讲稿final-真的最终版.md`、三个只差几十字节的 `draft/` 副本，散落在桌面和设备上。时间一长，人和 AI 都说不清哪份是能用的。

这个 skill 让 AI 按同一套规则整理，而不是每次临时发挥。

## 三条核心

<table>
  <tr>
    <td align="center" width="33%">
      <img src="assets/icons/package-check-dark.svg#gh-dark-mode-only" width="24"><img src="assets/icons/package-check.svg#gh-light-mode-only" width="24"><br>
      <b>一份正本</b><br>
      <sub><code>1-产出/</code> 里那份说了算</sub>
    </td>
    <td align="center" width="33%">
      <img src="assets/icons/notebook-pen-dark.svg#gh-dark-mode-only" width="24"><img src="assets/icons/notebook-pen.svg#gh-light-mode-only" width="24"><br>
      <b>一份日志</b><br>
      <sub>改了什么、为什么、素材从哪来</sub>
    </td>
    <td align="center" width="33%">
      <img src="assets/icons/boxes-dark.svg#gh-dark-mode-only" width="24"><img src="assets/icons/boxes.svg#gh-light-mode-only" width="24"><br>
      <b>一份公共资产</b><br>
      <sub>品牌、BGM、字体放公共区</sub>
    </td>
  </tr>
</table>

## 六条铁律

- 不删文件，只归档到 `9-归档/`。
- 不改名、不合并、不去重——判断不了正本的文件，加 `待确认-` 前缀交给人决定。
- 推送 GitHub 之前必须问用户，默认私有仓库。
- 不用 Git LFS。超过 100 MiB 的文件不进仓库，走 NAS。
- 只管文件管理，不管备份。
- 不在工作区根目录新建文件或文件夹。

## 项目目录

```
项目名/
├── README.md       入口：这是什么 + 状态 + 正本在哪 + 例外说明
├── 项目日志.md      复盘 + 修改记录（倒序）
├── .gitignore
├── 1-产出/          正本
├── 2-草稿/          进行中的版本
├── 3-素材/          原始素材（不进 git）
├── 4-过程/          plan/ 与 temp/
└── 9-归档/          被取代的旧版本
```

> **编号为什么跳过 5 到 8**：`1` 到 `4` 是常用的四类，`5` 到 `8` 有意留空，以后要加「5-交付」「6-评审」这类新类别时直接占号，不必把 `9-归档` 改成 `10-归档` 再全盘改引用。`9` 固定给归档，因此归档永远排在目录列表最后。

## 两种工作流

**工作流 A · 新项目**：建骨架 → 写 README → 写项目日志 → 裁 `.gitignore` → 首次存档 → 登记索引。

**工作流 B · 存量整理**：先原样存档 → 按项目归拢 → 请用户确认正本 → 判断不了的加 `待确认-` 前缀 → 每步存档 → 结束时 `find . -name '待确认-*'` 必须为空。

## 目录内容

| 路径 | 作用 |
|---|---|
| `SKILL.md` | skill 主体：规则、两种工作流、判断正本的经验法则 |
| `references/project-log-template.md` | 项目日志模板与四条填写规则 |
| `references/git-plain-language.md` | 把 commit/push/分支翻译成人话，什么时候存档 |
| `references/obsidian-index.md` | 本地文件夹、GitHub、Obsidian 三者的对应关系与 MOC 写法 |
| `assets/project-template/` | 可直接复制的项目骨架 |
| `assets/brand/` | 横幅与标志，暗色、浅色各一套 |
| `assets/icons/` | README 用的 Lucide 图标（ISC） |
| `scripts/check-project.sh` | 只读检查：缺什么目录、git 有没有、`待确认-` 是否清空、超大文件 |

## 安装

```bash
git clone <本仓库地址> ~/.claude/skills/file-governance
chmod +x ~/.claude/skills/file-governance/scripts/check-project.sh
```

在 Claude Code 里用 `/file-governance` 调用，或者直接说「整理一下这个文件夹」「给这个项目建个正本」。

## 检查脚本

```
$ scripts/check-project.sh ~/Desktop/【2】DO处理中/某项目
检查：/Users/you/Desktop/【2】DO处理中/某项目

问题  缺少 项目日志.md
问题  目录里还有 2 个待确认文件
注意  还没建 git，改动无法回退

结果：2 个问题，1 个注意
```

## 关于桌面布局的假设

`SKILL.md` 里的路径约定（`~/Desktop/桌面索引.md`、`【2】DO处理中/`、`【3】DONE归档区/`）来自作者自己的桌面结构。如果不打算沿用，改 SKILL.md 里「六条铁律」第 6 条和工作流 A 第 1、6 步即可，其余规则与路径无关。

## 它不管什么

不做备份，不做多设备同步，不对 Obsidian 库执行 git 操作。这三件事各有各的工具，混进来会让规则变复杂。

---

<p align="center">
  <img src="assets/brand/logo-dark.png#gh-dark-mode-only" width="40">
  <img src="assets/brand/logo.png#gh-light-mode-only" width="40"><br>
  <sub>file-governance · 一份正本，一份日志，一份公共资产</sub>
</p>
