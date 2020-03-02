#!/bin/env bash

sudo podman inspect --type=container nmongodb | jq -r '.[] | select(.State.Running).NetworkSettings.IPAddress'




