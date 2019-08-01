//
//  WKGLSLTool.m
//  OpenGL ES Demo
//
//  Created by Ke Wang on 2019/3/28.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#import <GLKit/GLKit.h>
#import "WKGLSLTool.h"

@implementation WKGLSLTool

static WKGLSLTool *_GLSLTool = nil;

+ (WKGLSLTool *)shareInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _GLSLTool = [[WKGLSLTool alloc] init];
    });
    
    return _GLSLTool;
}

- (GLuint)loadTextureWithImage:(UIImage *)image {
    
    //!< 将image转换为imageRef, 并获取其rect
    CGImageRef imageRef = [image CGImage];
    GLuint width = (GLuint)CGImageGetWidth(imageRef);
    GLuint height = (GLuint)CGImageGetHeight(imageRef);
    CGRect rect = CGRectMake(0, 0, width, height);
    
    //!< 绘制图片
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    void *imageData = malloc(width * height * 4);
    CGContextRef contextRef = CGBitmapContextCreate(imageData, width, height, 8, width * 4, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGContextTranslateCTM(contextRef, 0, height);
    CGContextScaleCTM(contextRef, 1.0, -1.0);
    CGColorSpaceRelease(colorSpace);
    CGContextClearRect(contextRef, rect);
    CGContextDrawImage(contextRef, rect, imageRef);
    
    //!< 生成纹理
    GLuint textureID;
    glGenTextures(1, &textureID);
    glBindTexture(GL_TEXTURE_2D, textureID);
    //!< 将图片数据写入纹理缓存
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, imageData);
    
    //!< 设置如何将纹素映射成像素
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    
    //!< 解除绑定
    glBindTexture(GL_TEXTURE_2D, 0);
    
    //!< 释放内存
    CGContextRelease(contextRef);
    free(imageData);
    
    return textureID;
}

- (GLuint)compileShaderWithShaderName:(NSString *)shaderName shaderType:(GLenum)shaderType {
    GLuint shader = glCreateShader(shaderType);
    
    //!< 查找shader文件
    
    NSString *shaderPath = [[NSBundle mainBundle] pathForResource:shaderName ofType:shaderType == GL_VERTEX_SHADER ? @"vsh" : @"fsh"];
    NSError *error;
    NSString *shaderStr = [NSString stringWithContentsOfFile:shaderPath encoding:NSUTF8StringEncoding error:&error];
    if (!shaderStr || error) {
        NSAssert(NO, @"加载shader文件失败");
        exit(1);
    }
    
    //!< 获取shader内容
    const char *shaderStrUTF8 = [shaderStr UTF8String];
    int shaderStrLength = (int)[shaderStr length];
    glShaderSource(shader, 1, &shaderStrUTF8, &shaderStrLength);
    
    //!< 编译shader
    glCompileShader(shader);
    
    //!< 查询编译结果
    GLint complieSuccess;
    glGetShaderiv(shader, GL_COMPILE_STATUS, &complieSuccess);
    
    if (complieSuccess == GL_FALSE) {
        GLchar messages[256];
        glGetShaderInfoLog(shader, sizeof(messages), 0, &messages[0]);
        NSString *messageStr = [NSString stringWithUTF8String:messages];
        NSAssert(NO, @"shader编译失败 reason:%@", messageStr);
        exit(1);
    }
    
    return shader;
    
}

//!< 将顶点着色器和片段着色器挂载到一个progrem上, 并返回progremID
- (GLuint)attachShaderToProgramWithShaderName:(NSString *)shaderName {
    GLuint program = glCreateProgram();
    
    //!< 编译两个着色器
    
    GLint vertexShader = [self compileShaderWithShaderName:shaderName shaderType:GL_VERTEX_SHADER];
    GLint fragementShader = [self compileShaderWithShaderName:shaderName shaderType:GL_FRAGMENT_SHADER];
    
    //!< 挂载
    glAttachShader(program, vertexShader);
    glAttachShader(program, fragementShader);
    
    //!< 链接progrem
    glLinkProgram(program);
    
    //!< 链接状态
    GLint linkSuccess;
    glGetProgramiv(program, GL_LINK_STATUS, &linkSuccess);
    if (linkSuccess == GL_FALSE) {
        
        GLchar message[256];
        glGetProgramInfoLog(program, sizeof(message), 0, &message[0]);
        NSString *messageStr = [NSString stringWithUTF8String:message];
        NSAssert(NO, @"programLink失败, reason:%@", messageStr);
        exit(1);
    }
    return program;
}

//!< 绑定展示渲染结果的layer
- (void)bindRenderLayer:(CALayer <EAGLDrawable> *)layer context:(EAGLContext *)context{
    
    GLuint frameBuffer; //!< 帧缓存
    GLuint renderBuffer; //!< 渲染缓存
    
    //!< 绑定renderBuffer到layer上
    glGenRenderbuffers(1, &renderBuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, renderBuffer);
    [context renderbufferStorage:GL_RENDERBUFFER fromDrawable:layer];
    
    //!< 将渲染缓存绑定到帧缓存上
    
    glGenFramebuffers(1, &frameBuffer);
    glBindFramebuffer(GL_FRAMEBUFFER, frameBuffer);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER,
                              GL_COLOR_ATTACHMENT0,
                              GL_RENDERBUFFER,
                              renderBuffer);
    
    
}


@end
