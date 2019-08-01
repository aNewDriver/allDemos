//
//  WKGLSLTool.h
//  OpenGL ES Demo
//
//  Created by Ke Wang on 2019/3/28.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKGLSLTool : NSObject

+ (WKGLSLTool *)shareInstance;

//!< 通过一张图片加载纹理, 并返回纹理ID
- (GLuint)loadTextureWithImage:(UIImage *)image;

//!< 通过文件名编译shader
- (GLuint)compileShaderWithShaderName:(NSString *)shaderName shaderType:(GLenum)shaderType;

//!< 将顶点着色器和片段着色器挂载到program上, 并返回programID
- (GLuint)attachShaderToProgramWithShaderName:(NSString *)shaderName;

//!< 绑定展示渲染结果的layer 将渲染缓存绑定到帧缓存上
- (void)bindRenderLayer:(CALayer <EAGLDrawable> *)layer context:(EAGLContext *)context;


@end

NS_ASSUME_NONNULL_END
