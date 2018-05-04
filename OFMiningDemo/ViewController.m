//
//  ViewController.m
//  OFMiningDemo
//
//  Created by xiepengxiang on 2018/5/4.
//  Copyright © 2018年 OFBank. All rights reserved.
//

#import "ViewController.h"
#import <OFMiningSDK/OFMiningSDK.h>

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArr;

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *userPwd;

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UITextView *logTextView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tableView.tableHeaderView = self.logTextView;
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.textField];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = [self.dataArr objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.userName = @"testUserName";
    self.userPwd = @"testUserPwd";
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        // 注册
        if (self.userName.length < 1) {
            self.textField.placeholder = @"请输入用户名";
            [self.textField setHidden:NO];
            [self.textField becomeFirstResponder];
            return;
        }
        if (self.userPwd.length < 1) {
            self.textField.placeholder = @"请输入密码";
            [self.textField setHidden:NO];
            [self.textField becomeFirstResponder];
            return;
        }
        
        [OFMiningSDK registerWithAccount:self.userName password:self.userPwd success:^(NSURLSessionDataTask *task, id  _Nullable responseObject) {
            NSLog(@"%@",responseObject);
            [self addLog:responseObject];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
            NSLog(@"%@",error);
            [self addLog:error];
        }];
    }else if(indexPath.row == 1) {
        // 登录
        if (self.userName.length < 1) {
            self.textField.placeholder = @"请输入用户名";
            [self.textField setHidden:NO];
            [self.textField becomeFirstResponder];
            return;
        }
        if (self.userPwd.length < 1) {
            self.textField.placeholder = @"请输入密码";
            [self.textField setHidden:NO];
            [self.textField becomeFirstResponder];
            return;
        }
        [OFMiningSDK loginWithAccount:self.userName password:self.userPwd tokenExpireTime:@"3600" success:^(NSURLSessionDataTask *task, id  _Nullable responseObject) {
            NSLog(@"%@",responseObject);
            [self addLog:responseObject];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
            NSLog(@"%@",error);
            [self addLog:error];
        }];
    }else if(indexPath.row == 2) {
        // 挖矿收益记录
        [OFMiningSDK getRewardsListWithPage:nil count:nil success:^(NSURLSessionDataTask *task, id  _Nullable responseObject) {
            NSLog(@"%@",responseObject);
            [self addLog:responseObject];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
            NSLog(@"%@",error);
            [self addLog:error];
        }];
    }else if(indexPath.row == 3) {
        // 交易记录
        [OFMiningSDK getDrawTransactionWithPage:nil count:nil success:^(NSURLSessionDataTask *task, id  _Nullable responseObject) {
            NSLog(@"%@",responseObject);
            [self addLog:responseObject];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
            NSLog(@"%@",error);
            [self addLog:error];
        }];
    }else if(indexPath.row == 4) {
        // 开始挖矿
        [OFMiningSDK startMining];
    }else if(indexPath.row == 5) {
        // 提现
        NSString *address = @"0x000009009c4a4544d408570f6e85a56f5edc99af5ed80afc94";
        NSString *coinNum = @"1";
        [OFMiningSDK withdrawCashWithWalletAddress:address coinNum:coinNum success:^(NSURLSessionDataTask *task, id  _Nullable responseObject) {
            NSLog(@"%@",responseObject);
            [self addLog:responseObject];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
            NSLog(@"%@",error);
            [self addLog:error];
        }];
    }else if(indexPath.row == 6) {
        // 提现记录
        [OFMiningSDK getDrawTransactionWithPage:@"1" count:@"10" success:^(NSURLSessionDataTask *task, id  _Nullable responseObject) {
            NSLog(@"%@",responseObject);
            [self addLog:responseObject];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
            NSLog(@"%@",error);
            [self addLog:error];
        }];
    }
}

#pragma mark - TextField
- (void)addLog:(id)obj
{
    self.logTextView.text = [NSString stringWithFormat:@"%@\n\n%@",self.logTextView.text, obj];
    NSRange range;
    range.location = [self.logTextView.text length] - 1;
    range.length = 0;
    [self.logTextView scrollRangeToVisible:range];
}

- (void)resignResponser
{
    [self.textField resignFirstResponder];
    self.textField.hidden = YES;
    if (self.userName.length < 1) {
        self.userName = self.textField.text;
    }else if (self.userPwd.length < 1) {
        self.userPwd = self.textField.text;
    }
    self.textField.text = @"";
}

#pragma mark - lazy load
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

- (NSArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = @[@"注册",
                     @"登录",
                     @"挖矿收益记录",
                     @"交易记录",
                     @"开始挖矿",
                     @"提现",
                     @"提现记录"];
    }
    return _dataArr;
}

- (UITextField *)textField
{
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 150, self.view.bounds.size.width - 40, 50)];
        _textField.backgroundColor = [UIColor lightGrayColor];
        _textField.hidden = YES;
        [_textField addTarget:self action:@selector(resignResponser) forControlEvents:UIControlEventEditingDidEndOnExit];
    }
    return _textField;
}

- (UITextView *)logTextView
{
    if (!_logTextView) {
        _logTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
    }
    return _logTextView;
}

@end
