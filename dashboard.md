# Dashboard 

__Popis uživatelského rozhaní pro obsluhu dronů ThunderFly__



## ReTerminal dashboard 


### Takeoff driver view

Zobrazení pro řidiče je určeno pro snadné provedení startu ze střechy auta za pomoci platformy. Zobrazení je co nejjednodušší bez zbytčných informací navíc. V levé části je zobrazen indikátor ukazující aktuální airspeed z vírníku a pomocí zeleného pruhu. 

V levé části pak je indikace stavu jednotlivých komponent. První dlaždice indikuje stav platformy. 


**Platforma**



**Vírník**

Indikátor může mít několik stavů: 

 * Žlutá: "Not ready" - stejný význam jako v QGC. Vírník není připraven k naarmování. Zkontroluj v QGC. 
 * Zelená: "Arm" - Naarmováno. Za letu by mělo být pole zelené
 * Modrá: "Takeoff" - při spuštěném startovacím procesu bude pole modré
 * Šedá: "Inactive" - nemám data. 


![obrazek](https://user-images.githubusercontent.com/5196729/167265046-1a38c656-e41a-4df0-9e77-c6866e08d222.png)

