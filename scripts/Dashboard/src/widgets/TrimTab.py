from kivy.app import App
from kivy.properties import ListProperty, StringProperty
from kivy.uix.widget import Widget
from kivy.uix.gridlayout import GridLayout
from kivy.uix.boxlayout import BoxLayout
from kivy.uix.label import Label
from kivy.uix.layout import Layout
from kivy.uix.button import Button
from kivy.uix.togglebutton import ToggleButton
from kivy.uix.switch import Switch
from kivy.uix.textinput import TextInput
from kivy.uix.tabbedpanel import TabbedPanel, TabbedPanelHeader, TabbedPanelItem
from kivy import uix
from kivy.clock import Clock
from kivy.logger import Logger
from kivy.core.audio import SoundLoader

from .range import SimpleRange
from functools import partial


class TrimTab():

    def __init__(self, vehicle, tabs):
        super(TrimTab, self).__init__()
        self.vehicle = vehicle
        self.tabs = tabs
        self.channels = 14
        self.active = False

    def content(self):
        layout = BoxLayout(orientation='horizontal')

        load_btn = Button(text = "Load param")
        load_btn.bind(on_press=self.update_params)
        layout.add_widget(load_btn)

        for i in range(self.channels):
            chnum = i+1
            channel_box = BoxLayout(orientation='vertical')

            channel_box.add_widget(Label(text="{}{}".format("M" if i<8 else "A", chnum), size_hint=(1, .1)))
            setattr(self, "btn_trim_{}_p".format(chnum), Button(text = "+", size_hint=(1, .15)))
            setattr(self, "val_trim_{}".format(chnum), Label(text = "0", size_hint=(1, .2), markup=True))
            setattr(self, "btn_trim_{}_m".format(chnum), Button(text = "-", size_hint=(1, .15)))
            setattr(self, "val_out_{}".format(chnum), Label(text = "0", size_hint=(1, .2), markup=True))
            setattr(self, "range_out_{}".format(chnum), SimpleRange())

            getattr(self, "btn_trim_{}_p".format(chnum)).bind(on_press = partial(self.change_offset, chnum, +1))
            getattr(self, "btn_trim_{}_m".format(chnum)).bind(on_press = partial(self.change_offset, chnum, -1))

            channel_box.add_widget(getattr(self, "btn_trim_{}_p".format(chnum)))
            channel_box.add_widget(getattr(self, "val_trim_{}".format(chnum)))
            channel_box.add_widget(getattr(self, "btn_trim_{}_m".format(chnum)))
            channel_box.add_widget(getattr(self, "val_out_{}".format(chnum)))
            channel_box.add_widget(getattr(self, "range_out_{}".format(chnum)))

            layout.add_widget(channel_box)
        return layout

    def set_active(self, active):
        self.active = active

    def change_offset(self, pwm, operation, data):
        if pwm < 9:
            param = "PWM_MAIN_TRIM{}"
        else:
            param = "PWM_AUX_TRIM{}"
            pwm -= 8

        trim = self.vehicle.parameters.get(param.format(pwm), 0)
        trim = round(trim, 2)+operation*0.01
        if trim > 1: trim = 1
        if trim < -1: trim = -1
        self.vehicle.parameters.set(param.format(pwm), trim)

        self.update_params()


    def update_params(self, btn = None):
        for i in range(1, self.channels):

            if i < 9:
                param = "PWM_MAIN_TRIM{}"
                pwm = i
            else:
                param = "PWM_AUX_TRIM{}"
                pwm = i- 8
            value = self.vehicle.parameters.get(param.format(pwm), -10)
            if value == 0:
                tval = "{:.0f}"
            else:
                tval = "[b]{:.2f}[/b]"
            getattr(self, 'val_trim_{}'.format(i)).text = tval.format(value)


    def update(self, time):
        if self.active:
            print("Update trim", time)
        print(self.vehicle)
        for i in range(self.channels):
            try:
                pass
                getattr(self, 'val_out_{}'.format(i+1)).text = "{}".format(self.vehicle.channels.get(str(i+1), -999))
                getattr(self, "range_out_{}".format(i+1)).set_value((self.vehicle.channels.get(str(i+1), -999)-1000)/10.0)
            except Exception as e:
                pass
                #print("Err", e)
