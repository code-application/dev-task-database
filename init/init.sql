-- Flywayの内部テーブルを管理するためのユーザー
-- グループロール(devtask_role)の権限を継承するためにINHERITを設定
CREATE USER flyway_user WITH INHERIT CREATEROLE PASSWORD '${FLYWAY_PASSWORD}';
GRANT ALL PRIVILEGES ON DATABASE devtask_db TO flyway_user;

-- アプリケーションで使用するテーブルにアクセス可能なロール
CREATE ROLE devtask_role;
-- 実行ユーザーはスキーマのオーナーと同じロールに属する必要がある
GRANT devtask_role TO flyway_user;
-- データベースへの接続権限をアプリケーション管理ロールに付与する
GRANT CONNECT ON DATABASE devtask_db TO devtask_role;
