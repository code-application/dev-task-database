-- Flywayの内部テーブルを管理するためのユーザー
\set flyway_password `echo $FLYWAY_PASSWORD`
CREATE USER flyway_user WITH PASSWORD :'flyway_password';
GRANT ALL PRIVILEGES ON DATABASE devtask_db TO flyway_user;

-- アプリケーションで使用するテーブルを管理するためのユーザー
-- \set devtask_password `echo $DEVTASK_PASSWORD`
-- CREATE USER devtask_user WITH PASSWORD :'devtask_password';
CREATE USER devtask_user WITH PASSWORD '${DEVTASK_PASSWORD}';

-- アプリケーションで使用するテーブルにアクセス可能なロール
CREATE ROLE devtask_role;
-- 実行ユーザーはスキーマのオーナーと同じロールに属する必要がある
GRANT devtask_role TO flyway_user;
GRANT devtask_role TO devtask_user;

-- データベースへの接続権限をアプリケーション管理ロールに付与する
GRANT CONNECT ON DATABASE devtask_db TO devtask_role;
