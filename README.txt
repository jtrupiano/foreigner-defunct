= foreigner

* http://github.com/jtrupiano/foreigner/tree/master

== DESCRIPTION:
This gem installs a ruby executable (foreigner) that will inspect a rails 
project's models and verify that their associations have a one-to-one 
correlation with the foreign key constraints set up in the MySQL database. 

== Usage:
foreigner [/full/path/to/rails/project/root]

Note: to run on a particular environment, invoke the executable as such:

$> RAILS_ENV=staging foreigner /full/path/to/rails/project/root

== INCOMPLETE ==
* Currently only inspects belongs_to and habtm relationships (has_one and has_many should be added)
* It likely misses any non-standard naming conventions (I almost never do this, so I don't have code handy to test with)
* No support for models defined in plugins, gems, etc.

== SYNOPSIS:

  FIX (code sample of usage)

== REQUIREMENTS:

* a rails app that uses MySQL

== INSTALL:

rake gem
sudo gem install pkg/foreigner-0.1.0.gem

== LICENSE:

(The MIT License)

Copyright (c) 2008 FIX

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
