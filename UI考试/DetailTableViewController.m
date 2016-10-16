//
//  DetailTableViewController.m
//  UI考试
//
//  Created by tony on 16/1/4.
//  Copyright © 2016年 tony. All rights reserved.
//

#import "DetailTableViewController.h"
#import "DetailTableViewCell.h"
#import "SignatrueEncryption.h"
#import "Categories.h"
#import "GetRequest.h"
#import "ListTableViewController.h"
#import <AFNetworking.h>
#import "DataBaseManager.h"

@interface DetailTableViewController ()

@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation DetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.string ==nil) {
        self.string =@"生活家居";
    }
    
    if (self.cate == nil) {
        self.cate = @"购物";
    }
    self.navigationItem.title =self.string;
    
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"分类切换" style:(UIBarButtonItemStyleDone) target:self action:@selector(listAction:)];
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"刷新" style:(UIBarButtonItemStyleDone) target:self action:@selector(update:)];
    
    NSDictionary *dict = [[DataBaseManager shareDataBase]queryDataModleWithString:self.cate];
    NSArray *array = dict[self.cate];
    self.dataArray = [[NSMutableArray alloc]init];
    if (array.count != 0) {
        for (NSDictionary *dict in array) {
            if ([self.string isEqualToString:dict[@"categories"]]) {
                Categories *cate = [[Categories alloc]init];
                cate.title = dict[@"title"];
                cate.commodityDescription = dict[@"description"];
                cate.s_image_url = dict[@"pictUrl"];
                [self.dataArray addObject:cate];
            }
        }
    }else{
     [[DataBaseManager shareDataBase]creatTableWithString:self.cate];
     [self makeData];
    }
}


//解析加密数据
-(void)makeData{
    
    NSDictionary *dic = @{@"city":@"北京",@"category":self.string,@"limit":@"30",@"page":@"1"};
    //SHA1加密
    NSMutableDictionary *encryptionDic = [SignatrueEncryption encryptedParamsWithBaseParams:dic];
    //将字符串中的汉字转成UTF8
    NSString *city = [encryptionDic[@"city"] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet symbolCharacterSet]];
    NSString *category = [encryptionDic[@"category"] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *sign = [encryptionDic[@"sign"] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet controlCharacterSet]];
    //初始化数组
    self.dataArray = [NSMutableArray array];
    //解析数据
    //拼接
    NSString *str =[NSString stringWithFormat:@"http://api.dianping.com/v1/deal/find_deals?appkey=42960815&sign=%@&city=%@&category=%@&limit=30&page=1",sign,city,category];
//    NSLog(@"%@",str);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:str parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *array =[NSArray array];
        array =responseObject[@"deals"];
        for (NSDictionary *dict in array) {
            Categories *cate =[Categories new];
            [cate setValuesForKeysWithDictionary:dict];
            [self.dataArray addObject:cate];
             [[DataBaseManager shareDataBase]insertDataWithString:self.cate andCategories:self.string andModle:cate];
        }
        [self.tableView reloadData];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}


-(void)listAction:(UIBarButtonItem *)sender{

    ListTableViewController *list =[[ListTableViewController alloc]init];
    [self.navigationController pushViewController:list animated:YES];
}


-(void)update:(UIBarButtonItem *)sender{

    NSDictionary *dict = [[DataBaseManager shareDataBase]queryDataModleWithString:self.cate];
    NSArray *array = dict[self.cate];
    self.dataArray = [[NSMutableArray alloc]init];
    if (array.count != 0) {
        for (NSDictionary *dict in array) {
            if ([self.string isEqualToString:dict[@"categories"]]) {
                Categories *cate = [[Categories alloc]init];
                cate.title = dict[@"title"];
                cate.commodityDescription = dict[@"description"];
                cate.s_image_url = dict[@"pictUrl"];
                [self.dataArray addObject:cate];
            }
        }
    }else{
        [[DataBaseManager shareDataBase]creatTableWithString:self.cate];
        [self makeData];
    }

}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" ];
    if (cell==nil) {
        cell =[[DetailTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    Categories *cate =self.dataArray[indexPath.row];
    [cell configureCellWithModel:cate];
    return cell;
}


//设置cell自适应高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return [self tableView:tableView cellForRowAtIndexPath:indexPath].frame.size.height;
}


@end
