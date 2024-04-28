-- アプリケーションで使用するテーブルが属するスキーマ
CREATE SCHEMA IF NOT EXISTS devtask AUTHORIZATION devtask_role;
GRANT ALL PRIVILEGES ON SCHEMA devtask TO devtask_role;
