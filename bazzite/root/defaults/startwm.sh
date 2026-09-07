#!/bin/bash
# Start GNOME for Bazzite-style (Fedora) Kasm workspace
export XDG_SESSION_TYPE=x11
# Custom s6 services start alongside the desktop. GNOME requires the system bus.
for ((attempt = 0; attempt < 30; attempt++)); do
    if dbus-send --system --print-reply --dest=org.freedesktop.DBus \
        / org.freedesktop.DBus.ListNames >/dev/null 2>&1; then
        exec gnome-session
    fi
    sleep 1
done
printf 'The container system D-Bus did not become ready.\n' >&2
exit 1
