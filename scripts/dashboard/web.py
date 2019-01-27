#!/usr/bin/python
# -*- coding: utf-8 -*-
import tornado
#from tornado import web
from tornado import ioloop
from tornado import auth
from tornado import escape
from tornado import httpserver
from tornado import options
from tornado import web

import time
import datetime
import calendar
import os


tornado.options.define("port", default=8888, help="port", type=int)
tornado.options.define("debug", default=True, help="debug mode", type=bool)

class home(web.RequestHandler):
    def get(self, path = None):
        self.write("Ahoj!!! :) ")

class rover_dashboard(web.RequestHandler):
    def get(self):
        self.render('rover.dashboard.hbs')

class WebApp(tornado.web.Application):
    def __init__(self, config={}):

        name = 'TF-R1 dashboard'
        server = 'loralhost'
        server_url = '{}:{}'.format(server, tornado.options.options.port)


        handlers = [
            #staticke soubory je vhodne nahradit pristupem primo z proxy serveru. (pak to tolik nevytezuje tornado)
            (r'/favicon.ico', tornado.web.StaticFileHandler, {'path': "/static/"}),
            (r'/static/(.*)', tornado.web.StaticFileHandler, {'path': 'static/'}),
            (r'/rover/dashboard/', rover_dashboard),
            (r'/rover/dashboard', rover_dashboard),
            (r'(.*)', home),
            (r'/(.*)', home)
        ]

        settings = dict(
            template_path= "templates/",
            static_path= "static/",
            xsrf_cookies=False,
            name=name,
            server_url=server_url,
            site_title=name,
            login_url="/login",
            #ui_modules=modules,
            port=tornado.options.options.port,
            compress_response=True,
            debug=tornado.options.options.debug,
            autoreload=True
        )
        #tornado.locale.load_translations("locale/")
        print("Done")
        tornado.web.Application.__init__(self, handlers, **settings)

def main():
    import os
    tornado.options.parse_command_line()
    http_server = tornado.httpserver.HTTPServer(WebApp())
    http_server.listen(tornado.options.options.port)
    tornado.ioloop.IOLoop.instance().start()
    #http_server.start(4)

if __name__ == "__main__":
    main()
