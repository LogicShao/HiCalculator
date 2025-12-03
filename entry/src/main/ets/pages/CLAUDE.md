# CLAUDE.md

[根目录](../../CLAUDE.md) > [entry](../) > **src/main/ets/pages**

## 变更记录 (Changelog)

- **2025-12-03**: 创建模块文档，描述页面组件功能。

## 模块职责

该模块包含了应用的所有页面组件，其中 Index.ets 是主页面，实现了计算器的用户界面和交互逻辑。

## 入口与启动

- **主页面文件**: `entry/src/main/ets/pages/Index.ets`
- **启动流程**: 由 EntryAbility 加载，作为应用的主界面展示给用户

## 对外接口

页面组件通过用户交互（点击按钮等）接收输入，并通过状态管理更新界面显示。

## 关键依赖与配置

- **依赖模块**:
  - `../utils/Complex` (复数计算工具)
  - `../utils/ExpressionEvaluator` (表达式求值器)
  - `@kit.AbilityKit` (部分UI组件)
- **资源配置**:
  - `entry/src/main/resources/base/element/color.json` (颜色资源)
  - `entry/src/main/resources/base/element/float.json` (尺寸资源)
  - `entry/src/main/resources/base/element/string.json` (字符串资源)

## 数据模型

- **displayValue**: string - 当前显示屏上显示的值
- **firstOperand**: Complex - 第一个操作数（复数）
- **operator**: string - 当前选择的运算符
- **waitingForSecondOperand**: boolean - 是否正在等待第二个操作数
- **hasError**: boolean - 是否发生错误
- **mode**: 'real' | 'complex' - 计算器模式（实数或复数）
- **expression**: string - 当前累积的表达式
- **showExpression**: boolean - 是否显示累积的表达式

## 测试与质量

页面组件的逻辑可以通过单元测试验证，特别是各种按钮点击后的状态变化和计算结果。

## 常见问题 (FAQ)

Q: 如何添加新的计算功能？
A: 在 Index.ets 中添加相应的状态变量和处理函数，并更新界面布局。

## 相关文件清单

- `entry/src/main/ets/pages/Index.ets`: 主页面组件实现
- `entry/src/main/resources/base/element/color.json`: 颜色资源配置
- `entry/src/main/resources/base/element/float.json`: 尺寸资源配置
- `entry/src/main/resources/base/element/string.json`: 字符串资源配置