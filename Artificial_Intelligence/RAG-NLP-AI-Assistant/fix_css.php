<?php
$dir = new RecursiveIteratorIterator(new RecursiveDirectoryIterator("Admin-Finale"));
foreach ($dir as $file) {
    if ($file->isFile() && pathinfo($file, PATHINFO_EXTENSION) === "php") {
        $content = file_get_contents($file);
        if (strpos($content, "css/style.css") !== false) {
            $content = preg_replace("/css\/style\.css(\?[^\"\'\s>]+)?/", "css/style.css?v=" . time(), $content);
            file_put_contents($file, $content);
            echo "Updated " . $file->getPathname() . "\n";
        }
    }
}
