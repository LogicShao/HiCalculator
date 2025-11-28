# HiCalculator

一个基于 HarmonyOS 的现代化计算器应用，使用 ArkTS 语言开发。

## 📱 应用截图

```
+-------------------------------+
|             0                 |  ← 显示区域
+-------------------------------+
|  C   ±   %   ÷   |
|  7   8   9   ×   |
|  4   5   6   -   |  ← 按钮区域
|  1   2   3   +   |
|  0       .   =   |
+-------------------------------+
```

## ✨ 功能特性

### 基础运算
- ✅ **四则运算**: 加法(+)、减法(-)、乘法(×)、除法(÷)
- ✅ **等号计算**: 执行运算并显示结果
- ✅ **清除功能**: 一键清除所有状态 (C)
- ✅ **小数点**: 支持小数运算
- ✅ **百分比**: 快速计算百分比
- ✅ **正负号**: 数值正负切换 (±)

### 用户体验
- 🎨 **现代化界面**: 深色主题设计
- 🎯 **直观布局**: 标准计算器按钮排列
- 📱 **响应式设计**: 适配不同屏幕尺寸
- 🎨 **色彩分类**:
  - 数字按钮: 深灰色
  - 运算符按钮: 橙色
  - 功能按钮: 浅灰色

### 技术特点
- ⚡ **高性能**: 基于 ArkTS 声明式 UI
- 🔧 **组件化**: 可复用的按钮组件
- 🛡️ **类型安全**: 完整的 TypeScript 类型支持
- 📦 **模块化**: 清晰的代码结构

## 🛠️ 技术栈

- **开发框架**: HarmonyOS
- **编程语言**: ArkTS (TypeScript 超集)
- **UI框架**: ArkUI
- **构建工具**: Hvigor
- **包管理器**: OHPM

## 📁 项目结构

```
HiCalculator/
├── AppScope/                    # 应用级配置
│   ├── app.json5               # 应用配置文件
│   └── resources/              # 应用级资源
├── entry/                      # 主模块
│   ├── src/main/               # 主代码目录
│   │   ├── ets/                # ArkTS 源代码
│   │   │   ├── entryability/   # 应用入口能力
│   │   │   └── pages/          # 页面组件
│   │   ├── resources/          # 模块资源
│   │   └── module.json5        # 模块配置
│   ├── src/ohosTest/           # 系统测试
│   └── src/test/               # 单元测试
├── oh_modules/                 # OHPM 依赖包
├── CLAUDE.md                   # Claude Code 指导文件
└── README.md                   # 项目说明文档
```

## 🚀 快速开始

### 环境要求

- **DevEco Studio**: 4.0 或更高版本
- **HarmonyOS SDK**: API 9 或更高版本
- **Node.js**: 16.0 或更高版本

### 构建和运行

1. **克隆项目**
   ```bash
   git clone <repository-url>
   cd HiCalculator
   ```

2. **安装依赖**
   ```bash
   ohpm install
   ```

3. **构建项目**
   ```bash
   hvigor assembleHap
   ```

4. **运行应用**
   - 在 DevEco Studio 中打开项目
   - 选择目标设备或模拟器
   - 点击运行按钮

### 常用命令

```bash
# 构建项目
hvigor assembleHap

# 清理构建
hvigor clean

# 运行代码检查
hvigor lint

# 运行单元测试
hvigor test
```

## 🎯 使用说明

### 基本操作

1. **输入数字**: 点击数字按钮输入数值
2. **选择运算符**: 点击 +、-、×、÷ 选择运算
3. **执行计算**: 点击 = 获得计算结果
4. **清除状态**: 点击 C 重置计算器

### 高级功能

- **百分比计算**: 输入数字后点击 % 转换为百分比
- **正负切换**: 点击 ± 切换当前数值的正负号
- **小数运算**: 点击 . 输入小数点

### 计算示例

```
计算: 12 + 34 × 2

操作步骤:
1. 输入 12
2. 点击 +
3. 输入 34
4. 点击 ×
5. 输入 2
6. 点击 =

结果: 80
```

## 🔧 核心代码

### 主页面组件

```typescript
@Entry
@Component
struct Index {
  @State displayValue: string = '0'
  @State firstOperand: number = 0
  @State operator: string = ''
  @State waitingForSecondOperand: boolean = false

  // 计算逻辑实现...
}
```

### 按钮组件

```typescript
@Builder
CalculatorButton(label: string, type: string, onClick: () => void): void {
  Button(label) {
    Text(label)
      .fontSize($r('app.float.button_font_size'))
      .fontColor(this.getButtonTextColor(type))
      .fontWeight(FontWeight.Bold)
  }
  // 样式和事件处理...
}
```

## 🎨 设计规范

### 颜色方案

| 元素 | 颜色值 | 用途 |
|------|--------|------|
| 计算器背景 | #1E1E1E | 主界面背景 |
| 显示区域 | #000000 | 结果显示区域 |
| 数字按钮 | #333333 | 数字按键 |
| 运算符按钮 | #FF9500 | 运算符号按键 |
| 功能按钮 | #A6A6A6 | 功能按键 |

### 字体大小

- **显示区域**: 48fp
- **按钮文字**: 32fp
- **按钮圆角**: 40fp

## 🧪 测试

项目包含完整的单元测试，使用 Hypium 测试框架：

```typescript
// 示例测试用例
describe('Calculator Tests', () => {
  it('should perform addition correctly', () => {
    // 测试加法逻辑
  })
})
```

## 📄 许可证

本项目基于 Apache License 2.0 开源协议。

## 🤝 贡献

欢迎提交 Issue 和 Pull Request 来改进这个项目！

## 📞 联系方式

如有问题或建议，请通过以下方式联系：

- 项目仓库: [GitHub Repository]
- 邮箱: [Your Email]

---

**HiCalculator** - 让计算更简单！ 🧮