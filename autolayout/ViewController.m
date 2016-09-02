//
//  ViewController.m
//  autolayout
//
//  Created by danal on 8/26/16.
//  Copyright © 2016 danal. All rights reserved.
//

#import "ViewController.h"
#import "DLAutoLayout.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)dealloc{
    NSLog(@"%s",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    btn1.backgroundColor = [UIColor redColor];


    
    //设置btn1相对父视图布局，left=20,top=100,其中top优先秀为700
    btn1
    .dl_reset                   //清除旧的约束
    .dl_begin(self.view, nil)   //调用begin开始,参数parent为父视图，参数toView为同级参考视图, 无则为nil
    .left(20)                   //与父视图left距离，参数constant为公式中的常量值:v1.attr=v2.attr*multiplier+constant
    .top(100)                   //同left
    .priority(700)              //设置最近一个约束的priority，类似的属性还有relation
    .dl_end();                  //调用end结束布局
    
    //设置box1相对btn1布局，与btn1左对齐，top距离btn1底部=10，width=200,height=100
    box1.
    dl_reset
    .dl_begin(self.view, btn1)
    .alignLeft(0)               //与btn1从对齐
    .top(10)                    //距离btn1底部10
    .width(200)                 //宽度
    .height(100)                //高度
    .dl_end();
    
    //设置btn2相对于父视图布局，top=10,width=60,距离右侧=10(即right=btn2.right-10)
    btn2
    .dl_reset
    .dl_begin(box1, nil)
    .top(10)
    .width(60)
    .right(-10)                 //父视图右侧距离10
    .dl_end();
    
    //设置btn3相对于btn2布局
    btn3
    .dl_reset
    .dl_begin(box1, btn2)
    .right(-10)         //距离btn2左侧距离10
    .width(0)
    .multiplier(2)      //宽为btn2的宽x2+0
    .alignCenterY(0)    //与btn2垂直对齐
    .dl_end();
    

    //创建一个label，使它位于box1下方10距离，距离父视图两边均为10距离
    UILabel *lbl = [[MYView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    lbl.numberOfLines = 0;
    [self.view addSubview:lbl];
    lbl.text = @"*DLAutoLayout总是以一个参照视图来进行布局，使用dl_begin来设置参照视图(toView)  \
    * 若toView为nil,则参照视图为父视图(parent) \
    * 所有属性与NSLayoutConstraint类基本相同  \
    * 若其中有属性与其它类冲突，可在属性前添加dl_前缀";
    lbl.translatesAutoresizingMaskIntoConstraints = NO;

    lbl
    .dl_reset
    .dl_begin(self.view, nil)
    .left(10)
    .right(-10)
    .relation(NSLayoutRelationLessThanOrEqual)
    .dl_end();

    lbl.
    dl_begin(self.view, box1)
    .top(10)
    .dl_end();
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end


@implementation MYView

- (void)dealloc{
    id o = [self dl_constraintInfo];
    NSLog(@"~~~~~%s %@",__func__, o);
}

@end