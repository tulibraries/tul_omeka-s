<?php
return [
    'logger' => [
        'log' => false,
        'priority' => \Laminas\Log\Logger::NOTICE,
    ],
    'http_client' => [
        'sslcapath' => null,
        'sslcafile' => null,
    ],
    'session' => [
        'config'=> [
            'cookie_secure' => true,
      ]
    ],
    'cli' => [
        'phpcli_path' => null,
    ],
    'thumbnails' => [
        'types' => [
            'large' => ['constraint' => 800],
            'medium' => ['constraint' => 200],
            'square' => ['constraint' => 200],
        ],
        'thumbnailer_options' => [
            'imagemagick_dir' => null,
        ],
    ],
    'translator' => [
        'locale' => 'en_US',
    ],
    'service_manager' => [
        'aliases' => [
            'Omeka\File\Store' => 'Omeka\File\Store\Local',
            'Omeka\File\Thumbnailer' => 'Omeka\File\Thumbnailer\ImageMagick',
        ],
    ],
    'mail' => [
        'transport' => [
            'type' => 'smtp',
            'options' => [
                'name' => getenv('MAIL_SERVER_NAME'),
                'host' => getenv('MAIL_SERVER'),
                'port' => '587',
                'connection_class' => 'plain',
                'connection_config' => [
                    'username' => getenv('MAIL_ADDRESS'),
                    'password' => getenv('MAIL_PASSWORD'),
                    'ssl' => 'tls',
                    'use_complete_quit' => true,
                ],
            ],
        ],
    ],
];
