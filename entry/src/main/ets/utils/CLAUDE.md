# CLAUDE.md

[根目录](../../CLAUDE.md) > [entry](../) > **src/main/ets/utils**

## 变更记录 (Changelog)

- **2025-12-03**: 创建模块文档，描述工具类功能。

## 模块职责

该模块包含了应用的核心计算逻辑，包括复数运算和表达式求值功能。

## 入口与启动

这些工具类通过静态方法提供功能，不需要单独启动。

## 对外接口

### Complex & ComplexCalculator

- `Complex`: 复数接口，包含实部(real)和虚部(imag)
- `ComplexCalculator.parse(value: string): Complex` - 解析字符串为复数
- `ComplexCalculator.format(c: Complex): string` - 格式化复数为字符串
- `ComplexCalculator.add(a: Complex, b: Complex): Complex` - 复数加法
- `ComplexCalculator.subtract(a: Complex, b: Complex): Complex` - 复数减法
- `ComplexCalculator.multiply(a: Complex, b: Complex): Complex` - 复数乘法
- `ComplexCalculator.divide(a: Complex, b: Complex): Complex` - 复数除法

### ExpressionEvaluator

- `ExpressionEvaluator.evaluate(expr: string): Complex` - 计算表达式值
- `ExpressionEvaluator.isValid(expr: string): boolean` - 验证表达式有效性
- `ExpressionEvaluator.formatResult(expr: string): string` - 格式化表达式结果

## 关键依赖与配置

无外部依赖，仅依赖 JavaScript/TypeScript 标准库。

## 数据模型

- **Complex**: 复数接口
  - `real`: number - 实部
  - `imag`: number - 虚部

## 测试与质量

这些核心计算逻辑应该有完善的单元测试覆盖各种边界情况和异常输入。

## 常见问题 (FAQ)

Q: 如何扩展支持更多的数学函数？
A: 可以在 ExpressionEvaluator 中添加新的运算符，并在 ComplexCalculator 中实现相应的复数运算。

## 相关文件清单

- `entry/src/main/ets/utils/Complex.ets`: 复数定义和运算实现
- `entry/src/main/ets/utils/ExpressionEvaluator.ets`: 表达式求值器实现