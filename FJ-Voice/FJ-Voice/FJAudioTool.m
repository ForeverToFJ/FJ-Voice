//
//  FJAudioTool.m
//  FJ-Voice
//
//  Created by  高帆 on 16/6/2.
//  Copyright © 2016年 GF. All rights reserved.
//

#import "FJAudioTool.h"

@implementation FJAudioTool

static NSMutableDictionary *_soudIDs;
static NSMutableDictionary *_players;

+ (void)initialize
{
    _soudIDs = [NSMutableDictionary dictionary];
    _players = [NSMutableDictionary dictionary];
}


+ (void)playSoundWithSoundName:(NSString *)soundName
{
    // 创建soundID = 0
    SystemSoundID soundID = 0;
    
    // 从字典中取出soundID
    soundID = [_soudIDs[soundName] unsignedIntValue];;
    
    // 判断soundID是否为0
    if (soundID == 0) {
        // 生成soundID
        CFURLRef url = (__bridge CFURLRef)[[NSBundle mainBundle] URLForResource:soundName withExtension:nil];
        AudioServicesCreateSystemSoundID(url, &soundID);
        
        // 将soundID保存到字典中
        [_soudIDs setObject:@(soundID) forKey:soundName];
        
    }
    
    // 播放音效
    AudioServicesPlaySystemSound(soundID);
}

+ (void)playMusicWithFileName:(NSString *)fileName
{
    // 创建空的播放器
    AVAudioPlayer *player = nil;
    
    // 从字典中取出播放器
    player = _players[fileName];
    
    // 判断播放器是否为空
    if (player == nil) {
        // 生成对应音乐资源
        NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:fileName withExtension:nil];
        if (fileUrl == nil) return;
        
        // 创建对应的播放器
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileUrl error:nil];
        
        // 保存到字典中
        [_players setObject:player forKey:fileName];
        
        // 准备播放
        [player prepareToPlay];
    }
    
    // 开始播放
    [player play];
    
}

+ (void)pauseMusicWithFileName:(NSString *)fileName
{
    // 从字典中取出播放器
    AVAudioPlayer *player = _players[fileName];
    
    // 暂停音乐
    if (player) {
        [player pause];
    }
}

+ (void)stopMusicWithFileName:(NSString *)fileName
{
    // 从字典中取出播放器
    AVAudioPlayer *player = _players[fileName];
    
    // 停止音乐
    if (player) {
        [player stop];
        [_players removeObjectForKey:fileName];
        player = nil;
    }
}

@end
