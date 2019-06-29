import kivy
from kivy.config import Config
from kivy.app import App
from kivy.clock import Clock
from kivy.properties import NumericProperty
from kivy.properties import StringProperty
from kivy.properties import BoundedNumericProperty
from kivy.uix.boxlayout import BoxLayout
from kivy.uix.widget import Widget
from kivy.uix.scatter import Scatter
from kivy.uix.image import Image
from kivy.uix.label import Label
from kivy.uix.progressbar import ProgressBar
from os.path import join, dirname, abspath
from kivy.core.text import Label as CoreLabel
from kivy.graphics import Color, Ellipse, Rectangle, Line


class Range(ProgressBar):

    def __init__(self, **kwargs):
        super(Range, self).__init__(**kwargs)

        self.thickness = 40
        self.texture_size = None
        self.refresh_text()

        # Redraw on innit
        self.draw()

    def draw(self):

        with self.canvas:
            self.canvas.clear()

            Color(0.26, 0.26, 0.26)
            Rectangle(size=self.size, pos=self.pos)

            r = self.value_normalized*2-0.5 if self.value_normalized > 0.5 else 0
            g = (1-abs(0.5-self.value_normalized)*2)
            b = 1-self.value_normalized*2 if self.value_normalized < 0.5 else 0

            #print(r, g, b)
            Color(r, g, b, 1)
            Rectangle(size=(self.size[0]-30, self.size[1]*(self.value_normalized)), pos=(self.pos[0]+15, self.pos[1]))

            # Center and draw the progress text
            Color(0.5, 0.5, 1, 0.7)
            Line(points=[self.pos[0]+3, self.pos[1]+self.size[1]/2, self.pos[0]+self.size[0]-3, self.pos[1]+self.size[1]/2], width=3)

    def refresh_text(self):
        pass
        #self.label.refresh()
        #self.texture_size = list(self.label.texture.size)

    def set_value(self, value):
        self.value = value
        self.refresh_text()

        self.draw()




class SimpleRange(ProgressBar):

    def __init__(self, **kwargs):
        super(SimpleRange, self).__init__(**kwargs)

        self.thickness = 40
        self.texture_size = None
        self.refresh_text()

        # Redraw on innit
        self.draw()

    def draw(self):

        with self.canvas:
            self.canvas.clear()

            Color(0.26, 0.26, 0.26)
            Rectangle(size=self.size, pos=self.pos)

            #print(r, g, b)
            #Color(r, g, b, 1)
            Color(100, 100, 100, 1)
            Rectangle(size=(self.size[0]-30, self.size[1]*(self.value_normalized)), pos=(self.pos[0]+15, self.pos[1]))

            # Center and draw the progress text
            Color(0.5, 0.5, 0.5, 0.5)
            Line(points=[self.pos[0]+3, self.pos[1]+self.size[1]/2, self.pos[0]+self.size[0]-3, self.pos[1]+self.size[1]/2], width=1)

    def refresh_text(self):
        pass
        #self.label.refresh()
        #self.texture_size = list(self.label.texture.size)

    def set_value(self, value):
        self.value = value
        self.refresh_text()
        self.draw()
