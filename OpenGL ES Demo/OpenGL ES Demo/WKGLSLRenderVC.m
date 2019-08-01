//
//  WKGLSLRenderVC.m
//  OpenGL ES Demo
//
//  Created by Ke Wang on 2019/3/28.
//  Copyright © 2019 Bankrous.inc. All rights reserved.
//

#import <GLKit/GLKit.h>
#import "WKGLSLRenderVC.h"
#import "WKGLSLTool.h"

/**
 定义顶点类型
 */
typedef struct {
    GLKVector3 positionCoord; // (X, Y, Z)
    GLKVector2 textureCoord; // (U, V)
} SenceVertex;

@interface WKGLSLRenderVC ()

@property (nonatomic, assign) SenceVertex *vertices; // 顶点数组
@property (nonatomic, strong) EAGLContext *context;
@property (nonatomic, strong) CAEAGLLayer *showLayer;

@end

@implementation WKGLSLRenderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"GLSLRender";
    [self baseConfigure];
    // Do any additional setup after loading the view.
}

- (void)dealloc {
    if ([EAGLContext currentContext] == self.context) {
        [EAGLContext setCurrentContext:nil];
    }
    
    if (_vertices) {
        free(_vertices);
        _vertices = nil;
    }
}

- (void)baseConfigure {
    
    //!< 创建上下文
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    //!< 设置currentContext
    [EAGLContext setCurrentContext:self.context];
    
    //!< 创建顶点数组
    self.vertices = malloc(sizeof(SenceVertex) * 4); //!< 4个顶点
    self.vertices[0] = (SenceVertex){{-1, 1, 0}, {0, 1}}; // 左上角
    self.vertices[1] = (SenceVertex){{-1, -1, 0}, {0, 0}}; // 左下角
    self.vertices[2] = (SenceVertex){{1, 1, 0}, {1, 1}}; // 右上角
    self.vertices[3] = (SenceVertex){{1, -1, 0}, {1, 0}}; // 右下角
    
    //!< 初始化一个展示纹理的layer
    CAEAGLLayer *layer = [[CAEAGLLayer alloc] init];
    layer.frame = CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.width);
    //!< 设置缩放比例 防止失真
    layer.contentsScale = [UIScreen mainScreen].scale;
    [self.view.layer addSublayer:layer];
    
    //!< 绑定纹理输出的layer
    [[WKGLSLTool shareInstance] bindRenderLayer:layer context:self.context];
    
    //!< 读取纹理, 通过图片获取纹理ID
    NSString *imagePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"example.jpg"];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    GLuint textureID = [[WKGLSLTool shareInstance] loadTextureWithImage:image];
    
    //!< 设置视口尺寸
    glViewport(0, 0, [self drawableWidth], [self drawableHeight]);
    
    //!< 编译链接shader
    GLuint program = [[WKGLSLTool shareInstance] attachShaderToProgramWithShaderName:@"shader"];
    //!< useProgram
    glUseProgram(program);
    
    //!< 获取shader着色器中的参数, 然后传数据进去  这些都定义在着色器中
    GLuint positionSlot = glGetAttribLocation(program, "Position"); //!< 位置插槽
    GLuint textureSlot = glGetUniformLocation(program, "Texture"); //!< 纹理插槽
    GLuint textureCoordsSlot = glGetAttribLocation(program, "TextureCoords"); //!< 纹理坐标插槽
    
    //!< 将纹理ID传给着色器程序
    glActiveTexture(GL_TEXTURE0);
    glBindTexture(GL_TEXTURE_2D, textureID);
    glUniform1i(textureSlot, 0); //!< 将 textureSlot 赋值为 0，而 0 与 GL_TEXTURE0 对应，这里如果写 1，上面也要改成 GL_TEXTURE1
    
    //!< 创建顶点缓存
    GLuint vertexBuffer;
    glGenBuffers(1, &vertexBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, vertexBuffer);
    GLsizeiptr bufferSizeBytes = sizeof(SenceVertex) * 4;
    glBufferData(GL_ARRAY_BUFFER, bufferSizeBytes, self.vertices, GL_STATIC_DRAW);
    
    //!< 设置顶点数据
    glEnableVertexAttribArray(positionSlot);
    glVertexAttribPointer(positionSlot, 3, GL_FLOAT, GL_FALSE, sizeof(SenceVertex), NULL +  offsetof(SenceVertex, positionCoord));
    
    
    //!< 设置纹理数据
    glEnableVertexAttribArray(textureCoordsSlot);
    glVertexAttribPointer(textureCoordsSlot, 2, GL_FLOAT, GL_FALSE, sizeof(SenceVertex), NULL + offsetof(SenceVertex, textureCoord));
    
    //!< 开始绘制
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
    
    //!< 将绑定的渲染缓存展示到屏幕上
    [self.context presentRenderbuffer:GL_RENDERBUFFER];
    
    glDeleteBuffers(1, &vertexBuffer);
    vertexBuffer = 0;
    
}


//!< 获取渲染缓存宽度
- (GLint)drawableWidth {
    GLint backingWidth;
    glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_WIDTH, &backingWidth);
    
    return backingWidth;
}

//!< 获取渲染缓存高度
- (GLint)drawableHeight {
    GLint backingHeight;
    glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_HEIGHT, &backingHeight);
    
    return backingHeight;
}




@end
