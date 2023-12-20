# mysql-backup-script

这是一个基于 [databacker/mysql-backup](https://github.com/databacker/mysql-backup) 的备份样例

## 使用

```shell
git clone https://github.com/akkuman/mysql-backup-script
cd mysql-backup-script
find ./scripts.d -type f -name '*.sh' -exec chmod +x {} \;
```

然后查看 docker-compose.yml，根据自己的配置进行修改，然后使用 `docker compose up -d` 启动即可

备份的文件将会保存在 docker-compose.yml 同目录下的 data 文件夹中

如果需要有更多配置说明，请查看[databacker/mysql-backup docker 说明](https://hub.docker.com/r/databack/mysql-backup)

## 说明

### 关于时区问题的解决

查看 [https://github.com/databacker/mysql-backup/issues?q=is%3Aissue+timezone](https://github.com/databacker/mysql-backup/issues?q=is%3Aissue+timezone) 可以看到关于时区的问题悬而未决，这会导致两个问题：

1. crontab 配置和预期不一致
2. 生成出来的文件名默认为 db_backup_2023-12-20T02-19-33Z.tgz 这种格式

所以可以通过挂载宿主机 /etc/localtime 和 /etc/timezone 来解决

前提是你需要正确配置好宿主机的时区（配置方法可参见下面的命令）

```shell
sudo timedatectl set-timezone Asia/Shanghai
sudo ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
```

### 保留固定天数备份的解决

可参见 [https://github.com/databacker/mysql-backup/pull/149](https://github.com/databacker/mysql-backup/pull/149)

鉴于作者还没合并，可以使用 `post-backup` 来解决，参见 [scripts.d\post-backup\delete_old_backups.sh](scripts.d\post-backup\delete_old_backups.sh)

通过设置 [docker-compose.yml](docker-compose.yml) 中的 `DB_DUMP_ARCHIVE_DAYS_TO_KEEP` 变量可以修改保留的天数
