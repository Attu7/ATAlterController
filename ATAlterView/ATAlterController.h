//
//  ATAlterController.h
//  ATAlterController
//
//  Created by Attu on 16/9/13.
//  Copyright © 2016年 Attu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ATAlterController;

@protocol ATAlterDelegate <NSObject>

- (void)alterController:(ATAlterController *)alterController clickedButtonAtIndex:(NSInteger)buttonIndex;

@end

@interface ATAlterController : UIViewController

@property (nonatomic, assign) id<ATAlterDelegate>delegate;

@property (nonatomic, strong) NSString *alterTitle;

@property (nonatomic, strong) NSArray *alterActions;

@end
