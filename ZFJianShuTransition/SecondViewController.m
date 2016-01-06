//
//  SecondViewController.m
//  ZFJianShuTransition
//
//  Created by macOne on 16/1/5.
//  Copyright © 2016年 WZF. All rights reserved.
//

#import "SecondViewController.h"
#import "CustomPresentAnimationCotroller.h"
#import "ViewController.h"

@interface SecondViewController ()<UITableViewDelegate,UITableViewDataSource>


@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizer:)];
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];
    
//    self.view.opaque = YES;
    UITableView *tableView = [UITableView new];
    tableView.frame = CGRectMake(0, self.view.bounds.size.height - 400, self.view.bounds.size.width, 400);
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];

}

-(void)tapGestureRecognizer:(UITapGestureRecognizer *)recognizer{
    

    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark -UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}

#pragma mark -UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"cellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:13.0f];
    cell.textLabel.text = @"这是一条测试";
    return cell;
    
}
@end
