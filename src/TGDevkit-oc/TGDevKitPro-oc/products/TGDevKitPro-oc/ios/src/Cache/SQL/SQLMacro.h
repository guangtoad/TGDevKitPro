//
//  SQLMacro.h
//  smartGLink_cn
//
//  Created by toad on 2021/2/18.
//  Copyright © 2021 TechnoASKA. All rights reserved.
//

#pragma mark - Sqllite 属性SQL文
#define SQLLITE_ALLTABLENAME @"SELECT name FROM sqlite_master WHERE type='table';"


#define SQLLITE_TABLE_INFO(__tableName) [NSString stringFromet:@"PRAGMA table_info(%@);",__tableName]

#pragma mark -

#define SQLLITE_TBLENAME_WebKitHistory @"WebKitHistory"

#define SQL_SELECT_ALLTABLENAME @"SELECT name FROM sqlite_master WHERE type='table';"

#define SQL_SELECT_TBL_ComExpReminderHistory(_GUID,_VIN,_OWNERS_ID,_NOTICE_TYPE) \
[NSString stringWithFormat:@"SELECT * FROM %@ WHERE GUID = '%@' AND VIN = '%@' AND OWNERS_ID = '%@' AND NOTICE_TYPE = '%@'",TBL_ComExpReminderHistory, _GUID, _VIN, _OWNERS_ID,_NOTICE_TYPE]

#define SQL_REPLACE_TBL_ComExpReminderHistory(_GUID,_VIN,_OWNERS_ID,_NOTICE_TYPE,_NOWTIME)\
[NSString stringWithFormat:@"REPLACE INTO tbl_ComExpReminderHistory (GUID,VIN,OWNERS_ID,NOTICE_TYPE,NOWTIME) VALUES ('%@','%@','%@','%@','%@');",_GUID,_VIN,_OWNERS_ID,_NOTICE_TYPE,_NOWTIME]

#define SQL_DELETE_TBL_ComExpReminderHistory(_GUID)\
[NSString stringWithFormat:@"DELETE FROM tbl_ComExpReminderHistory WHERE GUID = '%@'",_GUID]

#define SQL_CREATE_tbl_21MM_CarInfo @"CREATE TABLE tbl_21MM_CarInfo ( GUID VARCHAR NOT NULL UNIQUE, VIN VARCHAR NOT NULL UNIQUE, CAR_NUMBER VARCHAR, DATETIME VARCHAR, OILINFO TEXT, ISEVCAR VARCHAR, EV_Distance_AC VARCHAR, EvTravelableDistance VARCHAR, Charge_PlugStatus VARCHAR, ChargeRemainingAmount VARCHAR, G_FLG_LIST TEXT, IMAGE_URL VARCHAR, CONTROLNO VARCHAR, InsuranceFlag VARCHAR, Message VARCHAR, FINDCARNO VARCHAR, ACSETTINGS VARCHAR, AIRTEMPERATURE VARCHAR, VENTILATION VARCHAR, REMOTE_PARKING_IS_SHOW VARCHAR, ISPHEV VARCHAR, FIND_CAR_SETTING_VEHICLEINFO TEXT, VEHICLE_CONTROL_VEHICLEINFO TEXT, AC_SETTING_VEHICLEINFO TEXT, PRIMARY KEY ( GUID, VIN ));"

#define ELC_DB_ENCRYPTKEY @"f6c0975f2c742dbb487083ab5090da6f"
