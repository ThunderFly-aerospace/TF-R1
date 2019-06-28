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

        # Set constant for the bar thickness
        self.thickness = 40

        #self.label = CoreLabel(text="0%", font_size=self.thickness)

        self.texture_size = None

        # Refresh the text
        self.refresh_text()

        # Redraw on innit
        self.draw()

    def draw(self):

        with self.canvas:
            self.canvas.clear()

            Color(0.26, 0.26, 0.26)
            Rectangle(size=self.size, pos=self.pos)

            if abs(0.5-self.value_normalized)>0.16:
                Color(1, 0, 0)
            elif abs(0.5-self.value_normalized)>0.06:
                Color(1, 1, 0)
            else:
                Color(0, 1, 0)
            Rectangle(size=(self.size[0]-30, self.size[1]*(self.value_normalized)), pos=(self.pos[0]+15, self.pos[1]))

            # Center and draw the progress text
            Color(0.5, 0.5, 1, 0.7)
            Line(points=[self.pos[0]+3, self.pos[1]+self.size[1]/2, self.pos[0]+self.size[0]-3, self.pos[1]+self.size[1]/2], width=3)
            #Rectangle(texture=self.label.texture, size=self.texture_size,
            #          pos=(self.size[0]/2 - self.texture_size[0]/2, self.size[1]/2 - self.texture_size[1]/2))

    def refresh_text(self):
        pass
        #self.label.refresh()
        #self.texture_size = list(self.label.texture.size)

    def set_value(self, value):
        self.value = value

        #self.label.text = str(int(self.value_normalized*100)) + "%"
        self.refresh_text()

        self.draw()
