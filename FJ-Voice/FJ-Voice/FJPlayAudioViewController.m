//
//  FJPlayAudioViewController.m
//  FJ-Voice
//
//  Created by  高帆 on 16/6/2.
//  Copyright © 2016年 GF. All rights reserved.
//

#import "FJPlayAudioViewController.h"
#import "FJAudioTool.h"

@interface FJPlayAudioViewController ()

@end

@implementation FJPlayAudioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)doNot {
    [FJAudioTool playSoundWithSoundName:@"buyao.wav"];
}

- (IBAction)smallJoker {
    [FJAudioTool playSoundWithSoundName:@"m_16.wav"];
}

- (IBAction)bigJoker {
    [FJAudioTool playSoundWithSoundName:@"m_17.wav"];
}

@end
