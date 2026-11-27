#!/usr/bin/env bash
# 检查一个项目夹是否符合文件治理规范。
# 用法：check-project.sh <项目路径>
# 退出码：0 全部通过；1 有告警（结构缺失或残留待确认文件）；2 用法错误。

set -uo pipefail

if [ $# -lt 1 ]; then
  echo "用法：$0 <项目路径>" >&2
  exit 2
fi

ROOT="${1%/}"
if [ ! -d "$ROOT" ]; then
  echo "目录不存在：$ROOT" >&2
  exit 2
fi

problems=0
warns=0

say_problem() { echo "缺失  $1"; problems=$((problems + 1)); }
say_warn()    { echo "注意  $1"; warns=$((warns + 1)); }

echo "检查：$ROOT"
echo

# 1. 必备文件
for f in README.md 项目日志.md; do
  [ -f "$ROOT/$f" ] || say_problem "$f"
done

# 2. 必备目录
for d in 1-产出 2-草稿 3-素材 4-过程 9-归档; do
  [ -d "$ROOT/$d" ] || say_problem "$d/"
done
[ -d "$ROOT/4-过程/plan" ] || say_warn "4-过程/plan/ 不存在，计划文档会无处可放"

# 3. git
if [ -d "$ROOT/.git" ]; then
  echo "存档  已建 git"
  if [ -f "$ROOT/.gitignore" ]; then
    grep -q '3-素材' "$ROOT/.gitignore" || say_warn ".gitignore 没有忽略 3-素材/"
  else
    say_problem ".gitignore"
  fi
else
  say_warn "还没建 git（新项目应先 git init 并存一次）"
fi

# 4. 残留的待确认标记
pending=$(find "$ROOT" -name '待确认-*' -not -path '*/.git/*' 2>/dev/null)
if [ -n "$pending" ]; then
  echo
  echo "待确认的文件（共 $(printf '%s\n' "$pending" | wc -l | tr -d ' ') 个）："
  printf '%s\n' "$pending" | sed "s|^$ROOT/|  |"
  problems=$((problems + 1))
fi

# 5. 超大文件（>50 MiB），按大小倒序
big=$(find "$ROOT" -type f -size +50M -not -path '*/.git/*' 2>/dev/null)
if [ -n "$big" ]; then
  echo
  echo "超过 50 MiB 的文件（建议改走 NAS）："
  printf '%s\n' "$big" | while IFS= read -r f; do
    printf '  %s  %s\n' "$(du -h "$f" | cut -f1)" "${f#"$ROOT/"}"
  done
  warns=$((warns + 1))
fi

# 6. README 是否写了正本
if [ -f "$ROOT/README.md" ]; then
  grep -q '正本' "$ROOT/README.md" || say_warn "README.md 没写「正本」在哪"
fi

echo
if [ "$problems" -eq 0 ] && [ "$warns" -eq 0 ]; then
  echo "结果：通过"
  exit 0
fi
echo "结果：$problems 个问题，$warns 个注意"
[ "$problems" -eq 0 ] && exit 0
exit 1
