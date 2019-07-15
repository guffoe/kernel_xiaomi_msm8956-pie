#!/system/bin/sh

################################################################################
# helper functions to allow Android init like script

function write() {
    echo -n $2 > $1
}

function copy() {
    cat $1 > $2
}

# macro to write pids to system-background cpuset
function writepid_sbg() {
    until [ ! "$1" ]; do
        echo -n $1 > /dev/cpuset/system-background/tasks;
        shift;
    done;
}

function writepid_top_app() {
    until [ ! "$1" ]; do
        echo -n $1 > /dev/cpuset/top-app/tasks;
        shift;
    done;
}
################################################################################

sleep 10

	#set SoC Temp On
	write /sys/module/msm_thermal/parameters/enabled N
	
	# Set ice-COOL display
	write /sys/devices/platform/kcal_ctrl.0/kcal_cont 256
	write /sys/devices/platform/kcal_ctrl.0/kcal_val 256
	write /sys/devices/platform/kcal_ctrl.0/kcal_sat 250
	write /sys/devices/platform/kcal_ctrl.0/kcal_min 25
	write /sys/devices/platform/kcal_ctrl.0/kcal 256 256 256 
	write /sys/devices/platform/kcal_ctrl.0/kcal_enable 1
	
	# Virtual memory tweaks
	write /proc/sys/vm/dirty_ratio 20
	write /proc/sys/vm/dirty_background_ratio 5
	write /proc/sys/vm/dirty_expire_centisecs 200
	write /proc/sys/vm/dirty_writeback_centisecs 500
	write /proc/sys/vm/min_free_kbytes 6541
	write /proc/sys/vm/oom_kill_allocating_task 0
	write /proc/sys/vm/overcommit_ratio 50
	write /proc/sys/vm/swappiness 100
	write /proc/sys/vm/vfs_cache_pressure 100
	write /proc/sys/vm/laptop_mode 0
	write /proc/sys/vm/extra_free_kbytes 24300
	write /sys/block/zram0/disksize 534773760	
	
	#Set maple block I/O scheduler
	setprop sys.io.scheduler "maple"
	write /proc/sys/kernel/random/read_wakeup_threshold 128
	write /proc/sys/kernel/random/write_wakeup_threshold 256
	write /sys/block/mmcblk0/queue/read_ahead_kb 128
	write /sys/block/mmcblk0/queue/iostats 0
	write /sys/block/mmcblk0/queue/add_random 1
	write /sys/module/lowmemorykiller/parameters/lmk_fast_run 1
	write /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk 0
	write /sys/module/lowmemorykiller/parameters/cost 32
	write /sys/module/lowmemorykiller/parameters/adj_max_shift 353
	write /sys/module/lowmemorykiller/parameters/adj 0 , 100 , 200 , 300 , 900 , 906
	write /sys/module/lowmemorykiller/parameters/minfree "14746,18688,22118,25805,40000,55000"

	# Input Boost Default
	write /sys/kernel/cpu_input_boost/enabled 1
    write /sys/module/cpu_boost/parameters/input_boost_freq "0:1017600 4:1056000"
    write /sys/module/cpu_boost/parameters/input_boost_ms 35

	#Disable TouchBoost
	write /sys/module/msm_performance/parameters/touchboost 0
	
	#set max gpu
	write /sys/class/kgsl/kgsl-3d0/max_gpuclk 600000000
	
	#set disable fysnc
	write /sys/module/sync/parameters/fsync_enabled N
	
	#Disable TouchBoostMin
	write /sys/module/msm_performance/parameters/touchboost 0
	

	
	
	

	