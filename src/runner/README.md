# Runner — systemd user service

`npustackedcoder.service` is a **systemd user unit** (not a system/root
service). It brings the whole stack up as a single, seamless userspace
service: one `enable --now` starts FastFlowLM, OpenWebUI, and OpenCode
via podman compose, and stopping the unit stops them all.

## Install

Adjust `WorkingDirectory` and the compose paths in the unit if you
cloned this repo somewhere other than `~/npu-llm`, then:

```bash
mkdir -p ~/.config/systemd/user
cp src/runner/npustackedcoder.service ~/.config/systemd/user/
systemctl --user daemon-reload
systemctl --user enable --now npustackedcoder.service
```

## Use

```bash
systemctl --user status npustackedcoder.service
journalctl --user -u npustackedcoder.service -f
systemctl --user stop npustackedcoder.service
systemctl --user disable npustackedcoder.service
```

The unit runs `podman compose up` in the foreground (`Type=simple`),
so systemd can restart it on failure and `ExecStop` runs
`podman compose down`.
