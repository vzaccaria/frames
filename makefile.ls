#!/usr/bin/env lsc 

{ parse, add-plugin } = require('newmake')

name            = "_site"
destination-dir = "#name"
source-dir      = "assets"

s = -> "#source-dir#it"
d = -> "#destination-dir#it"

{baseUrl} = require('./site.json')


parse ->


    @add-plugin 'bfy', (g, deps) ->
        @compile-files( (-> "browserify -t coffeeify -t liveify --extension=\".coffee\" #{it.orig-complete} -o #{it.build-target}"), ".js", g, deps)

    @add-plugin 'jadeBeml',(g, deps) ->
        @compile-files( (-> "jade -O ./site.json -P -p #{it.orig-complete} < #{it.orig-complete} | beml-cli > #{it.build-target}"), ".html", g, deps )

    @notifyStrip destination-dir 

    @serveRoot './_site'

    @collect "all", -> [
        @notify ~>
            @toDir d("/css"), { strip: s("/less") }, ->
                @less s("/less/client.less"), s("/less/*.less")


        @notify ~>
            @toDir d(""), { strip: s("") }, -> [
                @jadeBeml s("/index.jade")
                ]

        @notify ~>
            @toDir d("/svg"), { strip: s("/svg")}, -> [
                @copy s("/svg/*.svg")
                ]

        @notify ~>
            @dest d("/js/client.js"), ->
                    @concatjs -> [
                            @copy ("./bower_components/snap.svg/dist/snap.svg.js")
                            @bfy s("/js/client.ls"), s("/js/**/*.{ls,js}")
                            ]
        ]

    @collect "deploy", -> 
        @command-seq -> [
            @make "all"
            @cmd "blog-ftp-cli -l #name -r #baseUrl"
            ]

    @collect "clean", -> [
        @remove-all-targets()
        @cmd "rm -rf #name"
    ]



        

