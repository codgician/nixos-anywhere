#!/bin/sh
set -efu "${enableDebug:-}"
has() {
  command -v "$1" >/dev/null && echo "y" || echo "n"
}
isNixos=$(if test -f /etc/os-release && grep -Eq 'ID(_LIKE)?="?nixos"?' /etc/os-release; then echo "y"; else echo "n"; fi)
cat <<FACTS
isOs=$(uname)
isArch=$(uname -m)
isKexec=$(if test -f /etc/is_kexec; then echo "y"; else echo "n"; fi)
isNixos=$isNixos
isInstaller=$(if [ "$isNixos" = "y" ] && grep -Eq 'VARIANT_ID="?installer"?' /etc/os-release; then echo "y"; else echo "n"; fi)
isContainer=$(if [ "$(has systemd-detect-virt)" = "y" ]; then systemd-detect-virt --container; else echo "none"; fi)
hasIpv6Only=y
hasTar=$(has tar)
hasCpio=$(has cpio)
hasSudo=$(has sudo)
hasDoas=$(has doas)
hasWget=$(has wget)
hasCurl=$(has curl)
hasSetsid=$(has setsid)
hasNixOSFacter=$(command -v nixos-facter >/dev/null && echo "y" || echo "n")
FACTS
