#ifndef _MAIN_NONE_H_
#define _MAIN_NONE_H_

#define CFG_CONFIG_FNAME          "beken_cfg_fname"
#define CFG_BSS_CONFIG            "wangzhilei_config:bss_fname"
#define CFG_AP_IFACE_CONFIG       "bss_config= wlan0"
#define WEP40_KEY_LENGTH           10

struct hapd_global {
	void **drv_priv;
	size_t drv_count;
};

extern char *bss_iface;

static void hostapd_thread_start(void);
static void hostapd_thread_stop(void);
int hostapd_main_entry(int argc, char *argv[]);
void hostapd_poll(void *param);
void wpa_hostapd_queue_poll(uint32_t param);
int hostapd_channel_switch(int new_freq);
int supplicant_main_entry(char *oob_ssid);
int supplicant_exit_handler(void);
int supplicant_exit_done(void);
void wpa_supplicant_poll(void *param);

int hostapd_is_exiting(void);
int hostapd_exit_done(void);
int hostapd_exit_handler(void);
int supplicant_is_exiting(void);

#endif // _MAIN_NONE_H_
// eof

