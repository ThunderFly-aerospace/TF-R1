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

from src.widgets.range import Range

import pyttsx3
from dronekit import connect
from src.widgets.TrimTab import TrimTab
import math
import time



class wValue(Widget):
    pressed = ListProperty([0, 0])

    def __init__(self, **kwargs):
        super(wValue, self).__init__(**kwargs)

    def on_touch_down(self, touch):
        if self.collide_point(*touch.pos):
            self.pressed = touch.pos
            return True

        return super(wValue, self).on_touch_down(touch)

    def on_pressed(self, instance, pos):
        print ('pressed at {pos}'.format(pos=pos))



class dashboard(App):
    def __init__(self, arg = None):
        super(dashboard, self).__init__()
        self.arg = arg
        self.run()


    def build(self):

        self.connect()
        self.load_sounds()

        self.main_tab = TabbedPanel()
        self.trim_tab = TrimTab(self.vehicle, self.main_tab)

        #self.main_tab.bind(children=self.on_switch)
        self.main_tab.bind(current_tab=self.on_switch)

        self.update_tab_callbacks()
        self.prepare()

        self.main_tab.default_tab_text = "Basic"
        self.main_tab.default_tab_content = self.dashboard_base_tab()

        th = TabbedPanelHeader(text = "Speed asist")
        th.content = self.dashboard_speed_tab()
        self.main_tab.add_widget(th)


        th = TabbedPanelHeader(text = "Trim")
        th.content = self.trim_tab.content()
        self.main_tab.add_widget(th)
        #self.main_tab.add_widget(self.draw_bottom_line())

        self.status_release = -9


        self.status_bar = BoxLayout(orientation="horizontal")
        self.last_update = Label()
        self.last_update.text = "Test..."
        self.status_bar.add_widget(self.last_update)
        self.status_bar.size_hint = (None, 0.1)

        self.window = BoxLayout(orientation="vertical")
        self.window.add_widget(self.main_tab)
        self.window.add_widget(self.status_bar)
        return self.window

    def on_switch(self, widget, tab):
        print("Switch to", tab.content.children, self.trim_tab.content)
        self.trim_tab.set_active(False)

        if tab.content == self.trim_tab.content:
            print("Zapinam TrimTab")
            self.trim_tab.set_active(True)

    def load_sounds(self):
        self.sound_ping = SoundLoader.load('media/sounds/short-ping.flac')
        self.sound_pop = SoundLoader.load('media/sounds/pop.flac')

    def prepare(self):
        self.target_speed = 10.0
        self.target_airspeed = True

    def alert(self, alert):
        Logger.info('ALERT:' + alert)

    def update_tab_callbacks(self):
        Logger.info("Nastavuji callbacky")
        self.callback_global = Clock.schedule_interval(self.cb_global, 1/10)
        self.callback_base = Clock.schedule_interval(self.cb_base, 1/10)
        self.callback_speed = Clock.schedule_interval(self.cb_speed_asistent, 1/10)
        self.callback_trim = Clock.schedule_interval(self.trim_tab.update, 1/10)

    def connect(self, ip = "0.0.0.0", port = 11000):
        self.vehicle = connect("0.0.0.0:11000", status_printer = self.alert)
        #self.vehicle = connect("0.0.0.0:14550", status_printer = self.alert)
        self.vehicle.initialize()
        Logger.info('Connected to vehicle')
        self.tts = pyttsx3.init()

    def cb_global(self, time):
        self.last_update.text = "Last update in: {:.2f}".format(self.vehicle.last_heartbeat)

    def cb_base(self, time):

        self.w_base_pitch_value.text = '''
            Pitch:  {:=+8.2f}
            Roll:     {:=+8.2f}
            Yaw:     {:=+8.2f}
            '''.format(math.degrees(self.vehicle.attitude.pitch),
                       math.degrees(self.vehicle.attitude.roll),
                       math.degrees(self.vehicle.attitude.yaw))

        armed = "ARMed" if self.vehicle.armed else "DISARMed"
        self.w_base_status_text.text = '''
            {}
            {}
            {}
            '''.format(self.vehicle.system_status.state,
                self.vehicle.mode.name, armed)

        self.w_base_spd_value.text = '''
        Aspd: {:5.2f}
        Gspd: {:5.2f}
        '''.format(self.vehicle.airspeed, self.vehicle.groundspeed)

        self.w_base_gps_value.text = '''
        FIX: {}
        Count: {}
        VHDOP: {}\{}
        '''.format(self.vehicle.gps_0.fix_type, self.vehicle.gps_0.satellites_visible,
            self.vehicle.gps_0.epv, self.vehicle.gps_0.eph)



    def dashboard_base_tab(self):
        canvas = GridLayout()
        canvas.cols = 3

        l = BoxLayout(orientation='vertical')
        l.add_widget(Label(text = "Status"))
        self.w_base_status_text = Label(font_size = "20sp", halign="center")
        l.add_widget(self.w_base_status_text)
        canvas.add_widget(l)

        l = BoxLayout(orientation='vertical')
        l.add_widget(Label(text = "Attitude"))
        self.w_base_pitch_value = Label(font_size = "25sp", halign="left")
        l.add_widget(self.w_base_pitch_value)
        canvas.add_widget(l)

        l = BoxLayout(orientation='vertical')
        l.add_widget(Label(text = "Speed"))
        self.w_base_spd_value = Label(font_size = "25sp", halign="left")
        l.add_widget(self.w_base_spd_value)
        canvas.add_widget(l)

        l = BoxLayout(orientation='vertical')
        l.add_widget(Label(text = "GPS"))
        self.w_base_gps_value = Label(font_size = "25sp", halign="left")
        l.add_widget(self.w_base_gps_value)
        canvas.add_widget(l)

        canvas.add_widget(wValue())

        return canvas

    def cb_speed_asistent(self, time):
        #self.w_spd_release_status.text = "Aspd: {:=6.3f}".format(self.vehicle.airspeed)
        #self.w_spd_speed_info.text = "Gspd: {:=6.3f}".format(self.vehicle.groundspeed)
        #self.w_spd_targetspeed.text = "{}m\s ({})".format(self.target_speed, self.target_speed*3.6)

        if self.status_release != round((self.vehicle.channels.get('9', 0)-1500)/500.0):
            self.status_release = round((self.vehicle.channels.get('9', 0)-1500)/500.0)
            self.sound_ping.play()

            if self.status_release == -1:
                text = "Připojeno"
                color = "00ff00"
            elif self.status_release == 1:
                text = "Odpojeno"
                color = "ff0000"
            else:
                text = "--neznám--"
                color = "FFA500"

            text = "[b][color={}][size=50]{}[/size][/color][/b]".format(color, text)
            self.w_spd_release_status.text = text

        self.w_spd_speed_info.text = "Airspeed:[size=24]\n{:.2f}[/size]\n".format(self.vehicle.airspeed*3.6)
        self.w_spd_speed_info.text+= "Groundspeed: \n [size=24]{:.2f}[/size] \n".format(self.vehicle.groundspeed*3.6)
        self.w_spd_speed_info.text+= "Delta: \n [size=24]{:.2f}[/size] \n".format((self.vehicle.groundspeed-self.vehicle.airspeed)*3.6)

        if self.target_airspeed: vspd = self.vehicle.airspeed
        else: vspd = self.vehicle.groundspeed
        offset = self.target_speed - vspd

        if abs(offset)>8:
            color = 'ff0000'
        elif abs(offset)>3:
            color = 'ffff00'
        else:
            color = '00ff00'
        self.w_spd_offset.text = """[/size][b][color={}][size=70]{:=+5.0f}[/color][/size][/b]""".format(color, offset*3.6)
        self.w_spd_range.set_value(50 - offset*100/14)

    def cb_set_speed_source(self, instance, value):
        if value == 'down':
            if instance.id == 'plus':
                self.target_speed += 1
            elif instance.id == 'minus':
                self.target_speed -= 1
            elif instance.id == 'gspd':
                self.target_airspeed = False
            elif instance.id == 'aspd':
                self.target_airspeed = True

            self.w_spd_targetspeed.text = "{}m\s ({})".format(self.target_speed, self.target_speed*3.6)



    def dashboard_speed_tab(self):
        canvas = BoxLayout(orientation='vertical')

        # 1st layer
        setup = BoxLayout(orientation='horizontal')
        #setup.height = 20
        setup.size_hint = (1, None)
        btnPlus  = Button(text='-', id = "minus")
        self.w_spd_targetspeed = Label(text='10', font_size = "20sp")
        btnMinus = Button(text='+', id="plus")
        btnAspd = ToggleButton(text='AirSpeed', id = "aspd", group='speed_source', state='down')
        btnGspd = ToggleButton(text='GndSpeed', id = "gspd", group='speed_source')
        btnAspd.bind(state=self.cb_set_speed_source)
        btnGspd.bind(state=self.cb_set_speed_source)
        btnPlus.bind(state=self.cb_set_speed_source)
        btnMinus.bind(state=self.cb_set_speed_source)
        swRead = Switch(active=False)
        swRead.bind(active=self.toggle_reading)
        setup.add_widget(btnPlus)
        setup.add_widget(self.w_spd_targetspeed)
        setup.add_widget(btnMinus)
        setup.add_widget(btnAspd)
        setup.add_widget(btnGspd)
        setup.add_widget(swRead)

        # zaskrtavatko - hlas, tón, pipani
        # Ukazatel

        data = BoxLayout(orientation='horizontal')

        data_actual = BoxLayout(orientation='vertical')
        self.w_spd_release_status = Label(text = "--Release--", markup=True)
        self.w_spd_speed_info = Label(text = "info", markup=True, halign = "center")
        data_actual.add_widget(self.w_spd_release_status)
        data_actual.add_widget(self.w_spd_speed_info)

        data_offset = BoxLayout(orientation='vertical')
        self.w_spd_offset = Label(text = "Err", font_size = "50sp", markup=True)
        data_offset.add_widget(self.w_spd_offset)

        self.w_spd_range = Range()

        data.add_widget(data_actual)
        data.add_widget(data_offset)
        data.add_widget(self.w_spd_range)

        canvas.add_widget(setup)
        canvas.add_widget(data)
        return canvas

    def toggle_reading(self, widget, state):
        if state:
            self.reading_timer = Clock.schedule_interval(self.read_velocity, 1.5)
        else:
            self.reading_timer.cancel()

    def read_velocity(self, time):
        print("Rychlost je", self.vehicle.groundspeed*3.6)
        self.tts.say("{}".format(round(self.vehicle.groundspeed*3.6)))
        self.tts.runAndWait()



def main():
    db = dashboard()

if __name__ == '__main__':
    main()
