//
//  ListTableViewController.m
//  UI考试
//
//  Created by tony on 16/1/4.
//  Copyright © 2016年 tony. All rights reserved.
//

#import "ListTableViewController.h"
#import "GDataXMLNode.h"
#import "DetailTableViewController.h"


@interface ListTableViewController ()

@property (nonatomic,strong)NSMutableDictionary *dataDic;
@property (nonatomic,strong)NSMutableArray *keyArray;
@property (nonatomic,strong)NSString *currentElement;

@end

@implementation ListTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationItem.title =@"所有分类";
    self.tableView.separatorStyle=NO;
    [self makeData];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}


-(void)makeData{

    self.dataDic = [NSMutableDictionary dictionaryWithCapacity:10];
    
    //存KEY
    self.keyArray = [NSMutableArray arrayWithCapacity:10];
    NSString *path =[[NSBundle mainBundle]pathForResource:@"Categories" ofType:@"xml"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    //    NSLog(@"%@",data);
    //XML解析
    NSError *error;
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithData:data options:0 error:&error];
    
    //根节点
    GDataXMLElement *rootElment = document.rootElement;
    
    //遍历子节点
    
    for (GDataXMLElement *subElement in rootElment.children) {
        if ([subElement.name isEqualToString:@"categories"]) {
            NSMutableArray *array = [NSMutableArray arrayWithCapacity:10];
            for (GDataXMLElement *element in subElement.children) {
                if ([element.name isEqualToString:@"category_name"]) {
                    [_keyArray addObject:element.stringValue];
                }else{
                    
                    [array addObject:element.stringValue];
                }
            }
            [_dataDic setObject:array forKey:_keyArray.lastObject];
        }
    }
  }


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return _keyArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [_dataDic[_keyArray[section]] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = _dataDic[_keyArray[indexPath.section]][indexPath.row];
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 50;
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

 return _keyArray[section];
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

   DetailTableViewController *dvc = [[DetailTableViewController alloc] init];
    //将相应的row中的元素传值过去
    dvc.string = _dataDic[_keyArray[indexPath.section]][indexPath.row];
    dvc.cate = self.keyArray[indexPath.section];
    [self showViewController:dvc sender:nil];
}


@end
