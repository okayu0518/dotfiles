#!/usr/bin/env python3
"""Claude Code statusLine renderer.

Reads the statusLine JSON payload from stdin and prints two short lines
instead of one long one, so it stays readable in a narrow terminal:
  [dirname (branch) Model]
  [ctx NN% 5h NN% 7d NN%]

Every optional segment (branch / ctx / 5h / 7d) is dropped gracefully when
its field is absent from the payload, so the line degrades instead of
breaking. The second line is omitted entirely if it would be empty (no ctx
and no rate-limit data). No external dependencies (e.g. jq) are required -
only python3 and git.
"""
import json
import os
import subprocess
import sys

GREEN, YELLOW, MAGENTA, CYAN, BLUE, RESET = (
    "\033[32m", "\033[33m", "\033[35m", "\033[36m", "\033[34m", "\033[0m"
)


def main() -> None:
    try:
        data = json.load(sys.stdin)
    except Exception:
        print("[]")
        return

    cwd = (data.get("workspace") or {}).get("current_dir") or data.get("cwd") or os.getcwd()
    dirname = os.path.basename(cwd.rstrip("/")) or cwd

    branch = ""
    try:
        result = subprocess.run(
            ["git", "--no-optional-locks", "-C", cwd, "rev-parse", "--abbrev-ref", "HEAD"],
            capture_output=True, text=True, timeout=2,
        )
        if result.returncode == 0:
            branch = result.stdout.strip()
    except Exception:
        pass

    model = (data.get("model") or {}).get("display_name", "")
    ctx = (data.get("context_window") or {}).get("used_percentage")
    rate_limits = data.get("rate_limits") or {}
    five_hour = (rate_limits.get("five_hour") or {}).get("used_percentage")
    seven_day = (rate_limits.get("seven_day") or {}).get("used_percentage")

    line1 = [f"{GREEN}{dirname}{RESET}"]
    if branch:
        line1.append(f"{YELLOW}({branch}){RESET}")
    if model:
        line1.append(f"{MAGENTA}{model}{RESET}")
    print(f"[{' '.join(line1)}]")

    line2 = []
    if ctx is not None:
        line2.append(f"{CYAN}ctx {round(ctx)}%{RESET}")
    if five_hour is not None:
        line2.append(f"{BLUE}5h {round(five_hour)}%{RESET}")
    if seven_day is not None:
        line2.append(f"{BLUE}7d {round(seven_day)}%{RESET}")
    if line2:
        print(f"[{' '.join(line2)}]")


if __name__ == "__main__":
    main()
