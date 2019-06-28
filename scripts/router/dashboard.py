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

from widgets.range import Range

import pyttsx3
from dronekit import connect
import math
import time



class wValue(Widget):
    pressed = ListProperty([0, 0])

    def __init__(self, **kwargs):
        super(wValue, self).__init__(**kwargs)
        self.add_widget(Label(text = "Name"))


    def on_touch_down(self, touch):
        if self.collide_point(*touch.pos):
            self.pressed = touch.pos
            return True

        return super(wValue, self).on_touch_down(touch)

    def on_pressed(self, instance, pos):
        print ('pressed at {pos}'.format(pos=pos))


class LoginScreen(GridLayout):

    def __init__(self, **kwargs):
        super(LoginScreen, self).__init__(**kwargs)
        self.cols = 2
        self.add_widget(Label(text='User Name'))
        self.username = TextInput(multiline=False)
        self.add_widget(self.username)
        self.add_widget(Label(text='password'))
        self.password = TextInput(password=True, multiline=False)
        self.add_widget(self.password)

class dashboard(App):
    def build(self):
        self.connect()
        self.update_tab_callbacks()
        self.prepare()

        self.main_tab = TabbedPanel()
        self.main_tab.default_tab_text = "Basic"
        self.main_tab.default_tab_content = self.dashboard_base_tab()

        th = TabbedPanelHeader(text = "Speed asist")
        th.content = self.dashboard_speed_tab()
        self.main_tab.add_widget(th)

        print(self.main_tab.tab_list)
        return self.main_tab

    def prepare(self):
        self.target_speed = 10.0
        self.target_airspeed = True

    def alert(self, alert):
        Logger.info('ALERT:' + alert)

    def update_tab_callbacks(self):
        Logger.info("Nastavuji callbacky")
        self.callback_base = Clock.schedule_interval(self.cb_base, 1/10)
        self.callback_base = Clock.schedule_interval(self.cb_speed_asistent, 1/10)

    def connect(self, ip = "0.0.0.0", port = 11000):
        self.vehicle = connect("127.0.0.1:11000", status_printer = self.alert)
        Logger.info('Connected to vehicle')

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

        canvas.add_widget(Label(text = 'Ahoj!'))
        canvas.add_widget(Label(text = 'Ahoj!'))
        canvas.add_widget(wValue())

        return canvas

    def cb_speed_asistent(self, time):
        self.w_spd_airspeed.text = "Aspd: {:=6.3f}".format(self.vehicle.airspeed)
        self.w_spd_groundspeed.text = "Gspd: {:=6.3f}".format(self.vehicle.groundspeed)
        self.w_spd_targetspeed.text = "{}".format(self.target_speed)


        if self.target_airspeed: vspd = self.vehicle.airspeed
        else: vspd = self.vehicle.groundspeed
        offset = self.target_speed - vspd
        if abs(offset)>8:
            color = 'ff0000'
        elif abs(offset)>3:
            color = 'ffff00'
        else:
            color = '00ff00'
        self.w_spd_offset.text = """[size=20]Spd [/size][b]{:=+007.2f}[/b][size=20] m/s[/size]\n\n[size=20]Err [/size][b][color={}][size=70]{:=+007.2f}[/color][/size][/b][size=20] m/s[/size]""".format(vspd, color, offset)
        self.w_spd_range.set_value(50-offset*2)

    def cb_set_speed_source(self, instance, value):
        print(instance, value, instance.id)
        if value == 'down':
            if instance.id == 'plus':
                self.target_speed += 1
            elif instance.id == 'minus':
                self.target_speed -= 1
            elif instance.id == 'gspd':
                self.target_airspeed = False
            elif instance.id == 'aspd':
                self.target_airspeed = True

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
        setup.add_widget(btnPlus)
        setup.add_widget(self.w_spd_targetspeed)
        setup.add_widget(btnMinus)
        setup.add_widget(btnAspd)
        setup.add_widget(btnGspd)


        # zaskrtavatko - hlas, tón, pipani
        # Ukazatel

        data = BoxLayout(orientation='horizontal')

        data_actual = BoxLayout(orientation='vertical')
        self.w_spd_airspeed = Label(text = "Airspeed")
        self.w_spd_groundspeed = Label(text = "Goundspeed")
        data_actual.add_widget(self.w_spd_airspeed)
        data_actual.add_widget(self.w_spd_groundspeed)

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


if __name__ == '__main__':
    db = dashboard()
    db.run()
