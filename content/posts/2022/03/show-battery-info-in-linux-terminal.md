---
title: "在 Linux 終端機上查看電池狀態"
date: 2022-03-22T23:24:53+08:00
tags: [linux,command-line]
---

在 `/sys/class/power_supply/BAT0/` 資料夾裡，有一系列的檔案存放著電池的資訊

```bash
$ ls /sys/class/power_supply/BAT0/
alarm                           charge_stop_threshold  serial_number
capacity                        current_now            status
capacity_level                  cycle_count            subsystem
charge_control_end_threshold    device                 technology
charge_control_start_threshold  hwmon1                 type
charge_full                     manufacturer           uevent
charge_full_design              model_name             voltage_min_design
charge_now                      power                  voltage_now
charge_start_threshold          present
```

只要是檔案類型的，都可以直接 `cat` 查看資料

查看電量 (百分比)
```bash
$ cat /sys/class/power_supply/BAT0/capacity
87
```

查看電池使用狀態 (Charging, Discharging, Full 等)
```bash
$ cat /sys/class/power_supply/BAT0/status
Charging
```

查看電池的材料
```bash
$ cat /sys/class/power_supply/BAT0/technology
Li-ion
```

查看全滿電量理論值 (µAh)
```bash
maple@debian:~$ cat /sys/class/power_supply/BAT0/charge_full_design
3513000
```

查看全滿電量實際值 (µAh)
```bash
maple@debian:~$ cat /sys/class/power_supply/BAT0/charge_full
3280000
```

查看目前電量 (µAh)
```bash
$ cat /sys/class/power_supply/BAT0/charge_now
3273000
```

查看所有的電池資訊
```bash
$ cat /sys/class/power_supply/BAT0/uevent
POWER_SUPPLY_NAME=BAT0
POWER_SUPPLY_TYPE=Battery
POWER_SUPPLY_STATUS=Unknown
POWER_SUPPLY_PRESENT=1
POWER_SUPPLY_TECHNOLOGY=Li-ion
POWER_SUPPLY_CYCLE_COUNT=0
POWER_SUPPLY_VOLTAGE_MIN_DESIGN=11100000
POWER_SUPPLY_VOLTAGE_NOW=12196000
POWER_SUPPLY_CURRENT_NOW=0
POWER_SUPPLY_CHARGE_FULL_DESIGN=3513000
POWER_SUPPLY_CHARGE_FULL=3280000
POWER_SUPPLY_CHARGE_NOW=3273000
POWER_SUPPLY_CAPACITY=99
POWER_SUPPLY_CAPACITY_LEVEL=Normal
POWER_SUPPLY_MODEL_NAME=99X99999
POWER_SUPPLY_MANUFACTURER=XYZ
POWER_SUPPLY_SERIAL_NUMBER=123456
```


### Reference
- [Linux power supply class — The Linux Kernel documentation](https://www.kernel.org/doc/html/latest/power/power_supply_class.html)
- https://github.com/torvalds/linux/blob/master/include/linux/power_supply.h
