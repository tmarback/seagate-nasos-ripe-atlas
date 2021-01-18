<!doctype html>

<html lang="en">
    <head>
        <meta charset="utf-8">

        <title>RIPE Atlas Probe</title>
        <meta name="description" content="RIPE Atlas Probe Console">
        <meta name="author" content="tmarback@sympho.dev">

        <meta http-equiv="content-type" content= "text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href= "/3rdparty/3rdparty.css">
        <script type="text/javascript" src="/3rdparty/3rdparty.js"></script>

        <link rel="stylesheet" type="text/css" href= "./main.css">
    </head>

    <body>
        <h1>RIPE Atlas Probe Console</h1>
        
        <h2>Public Key</h2>
        <div class="text_box console_text">
            <?= file_get_contents('/var/atlas-probe/etc/probe_key.pub'); ?>
        </div>

        <h2>Atlas Log</h2>
        <div class="text_box console_text log_text"><?php 
            $logfile = '/var/log/atlas/atlas.log';
            $log = file_get_contents($logfile); 
            if ( file_exists($logfile . '.1') )                                                
                $log = file_get_contents($logfile . '1') . $log;
            echo $log;
        ?></div>
    </body>
</html>
