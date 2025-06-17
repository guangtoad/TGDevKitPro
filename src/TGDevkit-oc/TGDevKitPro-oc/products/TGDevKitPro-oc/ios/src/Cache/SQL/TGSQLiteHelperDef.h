//
//  SqlDef.h
//  TG Develop Tools iOS
//
//  Created by toad on 2022/11/14.
//

#ifndef SqlDef_h
#define SqlDef_h

#import <MJExtension.h>
#import "TGFileUtil.h"
#endif /* SqlDef_h */

#pragma mark - Sqllite 属性SQL文
#define SQLLITE_ALLTABLENAME @"SELECT name FROM sqlite_master WHERE type='table';"
#define SQLLITE_TABLE_INFO(__tableName) [NSString stringFromet:@"PRAGMA table_info(%@);",__tableName]

#define SQL_TBL_USERINFO @""
#define SQL_TBL_LOG @""

#define SQL_CREATE_TAL_USER @""

#define SQL_SELECT_A @""
#define SQL_SELECT_A @""
#define SQL_REPLACE_USER(_USERID) [NSString stringWithFormat:@"REPLACE INTO %@ (GUID,VIN,OWNERS_ID,NOTICE_TYPE,NOWTIME) VALUES ('%@','%@','%@','%@','%@');",SQL_TBL_USERINFO,_GUID,_VIN,_OWNERS_ID,_NOTICE_TYPE,_NOWTIME]

