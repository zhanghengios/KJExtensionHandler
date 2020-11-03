//
//  UIImage+FloodFill.m
//  KJEmitterView
//
//  Created by 杨科军 on 2018/12/1.
//  Copyright © 2018 杨科军. All rights reserved.
//  

#import "UIImage+KJFloodFill.h"

/* ***************************  栈操作 KJLinkedListQueue *****************************/

#define INVALID_NODE_CONTENT INT_MIN
typedef struct PointNode {
    NSInteger value;
    NSInteger nextNodeOffset;
}PointNode;
@interface KJLinkedListQueue : NSObject
/// 初始化
- (instancetype)initWithCapacity:(NSInteger)capacity cacheSizeIncrements:(NSInteger)increments multiplier:(NSInteger)multiplier;
// 入栈
- (void)pushWithX:(NSInteger)x PushY:(NSInteger)y;
// 出栈
- (NSInteger)popWithX:(NSInteger *)x PopY:(NSInteger *)y;

@end

@interface KJLinkedListQueue(){
    NSMutableData *_nodeCache;
    NSInteger _topNodeOffset, _freeNodeOffset;
    NSInteger _cacheSizeIncrements, _multiplier;
}
@end

@implementation KJLinkedListQueue
static const int8_t kFinallyNodeOffset = -1;
- (instancetype)init {
    return [self initWithCapacity:500 cacheSizeIncrements:500 multiplier:1000];
}
- (instancetype)initWithCapacity:(NSInteger)capacity cacheSizeIncrements:(NSInteger)increments multiplier: (NSInteger)multiplier {
    if (self == [super init]) {
        _nodeCache = [NSMutableData dataWithLength:capacity * sizeof(PointNode)];
        _cacheSizeIncrements = increments;
        _multiplier = multiplier;
        _topNodeOffset = kFinallyNodeOffset;
        _freeNodeOffset = 0;
        [self initialiseNodeWithCount:capacity];
    }
    return self;
}

- (void)pushWithX:(NSInteger)x PushY:(NSInteger)y {
    PointNode *node = [self nextFreeNode];
    node->value = x * _multiplier + y;
    node->nextNodeOffset = _topNodeOffset;
    _topNodeOffset = [self offsetOfNode:node];
}

- (NSInteger)popWithX:(NSInteger *)x PopY:(NSInteger *)y {
    if (_topNodeOffset == kFinallyNodeOffset) return INVALID_NODE_CONTENT;
    PointNode *topNode = [self nodeOfOffset:_topNodeOffset];
    NSInteger value = topNode->value;
    NSInteger nextNodeOffset = topNode->nextNodeOffset;
    *x = value / _multiplier;
    *y = value % _multiplier;
    topNode->value = 0;
    topNode->nextNodeOffset = _freeNodeOffset;
    _freeNodeOffset = _topNodeOffset;
    _topNodeOffset = nextNodeOffset;
    return value;
}

#pragma mark - Private
- (PointNode*)nodeOfOffset:(NSInteger)offset {
    return (PointNode *)_nodeCache.mutableBytes + offset;
}

- (NSInteger)offsetOfNode:(PointNode *)node {
    return node - (PointNode *)_nodeCache.mutableBytes;
}

- (PointNode*)nextFreeNode {
    if (_freeNodeOffset < 0) {
        [_nodeCache increaseLengthBy:_cacheSizeIncrements * sizeof(PointNode)];
        _freeNodeOffset = _topNodeOffset + 1;
        [self initialiseNodeWithCount:_cacheSizeIncrements];
    }
    PointNode *node = (PointNode *)_nodeCache.mutableBytes + _freeNodeOffset;
    _freeNodeOffset = node->nextNodeOffset;
    return node;
}
/// 初始化节点
- (void)initialiseNodeWithCount:(NSInteger)count {
    PointNode *node = (PointNode *)_nodeCache.mutableBytes + _freeNodeOffset;
    for (int i = 0; i < count - 1; i ++) {
        node->value = 0;
        node->nextNodeOffset = _freeNodeOffset + i + 1;
        node ++;
    }
    node->value = 0;
    node->nextNodeOffset = kFinallyNodeOffset;
}

@end

/* ***************************  栈操作 KJLinkedListQueue *****************************/


@implementation UIImage (KJFloodFill)
/* 基于扫描线的泛洪算法，获取填充同颜色区域后的图片
 @param startPoint 相对于图片的起点
 @param newColor    填充的颜色
 @param tolerance  判断相邻颜色相同的容差值
 @param antialias  是否抗锯齿化
 @return          填充后的图片
 */
- (UIImage *)kj_FloodFillImageFromStartPoint:(CGPoint)startPoint NewColor:(UIColor*)newColor Tolerance: (CGFloat)tolerance UseAntialias:(BOOL)antialias {
    if (!self.CGImage || !newColor) return self;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGImageRef imageRef = self.CGImage;
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    NSUInteger bitsPerComponent = CGImageGetBitsPerComponent(imageRef);
    NSUInteger bytesPerPixel = CGImageGetBitsPerPixel(imageRef) / bitsPerComponent;
    NSUInteger bytesPerRow = CGImageGetBytesPerRow(imageRef);
    unsigned char *imageData = malloc(height * bytesPerRow);
    CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(imageRef);
    if (kCGImageAlphaLast == (uint32_t)bitmapInfo || kCGImageAlphaFirst == (uint32_t)bitmapInfo){
        bitmapInfo = (uint32_t)kCGImageAlphaPremultipliedLast;
    }
    CGContextRef context = CGBitmapContextCreate(imageData,
                                                 width,
                                                 height,
                                                 bitsPerComponent,
                                                 bytesPerRow,
                                                 colorSpace,
                                                 bitmapInfo);
    CGColorSpaceRelease(colorSpace);
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    // 获取开始的点
    NSUInteger byteIndex = roundf(startPoint.x) * bytesPerPixel + roundf(startPoint.y) * bytesPerRow;
    NSUInteger statrColor = getColorCode(byteIndex, imageData);
    // 将UIColor转为RGBA值
    NSUInteger red, green, blue, alpha = 0;
    const CGFloat *components = CGColorGetComponents(newColor.CGColor);
    if (CGColorGetNumberOfComponents(newColor.CGColor) == 2) {
        red = green = blue  = components[0] * 255;
        alpha = components[1] * 255;
    }else {
        red = components[0] * 255;
        green = components[1] * 255;
        blue = components[2] * 255;
        alpha = components[3] * 255;
    }
    NSUInteger nColor = red << 24 | green << 16 | blue << 8 | alpha;
    if (compareColor(statrColor, nColor, 0)) return self;
    
    // 开始点入栈
    KJLinkedListQueue *points = [[KJLinkedListQueue alloc] initWithCapacity:500 cacheSizeIncrements:500 multiplier:height];
    KJLinkedListQueue *antialiasPoints = [[KJLinkedListQueue alloc] initWithCapacity:500 cacheSizeIncrements:500 multiplier:height];
    [points pushWithX:roundf(startPoint.x) PushY:roundf(startPoint.y)];
    
    // 循环到栈内无节点
    NSInteger color;
    BOOL panLeft, panRight;
    NSInteger x, y;
    while ([points popWithX:&x PopY:&y] != INVALID_NODE_CONTENT) {
        byteIndex = bytesPerPixel * x + bytesPerRow * y;
        color = getColorCode(byteIndex, imageData);
        while (y >= 0 && compareColor(statrColor, color, tolerance)) {
            --y;
            if (y >= 0) {
                byteIndex = bytesPerPixel * x + bytesPerRow * y;
                color = getColorCode(byteIndex, imageData);
            }
        }
        if (y >= 0) {
            [antialiasPoints pushWithX:x PushY:y];
        }
        
        ++y;
        byteIndex = bytesPerPixel * x + bytesPerRow * y;
        color = getColorCode(byteIndex, imageData);
        panLeft = panRight = false;
        while (y < height && compareColor(statrColor, color, tolerance) && color != nColor) {
            // 颜色替换
            imageData[byteIndex] = red;
            imageData[byteIndex + 1] = green;
            imageData[byteIndex + 2] = blue;
            imageData[byteIndex + 3] = alpha;
            if (x > 0) {
                byteIndex = bytesPerPixel * (x - 1) + bytesPerRow * y;
                color = getColorCode(byteIndex, imageData);
                if (!panLeft && compareColor(statrColor, color, tolerance) && color != nColor) { // 左侧点入栈
                    [points pushWithX:x - 1 PushY:y];
                    panLeft = true;
                }else if (panLeft && !compareColor(statrColor, color, tolerance)) {
                    panLeft = false;
                }
                if (!panLeft && !compareColor(statrColor, color, tolerance) && color != nColor) { // 边缘点入栈
                    [antialiasPoints pushWithX:x - 1 PushY:y];
                }
            }
            
            if (x < width - 1) {
                byteIndex = bytesPerPixel * (x + 1) + bytesPerRow * y;
                color = getColorCode(byteIndex, imageData);
                if (!panRight && compareColor(statrColor, color, tolerance) && color != nColor) { // 右侧点入栈
                    [points pushWithX:x + 1 PushY:y];
                    panRight = true;
                }else if (panRight && !compareColor(statrColor, color, tolerance)){
                    panRight = false;
                }
                if (!panRight && !compareColor(statrColor, color, tolerance) && color != nColor) {
                    [antialiasPoints pushWithX:x + 1 PushY:y];
                }
            }
            ++y;
            if (y < height) {
                byteIndex = bytesPerPixel * x + bytesPerRow * y;
                color = getColorCode(byteIndex, imageData);
            }
        }
    }
    
    void (^block)(NSUInteger, NSUInteger) = ^(NSUInteger pointX, NSUInteger pointY) {
        NSUInteger byteIndex = bytesPerPixel * x + bytesPerRow * y;
        NSUInteger color = getColorCode(byteIndex, imageData);
        if (color != nColor) {
            antiAliasOperation(byteIndex, imageData, nColor);
        }
    };
    if (antialias) { // 抗锯齿化
        while ([antialiasPoints popWithX:&x PopY:&y] != INVALID_NODE_CONTENT) {
            NSUInteger byteIndex = bytesPerPixel * x + bytesPerRow * y;
            antiAliasOperation(byteIndex, imageData, nColor);
            if (x > 0) block(x-1, y);
            if (x < width-1) block(x+1, y);
            if (y > 0) block(x, y-1);
            if (y < height-1) block(x, y+1);
        }
    }
    // 将位图转为UIImage
    CGImageRef newImage = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    
    UIImage *nImage = [UIImage imageWithCGImage:newImage];
    CGImageRelease(newImage);
    return nImage;
}

#pragma mark - 内部方法
/// 将RGBA转为NSUInteger
static NSUInteger getColorCode(NSUInteger byteIndex, unsigned char *imageData) {
    NSUInteger red = imageData[byteIndex];
    NSUInteger green = imageData[byteIndex + 1];
    NSUInteger blue = imageData[byteIndex + 2];
    NSUInteger alpha = imageData[byteIndex + 3];
    return red << 24 | green << 16 | blue << 8 | alpha;
}
/// 对比两种颜色是否在容差内
static BOOL compareColor(NSUInteger color1, NSUInteger color2, NSInteger tolerance) {
    if(color1 == color2) return true;
    NSInteger red1   = ((0xff000000 & color1) >> 24);
    NSInteger green1 = ((0x00ff0000 & color1) >> 16);
    NSInteger blue1  = ((0x0000ff00 & color1) >> 8);
    NSInteger alpha1 =  (0x000000ff & color1);
    
    NSInteger red2   = ((0xff000000 & color2) >> 24);
    NSInteger green2 = ((0x00ff0000 & color2) >> 16);
    NSInteger blue2  = ((0x0000ff00 & color2) >> 8);
    NSInteger alpha2 =  (0x000000ff & color2);
    
    NSInteger diffRed   = labs(red2   - red1);
    NSInteger diffGreen = labs(green2 - green1);
    NSInteger diffBlue  = labs(blue2  - blue1);
    NSInteger diffAlpha = labs(alpha2 - alpha1);
    
    if (diffRed > tolerance || diffGreen > tolerance || diffBlue > tolerance || diffAlpha > tolerance){
        return false;
    }
    return true;
}
// 抗锯齿化
static void antiAliasOperation(NSUInteger byteIndex, unsigned char *imageData, NSUInteger blendedColor) {
    NSInteger red1   = ((0xff000000 & blendedColor) >> 24);
    NSInteger green1 = ((0x00ff0000 & blendedColor) >> 16);
    NSInteger blue1  = ((0x0000ff00 & blendedColor) >> 8);
    NSInteger alpha1 = (0x000000ff & blendedColor);
    
    NSInteger red2   = imageData[byteIndex];
    NSInteger green2 = imageData[byteIndex + 1];
    NSInteger blue2  = imageData[byteIndex + 2];
    NSInteger alpha2 = imageData[byteIndex + 3];
    
    imageData[byteIndex] = (red1 + red2) / 2;
    imageData[byteIndex + 1] = (green1 + green2) / 2;
    imageData[byteIndex + 2] = (blue1 + blue2) / 2;
    imageData[byteIndex + 3] = (alpha1 + alpha2) / 2;
}

@end

