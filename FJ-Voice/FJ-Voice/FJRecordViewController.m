//
//  FJRecordViewController.m
//  FJ-Voice
//
//  Created by  高帆 on 16/6/2.
//  Copyright © 2016年 GF. All rights reserved.
//

#import "FJRecordViewController.h"
#import <AVFoundation/AVFoundation.h>

#define FJRecordAudioFile @"FJRecord.caf"

@interface FJRecordViewController ()<AVAudioRecorderDelegate>

/**
 *  录音对象
 */
@property (nonatomic, strong) AVAudioRecorder *recorder;
/**
 *  播放器
 */
@property (nonatomic, strong) AVAudioPlayer *player;
/**
 *  录音声波监控
 */
@property (nonatomic, strong) NSTimer *timer;
/**
 *  音频波动
 */
@property (weak, nonatomic) IBOutlet UIProgressView *audioPower;

@end

@implementation FJRecordViewController

#pragma mark - 懒加载
- (AVAudioRecorder *)recorder {
    if (!_recorder) {
        // 创建录音文件保存路径
        NSURL *url = [self getSavePath];
        
        // 设置录音格式
        NSDictionary *setting = [self getAudioSetting];
        
        // 创建录音对象
        _recorder = [[AVAudioRecorder alloc] initWithURL:url settings:setting error:nil];
        _recorder.delegate = self;
        
        // 监听声波
        _recorder.meteringEnabled = YES;
    }
    return _recorder;
}

- (AVAudioPlayer *)player {
    if (!_player) {
        NSURL *url = [self getSavePath];
        _player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        _player.numberOfLoops = 0;
        [_player prepareToPlay];
    }
    return _player;
}

- (NSTimer *)timer {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(audioPowerChange) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setAudioSession];
    
}

- (void)setAudioSession {
    AVAudioSession *session = [AVAudioSession sharedInstance];
    // 设置为播放录音状态
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    [session setActive:YES error:nil];
}

- (NSURL *)getSavePath {
    NSString *urlStr = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    urlStr = [urlStr stringByAppendingPathComponent:FJRecordAudioFile];
    NSLog(@"%@", urlStr);
    NSURL *url = [NSURL fileURLWithPath:urlStr];
    return url;
}

- (NSDictionary *)getAudioSetting {
    NSMutableDictionary *dicM = [NSMutableDictionary dictionary];
    
    // 设置录音格式
    [dicM setObject:@(kAudioFormatLinearPCM) forKey:AVFormatIDKey];
    
    // 设置录音采样率
    [dicM setObject:@(8000) forKey:AVSampleRateKey];
    
    // 设置通道,这里采用单声道
    [dicM setObject:@(0) forKey:AVNumberOfChannelsKey];
    
    // 每个采样点位数  8 - 16 - 24 - 32
    [dicM setObject:@(8) forKey:AVLinearPCMBitDepthKey];
    
    // 采用浮点数采样
    [dicM setObject:@(YES) forKey:AVLinearPCMIsFloatKey];
    
    return dicM;
}

- (void)audioPowerChange {
    
    // 更新测试量
    [self.recorder updateMeters];
    
    // 取得第一个通道的音频  音频强度 -160 ~ 0
    float power = [self.recorder averagePowerForChannel:0];
    
    CGFloat progress = (1 / 160.0) * (power + 160);
    [self.audioPower setProgress:progress];
}

- (IBAction)recordClick:(id)sender {
    if (![self.recorder isRecording]) {
        [self.recorder record];
        self.timer.fireDate = [NSDate distantPast];
    }
}

- (IBAction)pauseClick {
    if ([self.recorder isRecording]) {
        [self.recorder pause];
        self.timer.fireDate = [NSDate distantFuture];
    }
}

- (IBAction)resumeClick:(id)sender {
    [self recordClick:sender];
}

- (IBAction)stopClick {
    [self.recorder stop];
    self.timer.fireDate = [NSDate distantFuture];
    self.audioPower.progress = 0;
}

#pragma mark - AVAudioRecorderDelegate
- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag {
    if (![self.player isPlaying]) {
        [self.player play];
    }
    NSLog(@"录音完成");
}

@end
