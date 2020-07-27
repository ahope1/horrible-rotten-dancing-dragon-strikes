10 REM ANOTHER ADVENTURE FROM SOFTLINE
15 REM WRITTEN FOR THE ATARI BUT EASILY TRANSPORTABLE IF YOU READ THE ACCOMPANYING ARTICLE
20 HOME:REM THIS CLEARS THE SCREEN
30 DIM N(34),S(34),E(34),W(34),OB(7),RD(34)
40 OB(1)=5:OB(2)=22:OB(3)=25:OB(4)=31:OB(5)=27:OB(6)=33:OB(7)=32
50 REM READING DATA INTO THE ARRAYS
60 FOR A=1 TO 33
70 READ X:N(A)=X:READ X:S(A)=X:READ X:E(A)=X:READ X:W(A)=X:X=0:RD(A)=0
80 NEXT A
90 R=1:GOSUB 1500:GOTO 620
100 REM PARSER
110 V1$="":N1$=""
120 PRINT :PRINT "WHAT NOW? ";:INPUT "";A$
130 HOME : PRINT DES$
140 FOR A = 1 TO LEN (A$)
150 IF MID$ (A$,A,1) = " " THEN X = A - 1: A = 0: GOTO 180
160 NEXT A
170 V1$ = A$: GOTO 300
180 V1$=LEFT$ (A$,X)
190 IF RIGHT$ (A$, LEN(A$) - X) = " " THEN N1$ = "": GOTO 300:REM BE SURE THERE IS A SPACE BETWEEN THE FIRST PAIR OF QUOTES AND NO SPACE BETWEEN THE SECOND PAIR OF QUOTES
200 N1$ = RIGHT$ (A$, LEN (A$) - (X+1)): GOTO 300
300 REM VERB-HANDLING ROUTINE
310 IF V1$="GO" THEN V1$="N1$":GOTO 500
320 IF V1$="NORTH" OR V1$="N" OR V1$="SOUTH" OR V1$="S" OR V1$="EAST" OR V1$="E" OR V1$="WEST" OR V1$="W" THEN GOTO 500
330 IF V1$="INVENTORY" OR V1$="INV" OR V1$="I" THEN GOTO 700
340 IF V1$="GET" OR V1$="TAKE" THEN GOTO 800
350 IF V1$="PUSH" OR V1$="PRESS" THEN GOTO 900
360 IF V1$="DROP" THEN GOTO 1000
370 IF V1$="QUIT" THEN GOTO 3700
380 IF V1$="HIT" OR V1$="STRIKE" OR V1$="BEAT" OR V1$="KILL" THEN GOTO 1200
390 IF V1$="EAT" THEN GOSUB 1300:GOTO 100
400 IF V1$="FEED" OR V1$="GIVE" THEN GOTO 1400
410 IF V1$="DANCE" THEN GOTO 1100
420 PRINT :PRINT "I DON'T KNOW HOW TO ";V1$;".":GOTO 100
500 REM MOVING AROUND ROUTINE
510 X=R:REM STORING CURRENT ROOM NUMBER
520 IF V1$="NORTH" OR V1$="N" THEN R = N(R)
530 IF V1$="SOUTH" OR V1$="S" THEN R = S(R)
540 IF V1$="EAST" OR V1$="E" THEN R = E(R)
550 IF V1$="WEST" OR V1$="W" THEN R = W(R)
560 IF X=28 AND R=32 THEN GOTO 590
570 IF R=28 AND S(28)=32 THEN GOTO 3570:REM RETURNING TO DRAGON'S CAVE
580 IF X=28 THEN GOTO 3590:REM TRAPPED IN DRAGON'S CAVE
590 IF R>0 THEN X=R:HOME:GOTO 610:REM YOU'VE MOVED AND X WILL BE USED IN SEARCHING FOR OBJECTS
600 IF R=0 THEN PRINT :PRINT "YOU CAN'T MOVE THAT WAY (I THINK).":R=X:X=0:GOTO 100:REM ORIGINAL ROOM VALUE SETUP
610 IF R>19 THEN GOTO 618
612 ON R GOSUB 1510,1530,1550,1570,1590,1610,1630,1650,1670,1690,1710,1730,1750,1770,1790,1810,1830,1850,1870
615 GOTO 620
618 ON (R-19) GOSUB 1890,1910,1930,1950,1970,1990,2010,2030,2050,2070,2090,2110,2130,2150
620 PRINT :PRINT "OBJECTS HERE ARE:":PRINT
630 X=R:GOSUB 2300
640 X=0
650 GOTO 100
700 REM INVENTORY ROUTINE
710 X=34
720 PRINT :PRINT "YOU ARE CARRYING: ":PRINT
730 GOSUB 2300
740 GOTO 100
800 REM GET ROUTINE
810 IF N1$="" THEN PRINT :PRINT "DON'T BE SILLY, I NEED A NOUN!":GOTO 890
820 GOSUB 2200
830 IF OB(X)=R OR OB(X)=34 THEN GOTO 850
840 PRINT :PRINT "YOU CAN'T, AT THE MOMENT.":PRINT :GOTO 890
850 IF X=3 AND OB(7)<34 THEN GOTO 3410
860 OB(X)=34
870 IF OB(3)=34 THEN GOTO 3400
880 PRINT :PRINT "YOU'VE GOT THE ";N1$;".":PRINT
890 X=0:GOTO 100
900 REM PRESS ROUTINE
910 IF N1$="" THEN PRINT :PRINT "DON'T BE SILLY, I NEED A NOUN!":GOTO 890
920 IF R=11 OR R=18 THEN GOTO 940
930 GOTO 990
940 IF R=18 THEN GOTO 980
950 IF OB(1)=34 THEN GOTO 3060
960 IF N1$="BUTTON" THEN GOTO 3050
970 GOTO 3040
980 IF N1$="ROCK" OR N1$="STONE" THEN GOTO 3220
990 PRINT :PRINT "I CAN'T ";V1$;" A ";N1$;".":PRINT :GOTO 100
1000 REM ROUTINE TO DROP OBJECTS
1010 GOSUB 2200
1020 IF OB(X)=34 THEN GOTO 1040
1030 PRINT :PRINT "I'M NOT CARRYING THE ";N1$;".":PRINT :GOTO 1080
1040 OB(X)=R
1050 IF N1$="WAGON" AND OB(7)=R THEN GOTO 3420
1060 PRINT :PRINT "I'VE DROPPED THE ";N1$;".":PRINT
1070 IF R=28 AND OB(X)=28 THEN OB(X)=0:GOTO 3580:REM THE DRAGON'S GONNA EAT IT
1080 X=0
1090 GOTO 100
1100 REM DANCE ROUTINE (SO TO SPEAK)
1110 PRINT: PRINT "YOU START TO HUM A CATCHY LITTLE TUNE. YOU GRACEFULLY LEAP UP IN THE AIR, DO A PIROUETTE, LAND,";
1115 PRINT "DO A CARTWHEEL,":PRINT "AND TAKE A BOW."
1120 IF R=28 THEN GOTO 3530
1130 PRINT :PRINT "FURRY LITTLE CREATURES APPEAR, APPLAUD FURRIOUSLY, AND LEAVE."
1140 GOTO 100
1200 REM BEATING AND HITTING ROUTINES
1210 IF N1$="" THEN PRINT :PRINT "OKAY, BUT YOU HAVE TO TELL ME WHAT IT IS YOU WANT TO ";V1$;".":PRINT :GOTO 100
1220 IF R=9 AND OB(7)<34 THEN GOTO 3310
1230 IF R=18 AND OB(2)=34 THEN GOTO 3230
1240 IF R=18 THEN GOTO 3250
1250 IF N1$="DRUM" OR N1$="DRUMSTICK" THEN GOTO 3320
1260 IF R=28 AND OB(2)=34 THEN GOTO 3550
1270 IF R=28 THEN GOTO 3560
1280 PRINT :PRINT "YOU CAN'T ";V1$;" A ";N1$;" HERE.":GOTO 100
1300 REM EATING ROUTINES
1310 IF N1$="" THEN PRINT :PRINT "TSK, TSK, PLEASE SUPPLY A NOUN.":PRINT :RETURN
1320 IF N1$="SANDWICH" AND OB(5)=34 THEN PRINT :PRINT "YUM, YUM, THAT TASTED GOOD.":OB(5)=0:RETURN
1320 IF N1$="MCRIB" AND OB(5)=34 THEN PRINT :PRINT "YUM, YUM, THAT TASTED GOOD.":OB(5)=0:RETURN
1340 IF N1$="SANDWICH" OR N1$="MCRIB" THEN PRINT :PRINT "YOU DON'T HAVE IT.":RETURN
1350 IF N1$="DRUMSTICK" AND OB(4)=34 THEN PRINT :PRINT "YUCK, THAT TASTED AWFUL.":OB(4)=0:RETURN
1360 IF N1$="DRUMSTICK" THEN PRINT :PRINT "HOW CAN YOU, YOU DON'T HAVE IT.":RETURN
1370 PRINT :PRINT "DON'T BE SILLY. YOU CAN'T EAT THAT!":RETURN
1400 REM GIVING OR FEEDING ROUTINE
1410 GOSUB 2200
1420 IF OB(X)=34 THEN GOTO 1440
1430 PRINT :PRINT "YOU CAN'T ";V1$;" SOMETHING YOU" :PRINT "DON'T HAVE!":GOTO 100
1440 IF R=28 THEN OB(X)=0:GOTO 3580:REM THE DRAGON'S GONNA EAT IT
1450 PRINT :PRINT "I DON'T KNOW HOW TO TELL YOU THIS, BUT NO ONE WANTS IT.":GOTO 100
1500 REM ROOM DESCRIPTION SUBROUTINE
1510 DES$="YOU ARE IN A FOREST":PRINT DES$:IF RD(R)=1 THEN RETURN
1520 PRINT :PRINT "IT IS A WARM SPRING DAY IN THE FOREST PRIMEVAL. YOU ARE DRESSED IN A JERKIN. CUTE LITTLE";
1522 PRINT " FURRY CREATURES BOUND THROUGH THE WOODS.":RD(R)=1:RETURN
1530 DES$="YOU ARE IN A LEAFY FOREST":PRINT DES$:IF RD(R)=1 THEN RETURN
1535 PRINT :PRINT "THE LEAVES IN THE TREES ARE QUITE UNUSUAL SINCE THIS IS SPRING.":PRINT
1540 PRINT "THESE ARE LEAF SPRINGS.":RD(R)=1:RETURN
1550 DES$="YOU ARE IN A LEAFY GLADE":PRINT DES$:IF RD(R)=1 THEN RETURN
1560 PRINT :PRINT "AREN'T YOU GLAD YOU'RE IN THE GLADE?":RD(R)=1:RETURN
1570 DES$="YOU ARE IN THE PINE FOREST":PRINT DES$:IF RD(R)=1 THEN RETURN
1575 PRINT :PRINT "THE WIND BLOWING THROUGH THE PINES IS SINGING A SONG. YOU LISTEN CLOSELY AND CAN MAKE OUT ";
1577 PRINT "SOME OF THE WORDS.":PRINT :PRINT "THEY ARE, 'I OPINE A DRAGON TO SWEETEN MAKE SURE THAT HE'S EATEN'."
1580 RD(R)=1:RETURN
1590 DES$="ALL THE TREES ARE DEAD HERE":PRINT DES$:IF RD(R)=1 THEN RETURN
1600 RD(R)=1:RETURN :REM PUT YOUR OWN CLEVER MESSAGE ON THIS LINE
1610 DES$="YOU ARE ON A PAVED ROAD":PRINT DES$:IF RD(R)=1 THEN RETURN
1615 PRINT :PRINT "TO THE SOUTH IS THE NORTH SIDE OF A DRAWBRIDGE. THE BRIDGE LOOKS PRETTY RICKETY."
1620 RD(R)=1:RETURN
1630 DES$="YOU ARE IN THE THRONE ROOM":PRINT DES$:GOSUB 3100
1640 RETURN
1650 DES$="YOU ARE IN THE ANTECHAMBER":PRINT DES$:IF RD(R)=1 THEN RETURN
1660 PRINT :PRINT "THIS, AS YOU'LL FIND, IS NOT A VERY LARGE CASTLE. IN FACT IT HAS ONLY THREE (I THINK) ";
1665 PRINT "ROOMS.":RD(R)=1:RETURN
1670 DES$="THIS IS THE KING'S BEDROOM":PRINT DES$:IF OB(3)=34 THEN PRINT :PRINT "THE ROOM IS EMPTY.":RETURN
1680 PRINT :PRINT "THE POOR KING HAS BEEN EXPOSED TO WEREWOLF SIMPLEX II AND IS SLOWLY TURNING INTO ";
1685 PRINT "A WOLF.":PRINT :PRINT "HE EXPLAINS THAT UNLESS CURED BY THE MAGIC SPRING HE IS DOOMED SINCE HE CAN'T "
1687 PRINT "LEAVE THE PALACE.":RD(R)=1:RETURN
1690 DES$="MORE FOREST":PRINT DES$:IF RD(R)=1 THEN RETURN
1700 PRINT :PRINT "JUST MORE AND MORE FOREST":RD(R)=1:RETURN
1710 DES$="NORTH END OF BRIDGE":PRINT DES$:GOSUB 3000
1720 RETURN
1730 DES$="CAUSEWAY TO CASTLE":PRINT DES$:IF RD(R)=1 THEN RETURN
1740 PRINT :PRINT "TO THE NORTH YOU SEE A SMALL CASTLE. SMALL DOES NOT DO IT JUSTICE. IT IS REALLY SMALL. ";
1745 DES$="IF YOU WANT TO SEE ":PRINT "HOW SMALL, GO NORTH.":RD(R)=1:RETURN
1750 DES$="AND YET EVEN MORE FOREST":PRINT DES$:IF RD(R)=1 THEN RETURN
1760 PRINT :PRINT "IF YOU THINK IT'S DULL READING ABOUT THE FOREST, YOU SHOULD TRY YOUR HAND AT WRITING ABOUT ";
1765 PRINT "IT.":RD(R)=1:RETURN
1770 DES$="DARK FOREST":PRINT DES$:IF RD(R)=1 THEN RETURN
1780 PRINT :PRINT "THERE IS SOMETHING VERY STRANGE HERE. THE GROUND SOUNDS HOLLOW!":RD(R)=1:RETURN
1790 DES$="SOUTH SIDE OF DRAWBRIDGE.":PRINT DES$:IF RD(R)=1 THEN RETURN
1800 GOSUB 3070:RETURN
1810 DES$="GENTLY ROLLING HILLS":PRINT DES$:IF RD(R)=1 THEN RETURN
1820 PRINT :PRINT "THE HILES ARE ALIVE WITH THE SOUND OF MUSIC. THEY SING:":PRINT :PRINT "DON'T PUT YOUR SHOULDER"
1825 PRINT "TO THE BOULDER,":PRINT "BUT TEST YOUR METTLE,":PRINT "AGAINST THE KETTLE.":RD(R)=1:RETURN
1830 DES$="VOLCANIC HIGHLANDS":PRINT DES$:IF RD(R)=1 THEN RETURN
1840 PRINT :PRINT "ALL ADVENTURE GAMES HAVE TO HAVE AT LEAST ONE VOLCANO. THIS VOLCANO IS ALL POOPED OUT AND ";
1845 PRINT "WILL NOT ERUPT DURING THIS GAME.":RD(R)=1:RETURN
1850 DES$="VOLCANO VALLEY":PRINT DES$:IF N(18)=14 THEN RETURN :REM IF N(19)=14 THE SECRET PASSAGE IS OPEN
1860 GOSUB 3210:RETURN
1870 DES$="MARSHY SWAMP":PRINT DES$:IF RD(R)=1 THEN RETURN
1880 PRINT :PRINT "A SMALL DINOSAUR STICKS ITS TONGUE OUT AT YOU FROM BEHIND A FERN. IT THEN DARTS AWAY."
1885 RD(R)=1:RETURN
1890 DES$="MORE MARSHY SWAMP":PRINT DES$:IF RD(R)=1 THEN RETURN
1900 PRINT :PRINT "THE SMALL DINOSAUR REAPPEARS AND HURLS A ROCK AT YOU. THE ROCK MISSES AND THE DINOSAUR DARTS ";
1905 PRINT "AWAY.":RD(R)=1:RETURN
1910 DES$="MUSHY SWAMP":PRINT DES$:IF RD(R)=1 THEN RETURN
1920 PRINT :PRINT "THE SMALL DINOSAUR TAUNTS YOU BY SAING (IN DINOSAUR LANGUAGE):":PRINT :PRINT " 'NYAH, ";
1925 PRINT "NYAH, THE DRAGON'S GONNA ":PRINT "GET YOU!'":RD(R)=1:RETURN
1930 DES$="A PLAIN":PRINT DES$:IF RD(R)=1 THEN RETURN
1940 PRINT :PRINT "OUTSIDE OF A RUSTY SWORD, THERE IS NOTHING UNUSUAL HERE.":RD(R)=1:RETURN
1950 DES$="PLAIN PLAIN":PRINT DES$:IF RD(R)=1 THEN RETURN
1960 PRINT :PRINT "NOTHING UNUSUAL HERE.":RD(R)=1:RETURN
1970 DES$="PLANE PLAIN PLAIN":PRINT DES$:IF RD(R)=1 THEN RETURN
1980 PRINT :PRINT "NOT ONLY IS NOTHING UNUSUAL HERE, BUT IT'S VERY FLAT HERE.":RD(R)=1:RETURN
1990 DES$="THE LAND OF THE MAGIC SPRING":PRINT DES$:IF RD(R)=1 THEN RETURN
2000 PRINT :PRINT "A GORGEOUS RAINBOW ARCHES ACROSS THE SKY AND PINK EGRETS FLAP HAPPILY BY. A SIGN PAINTED ";
2005 PRINT "ON THE WALL SAYS:":PRINT "'SATISFACTION GUARANTEED OR YOUR MONEY BACK!'":RD(R)=1:RETURN
2010 DES$="NONDESCRIPT LAND":PRINT DES$:IF RD(R)=1 THEN RETURN
2020 PRINT :PRINT "I SIMPLY CAN'T DESCRIBE A NONDESCRIPT LAND.":RD(R)=1:RETURN
2030 DES$="BREAK LAND":PRINT DES$:IF RD(R)=1 THEN RETURN
2040 PRINT :PRINT "LOOKING AROUND YOU SEE PICNIC TABLES AND GARBAGE CANS OVERFLOWING WITH LITTER.  ";
2045 PRINT "HOWEVER, IT APPEARS THAT YOU FRIGHTENED SOMEONE OR SOMETHING AWAY AS THEY LEFT THEIR LUNCH ON THE ";
2047 PRINT "TABLE.":RD(R)=1:RETURN
2050 DES$="LAIR OF THE DRAGON":PRINT DES$:GOTO 3500:REM OFF TO THE DRAGON ROUTINES
2060 REM DON'T NEED SECONDARY DESCRIPTIONS HERE
2070 DES$="TWISTY LITTLE MAZES":PRINT DES$:IF RD(R)=1 THEN RETURN
2080 PRINT :PRINT "JUST KIDDING. NO MAZES IN THIS GAME. IF YOU WANT TO SEE MY FEELING ON MAZES SEE THE LAST ";
2085 PRINT "ISSUE OF 'SOFTLINE'.":RD(R)=1:RETURN
2090 DES$="ENTRANCE TO MAGIC LAND":PRINT DES$:IF RD(R)=1 THEN RETURN
2100 PRINT :PRINT "MAGIC LAND IS TOO GORGEOUS FOR WORDS.":RD(R)=1:RETURN
2110 DES$="COLONEL'S CAVERN":PRINT DES$:IF RD(R)=1 THEN RETURN
2120 PRINT :PRINT "THIS APPEARS TO HAVE BEEN SOME SORT OF QUICK FOOD PLACE AT ONE TIME. THERE IS THE SMELL OF ";
2125 PRINT "GREASE IN THE AIR.":RD(R)=1:RETURN
2130 DES$="VERY SECRET CAVE":PRINT DES$:IF RD(R)=1 THEN RETURN
2140 PRINT :PRINT "SOMEONE HAS SPRAY PAINTED THIS CAVE AND SCRAWLED GRAFFITI ALL OVER THE WALL. I WON'T ";
2145 PRINT "GIVE ANY MORE DETAILS ":PRINT "AS I'M NOT THAT SORT OF COMPUTER.":RD(R)=1:RETURN
2150 DES$="BOOM BOOM ROOM":PRINT DES$:IF RD(R)=1 THEN RETURN
2160 PRINT :PRINT "ISN'T THAT RICH?":RD(R)=1:RETURN
2200 REM SUBROUTINE TO CHECK NOUNS
2210 IF N1$="STICK" THEN X=1
2220 IF N1$="SWORD" THEN X=2
2230 IF N1$="SPRING" THEN X=3
2240 IF N1$="DRUMSTICK" THEN X=4
2250 IF N1$="MCRIB" OR N1$="SANDWICH" THEN X=5
2260 IF N1$="DRUM" THEN X=6
2270 IF N1$="WAGON" THEN X=7
2280 RETURN
2300 REM SUBROUTINE TO CHECK NOUNS
2310 IF X=OB(1) THEN PRINT "A STICK":Y=1
2320 IF X=OB(2) THEN PRINT "A SWORD":Y=1
2330 IF X=OB(3) THEN PRINT "A MAGIC SPRING":Y=1
2340 IF X=OB(4) THEN PRINT "A DRUMSTICK":Y=1
2350 IF X=OB(5) THEN PRINT "A MCRIB SANDWICH":Y=1
2360 IF X=OB(6) THEN PRINT "A TOY DRUM":Y=1
2370 IF X=OB(7) THEN PRINT "A DRAGON WAGON":Y=1
2380 IF Y=0 THEN PRINT "NOTHING"
2390 PRINT
2400 Y=0
2410 RETURN
2500 REM THESE ARE THE ROOM DATA STATEMENTS
2510 DATA 0,6,2,0
2520 DATA 0,0,3,1
2530 DATA 0,0,4,2
2540 DATA 0,0,5,3
2550 DATA 0,10,0,4
2560 DATA 1,11,0,0
2570 DATA 0,0,8,0
2580 DATA 0,12,9,7
2590 DATA 0,0,0,8
2600 DATA 5,14,0,0
2610 DATA 6,0,12,0
2620 DATA 8,0,13,11
2630 DATA 0,0,14,12
2640 DATA 10,0,0,13
2650 DATA 0,19,16,0
2660 DATA 0,0,17,15
2670 DATA 0,0,18,16
2680 DATA 0,0,0,17
2690 DATA 15,20,0,0
2700 DATA 19,21,0,0
2710 DATA 20,22,0,0
2720 DATA 21,26,23,0
2730 DATA 0,27,24,22
2740 DATA 0,29,0,23
2750 DATA 0,30,0,0
2760 DATA 22,31,27,0
2770 DATA 23,0,28,26
2780 DATA 0,0,0,0
2790 DATA 24,0,30,28
2800 DATA 25,33,0,29
2810 DATA 26,0,0,0
2820 DATA 28,29,0,0
2830 DATA 30,0,0,0
3000 REM DRAWBRIDGE ROUTINES
3010 IF S(11)=15 THEN PRINT :PRINT "THE BRIDGE IS DOWN.":GOTO 3030
3020 PRINT :PRINT "THE BRIDGE IS UP BUT THERE IS A LARGE BUTTON JUST OUT OF YOUR REACH."
3030 PRINT :PRINT "A SIGN UNDER THE BUTTON SAYS: 'UNDER NO CIRCUMSTANCES PUSH THIS BUTTON!'":RETURN
3040 PRINT :PRINT "WHOEVER HEARD OF PRESSING A BUTTON WITH A ";N1$;"?":PRINT :GOTO 100
3050 PRINT :PRINT "YOU LEAP HIGH IN THE AIR AND PRESS THE BUTTON WITH YOUR HAND. THE POISONED LIZARD LIVING ";
3055 PRINT :PRINT "IN THE BUTTONHOLE ":PRINT "PRESSES YOUR HAND WITH ITS FANGS AND...":GOTO 3700
3060 PRINT :PRINT "I'LL PRESS THE BUTTON WITH YOUR STICK SO THE BRIDGE WILL DROP.":PRINT
3065 PRINT "OOPS, I'VE DROPPED THE STICK INTO THE RIVER":OB(1)=0:S(11)=15:GOTO 100
3070 PRINT :PRINT "AS YOU PASS OVER THE DRAWBRIDGE A THREE-TOED OGRE RUNS FROM UNDER THE BRIDGE CARRYING ";
3075 PRINT "YOUR STICK. HE PRESSES";:PRINT "THE BUTTON, CATCHES THE POISONED LIZARD FROM THE BUTTONHOLE ";
3080 PRINT "AND EATS IT.":PRINT :PRINT "THE BRIDGE RAISES HIGH UP IN THE AIR, MAKING IT IMPOSSIBLE TO RETURN."
3085 RD(R)=1:RETURN
3100 REM THRONE ROOM ROUTINES
3110 IF OB(7)=34 AND OB(3)=34 THEN GOTO 3130
3120 PRINT :PRINT "THE THRONE ROOM IS EMPTY AND FAIRLY CLEAN EXCEPT FOR A DUSTY TAPESTRY ON THE WALL. ";
3125 PRINT "THE TAPESTRY DEPICTS A":PRINT "DRAGON IN A CAVE EATING A MCRIB SANDWICH.":RETURN
3130 PRINT :PRINT "THE KING JUMPS UP AND DOWN ON THE MAGIC SPRING WHICH ACTIVATES ITS CURATIVE POWERS. ";
3140 PRINT "HE IS CURED. ":PRINT :PRINT "TO SHOW HIS GRATITUDE HE GIVES YOU THE DUSTY TAPESTRY, A DEED TO THE ";
3145 PRINT " DRAGON'S CAVE, AND THE TAX BILL THAT THE DRAGON NEVER GOT AROUND TO PAING ON THAT PARTICULAR ";
3147 PRINT "PIECE OF PROPERTY."
3150 PRINT :PRINT "HE ALSO GIVES YOU A COMMISSION FOR A MUNCH MORE LUCRATIVE QUEST, BUT THAT IS ANOTHER ADVENTURE ";
3155 PRINT "FOR ANOTHER TIME.":GOTO 3700
3200 REM VOLCANIC ROCK ROUTINE
3210 PRINT :PRINT "YOU ARE IN A WEIRD VALLEY. BLOCKING THE NORTH SIDE OF THE CLIFF IS A HUGE ROCK. THE ROCK ";
3215 PRINT "IS CHIPPED AND PRETTY":PRINT "WELL BEATEN UP AND DENTED.":PRINT :PRINT "A DENTED WITCH'S KETTLE IS ";
3218 PRINT "BOLTED DOWN HERE.":RETURN
3220 PRINT :PRINT "YOU PUSH AGAINST IT WITH ALL YOUR MIGHT BUT NOTHING SEEMS TO HAPPEN.":PRINT :GOTO 100
3230 IF N1$="KETTLE" THEN PRINT :PRINT "YOU ";V1$; " THE SWORD AGAINST THE ":PRINT "KETTLE. THE ROCK VIBRATES IN ";
3235 PRINT "TUNE ":PRINT "AND ROLLS ASIDE, REVEALING A PASSAGE TO THE NORTH.":N(18)=14:S(14)=18:GOTO 100
3240 PRINT "YOU ";V1$" THE SWORD AGAINST THE ":PRINT N1$;" BUT NOTHING HAPPENS.":GOTO 100
3250 PRINT :PRINT "YOU ";V1$;" IT WITH YOUR HAND.":PRINT :PRINT "NOTHING SEEMS TO HAPPEN EXCEPT YOUR HAND ";
3255 PRINT "HURTS.":GOTO 100
3300 REM MISCELLANEOUS HITTING AND KILLING ROUTINES
3310 PRINT :PRINT "WHAT, YOU DARE TO ";V1$" IN THE ":PRINT "PRESENCE OF THE KING?":PRINT "THE GUARDS SEIZE YOU ";
3315 PRINT "AND DRAG YOU OFF":PRINT "KICKING AND SCREAMING TO BE FED TO THE DRAGON.":PRINT :GOTO 3700
3320 REM BEATING THE DRUM
3330 IF OB(4)=34 AND OB(6)=34 THEN GOTO 3370
3340 IF OB(4) <> 34 AND OB(6) <> 34 THEN PRINT "YOU DON'T HAVE THAT.":GOTO 100
3350 IF OB(4)=34 THEN PRINT :PRINT "PERHAPS IF YOU HAD A DRUM...":GOTO 100
3360 IF OB(6)=34 THEN PRINT :PRINT "YOU HIT THE DRUM WITH YOUR HAND AND PRODUCE A MUFFLED THUD.":GOTO 100
3370 IF R=28 THEN GOTO 3620
3380 PRINT :PRINT "KABOOM, KABOOM. HITTING THE DRUM WITH THE DRUMSTICK PRODUCES A NICE BEAT. YOU'RE NO GENE ";
3385 PRINT "KRUPA (WHO?), BUT YOU'LL";:PRINT "DO IN A PINCH.":GOTO 100
3390 REM GETTING THE SPRING
3400 PRINT :PRINT "YOU PUSH AND TUG THE MAGIC METAL SPRING INTO THE WAGON AND  FIND THAT YOU CAN NOW ";
3405 PRINT "TRANSPORT IT. AREN'T YOU CLEVER, YOU RASCAL YOU.":GOTO 890
3410 PRINT :PRINT "YOU CAN'T SEEM TO MOVE THE HEAVY SPRING.":GOTO 890
3420 OB(3)=R:PRINT :PRINT "OH, OH, WITHOUT HAVING THE WAGON THE HEAVY METAL SPRING TUMBLES TO THE FLOOR."
3425 GOTO 1070
3500 REM DRAGON ROUTINES
3510 PRINT :PRINT "A HUGE, FIERCE, HUNGRY RED DRAGON GETS UP FROM ITS NEST IN THE MIDDLE OF THE CAVE.":PRINT
3515 PRINT "IT SNORTS FIRE FROM ITS NOSTRILS, BURPS, DOES A BIT OF THE OLD SOFT SHOE, AND SAYS TO YOU:":PRINT
3520 PRINT "'BOY I'M GLAD YOU MADE IT. NOT ONLY AM I BORED, BUT I'M STARVING.":PRINT "SHALL WE DANCE, OR ;";
3530 PRINT "SHALL YOU":PRINT "FEED ME FIRST?'":GOTO 100
3530 PRINT :PRINT "THE DRAGON LOOKS AT YOU IN DISGUST. HE GETS UP AND SAYS, ":PRINT "'THAT'S AWFUL. THIS IS ";
3535 PRINT "HOW YOU DO IT.'":PRINT "HE IS EXTREMELY CLUMSY AND SAYS,":PRINT "'I JUST CAN'T SEEM TO GET THE"
3537 PRINT "TEMPO RIGHT.'":PRINT :PRINT "HE IS GETTING MADDER AND MADDER. HE LOOKS AT YOU, SNARLS, AND SAYS, "
3540 PRINT "'WELL, IF YOU WON'T HELP ME.....'CHOMP!!":GOTO 3700
3550 PRINT :PRINT "YOU WHIP OUT YOUR TRUSTY SWORD AND LUNGE.":PRINT :PRINT "THE DRAGON LOOKS AT YOU AND SAYS: "
3555 PRINT "HOW THOUGHTFUL, HE BROUGHT HIS OWN TOOTHPICK.'":PRINT :PRINT ".......CHOMP!!!!":GOTO 3700
3560 PRINT :PRINT "YOU ATTACK THE DRAGON FURIOUSLY WITH YOUR BARE HANDS. THE DRAGON CHUCKLES AT YOU...":PRINT
3565 PRINT "'IF YOU HAD A MAGIC SWORD YOU MIGHT HAVE HAD A CHANCE.'":PRINT :PRINT "........CHOMP!!!!":GOTO 3700
3570 PRINT :PRINT "THE DRAGON NOTICES YOU REENTER.":PRINT :PRINT "'MY, THAT WAS A NICE DANCE. NOW, I'M HUNGRY!'"
3575 PRINT :PRINT "........CHOMP!!!!":GOTO 3700
3580 PRINT :PRINT "THE DRAGON GOBBLES UP THE ";N1$;".":PRINT :PRINT "'YUMMY, GOOD! WHAT (OR WHO) IS NEXT?'":GOTO 100
3590 X=0:R=28:PRINT :PRINT "YOU'RE TRAPPED IN THE DRAGON'S CAVE. IF YOU DON'T DO SOMETHING SOON YOU'RE IN BIG ";
3595 PRINT "TROUBLE.":TC=TC+1:PRINT :PRINT "YOU'VE ONLY GOT ";5-TC;" MINUTES LEFT."
3600 IF TC<5 THEN GOTO 100
3610 PRINT :PRINT "OH, NO...THE DRAGON'S GETTING UP.":PRINT :PRINT "HE'S ";
3615 PRINT "GOING TO ....CHOMP!!!!":GOTO 3700
3620 PRINT :PRINT "WOW!!! THE DRAGON IS FASCINATED.":PRINT "HE GETS UP, TAKES THE DRUM AND DRUMSTICK, ";
3625 PRINT "SNIFFS IT, AND BEGINS TO DANCE ":PRINT "AND BEAT THE DRUMP IN 3/4 TIME."
3630 PRINT :PRINT "WHILE HE'S SO OCCUPIED, YOU NOTICE HE HAS MOVED AWAY FROM A PASSAGE TO THE SOUTH.":S(28)=32
3635 GOTO 100
3700 PRINT :PRINT "AUF WIEDERSEHEN":END