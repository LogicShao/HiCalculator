# CLAUDE.md

[根目录](../../CLAUDE.md) > **entry**

## 变更记录 (Changelog)

- **2025-12-03**: 创建模块文档，描述 entry 模块结构和功能。

## 模块职责

entry 是 HiCalculator 应用的主模块，包含了应用的所有核心功能，包括用户界面、业务逻辑和测试代码。

## 入口与启动

- **模块配置**: `entry/src/main/module.json5`
- **应用入口**: `entry/src/main/ets/entryability/EntryAbility.ets`
- **主页面**: `entry/src/main/ets/pages/Index.ets`

## 对外接口

entry 模块作为应用的主模块，通过 UI 界面与用户交互，不提供编程接口。

## 关键依赖与配置

- **依赖包**:
  - `@ohos/hypium` (测试框架)
  - `@ohos/hamock` (测试模拟框架)
- **配置文件**:
  - `entry/src/main/module.json5` (模块配置)
  - `entry/src/main/resources/base/profile/main_pages.json` (页面路由)
  - `entry/src/main/resources/base/element/string.json` (字符串资源)
  - `entry/src/main/resources/base/element/color.json` (颜色资源)
  - `entry/src/main/resources/base/element/float.json` (尺寸资源)

## 数据模型

entry 模块本身不定义复杂的数据模型，主要使用在 `utils` 模块中定义的 `Complex` 接口进行数据处理。

## 测试与质量

- **单元测试**: `entry/src/test/`
- **系统测试**: `entry/src/ohosTest/

## 常见问题 (FAQ)

Q: 如何添加新的页面？
A:
1. 在 `entry/src/main/ets/pages/` 目录下创建新的页面文件
2. 在 `entry/src/main/resources/base/profile/main_pages.json` 中注册新页面
3. 在 `entry/src/main/module.json5` 中更新页面配置（如有必要）

## 相关文件清单

- `entry/src/main/module.json5`: 模块配置文件
- `entry/src/main/resources/base/profile/main_pages.json`: 页面路由配置
- `entry/src/main/resources/base/element/string.json`: 字符串资源
- `entry/src/main/resources/base/element/color.json`: 颜色资源
- `entry/src/main/resources/base/element/float.json`: 尺寸资源
- `entry/src/main/ets/entryability/EntryAbility.ets`: 应用入口能力
- `entry/src/main/ets/pages/Index.ets`: 主页面
- `entry/src/main/ets/utils/Complex.ets`: 复数工具类
- `entry/src/main/ets/utils/ExpressionEvaluator.ets`: 表达式求值器
- `entry/src/test/`: 单元测试代码
- `entry/src/ohosTest/`: 系统测试代码
- `entry/hvigorfile.ts`: 构建配置文件