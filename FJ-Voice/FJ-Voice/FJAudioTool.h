//
//  FJAudioTool.h
//  FJ-Voice
//
//  Created by  高帆 on 16/6/2.
//  Copyright © 2016年 GF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface FJAudioTool : NSObject

/**
 *  播放音效
 */
+ (void)playSoundWithSoundName:(NSString *)soundName;

/**
 *  播放音乐 fileName:音乐文件
 */
+ (void)playMusicWithFileName:(NSString *)fileName;

/**
 *  暂停音乐 fileName:音乐文件
 */
+ (void)pauseMusicWithFileName:(NSString *)fileName;

/**
 *  停止音乐 fileName:音乐文件
 */
+ (void)stopMusicWithFileName:(NSString *)fileName;


@end
