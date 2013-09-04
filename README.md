sinatra_demo
============

This is a project to learn sinatra

# Commands

rubocop --auto-gen-config

# bundle
bundle check
bundle list  
bundle show [gemname]
bundle init

# active record

rake db:create_migration NAME=create_posts
createdb -O postgres sinatradb -h localhost -U postgres
rake db:migrate

Just remember 1 thing, require main in rake file

CREATE TABLE tbl_post (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    title VARCHAR(128) NOT NULL,
    content TEXT NOT NULL,
    create_time INTEGER NOT NULL
);

# load bundler with your dependencies load paths
require 'bundler/setup'
Bundler.require(:default, :test)

$ tux
>> Post.count
3
>> p = Post.new(title: "My Post", body: "This is exciting!")
>> p = new_record?
true
>> p.save
>> p.new_record?
false
>> Post.count
4

#event-machine

ab -c 10 -n 100 http://localhost:8181/delayed-hello

#localization:
ar, bg, bn-IN, bs, ca, cy, cz, da, de, de-AT, de-CH, dsb, el, en-GB, en-US, eo, es, es-AR, es-CO, es-MX, es-PE, et, eu, fa, fi, fr, fr-CA, fr-CH, fur, gl-ES, gsw-CH, he, hi-IN, hr, hsb, hu, id, is, it, ja, ko, lo, lt, lv, mk, mn, nb, nl, nn, pl, pt-BR, pt-PT, rm, ro, ru, sk, sl, sr, sr-Latn, sv-SE, sw, th, tr, uk, vi, zh-CN, zh-TW

#qa

https://github.com/cucumber/cucumber/wiki

http://selenium.googlecode.com/git/docs/api/rb/index.html

#rubocop

rubocop --auto-gen-config

# TODO:

* try to use some headless browser
* use machinist
* selenium more decent structure
* Sinatra::Contrib
* try sequel ohm, couchdb restclient,
* sina_em: I don't know what it mean

Thanks to:

* http://mherman.org/blog/2013/06/08/designing-with-class-sinatra-plus-postgresql-plus-heroku/

* http://www.danneu.com/posts/15-a-simple-blog-with-sinatra-and-active-record-some-useful-tools/
