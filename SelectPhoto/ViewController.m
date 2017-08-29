//
//  ViewController.m
//  SelectPhoto
//
//  Created by 吉祥 on 2017/8/29.
//  Copyright © 2017年 jixiang. All rights reserved.
//

#import "ViewController.h"
#import "SelectPhotoManager.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (nonatomic, strong)SelectPhotoManager *photoManager;
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setHead];
}
//头像点击事件
-(void)tapClick:(UITapGestureRecognizer *)recognizer{
    
    if (!_photoManager) {
        _photoManager =[[SelectPhotoManager alloc]init];
    }
    [_photoManager startSelectPhotoWithImageName:@"选择头像"];
    __weak typeof(self)mySelf=self;
    //选取照片成功
    _photoManager.successHandle=^(SelectPhotoManager *manager,UIImage *image){
        
        mySelf.headerImage.image = image;
        //保存到本地
        NSData *data = UIImagePNGRepresentation(image);
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"headerImage"];
    };
}

-(void)setHead{
    _headerImage.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [_headerImage addGestureRecognizer:tap];
    //这里是从本地取的，如果是上线项目一定要从服务器取头像地址加载
    UIImage *img = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"headerImage"]];
    if (img) {
        _headerImage.image = img;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
