v 20130925 2
C 40000 40000 0 0 0 title-B.sym
C 42100 46600 1 0 0 TL431-1.sym
{
T 43800 48300 5 10 1 1 0 0 1
refdes=U1
T 42400 48300 5 10 1 1 0 0 1
device=TL431
T 42400 48700 5 10 0 0 0 0 1
footprint=TO92
}
C 39400 41900 1 0 0 LM35.sym
{
T 41200 43200 5 10 1 1 0 6 1
refdes=U4
T 40300 42900 5 10 0 0 0 0 1
device=LM35
T 40300 43100 5 10 0 0 0 0 1
footprint=TO92
T 40600 42900 5 10 0 0 0 0 1
device=PTC
T 39400 41900 5 10 0 0 0 0 1
net=+5V:1
}
C 41800 47500 1 90 0 resistor-2.sym
{
T 41450 47900 5 10 0 0 90 0 1
device=RESISTOR
T 41500 47700 5 10 1 1 90 0 1
refdes=R2
T 41800 47500 5 10 0 0 0 0 1
value=10k
T 41800 47500 5 10 0 0 0 0 1
footprint=ACY300
}
C 41800 46600 1 90 0 resistor-2.sym
{
T 41450 47000 5 10 0 0 90 0 1
device=RESISTOR
T 41500 46900 5 10 1 1 90 0 1
refdes=R3
T 41800 46600 5 10 0 0 0 0 1
value=10k
T 41800 46600 5 10 0 0 0 0 1
footprint=ACY300
}
C 43300 49000 1 90 0 resistor-2.sym
{
T 42950 49400 5 10 0 0 90 0 1
device=RESISTOR
T 43000 49200 5 10 1 1 90 0 1
refdes=R1
T 43300 49000 5 10 0 0 0 0 1
value=50
T 43300 49000 5 10 0 0 0 0 1
footprint=ACY300
}
N 49500 43200 49500 43500 4
N 49500 43500 50200 43500 4
C 49600 43200 1 0 0 ground.sym
C 43000 46300 1 0 0 ground.sym
C 41500 46300 1 0 0 ground.sym
C 43000 49900 1 0 0 vcc-1.sym
N 43200 49000 43200 48500 4
C 44300 49000 1 0 0 5V-plus-1.sym
C 46100 45000 1 0 0 vcc-1.sym
N 50200 44400 50200 45000 4
N 42100 47500 41700 47500 4
N 41700 48400 41700 48800 4
N 41700 48800 43200 48800 4
N 44500 49000 44500 48800 4
N 44500 48800 43200 48800 4
N 46300 41800 46300 45000 4
N 46300 42300 46800 42300 4
N 46800 42600 46300 42600 4
N 49700 47800 50400 47800 4
N 46800 43500 46800 43200 4
C 46300 43200 1 0 0 ground.sym
N 46500 43500 46800 43500 4
N 49500 42600 50300 42600 4
N 50300 41800 46300 41800 4
C 51800 47100 1 180 0 input-2.sym
{
T 51800 46900 5 10 0 0 180 0 1
net=TMP:1
T 51200 46400 5 10 0 0 180 0 1
device=none
T 51300 47000 5 10 1 1 180 7 1
value=Temp
}
C 51800 47900 1 180 0 input-2.sym
{
T 51800 47700 5 10 0 0 180 0 1
net=SW:1
T 51200 47200 5 10 0 0 180 0 1
device=none
T 51300 47800 5 10 1 1 180 7 1
value=Switch
}
C 44300 44300 1 0 0 input-2.sym
{
T 44300 44500 5 10 0 0 0 0 1
net=PWM1:1
T 44900 45000 5 10 0 0 0 0 1
device=none
T 44800 44400 5 10 1 1 0 7 1
value=PWM1
}
C 52200 42400 1 180 0 input-2.sym
{
T 52200 42200 5 10 0 0 180 0 1
net=PWM2:1
T 51600 41700 5 10 0 0 180 0 1
device=none
T 51700 42300 5 10 1 1 180 7 1
value=PWM2
}
N 50800 42300 49500 42300 4
N 45700 44400 46800 44400 4
N 50400 47000 49700 47000 4
C 50400 48500 1 0 0 output-2.sym
{
T 51300 48700 5 10 0 0 0 0 1
net=PWM1:1
T 50600 49200 5 10 0 0 0 0 1
device=none
T 51300 48600 5 10 1 1 0 1 1
value=PWM1
}
C 50400 48100 1 0 0 output-2.sym
{
T 51300 48300 5 10 0 0 0 0 1
net=PWM2:1
T 50600 48800 5 10 0 0 0 0 1
device=none
T 51300 48200 5 10 1 1 0 1 1
value=PWM2
}
C 50800 42800 1 0 0 output-2.sym
{
T 51700 43000 5 10 0 0 0 0 1
net=FAN2:1
T 51000 43500 5 10 0 0 0 0 1
device=none
T 51700 42900 5 10 1 1 0 1 1
value=Fan 2
}
C 45700 43000 1 180 0 output-2.sym
{
T 44800 42800 5 10 0 0 180 0 1
net=FAN1:1
T 45500 42300 5 10 0 0 180 0 1
device=none
T 44800 42900 5 10 1 1 180 1 1
value=Fan 1
}
N 46400 42900 46800 42900 4
N 49500 42900 50100 42900 4
N 50400 48600 49700 48600 4
N 49700 48200 50400 48200 4
C 54400 44300 1 0 0 connector2-2.sym
{
T 55100 45600 5 10 1 1 0 6 1
refdes=Button
T 54700 45550 5 10 0 0 0 0 1
device=CONNECTOR_2
T 54700 45750 5 10 0 0 0 0 1
footprint=SIP2N
}
C 54400 46000 1 0 0 connector3-2.sym
{
T 55100 47700 5 10 1 1 0 6 1
refdes=Fan 2
T 54700 47650 5 10 0 0 0 0 1
device=CONNECTOR_3
T 54700 47850 5 10 0 0 0 0 1
footprint=SIP3N
}
C 41100 44200 1 0 1 connector3-2.sym
{
T 40400 45900 5 10 1 1 0 0 1
refdes=Power
T 40800 45850 5 10 0 0 0 6 1
device=CONNECTOR_3
T 40800 46050 5 10 0 0 0 6 1
footprint=SIP3N
}
C 54400 42100 1 0 0 connector3-2.sym
{
T 55100 43800 5 10 1 1 0 6 1
refdes=Temperature
T 54700 43750 5 10 0 0 0 0 1
device=CONNECTOR_3
T 54700 43950 5 10 0 0 0 0 1
footprint=SIP3N
}
C 54100 45000 1 0 1 output-2.sym
{
T 53200 45200 5 10 0 0 0 6 1
net=SW:1
T 53900 45700 5 10 0 0 0 6 1
device=none
T 53200 45100 5 10 1 1 0 7 1
value=Switch
}
C 41200 45400 1 0 0 vcc-1.sym
C 41200 44300 1 0 0 ground.sym
C 53900 42200 1 0 0 ground.sym
C 53900 44400 1 0 0 ground.sym
C 53900 46100 1 0 0 ground.sym
C 53900 48200 1 0 0 ground.sym
C 54100 43000 1 180 0 output-2.sym
{
T 53200 42800 5 10 0 0 180 0 1
net=TMP:1
T 53900 42300 5 10 0 0 180 0 1
device=none
T 53200 42900 5 10 1 1 180 1 1
value=Temp
}
C 52700 46700 1 0 0 input-2.sym
{
T 52700 46900 5 10 0 0 0 0 1
net=FAN2:1
T 53300 47400 5 10 0 0 0 0 1
device=none
T 53200 46800 5 10 1 1 0 7 1
value=Fan 2
}
C 52700 48800 1 0 0 input-2.sym
{
T 52700 49000 5 10 0 0 0 0 1
net=FAN1:1
T 53300 49500 5 10 0 0 0 0 1
device=none
T 53200 48900 5 10 1 1 0 7 1
value=Fan 1
}
N 54100 45100 54400 45100 4
N 54100 46800 54400 46800 4
N 54400 48900 54100 48900 4
N 54100 48500 54400 48500 4
N 54100 44700 54400 44700 4
N 54100 42900 54400 42900 4
N 41100 45400 41400 45400 4
N 41100 44600 41400 44600 4
C 53900 43300 1 0 0 5V-plus-1.sym
N 54400 43300 54100 43300 4
C 40800 40900 1 0 0 switch-pushbutton-no-1.sym
{
T 41200 41200 5 10 1 1 0 0 1
refdes=S1
T 41200 41500 5 10 0 0 0 0 1
device=SWITCH_PUSHBUTTON_NO
}
T 50000 40700 9 10 1 0 0 0 1
Fan Control for Fursuit Head
T 50100 40100 9 10 1 0 0 0 1
1
T 51600 40100 9 10 1 0 0 0 1
1
T 54000 40400 9 10 1 0 0 0 1
1.2
T 54000 40100 9 10 1 0 0 0 1
o'wolf
N 54100 42500 54400 42500 4
C 50400 46200 1 90 0 capacitor-1.sym
{
T 49700 46400 5 10 0 0 90 0 1
device=CAPACITOR
T 49900 46400 5 10 1 1 90 0 1
refdes=C3
T 49500 46400 5 10 0 0 90 0 1
symversion=0.1
T 50400 46200 5 10 0 0 0 0 1
footprint=RCY100
}
N 50200 47100 50200 47800 4
C 50000 45900 1 0 0 ground.sym
C 51100 49000 1 90 0 capacitor-1.sym
{
T 50400 49200 5 10 0 0 90 0 1
device=CAPACITOR
T 50600 49200 5 10 1 1 90 0 1
refdes=C2
T 50200 49200 5 10 0 0 90 0 1
symversion=0.1
T 51100 49000 5 10 0 0 0 0 1
footprint=RCY100
}
C 50700 48900 1 0 0 ground.sym
C 44300 48800 1 270 0 capacitor-4.sym
{
T 45400 48600 5 10 0 0 270 0 1
device=POLARIZED_CAPACITOR
T 44800 48600 5 10 1 1 270 0 1
refdes=C1
T 45000 48600 5 10 0 0 270 0 1
symversion=0.1
T 44300 48800 5 10 0 0 0 0 1
footprint=RCY200P
}
C 44300 47600 1 0 0 ground.sym
C 50100 42700 1 0 0 diode-1.sym
{
T 50500 43300 5 10 0 0 0 0 1
device=DIODE
T 50400 43200 5 10 1 1 0 0 1
refdes=D2
T 50100 42700 5 10 0 0 0 0 1
footprint=ACY300
}
C 45500 42700 1 0 0 diode-3.sym
{
T 45950 43250 5 10 0 0 0 0 1
device=DIODE
T 45850 43150 5 10 1 1 0 0 1
refdes=D1
T 45500 42700 5 10 0 0 0 0 1
footprint=ACY300
}
N 45700 42900 45500 42900 4
N 50800 42900 51000 42900 4
C 50000 45000 1 0 0 5V-plus-1.sym
N 49300 44400 50200 44400 4
C 50300 48900 1 90 0 resistor-2.sym
{
T 49950 49300 5 10 0 0 90 0 1
device=RESISTOR
T 50000 49100 5 10 1 1 90 0 1
refdes=R5
T 50300 48900 5 10 0 0 0 0 1
value=10k
T 50300 48900 5 10 0 0 0 0 1
footprint=ACY300
}
N 50200 48900 50200 47800 4
C 50000 49900 1 0 0 5V-plus-1.sym
C 41400 42600 1 0 0 resistor-2.sym
{
T 41800 42950 5 10 0 0 0 0 1
device=RESISTOR
T 41600 42900 5 10 1 1 0 0 1
refdes=R4
T 41400 42600 5 10 0 0 0 0 1
value=2k
T 41400 42600 5 10 0 0 0 0 1
footprint=ACY300
}
N 41400 42700 41500 42700 4
N 42200 42700 42300 42700 4
C 50400 43500 1 90 0 capacitor-1.sym
{
T 49700 43700 5 10 0 0 90 0 1
device=CAPACITOR
T 49900 43700 5 10 1 1 90 0 1
refdes=C4
T 49500 43700 5 10 0 0 90 0 1
symversion=0.1
T 50400 43500 5 10 0 0 0 0 1
value=22nF
T 50400 43500 5 10 0 0 0 0 1
netname=capacitor_radial
T 50400 43500 5 10 0 0 0 0 1
footprint=RCY100
}
C 46100 41800 1 270 0 capacitor-4.sym
{
T 47200 41600 5 10 0 0 270 0 1
device=POLARIZED_CAPACITOR
T 46600 41600 5 10 1 1 270 0 1
refdes=C5
T 46800 41600 5 10 0 0 270 0 1
symversion=0.1
T 46100 41800 5 10 0 0 0 0 1
value=22µF
T 46100 41800 5 10 0 0 0 0 1
footprint=RCY200P
}
N 40800 40500 40800 40900 4
N 40800 40500 42200 40500 4
N 50900 49900 50200 49900 4
N 50900 49200 50900 49000 4
N 50200 49800 50200 49900 4
C 42200 41900 1 0 0 connector3-2.sym
{
T 42900 43600 5 10 1 1 0 6 1
refdes=Temperature
T 42500 43550 5 10 0 0 0 0 1
device=CONNECTOR_3
T 42500 43750 5 10 0 0 0 0 1
footprint=SIP3N
}
C 42200 40100 1 0 0 connector2-2.sym
{
T 42900 41400 5 10 1 1 0 6 1
refdes=Button
T 42500 41350 5 10 0 0 0 0 1
device=CONNECTOR_2
T 42500 41550 5 10 0 0 0 0 1
footprint=SIP2N
}
N 41800 40900 42200 40900 4
C 41700 43100 1 0 0 generic-power.sym
{
T 41900 43350 5 10 0 1 0 3 1
net=Vsensor:1
T 41600 43350 5 10 1 1 0 0 1
value=Vsensor
}
N 41900 43100 42200 43100 4
C 41800 42000 1 0 0 gnd-1.sym
N 41900 42300 42200 42300 4
C 46800 42000 1 0 0 L293D.sym
{
T 49400 44575 5 10 0 0 0 0 1
device=L293
T 49200 44800 5 10 1 1 0 6 1
refdes=U3
T 48295 44800 5 10 0 1 0 0 1
footprint=DIP16
}
C 46500 46700 1 0 0 ATtiny25.sym
{
T 49400 49000 5 10 1 1 0 6 1
refdes=U2
T 46800 49150 5 10 0 0 0 0 1
device=ATtiny25
T 46800 49350 5 10 0 0 0 0 1
footprint=DIP8
}
N 50300 42600 50300 41800 4
C 46100 40600 1 0 0 ground.sym
C 54400 48100 1 0 0 connector3-2.sym
{
T 55100 49800 5 10 1 1 0 6 1
refdes=Fan 1
T 54700 49750 5 10 0 0 0 0 1
device=CONNECTOR_3
T 54700 49950 5 10 0 0 0 0 1
footprint=SIP3N
}
C 53900 47300 1 0 0 vcc-1.sym
C 53900 49500 1 0 0 vcc-1.sym
N 54100 49500 54100 49300 4
N 54100 49300 54400 49300 4
N 54100 47300 54100 47200 4
N 54100 47200 54400 47200 4
N 54100 46400 54400 46400 4