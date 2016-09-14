//
//  ATAlterController.m
//  ATAlterController
//
//  Created by Attu on 16/9/13.
//  Copyright © 2016年 Attu. All rights reserved.
//

#import "ATAlterController.h"

#define AT_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define AT_CELL_HEIGHT 49.0f
#define AT_MAX_HEIGHT 6 * AT_CELL_HEIGHT + 8.0f

@interface ATAlterController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIControl *bgView;
@property (nonatomic, strong) UIView *alterBgView;

@property (nonatomic, strong) NSLayoutConstraint *constraint_Bottom_alterBgView;
@property (nonatomic, strong) NSLayoutConstraint *constraint_Height_alterBgView;

@property (nonatomic, assign) CGFloat currentHeight;
@property (nonatomic, assign) CGFloat maxHeight;

@end

@implementation ATAlterController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        self.view.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.bgView];
    [self.view addSubview:self.alterBgView];
    [self.alterBgView addSubview:self.headerView];
    [self.alterBgView addSubview:self.tableView];
    [self.alterBgView addSubview:self.cancelButton];

    NSArray *constraint_V_bgView = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_bgView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_bgView)];
    NSArray *constraint_H_bgView = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_bgView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_bgView)];
    [self.view addConstraints:constraint_H_bgView];
    [self.view addConstraints:constraint_V_bgView];
    
    self.constraint_Bottom_alterBgView = [NSLayoutConstraint constraintWithItem:self.alterBgView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:AT_MAX_HEIGHT];
    self.constraint_Height_alterBgView = [NSLayoutConstraint constraintWithItem:self.alterBgView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:AT_MAX_HEIGHT];
    NSArray *constraint_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_alterBgView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_alterBgView)];
    
    [self.view addConstraint:self.constraint_Bottom_alterBgView];
    [self.view addConstraint:self.constraint_Height_alterBgView];
    [self.view addConstraints:constraint_H];
    
    NSArray *constraint_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_headerView(==height)]-1-[_tableView]-8.0-[_cancelButton(==height)]-0-|" options:0 metrics:@{@"height":[NSNumber numberWithInteger:AT_CELL_HEIGHT]} views:NSDictionaryOfVariableBindings(_headerView, _tableView, _cancelButton)];
    NSArray *constraint_H_headerView = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_headerView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_headerView)];
    NSArray *constraint_H_tableView = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_tableView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_tableView)];
    NSArray *constraint_H_cancelButton = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_cancelButton]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_cancelButton)];
    [self.alterBgView addConstraints:constraint_V];
    [self.alterBgView addConstraints:constraint_H_headerView];
    [self.alterBgView addConstraints:constraint_H_tableView];
    [self.alterBgView addConstraints:constraint_H_cancelButton];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.1f animations:^{
        weakSelf.bgView.backgroundColor = [UIColor colorWithRed:20/255.0f green:20/255.0f blue:20/255.0f alpha:0.5f];
    }];
    self.constraint_Bottom_alterBgView.constant = 0;
    [UIView animateWithDuration:0.33f animations:^{
        [weakSelf.view layoutIfNeeded];
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.alterActions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.text = [self.alterActions objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return AT_CELL_HEIGHT;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_delegate) {
        [self.delegate alterController:self clickedButtonAtIndex:indexPath.row];
        [self onClose];
    }
}

#pragma mark - Events

- (void)onClose {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.1f animations:^{
        weakSelf.bgView.backgroundColor = [UIColor colorWithRed:20/255.0f green:20/255.0f blue:20/255.0f alpha:0.0f];
    }];
    self.constraint_Bottom_alterBgView.constant = AT_MAX_HEIGHT;
    [UIView animateWithDuration:0.33f animations:^{
        [weakSelf.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
}

#pragma mark - setter

- (void)setAlterTitle:(NSString *)alterTitle {
    _alterTitle = alterTitle;
    self.titleLabel.text = alterTitle;
}

- (void)setAlterActions:(NSArray *)alterActions {
    _alterActions = alterActions;
    self.currentHeight = ([alterActions count] + 2) * AT_CELL_HEIGHT + 8.0f;
    if (self.currentHeight > AT_MAX_HEIGHT) {
        self.currentHeight = AT_MAX_HEIGHT;
        [self.tableView setScrollEnabled:YES];
    }
    self.constraint_Height_alterBgView.constant = self.currentHeight;
}

#pragma mark - Init Views

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.scrollEnabled = NO;
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
        [_tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    return _tableView;
}

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] init];
        [_headerView setBackgroundColor:[UIColor whiteColor]];
        [_headerView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_headerView addSubview:self.titleLabel];
        NSArray *constraint_V_titleLabel = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_titleLabel]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_titleLabel)];
        NSArray *constraint_H_titleLabel = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[_titleLabel]-30-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_titleLabel)];
        [_headerView addConstraints:constraint_H_titleLabel];
        [_headerView addConstraints:constraint_V_titleLabel];
    }
    return _headerView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setTextColor:[UIColor colorWithRed:80/255.0f green:80/255.0f blue:80/255.0f alpha:1.0f]];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_titleLabel setFont:[UIFont systemFontOfSize:14]];
        _titleLabel.numberOfLines = 0;
        _titleLabel.text = @"提示";
        [_titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    return _titleLabel;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.backgroundColor = [UIColor whiteColor];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(onClose) forControlEvents:UIControlEventTouchUpInside];
        [_cancelButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    return _cancelButton;
}

- (UIView *)alterBgView {
    if (!_alterBgView) {
        _alterBgView = [[UIView alloc] init];
        _alterBgView.backgroundColor = [UIColor colorWithRed:230/255.0f green:230/255.0f blue:230/255.0f alpha:1.0f];
        [_alterBgView setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    return _alterBgView;
}

- (UIControl *)bgView {
    if (!_bgView) {
        _bgView = [[UIControl alloc] init];
        _bgView.backgroundColor = [UIColor clearColor];
        [_bgView addTarget:self action:@selector(onClose) forControlEvents:UIControlEventTouchUpInside];
        [_bgView setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    return _bgView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
