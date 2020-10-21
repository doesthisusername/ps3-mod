#!/usr/bin/env python3

import os

found = False

# find ld.lld
paths = os.environ["PATH"].split(os.pathsep)
for path in paths:
    lld_path = path + os.sep + "lld"
    
    for ext in ["", ".exe"]:
        if os.path.exists(lld_path + ext):
            with open(lld_path + ext, "rb") as lld:
                lld_bstr = lld.read()
                # r2 -> r20 in the long branch function
                patched_lld = lld_bstr.replace(b"\x0D\x00\x00\x82\x3D", b"\x0D\x00\x00\x94\x3D")

                with open("ld.lld" + ext, "wb") as lld_out:
                    lld_out.write(patched_lld)

                os.chmod("ld.lld", 0o744)
                found = True
                break

    if found:
        break

print("Copied and patched lld" if found else "Failed to find lld!")
