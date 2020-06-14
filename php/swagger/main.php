<?php

require 'vendor/autoload.php';

use OpenApi\Serializer;
use OpenApi\Annotations\OpenApi;
use Symfony\Component\Yaml\Yaml;

$data = Yaml::parseFile('swagger.yml');
$json = json_encode($data);
$serializer = new Serializer;

$openapi = $serializer->deserialize($json, OpenApi::class);
foreach ($openapi->paths as $k => $path) {
    $items = (array) $path->get->responses[200]->content["application/json"]->schema->items;
    foreach ($items as $k => $item) {
        if ($k == "ref") {
            echo $item;
        }
    }
}