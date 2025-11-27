# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 项目概述

这是一个基于 HarmonyOS 的 HiCalculator 计算器应用项目，使用 ArkTS 语言开发。

## 开发环境

- **开发框架**: HarmonyOS
- **编程语言**: ArkTS (TypeScript 的超集)
- **构建工具**: Hvigor
- **包管理器**: OHPM (OpenHarmony Package Manager)

## 项目结构

```
HiCalculator/
├── AppScope/                    # 应用级配置
│   ├── app.json5               # 应用配置文件
│   └── resources/              # 应用级资源文件
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
├── hvigor/                     # Hvigor 配置
└── hvigorfile.ts               # 构建脚本
```

## 常用命令

### 构建和运行
```bash
# 构建项目
hvigor assembleHap

# 清理构建
hvigor clean
```

### 代码检查
```bash
# 运行代码检查
hvigor lint
```

### 测试
```bash
# 运行单元测试
hvigor test
```

## 核心文件说明

### 配置文件
- `AppScope/app.json5`: 应用级配置，包含包名、版本等信息
- `entry/src/main/module.json5`: 模块配置，定义能力、页面路由等
- `oh-package.json5`: 项目依赖配置
- `hvigorfile.ts`: 构建配置

### 关键代码文件
- `entry/src/main/ets/entryability/EntryAbility.ets`: 应用入口能力
- `entry/src/main/ets/pages/Index.ets`: 主页面组件
- `entry/src/main/resources/base/profile/main_pages.json`: 页面路由配置

## 开发注意事项

1. **ArkTS 语法**: 使用 TypeScript 语法，支持装饰器如 `@Entry`、`@Component`
2. **UI 组件**: 使用 ArkUI 声明式语法，如 `Text`、`RelativeContainer`
3. **资源引用**: 使用 `$r('app.float.page_text_font_size')` 格式引用资源
4. **依赖管理**: 使用 OHPM 管理第三方依赖
5. **测试框架**: 使用 Hypium 测试框架进行单元测试

## 代码规范

项目配置了代码检查规则，重点关注安全相关的加密算法使用，避免不安全的加密实现。

## 扩展能力

项目支持备份能力，通过 `EntryBackupAbility` 实现数据备份功能。