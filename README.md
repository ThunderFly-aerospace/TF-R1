# ThunderFly mission rover TF-R1
Mission support rover for unmanned drones. 

ThunderFly developes UAVs designed for flying in extreme conditions. In these conditions, it can be dangerous for the mission crew to be under sky. The aim of this rover is keep crew in safety of car chassis and be able to proceed drone takeoff.

Car is equipted with necessary equipment to perform flight operations. 

![TF-R1 in the field](/doc/TF-R1.jpg)

The rover is equipped by:
  * Datalink telemetry diagnostics tools
  * Long range datalink modem
  * Datalink antennas
  * UAV pilot terminal
  * Driver indicators
  * Off-the-board computer
  * Camera recorders
  * Data recorders
  * GNSS RTK reference
  * Weather sensors
  * Aerotow hitch


## ThunderFly UAV Groung control station ([TF-BOX]())
Ground control station (GCS) is one of key element of unmanned system. GCS has several tasks. 

**High important**:
 * Ensuring high quality data connection to UAV
 * Monitors drone condition (battery, fail-safe modes, position, ...)
 * Allows the operator to control and command the UAV
**Optional**:
 * Live data collecting
 * Visualization of some units
 * Dron UX for operator



### ThunderFly implementation
[![](https://mermaid.ink/img/eyJjb2RlIjoiZ3JhcGggVERcbiAgICBBW1R1cnJpcyBNT1hdIC0tPiBCKENQVSlcbiAgICBBIC0tPiBNUChNT1ggUG9FKVxuICAgIEEgLS0-IE1BKE1PWCBBIC1jcHUpXG4gICAgQSAtLT4gTUcoTU9YIEcgLSBtUENJZSB3aWZpKVxuICAgIEEgLS0-IE1GKE1PWCBGIC0gVVNCKVxuICAgIEEgLS0-IE1DKE1PWCBDIC0gU3dpdGNoKVxuXG4gICAgTUEgLS0-IFAoUG93ZXIgc291cmNlKVxuICAgIFAgLS0-IElOVig4LTE2ViAtPiAxMlYgcG93ZXIgc3VwcGx5KVxuICAgIElOViAtLT4gUEIoUEIgYmF0dGVyeSwgY2hhcmdpbmcgZnJvbSBDQVIgc29ja2V0KVxuICAgIE1BIC0tPiB8VVNCfCBEKERhdGEgc3RvcmFnZSlcbiAgICBEIC0tPiBMWEMoTFhDIGNvbnRhaW5lcnMpXG4gICAgRCAtLT4gREFUQShVc2VyIGRhdGEgc3RvcmFnZSlcblxuICAgIE1HIC0tPiBXSUZJXG5cbiAgICBNRiAtLT4gfFVTQnwgREwoRGF0YSBsaW5rIHRvIFVBVilcbiAgICBNRiAtLT4gfFVTQnwgT0JJKE90aGVyIG9uLWJvYXJkIGluc3RydW1lbnRzKVxuXG4gICAgTUMgLS0-IHxFVEh8IE9QKE9wZXJhdG9yIGxhcHRvcClcbiAgICBNQyAtLT4gfEVUSHwgT1QoT3BlcmF0b3IgdGVybWluYWwpXG4gICAgTUMgLS0-IHxFVEh8IElOVChJbnRlcm5ldCBzb3VyY2UgLSBPbW5pYSB3aXRoIExURSBtb2RlbSkiLCJtZXJtYWlkIjp7fSwidXBkYXRlRWRpdG9yIjpmYWxzZX0)](https://mermaid-js.github.io/mermaid-live-editor/#/edit/eyJjb2RlIjoiZ3JhcGggVERcbiAgICBBW1R1cnJpcyBNT1hdIC0tPiBCKENQVSlcbiAgICBBIC0tPiBNUChNT1ggUG9FKVxuICAgIEEgLS0-IE1BKE1PWCBBIC1jcHUpXG4gICAgQSAtLT4gTUcoTU9YIEcgLSBtUENJZSB3aWZpKVxuICAgIEEgLS0-IE1GKE1PWCBGIC0gVVNCKVxuICAgIEEgLS0-IE1DKE1PWCBDIC0gU3dpdGNoKVxuXG4gICAgTUEgLS0-IFAoUG93ZXIgc291cmNlKVxuICAgIFAgLS0-IElOVig4LTE2ViAtPiAxMlYgcG93ZXIgc3VwcGx5KVxuICAgIElOViAtLT4gUEIoUEIgYmF0dGVyeSwgY2hhcmdpbmcgZnJvbSBDQVIgc29ja2V0KVxuICAgIE1BIC0tPiB8VVNCfCBEKERhdGEgc3RvcmFnZSlcbiAgICBEIC0tPiBMWEMoTFhDIGNvbnRhaW5lcnMpXG4gICAgRCAtLT4gREFUQShVc2VyIGRhdGEgc3RvcmFnZSlcblxuICAgIE1HIC0tPiBXSUZJXG5cbiAgICBNRiAtLT4gfFVTQnwgREwoRGF0YSBsaW5rIHRvIFVBVilcbiAgICBNRiAtLT4gfFVTQnwgT0JJKE90aGVyIG9uLWJvYXJkIGluc3RydW1lbnRzKVxuXG4gICAgTUMgLS0-IHxFVEh8IE9QKE9wZXJhdG9yIGxhcHRvcClcbiAgICBNQyAtLT4gfEVUSHwgT1QoT3BlcmF0b3IgdGVybWluYWwpXG4gICAgTUMgLS0-IHxFVEh8IElOVChJbnRlcm5ldCBzb3VyY2UgLSBPbW5pYSB3aXRoIExURSBtb2RlbSkiLCJtZXJtYWlkIjp7fSwidXBkYXRlRWRpdG9yIjpmYWxzZX0)

# DashBoard app

The dashboard application is used for display of essential data for UAV mission.  It is used by all crew members while the UAV is in the flight. 
```bash
  sudo pip3 install kivy pyttsx
  sudo apt install libespeak1
```
