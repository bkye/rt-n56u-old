##################################################################
# Board PID # Board Name       # PRODUCT # Note
##################################################################
# A3004NS # TOTOLINK A3004NS  # MT7621  #
##################################################################

CFLAGS += -DBOARD_A3004NS -DVENDOR_TOTOLINK
BOARD_NUM_USB_PORTS=1

# AP MODE MediaTek MT7620/MT7602E/MT7612E RBUS/PCIe Wireless driver
#
CONFIG_MT76X2_AP=m
CONFIG_MT76X2_AP_LED=y
CONFIG_MT76X2_AP_LED_SOFT=y
CONFIG_MT76X2_AP_LED_SOFT_GPIO=17

# AP MODE MediaTek MT7603E PCIe Wireless driver
#
CONFIG_MT76X3_AP=m
CONFIG_MT76X3_AP_LED=y
CONFIG_MT76X3_AP_LED_SOFT=y
CONFIG_MT76X3_AP_LED_SOFT_GPIO=5