日志归档脚本
======

## TOC

* [功能说明](#功能说明)
* [使用说明](#使用说明)
* [注意事项](#注意事项)

## 功能说明

以 Nginx GET 日志为例，Nginx 在 logs 目录下产生 `access.log` ，一段时间后，`access.log` 会发生轮转，此时目录下会存在 `access.log` 、 `access.log.1` ，在过一段时间，日志继续轮转，产生 `access.log.2.gz`...... 此时日志文件结构如下：

```
logs
├── access.log
├── access.log.1
├── access.log.2.gz
├── access.log.3.gz
├── access.log.4.gz
└── ...
```

为了方便日志分析，本脚本可以将以上日志按日期分割为 `afdoa_access_log.YYYY-MM-DD.log` 的日志文件存档

## 使用说明

```shell
./logarchive.sh <LOG_TO_ARCHIVE_PATH> <COMMON_PREFIX> <ARCHIVED_LOG_PATH> <PREFIX>
```
上面的命令要传递**四个参数**：
* LOG_TO_ARCHIVE_PATH: 待归档的日志的路径
* COMMON_PREFIX: 待归档的日志的公共前缀
* ARCHIVED_LOG_PATH: 归档日志的存放路径
* PREFIX: 归档日志的文件名前缀

**用法示例：**

```shell
./logarchive.sh /source/logs access /destination/logs afdoa_access_log
```
## 注意事项

* `<LOG_TO_ARCHIVE_PATH>` 目录下不能存在与待归档日志有相同的 `<COMMON_PREFIX>` 的其他文件
* 命令执行者对 `<ARCHIVED_LOG_PATH>` 要有 **write** 权限

## License

![](https://img.shields.io/github/license/rocj/logarchive.svg?style=flat-square)

Released under the [MIT](./LICENSE) License.
