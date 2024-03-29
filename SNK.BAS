10 '***********************************
10 ' X Y START POSITION OF THE SNAKE
10 ' NE NUMBER OF SNAKE ELEMENTS
10 ' CD CURRENT DIRECTION
10 ' PD PREVIOUS DIRECTION
10 ' SC SCORE
10 ' CM CENTENAS DE MILLAR
10 ' DM DECENAS DE MILLAR
10 ' MI MILLARES
10 ' CE CENTENAS
10 ' DE DECENAS
10 ' TL START POSITION OF ALPHA NUMERIC TILES A,C,D,...,0,1...
10 ' SX X SNAKE COORDINATE ELEMENTS UNIDIMENSINAL ARRAY
10 ' SY Y SNAKE COORDINATE ELEMENTS UNIDIMENSINAL ARRAY
10 ' SS SNAKE TILES UNIDIMENSINAL ARRAY
10 '***********************************

100 ' INITIALIZATION
100 COLOR 15,1,1
110 SCREEN 2,0,0
115 'CALL TURBO ON
120 'DEFINT A-Z
121 X=64: Y=64
122 NE=3:CD=0:PD=0
123 SC=0: CM=100000: DM=10000: MI=1000: CE=100: DE=10: TL=45

131 ' SNAKE (X,Y) MATRIX
131 DIM SX(3),SY(3)
132 FOR I=0 TO 2
133     SX(I)=X-(8*I)
134     SY(I)=Y
135 NEXT I

136 ' SNAKE ELEMENTS MATRIX
136 DIM SS(3)
137 SS(0)=9
138 SS(1)=10
139 SS(2)=11

140 GOSUB 10000

141 FOR I=0 TO NE-1
142     C=SX(I)\8
143     D=SY(I)\8
144     VPOKE &H1800+C+D*32,  SS(I)
145 NEXT I

200 ' GAME LOOP

210 ' UPDATE BLOCK

215 ' DRAW BLOCK

300 S=STICK(0)
310 IF (S=1 AND CD<>5) OR CD=1 THEN PD=CD:CD=1:GOSUB 3100
320 IF (S=3 AND CD<>7) OR CD=3 THEN PD=CD:CD=3:GOSUB 3300
330 IF (S=5 AND CD<>1) OR CD=5 THEN PD=CD:CD=5:GOSUB 3500
340 IF (S=7 AND CD<>3) OR CD=7 THEN PD=CD:CD=7:GOSUB 3700

341 ' COLISION DETECTION
342 IF P1=5 THEN GOSUB 600
343 IF P1=3 THEN GOSUB 700

345 FOR I=0 TO NE-1

350    'TIME=0
355    'IF TIME<3 GOTO 355

360    C=SX(I)\8
365    D=SY(I)\8
370    E=SS(I)

375    IF CD=1 THEN VPOKE &H1800+C+D*32,E
380    IF CD=3 THEN VPOKE &H1800+C+D*32,E
385    IF CD=5 THEN VPOKE &H1800+C+D*32,E
390    IF CD=7 THEN VPOKE &H1800+C+D*32,E

395 NEXT I

400 ' CLEAN SPRITES
400 GOSUB 4200

500 GOTO 200

600 ' PLAYER DIES
600 END
700 ' PLAYER WINS

705 SC=SC+5

710 DS=SC: DD=CM: GOSUB 4100
715 N1=ID
720 R1=SC-(N1*CM)
725 N=N1
730 GOSUB 4000
735 VPOKE &H1800+6+23*32,TL

740 DS=R1: DD=DM: GOSUB 4100
745 N2=ID
750 R2=R1-(N2*DM)
755 N=N2
760 GOSUB 4000
765 VPOKE &H1800+7+23*32,TL

770 DS=R2: DD=MI: GOSUB 4100
775 N3=ID
780 R3=R2-(N3*MI)
785 N=N3
790 GOSUB 4000
795 VPOKE &H1800+8+23*32,TL

800 DS=R3: DD=CE: GOSUB 4100
805 N4=ID
810 R4=R3-(N4*C)
815 N=N4
820 GOSUB 4000
825 VPOKE &H1800+9+23*32,TL

830 DS=R4: DD=DE: GOSUB 4100
835 N5=ID
840 R5=R4-(N5*DE)
845 N=N5
850 GOSUB 4000
855 VPOKE &H1800+10+23*32,TL

890 N=R5
895 GOSUB 4000
900 VPOKE &H1800+11+23*32,TL

905 'GOTO 200
905 RETURN

1000 ' PATTERNS

1000 ' BLANK TILE
1000 DATA FF,FF,FF,FF,FF,FF,FF,FF

1005 ' WALL TILE
1005 DATA 00,7F,7F,7F,00,F7,F7,F7

1010 ' LAVA TILE
1010 DATA FD,EE,DF,33,FD,EE,DF,33

1015 ' APPLE TILE
1015 DATA 3C,7F,DB,FF,FF,DB,7E,3C

1020 ' DESERT TILE
1020 DATA 80,20,80,00,41,00,84,10

1025 ' GRASS TILE
1025 DATA 80,20,80,00,41,00,84,10

1030 ' UP SNAKE TILES
1030 DATA 00,00,24,7E,5A,FF,FF,FF
1035 DATA FF,FF,FF,FF,FF,FF,FF,FF
1040 DATA FF,FF,7E,7E,3C,3C,18,18

1045 ' RIGHT SNAKE TILES
1045 DATA E0,F8,EC,F8,F8,EC,F8,E0
1050 DATA FF,FF,FF,FF,FF,FF,FF,FF
1055 DATA 03,0F,3F,FF,FF,3F,0F,03

1060 ' DOWN SNAKE TILES
1065 DATA FF,FF,FF,5A,7E,24,00,00
1070 DATA FF,FF,FF,FF,FF,FF,FF,FF
1075 DATA 18,18,3C,3C,7E,7E,FF,FF

1080 ' LEFT SNAKE TILES
1080 DATA 07,1F,37,1F,1F,37,1F,07
1085 DATA FF,FF,FF,FF,FF,FF,FF,FF
1090 DATA C0,F0,FC,FF,FF,FC,F0,C0

1095 ' LETTERS TILES
1095 DATA FF,FF,FF,FF,FF,FF,FF,FF
1100 DATA 02,06,0E,1E,3E,76,E6,76
1105 DATA FE,CC,D8,FE,CC,D8,F0,E0
1110 DATA 7E,FC,C0,C0,C0,C0,FC,7E
1115 DATA FE,FE,CC,D8,F0,E0,C0,80
1120 DATA FE,FE,00,FE,FE,00,FE,FE
1125 DATA FF,FE,C0,FC,F8,C0,C0,80
1130 DATA 7E,FC,C0,C0,C2,C6,FE,7F
1135 DATA C6,C6,C6,FE,FE,C6,C6,84
1140 DATA 38,38,38,38,38,38,30,20
1145 DATA 02,06,06,06,06,06,7E,FE
1150 DATA CE,DC,F8,F0,F8,DC,CE,86
1155 DATA 40,C0,C0,C0,C0,C0,FE,FC
1160 DATA 82,C6,EE,FE,FE,D6,C6,C6
1165 DATA C6,E6,F6,FE,DE,CE,C6,42
1170 DATA 7C,FE,C6,C6,C6,C6,FE,7C
1175 DATA FC,FE,06,FE,FC,C0,C0,80
1180 DATA 7C,FE,C6,C6,D6,FE,7C,10
1185 DATA C8,DC,CE,DC,F8,DC,CE,86
1190 DATA FE,FE,80,FE,FE,02,FE,FE
1195 DATA FE,FC,30,30,30,30,30,20
1200 DATA 82,C6,C6,C6,C6,C6,FE,7C
1205 DATA 03,06,CC,D8,F0,E0,C0,80
1210 DATA C6,C6,D6,FE,FE,EE,C6,82
1215 DATA 86,CE,FC,78,3C,7E,E6,C2
1220 DATA 87,CE,FC,78,30,30,30,20
1225 DATA 7E,FE,1C,38,70,E0,FE,FC

1230 ' NUMBERS TILES
1230 DATA 7C,86,8A,92,A2,C2,7C,00
1235 DATA 10,30,50,90,10,10,FE,00
1240 DATA 7C,82,02,0C,70,80,FE,00
1245 DATA 7C,82,02,0C,02,82,7C,00
1250 DATA 0C,14,24,44,FE,04,04,00
1255 DATA FE,80,F8,04,02,04,F8,00
1260 DATA 3C,40,80,FC,82,82,7C,00
1265 DATA FE,82,04,08,10,10,10,00
1270 DATA 7C,82,82,7C,82,82,7C,00
1275 DATA 7C,82,82,7E,02,04,78,00
1280 DATA *

1500 ' COLORS

1500 ' BLANK
1500 DATA 01,01,01,01,01,01,01,01
1505 ' WALL
1505 DATA E0,E0,E0,E0,E0,E0,E0,E0
1510 ' LAVA
1510 DATA 68,68,68,68,68,68,68,68
1515 ' APPLE
1515 DATA D0,D0,D0,D0,D0,D0,D0,D0
1520 ' DESERT
1520 DATA 6B,6B,6B,6B,6B,6B,6B,6B
1525 ' GRASS
1525 DATA 23,23,23,23,23,23,23,23

1530 ' UP
1530 DATA F0,F0,F0,F0,F0,F0,F0,F0
1535 DATA F0,F0,F0,F0,F0,F0,F0,F0
1540 DATA F0,F0,F0,F0,F0,F0,F0,F0

1545 ' DOWN
1545 DATA F0,F0,F0,F0,F0,F0,F0,F0
1550 DATA F0,F0,F0,F0,F0,F0,F0,F0
1555 DATA F0,F0,F0,F0,F0,F0,F0,F0

1560 ' RIGHT
1560 DATA F0,F0,F0,F0,F0,F0,F0,F0
1565 DATA F0,F0,F0,F0,F0,F0,F0,F0
1570 DATA F0,F0,F0,F0,F0,F0,F0,F0

1575 ' LEFT
1575 DATA F0,F0,F0,F0,F0,F0,F0,F0
1580 DATA F0,F0,F0,F0,F0,F0,F0,F0
1585 DATA F0,F0,F0,F0,F0,F0,F0,F0

1590 ' LETTERS
1595 DATA F0,F0,F0,F0,F0,F0,F0,F0
1600 DATA F0,F0,F0,F0,F0,F0,F0,F0
1605 DATA F0,F0,F0,F0,F0,F0,F0,F0
1610 DATA F0,F0,F0,F0,F0,F0,F0,F0
1615 DATA F0,F0,F0,F0,F0,F0,F0,F0
1620 DATA F0,F0,F0,F0,F0,F0,F0,F0
1625 DATA F0,F0,F0,F0,F0,F0,F0,F0
1630 DATA F0,F0,F0,F0,F0,F0,F0,F0
1635 DATA F0,F0,F0,F0,F0,F0,F0,F0
1640 DATA F0,F0,F0,F0,F0,F0,F0,F0
1645 DATA F0,F0,F0,F0,F0,F0,F0,F0
1650 DATA F0,F0,F0,F0,F0,F0,F0,F0
1655 DATA F0,F0,F0,F0,F0,F0,F0,F0
1660 DATA F0,F0,F0,F0,F0,F0,F0,F0
1665 DATA F0,F0,F0,F0,F0,F0,F0,F0
1670 DATA F0,F0,F0,F0,F0,F0,F0,F0
1675 DATA F0,F0,F0,F0,F0,F0,F0,F0
1680 DATA F0,F0,F0,F0,F0,F0,F0,F0
1685 DATA F0,F0,F0,F0,F0,F0,F0,F0
1690 DATA F0,F0,F0,F0,F0,F0,F0,F0
1695 DATA F0,F0,F0,F0,F0,F0,F0,F0
1700 DATA F0,F0,F0,F0,F0,F0,F0,F0
1705 DATA F0,F0,F0,F0,F0,F0,F0,F0
1710 DATA F0,F0,F0,F0,F0,F0,F0,F0
1715 DATA F0,F0,F0,F0,F0,F0,F0,F0
1720 DATA F0,F0,F0,F0,F0,F0,F0,F0

1725 ' NUMBERS
1725 DATA F0,F0,F0,F0,F0,F0,F0,F0
1730 DATA F0,F0,F0,F0,F0,F0,F0,F0
1735 DATA F0,F0,F0,F0,F0,F0,F0,F0
1740 DATA F0,F0,F0,F0,F0,F0,F0,F0
1745 DATA F0,F0,F0,F0,F0,F0,F0,F0
1750 DATA F0,F0,F0,F0,F0,F0,F0,F0
1755 DATA F0,F0,F0,F0,F0,F0,F0,F0
1760 DATA F0,F0,F0,F0,F0,F0,F0,F0
1765 DATA F0,F0,F0,F0,F0,F0,F0,F0
1770 DATA F0,F0,F0,F0,F0,F0,F0,F0
1775 DATA *

2000 ' NAMES

2000 DATA 5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5
2005 DATA 5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5
2010 DATA 5,0,0,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5
2015 DATA 5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5
2020 DATA 5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,0,0,0,0,0,0,0,0,0,5
2025 DATA 5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5
2030 DATA 5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5
2035 DATA 5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5

2040 DATA 5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5
2045 DATA 5,0,0,0,0,0,0,0,0,0,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5
2050 DATA 5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5
2055 DATA 5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5
2060 DATA 5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5
2065 DATA 5,0,0,0,0,0,0,0,0,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5
2070 DATA 5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5
2075 DATA 5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5

2080 DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
2085 DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
2090 DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
2095 DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
2100 DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
2105 DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
2110 DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
2115 DATA 25,15,21,24,17,0,2D,2D,2D,2D,2D,2D,0,1A,1B,0,2E,2D,2D,2D,2D,2D,0,25,26,13,19,17,0,2D,2E,0
2190 DATA *

2200 ' SPRITES

2200 ' RIGHT DIRECTION - HEAD
2200 DATA E0,F8,EC,F8,F8,EC,F8,E0
2205 ' RIGHT DIRECTION - BODY
2205 DATA FF,FF,FF,FF,FF,FF,FF,FF
2210 ' RIGHT DIRECTION - TAIL
2210 DATA 03,0F,3F,FF,FF,3F,0F,03
2215 ' DOWN DIRECTION - HEAD
2215 DATA FF,FF,FF,5A,7E,24,00,00
2220 ' DOWN DIRECTION - BODY
2220 DATA FF,FF,FF,FF,FF,FF,FF,FF
2225 ' DOWN DIRECTION - TAIL
2225 DATA 18,18,3C,3C,7E,7E,FF,FF
2230 ' UP DIRECTION - HEAD
2235 DATA 00,00,24,7E,5A,FF,FF,FF
2240 ' BODY-UP DIRECTION
2240 DATA FF,FF,FF,FF,FF,FF,FF,FF
2245 ' TAIL-UP DIRECTION
2245 DATA FF,FF,7E,7E,3C,3C,18,18
2250 ' LEFT DIRECTION - HEAD
2250 DATA 07,1F,37,1F,1F,37,1F,07
2255 ' LEFT DIRECTION - BODY
2255 DATA FF,FF,FF,FF,FF,FF,FF,FF
2260 ' LEFT DIRECTION - TAIL
2260 DATA C0,F0,FC,FF,FF,FC,F0,C0
2290 DATA *

3100 ' MOVE UP

3100 IF SS(0)=6 THEN SY(0)=SY(0)-8:P1=VPEEK(&H1800+(SX(0)\8)+(SY(0)\8)*32)
3110 IF SS(1)=7 THEN SY(1)=SY(1)-8
3115 IF SS(2)=8 THEN SY(2)=SY(2)-8
3120 ' COMING FROM THE RIGHT
3120 IF SS(0)=15 THEN J=NE:SS(0)=6:SY(0)=SY(0)-(8*1)
3125 IF SS(1)=16 THEN SS(1)=7:SX(1)=SX(1)-(8*1)
3130 IF SS(2)=17 THEN IF J=3 THEN SS(2)=17:SX(2)=SX(2)-(8*1)
3135 IF SS(2)=17 THEN IF J=2 THEN SS(2)=8:SX(2)=SX(2)-(8*1)
3140 ' COMING FROM THE LEFT
3140 IF SS(0)=9 THEN J=NE:SS(0)=6:SY(0)=SY(0)-(8*1)
3145 IF SS(1)=10 THEN SS(1)=7:SX(1)=SX(1)+(8*1)
3150 IF SS(2)=11 THEN IF J=3 THEN SS(2)=11:SX(2)=SX(2)+(8*1)
3155 IF SS(2)=11 THEN IF J=2 THEN SS(2)=8:SX(2)=SX(2)+(8*1)

3160 IF J>0 THEN J=J-1
3165 RETURN

3300 ' MOVE RIGHT

3300 IF SS(0)=9 THEN SX(0)=SX(0)+8:P1=VPEEK(&H1800+(SX(0)\8)+(SY(0)\8)*32)
3310 IF SS(1)=10 THEN SX(1)=SX(1)+8
3315 IF SS(2)=11 THEN SX(2)=SX(2)+8
3320 ' COMING FROM ABOVE
3320 IF SS(0)=12 THEN J=NE:SS(0)=9:SX(0)=SX(0)+(8*1)
3325 IF SS(1)=13 THEN SS(1)=10:SY(1)=SY(1)+(8*1)
3330 IF SS(2)=14 THEN IF J=3 THEN SS(2)=14:SY(2)=SY(2)+(8*1)
3335 IF SS(2)=14 THEN IF J=2 THEN SS(2)=11:SY(2)=SY(2)+(8*1)
3340 ' COMING FROM BELOW
3340 IF SS(0)=6 THEN J=NE:SS(0)=9:SX(0)=SX(0)+(8*1)
3345 IF SS(1)=7 THEN SS(1)=10:SY(1)=SY(1)-(8*1)
3350 IF SS(2)=8 THEN IF J=3 THEN SS(2)=8:SY(2)=SY(2)-(8*1)
3355 IF SS(2)=8 THEN IF J=2 THEN SS(2)=11:SY(2)=SY(2)-(8*1)

3360 IF J>0 THEN J=J-1
3365 RETURN

3500 ' MOVE DOWN

3500 IF SS(0)=12 THEN SY(0)=SY(0)+8:P1=VPEEK(&H1800+(SX(0)\8)+(SY(0)\8)*32)
3510 IF SS(1)=13 THEN SY(1)=SY(1)+8
3515 IF SS(2)=14 THEN SY(2)=SY(2)+8
3520 ' COMING FROM THE RIGHT
3520 IF SS(0)=15 THEN J=NE:SS(0)=12:SY(0)=SY(0)+(8*1)
3525 IF SS(1)=16 THEN SS(1)=13:SX(1)=SX(1)-(8*1)
3530 IF SS(2)=17 THEN IF J=3 THEN SS(2)=17:SX(2)=SX(2)-(8*1)
3535 IF SS(2)=17 THEN IF J=2 THEN SS(2)=14:SX(2)=SX(2)-(8*1)
3540 ' COMING FROM THE LEFT
3540 IF SS(0)=9 THEN J=NE:SS(0)=12:SY(0)=SY(0)+(8*1)
3545 IF SS(1)=10 THEN SS(1)=13:SX(1)=SX(1)+(8*1)
3550 IF SS(2)=11 THEN IF J=3 THEN  SS(2)=11: SX(2)=SX(2)+(8*1)
3555 IF SS(2)=11 THEN IF J=2 THEN SS(2)=14:SX(2)=SX(2)+(8*1)

3560 IF J>0 THEN J=J-1
3565 RETURN

3700 ' MOVE LEFT

3700 IF SS(0)=15 THEN SX(0)=SX(0)-8:P1=VPEEK(&H1800+(SX(0)\8)+(SY(0)\8)*32)
3710 IF SS(1)=16 THEN SX(1)=SX(1)-8
3715 IF SS(2)=17 THEN SX(2)=SX(2)-8
3720 ' COMING FROM ABOVE
3720 IF SS(0)=12 THEN J=NE:SS(0)=15:SX(0)=SX(0)-(8*1)
3725 IF SS(1)=13 THEN SS(1)=16:SY(1)=SY(1)+(8*1)
3730 IF SS(2)=14 THEN IF J=3 THEN SS(2)=14:SY(2)=SY(2)+(8*1)
3735 IF SS(2)=14 THEN IF J=2 THEN SS(2)=17:SY(2)=SY(2)+(8*1)
3740 ' COMING FROM BELOW
3740 IF SS(0)=6 THEN J=NE:SS(0)=15:SX(0)=SX(0)-(8*1)
3745 IF SS(1)=7 THEN SS(1)=16:SY(1)=SY(1)-(8*1)
3750 IF SS(2)=8 THEN IF J=3 THEN SS(2)=8:SY(2)=SY(2)-(8*1)
3755 IF SS(2)=8 THEN IF J=2 THEN SS(2)=17:SY(2)=SY(2)-(8*1)

3760 IF J>0 THEN J=J-1
3765 RETURN

4000 ' NUMBER TO TILE PARING

4005 IF N=0 THEN TL=45
4010 IF N=1 THEN TL=46
4015 IF N=2 THEN TL=47
4020 IF N=3 THEN TL=48
4025 IF N=4 THEN TL=49
4030 IF N=5 THEN TL=50
4035 IF N=6 THEN TL=51
4040 IF N=7 THEN TL=52
4045 IF N=8 THEN TL=53
4050 IF N=9 THEN TL=54
4055 RETURN

4100 ' INTEGER DIVISION

4105 ID=-1
4110 ' Start of the loop
4115 SB=DS-DD
4120 ID=ID+1
4125 DS=SB
4130 IF SB>=0 THEN GOTO 4110
4135 RETURN

4200 ' CLEAN SPRITES

4210 IF CD=1 AND VPEEK(&H1800+C+(D+1)*32)<>5 AND VPEEK(&H1800+C+(D+1)*32)<>3 THEN VPOKE &H1800+C+(D+1)*32,0
4215 IF CD=1 AND PD=3 THEN VPOKE &H1800+(C-1)+D*32,0:VPOKE &H1800+C+D*32,0
4220 IF CD=1 AND PD=7 THEN VPOKE &H1800+(C+1)+D*32,0:VPOKE &H1800+C+D*32,0

4230 IF CD=3 AND VPEEK(&H1800+(C-1)+D*32)<>5 AND VPEEK(&H1800+(C-1)+D*32)<>3 THEN VPOKE &H1800+(C-1)+D*32,0
4235 IF CD=3 AND PD=5 THEN VPOKE &H1800+C+(D-1)*32,0:VPOKE &H1800+C+D*32,0
4240 IF CD=3 AND PD=1 THEN VPOKE &H1800+C+(D+2)*32,0:VPOKE &H1800+C+(D+1)*32,0:VPOKE &H1800+C+D*32,0

4250 IF CD=5 AND VPEEK(&H1800+C+(D-1)*32)<>5 AND VPEEK(&H1800+C+(D-1)*32)<>3 THEN VPOKE &H1800+C+(D-1)*32,0
4255 IF CD=5 AND PD=7 THEN VPOKE &H1800+(C+1)+D*32,0:VPOKE &H1800+C+D*32,0
4260 IF CD=5 AND PD=3 THEN VPOKE &H1800+(C-1)+D*32,0:VPOKE &H1800+(C-2)+D*32,0:VPOKE &H1800+C+D*32,0

4280 IF CD=7 AND VPEEK(&H1800+(C+1)+D*32)<>5 AND VPEEK(&H1800+(C+1)+D*32)<>3 THEN VPOKE &H1800+(C+1)+D*32,0
4285 IF CD=7 AND PD=1 THEN VPOKE &H1800+C+(D+1)*32,0:VPOKE &H1800+C+D*32,0:VPOKE &H1800+C+(D+2)*32,0
4290 IF CD=7 AND PD=5 THEN VPOKE &H1800+C+(D-2)*32,0:VPOKE &H1800+C+(D-1)*32,0:VPOKE &H1800+C+D*32,0

4300 RETURN

10000 GOSUB 10100
10010 GOSUB 10200
10020 GOSUB 10300
10030 GOSUB 10400
10050 RETURN

10100 ' LOAD PATTERNS
10110 S=0
10120 READ R$
10130 IF R$="*" THEN RETURN ELSE R=VAL("&H"+R$)
10140 VPOKE S,R
10150 VPOKE 2048+S,R
10160 VPOKE 4096+S,R
10170 S=S+1:GOTO 10120

10200 ' LOAD COLORS
10210 S=0
10220 READ R$
10230 IF R$="*" THEN RETURN ELSE R=VAL("&H"+R$)
10240 VPOKE &H2000+S,R
10250 VPOKE &H2800+S,R
10260 VPOKE &H3000+S,R
10270 S=S+1:GOTO 10220

10300 ' LOAD NAMES
10310 S=&H1800
10320 READ R$
10330 IF R$="*" THEN RETURN
10340 VPOKE S,VAL("&H"+R$)
10350 S=S+1:GOTO 10320

10400 ' LOAD SPRITES
10410 S=&H3800
10420 READ R$
10430 IF R$="*" THEN RETURN ELSE VPOKE S,VAL("&H"+R$):S=S+1
10440 GOTO 10420
