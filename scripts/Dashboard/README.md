# TFdashboard

TFdashboard UAV GCS ([Unmanned Aerial Vehicle](https://en.wikipedia.org/wiki/Unmanned_aerial_vehicle) - [Ground control station](https://en.wikipedia.org/wiki/Ground_control_station)) is appplication focused for easy and fast drone status chceck.

TFdashboard is developed for PX4 based airplanes. It should be compatibile with another systems that supports [mavlink](https://en.wikipedia.org/wiki/MAVLink) protocol.

Application is dividen in several screens.

## Basic

## Tow launch
This tab is focused for taking-off from the rope behind the car. Here you can set target airspeed and (car) driver should hold this speed. The right tri-color column shows offset from target speed. The best one is in the middle. 

![Tow launch](https://user-images.githubusercontent.com/5196729/60383096-022b0f80-9a6d-11e9-9676-529db8eb5006.png)

## PWM outputs and trimm
![PWM screen](https://user-images.githubusercontent.com/5196729/60383094-ffc8b580-9a6c-11e9-9e89-3890827878a7.png)


## Installation

### Stable (still alpha) releases

```
pip3 install TFdashboard 
```

### Development versions

```
git clone https://github.com/ThunderFly-aerospace/TF-R1.git
TF-R1/scripts/Dashboard
```
```
sudo python3 setup.py install
```
or 
```
sudo python3 setup.py develop
```

### Using TFdashboard
After succesful installation you can run TFdashboard by typing:
```
TFdashboard
```
