使用方式
-------------
默认存储数据库为sqlite3,不用做修改 <br>
如果要改成mysql，则对sentry.conf.py里面进行调整,模板文件:sentry.conf.py.mysql <br>
配置邮件:配置文件(sentry.conf.py)修改内容： SENTRY_URL_PREFIX 与 邮件相关配置 <br>
配置sentry登录用户:修改entrypoint.sh,Username/Email/Password ;默认用户密码为admin/admin <br>
