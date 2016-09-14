//
//  ViewController.m
//  ATAlterController
//
//  Created by Attu on 16/9/13.
//  Copyright © 2016年 Attu. All rights reserved.
//

#import "ViewController.h"
#import "ATAlterView/ATAlterController.h"

@interface ViewController ()<ATAlterDelegate>

@property (nonatomic, strong) ATAlterController *alterController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"disapper");
}

- (IBAction)onClickShow:(UIButton *)sender {
    self.alterController = [[ATAlterController alloc] init];
    self.alterController.alterActions = @[@"简单", @"选择器", @"退出动画", @"利用"];
    self.alterController.delegate = self;
    [self presentViewController:self.alterController animated:YES completion:nil];
}

- (void)alterController:(ATAlterController *)alterController clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"%ld", (long)buttonIndex);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
