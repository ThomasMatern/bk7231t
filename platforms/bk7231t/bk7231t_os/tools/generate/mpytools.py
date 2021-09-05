import os
import sys
import json

firmware_str = sys.argv[1]
ver_str = sys.argv[2]

out_json = {
    "magic": "RT-Thread",
    "version": "0.1",
    "count": 4,
    "section": [
        {
            "firmware": "bootloader_enc.bin",                    
            "version": ver_str,
            "partition": "bootloader",
            "start_addr": "0x00000000",
            "size": "68K"
        },
        {
            "firmware": firmware_str,
            "version": ver_str,
            "partition": "app",
            "start_addr": "0x00011000",
            "size": str(34 * os.path.getsize(firmware_str) // 32 + 0x100)
        }
    ]
}

out_path = "config.json"
out_json = json.dumps(out_json, sort_keys=True, indent=4)

with open(str(out_path), "w") as f:
    f.write(out_json)
