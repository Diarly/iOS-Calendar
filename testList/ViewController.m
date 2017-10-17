//
//  ViewController.m
//  testList
//
//  Created by hiten on 2017/9/25.
//  Copyright © 2017年 hiten. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *listTableView;
@property (strong, nonatomic) NSArray *list;

@end

@implementation ViewController

@synthesize listTableView;
@synthesize list;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"列表展示";
    listTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    listTableView.delegate = self;
    listTableView.dataSource = self;
    [self.view addSubview:listTableView];
    
    list = @[@{@"title":@"日历",@"class":@"CustomerCalendarViewController"}];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return list.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 55.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    NSDictionary *info = list[indexPath.row];
    cell.textLabel.text = info[@"title"];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *info = list[indexPath.row];
    NSString *classStr = info[@"class"];
    Class class = NSClassFromString(classStr);
    id object = [[class alloc] init];
    [self.navigationController pushViewController:object animated:YES];
    
}


@end
