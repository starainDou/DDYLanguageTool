# [https://github.com/RainOpen/DDYLanguageTool](https://github.com/RainOpen/DDYLanguageTool)

多语言国际化工具(应用内国际化/跟随系统)


# 集成

* CocoaPods方式 

  1.pod 'DDYLanguageTool', '~> 1.3.0' 
 
  2.#import <DDYLanguageTool/DDYLanguageTool.h>

[使用方案](https://github.com/starainDou/DDYLanguageTool)

* 文件夹拖入工程方式
  
  1.下载工程解压后将'DDYLanguageTool'文件夹拖到工程中

  2.#import "DDYLanguageTool.h"
  
# 配置

1. 工程需要添加多语言支持

![AddLanguage.png](http://upload-images.jianshu.io/upload_images/1465510-df8357aea2b0ec6f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

2. 建立String File文件，命名命名为“Localizable，生成一个Localizable.strings文件(名字不要其他的) 

![Localizable.png](http://upload-images.jianshu.io/upload_images/1465510-451ef24a5833160c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

3. 选中新建的Localizable.strings文件，点击右边的Localize，添加English和Chinese(还可以更多)

![Localize.png](http://upload-images.jianshu.io/upload_images/1465510-0421e964609dedb8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

4. 在相应strings文件中写对应KV(系统默认Localizable 也可以自定义)

    在Localizable.strings(English)  文件中写 "OK" = "OK";（不要忘记写分号） 
    在Localizable.strings(Chinese) 文件中写 "OK" = "确定";（不要忘记写分号）

# 使用

* 跟随系统

    如果未通过DDYLanguageTool设置任何语言，或设置过再将语言设置nil或@""，表示跟随系统，执行上面配置即可

* 应用内切换语言(包括能切回跟随系统)

    这种方式可以在不重启App情况下国际化，但是局限在应用内控件，对displayName 和 系统弹窗(如权限弹窗)无效
    
1. 引入
2. 设置语言

    ```
    // 参考工程
    [DDYLanguageTool ddy_SetLanguage:<#某语言如zh-Hans#> complete:^(NSError *error) {
        // 刷新rootVC等
    }];
    ```

3. 取相应字符串

    ```
    // 默认Localizable.strings
    label.text = DDYLocalStr(@"string文件中字符串Key");
    // 或
    label.text = NSLocalizedString(@"string文件中字符串Key", nil);
    // 自定义名称.strings
    label.text = NSLocalizedString(@"string文件中字符串Key", 对应table);
    ```

# 附加

* NSLocalizedString的定义：

    ```
    #define NSLocalizedString(key, comment) \
    [[NSBundle mainBundle] localizedStringForKey:(key) value:@"" table:nil]
    // 第一个参数key是从Localizable.strings这个文件中读取对应的key-value值。
    // 第二个参数comment可以是nil，可以是一段为空的字符串，也可以是对key的注释。
    ```

* 自定义名称.strings(不是Localizable，如hel.strings)

    ```
    label.text = NSLocalizedStringFromTable(@"hello",@"hel", nil);
    ```

* 如果不能添加语言支持

    localizations--choose files and reference language to create...为空白
    
1. 打开工程配置 .pbxproj，搜 ``` /* Begin XCBuildConfiguration section */ ```
在之前添加段落

    ```
    /* Begin PBXVariantGroup section */
    		4C0E56D11F09E6B900583071 /* Localizable.strings */ = {
    			isa = PBXVariantGroup;
    			children = (
    				4C0E56D01F09E6B900583071 /* en */,
    				4C0E56D21F09E6C200583071 /* zh-Hans */,
    			);
    			name = Localizable.strings;
    			sourceTree = "<group>";
    		};
    		ABCB97AC1D71D063000DEBEF /* LaunchScreen.storyboard */ = {
    			isa = PBXVariantGroup;
    			children = (
    				ABCB97AD1D71D063000DEBEF /* Base */,
    				4C0E56CC1F09E37B00583071 /* zh-Hans */,
    			);
    			name = LaunchScreen.storyboard;
    			sourceTree = "<group>";
    		};
    /* End PBXVariantGroup section */
    ```
    
2. 然后添加直接添加Localizable.strings，方法见上，不考虑别的问题，然后回到配置文件搜索 ``` /* Localizable.strings in Resources */ ```
3. 复制ID
4. 搜 ``` /* Begin PBXVariantGroup section */ ```，将 ``` /* Localizable.strings */ ``` 前面的ID 替换保存即可