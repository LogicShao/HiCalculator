# CLAUDE.md

[根目录](../../CLAUDE.md) > [entry](../) > **src/main/ets/entryability**

## 变更记录 (Changelog)

- **2025-12-03**: 创建模块文档，描述 EntryAbility 功能。

## 模块职责

EntryAbility 是应用的主入口点，负责应用的生命周期管理，包括创建、销毁、前后台切换等。它还负责加载主页面 Index。

## 入口与启动

- **入口文件**: `entry/src/main/ets/entryability/EntryAbility.ets`
- **启动流程**:
  1. 应用启动时，系统会创建 EntryAbility 实例
  2. `onCreate()` 方法被调用，进行初始化设置
  3. `onWindowStageCreate()` 方法被调用，加载主页面 Index
  4. 用户与应用交互，应用可能进入后台或回到前台
  5. 应用退出时，`onDestroy()` 方法被调用，释放资源

## 对外接口

EntryAbility 本身不提供对外接口，它通过 UIAbility 框架与系统交互。

## 关键依赖与配置

- **依赖模块**: `@kit.AbilityKit`, `@kit.PerformanceAnalysisKit`, `@kit.ArkUI`
- **配置文件**: `entry/src/main/module.json5`

## 数据模型

无特定数据模型，主要处理应用生命周期事件。

## 测试与质量

目前没有针对 EntryAbility 的专门测试用例，其功能通过系统测试验证。

## 常见问题 (FAQ)

Q: 如何修改应用启动时加载的页面？
A: 修改 `onWindowStageCreate()` 方法中的 `loadContent()` 参数。

## 相关文件清单

- `entry/src/main/ets/entryability/EntryAbility.ets`: 应用入口能力实现
- `entry/src/main/module.json5`: 模块配置文件