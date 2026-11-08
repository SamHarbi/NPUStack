# Runner — systemd user service

`npustack.service` is a **systemd user unit** (not a system/root
service). It brings the whole stack up as a single, seamless userspace
service: one `enable --now` starts FastFlowLM, OpenWebUI, and OpenCode
via podman compose, and stopping the unit stops them all.

## Install

Adjust `WorkingDirectory` and the compose paths in the unit if you
cloned this repo somewhere other than `~/npu-llm`, then:

```bash
mkdir -p ~/.config/systemd/user
cp src/runner/npustack.service ~/.config/systemd/user/
systemctl --user daemon-reload
systemctl --user enable --now npustack.service
```

## Use

```bash
systemctl --user status npustack.service
journalctl --user -u npustack.service -f
systemctl --user stop npustack.service
systemctl --user disable npustack.service
```

The unit runs `podman compose up` in the foreground (`Type=simple`),
so systemd can restart it on failure and `ExecStop` runs
`podman compose down`.
