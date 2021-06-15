#!/bin/bash -xe

dbus-daemon --system --fork

su chimera -c "/home/chimera/server/scripts/user-run.sh"