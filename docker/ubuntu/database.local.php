<?php

return [
    'doctrine' => [
        'connection' => [
            'orm_default' => [
                'params' => [
                    'host' => 'mariadb',
                    'user' => 'monarc',
                    'password' => 'demo',
                    'dbname' => 'monarc_common',
                ],
            ],
            'orm_cli' => [
                'params' => [
                    'host' => 'mariadb',
                    'user' => 'monarc',
                    'password' => 'demo',
                    'dbname' => 'monarc_cli',
                ],
            ],
        ],
    ],
];