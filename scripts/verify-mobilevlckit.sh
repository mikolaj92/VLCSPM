#!/usr/bin/env bash
# Verify that Package.swift's MobileVLCKit binaryTarget URL is reachable
# and that the published zip still matches the declared SHA-256.
set -euo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
manifest="$root/Package.swift"

url="$(sed -n 's/^let mobileVLCKitURL = "\(.*\)"/\1/p' "$manifest")"
expected="$(sed -n 's/^let mobileVLCKitChecksum = "\(.*\)"/\1/p' "$manifest")"

if [[ -z "$url" || -z "$expected" ]]; then
	echo "error: could not read mobileVLCKitURL / mobileVLCKitChecksum from Package.swift" >&2
	exit 1
fi

if grep -q 'path: "Frameworks/' "$manifest"; then
	echo "error: Package.swift still points at a local Frameworks/ path" >&2
	exit 1
fi

echo "URL: $url"
echo "expected SHA-256: $expected"

code="$(curl -sI -o /dev/null -w '%{http_code}' -L --fail "$url")"
echo "HTTP: $code"

tmp="$(mktemp)"
trap 'rm -f "$tmp"' EXIT
curl -fsSL --retry 3 -o "$tmp" "$url"

actual="$(sha256sum "$tmp" | awk '{ print $1 }')"
echo "actual SHA-256:   $actual"

if [[ "$actual" != "$expected" ]]; then
	echo "error: checksum mismatch" >&2
	exit 1
fi

python3 - "$tmp" <<'PY'
import sys, zipfile
path = sys.argv[1]
with zipfile.ZipFile(path) as z:
    names = z.namelist()
if not any(n == "MobileVLCKit.xcframework/" or n.startswith("MobileVLCKit.xcframework/") for n in names):
    raise SystemExit("error: zip does not contain MobileVLCKit.xcframework")
print("zip contains MobileVLCKit.xcframework")
PY

echo "ok"
