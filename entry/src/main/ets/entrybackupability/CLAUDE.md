# CLAUDE.md

[根目录](../../CLAUDE.md) > [entry](../) > **src/main/ets/entrybackupability**

## 变更记录 (Changelog)

- **2025-12-03**: 创建模块文档，描述 EntryBackupAbility 功能。

## 模块职责

EntryBackupAbility 负责应用的数据备份和恢复功能，允许用户在设备间同步应用数据。

## 入口与启动

- **入口文件**: `entry/src/main/ets/entrybackupability/EntryBackupAbility.ets`
- **启动条件**: 当系统需要备份或恢复应用数据时自动启动

## 对外接口

EntryBackupAbility 通过 HarmonyOS 的备份框架与系统交互，不提供直接的对外接口。

## 关键依赖与配置

- **配置文件**:
  - `entry/src/main/module.json5` (定义了 backup 类型的 extensionAbility)
  - `entry/src/main/resources/base/profile/backup_config.json` (备份配置)

## 数据模型

备份功能主要处理应用的用户数据，具体数据结构由应用业务逻辑决定。

## 测试与质量

备份功能通常通过系统级别的测试来验证，应用层面可以测试数据序列化和反序列化的正确性。

## 常见问题 (FAQ)

Q: 如何配置哪些数据需要备份？
A: 通过修改 `backup_config.json` 文件来指定需要备份的数据。

## 相关文件清单

- `entry/src/main/ets/entrybackupability/EntryBackupAbility.ets`: 备份能力实现
- `entry/src/main/module.json5`: 模块配置文件
- `entry/src/main/resources/base/profile/backup_config.json`: 备份配置文件