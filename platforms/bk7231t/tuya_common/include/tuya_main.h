/*
 * tuya_main.h
 *
 *  Created on: 29/08/2021
 *      Author: thomas
 */

#ifndef PLATFORMS_BK7231T_TUYA_COMMON_INCLUDE_TUYA_MAIN_H_
#define PLATFORMS_BK7231T_TUYA_COMMON_INCLUDE_TUYA_MAIN_H_

typedef VOID (*APP_PROD_CB)(BOOL_T flag, CHAR_T rssi);
void app_cfg_set(IN CONST GW_WF_CFG_MTHD_SEL mthd, APP_PROD_CB callback);


#endif /* PLATFORMS_BK7231T_TUYA_COMMON_INCLUDE_TUYA_MAIN_H_ */
