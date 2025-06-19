//
//  ViewController+OpenVC.m
//  OpenVC+tesseract
//
//  Created by home on 2017/12/27.
//  Copyright © 2017年 toad. All rights reserved.
//

#import "ViewController+OpenVC.h"
//#include <opencv2/opencv.hpp>
#include <opencv2/opencv.hpp>
#include <opencv2/imgproc/types_c.h>
#include <opencv2/imgcodecs/ios.h>

// OSTU算法求出阈值
int  Otsu(unsigned char* pGrayImg , int iWidth , int iHeight)
{
    if((pGrayImg==0)||(iWidth<=0)||(iHeight<=0))return -1;
    int ihist[256];
    int thresholdValue=0; // „–÷µ
    int n, n1, n2 ;
    double m1, m2, sum, csum, fmax, sb;
    int i,j,k;
    memset(ihist, 0, sizeof(ihist));
    n=iHeight*iWidth;
    sum = csum = 0.0;
    fmax = -1.0;
    n1 = 0;
    for(i=0; i < iHeight; i++)
    {
        for(j=0; j < iWidth; j++)
        {
            ihist[*pGrayImg]++;
            pGrayImg++;
        }
    }
    pGrayImg -= n;
    for (k=0; k <= 255; k++)
    {
        sum += (double) k * (double) ihist[k];
    }
    for (k=0; k <=255; k++)
    {
        n1 += ihist[k];
        if(n1==0)continue;
        n2 = n - n1;
        if(n2==0)break;
        csum += (double)k *ihist[k];
        m1 = csum/n1;
        m2 = (sum-csum)/n2;
        sb = (double) n1 *(double) n2 *(m1 - m2) * (m1 - m2);
        if (sb > fmax)
        {
            fmax = sb;
            thresholdValue = k;
        }
    }
    return(thresholdValue);
}

cv::Mat AdaptiveThereshold(cv::Mat src,cv::Mat dst)
{
    cvtColor(src,dst,CV_BGR2GRAY);
    int x1, y1, x2, y2;
    int count=0;
    long long sum=0;
    int S=src.rows>>3;  //划分区域的大小S*S
    int T=15;         /*百分比，用来最后与阈值的比较。原文：If the value of the current pixel is t percent less than this average
                       then it is set to black, otherwise it is set to white.*/
    int W=dst.cols;
    int H=dst.rows;
    long long **Argv;
    Argv=new long long*[dst.rows];
    for(int ii=0;ii<dst.rows;ii++)
    {
        Argv[ii]=new long long[dst.cols];
    }
    
    for(int i=0;i<W;i++)
    {
        sum=0;
        for(int j=0;j<H;j++)
        {
            sum+=dst.at<uchar>(j,i);
            if(i==0)
                Argv[j][i]=sum;
            else
                Argv[j][i]=Argv[j][i-1]+sum;
        }
    }
    
    for(int i=0;i<W;i++)
    {
        for(int j=0;j<H;j++)
        {
            x1=i-S/2;
            x2=i+S/2;
            y1=j-S/2;
            y2=j+S/2;
            if(x1<0)
                x1=0;
            if(x2>=W)
                x2=W-1;
            if(y1<0)
                y1=0;
            if(y2>=H)
                y2=H-1;
            count=(x2-x1)*(y2-y1);
            sum=Argv[y2][x2]-Argv[y1][x2]-Argv[y2][x1]+Argv[y1][x1];
            
            
            if((long long)(dst.at<uchar>(j,i)*count)<(long long)sum*(100-T)/100)
                dst.at<uchar>(j,i)=0;
            else
                dst.at<uchar>(j,i)=255;
        }
    }
    for (int i = 0 ; i < dst.rows; ++i)
    {
        delete [] Argv[i];
    }
    delete [] Argv;
    return dst;
}

@interface ViewController_OpenVC ()
@property (nonatomic,assign)NSInteger indxe;
@end

@implementation ViewController_OpenVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *image = [UIImage imageNamed:@"idc.jpg"];
    // 图片转换
    cv::Mat resultImage;
    UIImageToMat(image, resultImage);
    
    [self.imsss setImage:MatToUIImage(resultImage)];
    // Do any additional setup after loading the view.
}
- (UIImage *) openVC1Image:(UIImage *)image{
    cv::Mat cvImage;
    UIImageToMat(image, cvImage);
    cv::Mat gray;
    // 将图像转换为灰度显示
    cv::cvtColor(cvImage,gray,CV_RGB2GRAY);
    // 应用高斯滤波器去除小的边缘
    cv::GaussianBlur(gray, gray, cv::Size(5,5), 1.2,1.2);
    // 计算与画布边缘
    cv::Mat edges;
    cv::Canny(gray, edges, 0, 50);
    // 使用白色填充
    cvImage.setTo(cv::Scalar::all(225));
    // 修改边缘颜色
    cvImage.setTo(cv::Scalar(0,128,255,255),edges);
    // 将Mat转换为Xcode的UIImageView显示
    return MatToUIImage(cvImage);
}

- (UIImage *) openVC2Image:(UIImage *)image{
    cv::Mat resultImage;
    UIImageToMat(image, resultImage);
    //先用使用 3x3内核来降噪
    blur( resultImage, resultImage, cv::Size(3,3),cv::Point(-1,-1));
    //return MatToUIImage(resultImage);
    //积分阈值二值化
    resultImage =AdaptiveThereshold(resultImage, resultImage);
    //腐蚀，填充（腐蚀是让黑色点变大）
    cv::Mat erodeElement = getStructuringElement(cv::MORPH_RECT, cv::Size(22,22));
    cv::erode(resultImage, resultImage, erodeElement);
    //轮廊检测
    std::vector<std::vector<cv::Point>> contours;//定义一个容器来存储所有检测到的轮廊
    cv::findContours(resultImage, contours, CV_RETR_TREE, CV_CHAIN_APPROX_SIMPLE, cvPoint(0, 0));
    //cv::drawContours(resultImage, contours, -1, cv::Scalar(255),4);
    //取出身份证号码区域
    std::vector<cv::Rect> rects;
    cv::Rect NameNumberRect = cv::Rect(0,0,0,0);
    cv::Rect CardNumberRect = cv::Rect(0,0,0,0);
    std::vector<std::vector<cv::Point>>::const_iterator itContours = contours.begin();
    for ( ; itContours != contours.end(); ++itContours) {
        cv::Rect rect = cv::boundingRect(*itContours);
        rects.push_back(rect);
        //算法原理
        if (rect.width > CardNumberRect.width && rect.width > rect.height * 6) {
            CardNumberRect = rect;
        }
        if (rect.x > 100 && rect.y<100 && rect.height < rect.width) {
            NameNumberRect = rect;
        }
    }
    
    
    //定位成功成功，去原图截取身份证号码区域，并转换成灰度图、进行二值化处理
    //去原图截取身份证姓名区域，并转换成灰度图、进行二值化处理
    cv::Mat matImage;
    UIImageToMat(image, matImage);
    cv::Mat NameImageMat;
    NameImageMat = matImage(NameNumberRect);
    IplImage grey = NameImageMat;
    unsigned char* dataImage = (unsigned char*)grey.imageData;
    int threshold = Otsu(dataImage, grey.width, grey.height);
    printf("阈值：%d\n",threshold);
    NameImageMat =AdaptiveThereshold(NameImageMat, NameImageMat);
    UIImage *NameImage = MatToUIImage(NameImageMat);
    
    cv::Mat CardImageMat;
    CardImageMat = matImage(CardNumberRect);
    CardImageMat =AdaptiveThereshold(CardImageMat, CardImageMat);
    UIImage *CardImage = MatToUIImage(CardImageMat);
    return CardImage;
}

- (IBAction)nnn:(id)sender {
    self.imsss.image = [self openVC2Image:self.imsss.image];
//
//    cv::Mat cvImage;
//    UIImageToMat(self.imsss.image, cvImage);
//    cv::Mat gray;
//    // 将图像转换为灰度显示
//    cv::cvtColor(cvImage,gray,CV_RGB2GRAY);
//    // 应用高斯滤波器去除小的边缘
//    cv::GaussianBlur(gray, gray, cv::Size(5,5), 1.2,1.2);
//    // 计算与画布边缘
//    cv::Mat edges;
//    cv::Canny(gray, edges, 0, 50);
//    // 使用白色填充
//    cvImage.setTo(cv::Scalar::all(225));
//    // 修改边缘颜色
//    cvImage.setTo(cv::Scalar(0,128,255,255),edges);
//    // 将Mat转换为Xcode的UIImageView显示
//    self.imsss.image = MatToUIImage(cvImage);
    return;
    
//    cv::Mat resultImage;
//    UIImageToMat(self.imsss.image, resultImage);
//    switch (self.indxe) {
//            case 0:{
//                cvtColor(resultImage, resultImage, cv::COLOR_BGR2GRAY);
//            break;
//            }
//            case 1:{
//                // 二阈值处理
//                cv::threshold(resultImage, resultImage, 100, 255, CV_THRESH_BINARY);
//                break;
//            }
//            case 2:{
////
////                // 腐蚀：白色背景缩小，黑色扩大
////                cv::Mat erodeElement = getStructuringElement(cv::MORPH_RECT, cv::Size(25,25)); //3535
////                cv::erode(resultImage, resultImage, erodeElement);
//            }
//        default:
//            break;
//    }
//
//    [self.imsss setImage:MatToUIImage(resultImage)];
//    self.indxe++;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
