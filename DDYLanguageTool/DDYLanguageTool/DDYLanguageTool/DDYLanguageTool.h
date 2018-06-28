#import <Foundation/Foundation.h>

#define DDYLocalStr(key)  [NSBundle.mainBundle localizedStringForKey:(key) value:@"" table:nil]

// 中文(简体 大陆)
extern NSString *const DDY_CN;
// 英文(通用)
extern NSString *const DDY_EN;
// 中文(繁体 港澳台)
extern NSString *const DDY_ZHT;
// 日本语
extern NSString *const DDY_JA;
// 法语
extern NSString *const DDY_FR;
// 德语
extern NSString *const DDY_DE;
// 韩语
extern NSString *const DDY_KO;


extern NSErrorDomain DDYLanguageErrorDomain;
#define kDDYLanguageErrorSuccess       0  // 设置语言成功 (完成App内语言，不再跟随系统语言)
#define kDDYLanguageErrorNil          -1  // 语言为空 (恢复跟随系统语言，而不再是App内语言)
#define kDDYLanguageErrorUnsupport    -2  // 不支持的语言 (设置的语言没有相应的 .lproj 文件)
#define kDDYLanguageErrorUnknown      -3  // 未知错误

@interface DDYLanguageTool : NSObject

/** 手机系统语言 */
+ (NSString *)ddy_SystemLanguage;
/** App应用语言 如果未设置将返回手机系统语言 */
+ (NSString *)ddy_AppLanguage;
/** 设置语言  */
+ (void)ddy_SetLanguage:(NSString *)language complete:(void (^)(NSError *error))complete;;

@end
