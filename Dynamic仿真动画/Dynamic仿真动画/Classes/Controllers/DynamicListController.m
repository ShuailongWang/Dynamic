//
//  DynamicListController.m
//  Dynamic仿真动画
//
//  Created by czbk on 16/6/27.
//  Copyright © 2016年 王帅龙. All rights reserved.
//

#import "DynamicListController.h"
#import "BasicController.h"


@interface DynamicListController ()

@property (strong,nonatomic) NSArray *dynamicList;

@end

@implementation DynamicListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //隐藏多余的cel,把脚部视图占用就行了
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    //设置标题
    self.navigationItem.title = @"仿真行为";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //选择取消
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //NSLog(@"%zd",indexPath.row);

    //创建控制器
    BasicController *basicVC = [[BasicController alloc]init];
    
    //设置标题
    basicVC.navigationItem.title = self.dynamicList[indexPath.row][@"title"];
    
    //把选择的索引传递过去
    basicVC.basicIndex = (int)indexPath.row;
    
    //跳转
    [self.navigationController pushViewController:basicVC animated:YES];

}

#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dynamicList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseIdentifier"];
    }
    
    cell.textLabel.text = self.dynamicList[indexPath.row][@"title"];
    
    return cell;
}


#pragma mark -懒加载
-(NSArray *)dynamicList{
    if(_dynamicList == nil){
        _dynamicList = @[
                         @{@"title":@"吸附行为"},
                         @{@"title":@"推动行为"},
                         @{@"title":@"刚性附着行为"},
                         @{@"title":@"弹性附着行为"},
                         @{@"title":@"碰撞检测行为"},
                         ];
    }
    return _dynamicList;
}

@end
