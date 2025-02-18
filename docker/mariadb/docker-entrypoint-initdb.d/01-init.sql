
CREATE DATABASE IF NOT EXISTS monarc_cli DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
CREATE DATABASE IF NOT EXISTS monarc_common DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;

GRANT ALL PRIVILEGES ON monarc_cli.* TO 'monarc'@'%';
GRANT ALL PRIVILEGES ON monarc_common.* TO 'monarc'@'%';

FLUSH PRIVILEGES;
