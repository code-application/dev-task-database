-- UUIDを使用する拡張機能
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- アプリケーションで使用するテーブルが属するスキーマ
CREATE SCHEMA IF NOT EXISTS devtask AUTHORIZATION devtask_role;
GRANT ALL ON SCHEMA devtask TO devtask_role;


-- 今後追加されるテーブルに対するデフォルトの権限を修正する
-- デフォルトから変更する場合、テーブル作成後に明示的に権限を修正する
-- デフォルトの権限は今後作成するすべてのテーブルに適用されるため、必要最小限の権限を設定する
ALTER DEFAULT PRIVILEGES IN SCHEMA devtask
    GRANT ALL ON TABLES TO devtask_role;


-- アプリケーションで使用するテーブルを管理するためのユーザー
-- グループロール(devtask_role)の権限を継承するためにINHERITを設定
CREATE USER devtask_user WITH INHERIT PASSWORD '${DEVTASK_PASSWORD}';
GRANT devtask_role TO devtask_user;


-- APIの実行ユーザー
CREATE USER api_client WITH INHERIT PASSWORD '${API_CLIENT_PASSWORD}';
-- flywayで権限設定するためにflyway_userにロールを付与する
GRANT api_client TO flyway_user;

-- API実行ユーザーに権限を付与する
GRANT CONNECT ON DATABASE devtask_db TO api_client;
GRANT USAGE ON SCHEMA devtask TO api_client;
-- 今後追加されるテーブルに対するデフォルトの権限を修正する
-- デフォルトから変更する場合、テーブル作成後に明示的に権限を修正する
-- デフォルトの権限は今後作成するすべてのテーブルに適用されるため、必要最小限の権限を設定する
ALTER DEFAULT PRIVILEGES IN SCHEMA devtask
    GRANT ALL ON TABLES TO api_client;