//
//  FJPlayMusicViewController.m
//  FJ-Voice
//
//  Created by  高帆 on 16/6/2.
//  Copyright © 2016年 GF. All rights reserved.
//

#import "FJPlayMusicViewController.h"
#import "FJAudioTool.h"

@interface FJPlayMusicViewController ()

@end

@implementation FJPlayMusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)play {
    [FJAudioTool playMusicWithFileName:@"14945107.mp3"];
}

- (IBAction)pause {
    [FJAudioTool pauseMusicWithFileName:@"14945107.mp3"];
}

- (IBAction)stop {
    [FJAudioTool stopMusicWithFileName:@"14945107.mp3"];
}

@end
