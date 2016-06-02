//
//  FJRecordViewController.m
//  FJ-Voice
//
//  Created by  高帆 on 16/6/2.
//  Copyright © 2016年 GF. All rights reserved.
//

#import "FJRecordViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface FJRecordViewController ()

/**
 *  录音对象
 */
@property (nonatomic, strong) AVAudioRecorder *recorder;

@end

@implementation FJRecordViewController

#pragma mark - 懒加载
- (AVAudioRecorder *)recorder {
    if (!_recorder) {
        // 创建沙盒路径
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        
        // 拼接音频文件
        NSString *filePath = [path stringByAppendingPathComponent:@"123.caf"];
        
        // 转化成url file://
        NSURL *url = [NSURL fileURLWithPath:filePath];
        
        // 设置录音的参数
        NSDictionary *settingRecorder = @{
                                          AVEncoderAudioQualityKey : [NSNumber numberWithInteger:AVAudioQualityLow],
                                          AVEncoderBitRateKey : [NSNumber numberWithInteger:16],
                                          AVSampleRateKey : [NSNumber numberWithFloat:8000],
                                          AVNumberOfChannelsKey : [NSNumber numberWithInteger:2]
                                          };
        
        // 创建录音对象
        self.recorder = [[AVAudioRecorder alloc] initWithURL:url settings:settingRecorder error:nil];
    }
    return _recorder;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)star {
    // 开始录音
    [self.recorder record];
}

- (IBAction)stop {
    // 停止录音
    [self.recorder stop];
}

- (IBAction)play {
    NSLog(@"%@", NSHomeDirectory());
}

@end
