//
//  AppDelegate.m
//  TagController
//
//  Created by 河野 さおり on 2015/04/06.
//  Copyright (c) 2015年 Saori Kohno. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate{
    NSURL *url;
}

- (BOOL)getURL{
    NSOpenPanel *openPanel	= [NSOpenPanel openPanel];
    [openPanel setCanChooseFiles:YES]; //ファイルの選択を可能に設定
    [openPanel setCanChooseDirectories:YES]; //フォルダの選択を可能に設定
    [openPanel setAllowsMultipleSelection:NO]; //複数選択を不可に設定
    NSInteger pressedButton = [openPanel runModal];
    if(pressedButton == NSOKButton){
        url = [openPanel URL]; //パスを取得
        return YES;
    }else{
        return NO;
    }
}

- (NSMutableArray*)getTags{
        NSDictionary *tagDict = [url resourceValuesForKeys:[NSArray arrayWithObjects:NSURLTagNamesKey,nil] error:NULL];
        NSMutableArray *array = [NSMutableArray arrayWithArray:[tagDict objectForKey:NSURLTagNamesKey]];
    return array;
}

- (IBAction)addTag:(id)sender {
    if ([self getURL]) {
        NSMutableArray *array = [self getTags];
        NSUInteger index = [array indexOfObject:@"グリーン"];
        if (index == NSNotFound){
            [array addObject:@"グリーン"];
            [url setResourceValue:array forKey:NSURLTagNamesKey error:NULL];
        }
    }
}

- (IBAction)clearAllTags:(id)sender {
    if ([self getURL]) {
        [url setResourceValue:[NSArray array] forKey:NSURLTagNamesKey error:NULL];
    }
}

- (IBAction)deleteTag:(id)sender {
    if ([self getURL]) {
        NSMutableArray *array = [self getTags];
        [array removeObject:@"ブルー"];
        [url setResourceValue:array forKey:NSURLTagNamesKey error:NULL];
    }
}

@end
