set I; # items

set ST; # supply and transshipment nodes
set D; # demand nodes
set K := ST union D; # all nodes 
set E within {K, K}; # all edges

set DU; # dummy nodes
set KDU := K union DU; # all nodes + dummies
set EDU within {KDU,KDU}; # all edges + dummies

# param item_priority {I};
param transp_cost {E};
param supply_demand {KDU, I};
param node_capacity {K};

var X {EDU, I} >= 0 integer; # items to be transported

minimize Objectives: # item_priority[i] 
	(sum {(k,j) in E, i in I} transp_cost[k,j] * X[k,j,i]) + 
	10000*(sum {k in D, i in I} ((sum {(j,k) in E} X[j,k,i]) / -supply_demand[k,i]) ^ 2); # fairness
	
subject to Transportation_Balance {k in KDU, i in I}:
	sum {(k,j) in EDU} X[k,j,i] - sum {(j,k) in EDU} X[j,k,i] = supply_demand[k,i];

subject to Inbound_Capacity {k in K}:
	sum {(j,k) in E, i in I} X[j,k,i] <= node_capacity[k];
	
subject to Outbound_Capacity {k in K}:
	sum {(k,j) in E, i in I} X[k,j,i] <= node_capacity[k];
	
data;
set I := I1 I2 I3;
set ST := S1 S2 S3 S4 S5 S6 S7 T11 T12 T13 T14 T15 T16 T17 T18 T21 T22 T23 T24 T25;
set D := D1 D2 D3 D4 D5 D6 D7 D8 D9 D10;
set DU := dummy_sup dummy_dem;

set E := 
   (S1,T11) (S1,T12) (S1,T13) (S1,T14) (S1,T15) (S1,T16) (S1,T17) (S1,T18) (S2,T11) (S2,T12) (S2,T13) (S2,T14) (S2,T15) (S2,T16) (S2,T17) (S2,T18) (S3,T11) (S3,T12) (S3,T13) (S3,T14) (S3,T15) (S3,T16) (S3,T17) (S3,T18) (S4,T11) (S4,T12) (S4,T13) (S4,T14) (S4,T15) (S4,T16) (S4,T17) (S4,T18) (S5,T11) (S5,T12) (S5,T13) (S5,T14) (S5,T15) (S5,T16) (S5,T17) (S5,T18) (S6,T11) (S6,T12) (S6,T13) (S6,T14) (S6,T15) (S6,T16) (S6,T17) (S6,T18) (S7,T11) (S7,T12) (S7,T13) (S7,T14) (S7,T15) (S7,T16) (S7,T17) (S7,T18)
   (T11,T21) (T11,T22) (T11,T23) (T11,T24) (T11,T25) (T12,T21) (T12,T22) (T12,T23) (T12,T24) (T12,T25) (T13,T21) (T13,T22) (T13,T23) (T13,T24) (T13,T25) (T14,T21) (T14,T22) (T14,T23) (T14,T24) (T14,T25) (T15,T21) (T15,T22) (T15,T23) (T15,T24) (T15,T25) (T16,T21) (T16,T22) (T16,T23) (T16,T24) (T16,T25) (T17,T21) (T17,T22) (T17,T23) (T17,T24) (T17,T25) (T18,T21) (T18,T22) (T18,T23) (T18,T24) (T18,T25)
   (T21,D1) (T21,D2) (T21,D3) (T21,D4) (T21,D5) (T21,D6) (T21,D7) (T21,D8) (T21,D9) (T21,D10) (T22,D1) (T22,D2) (T22,D3) (T22,D4) (T22,D5) (T22,D6) (T22,D7) (T22,D8) (T22,D9) (T22,D10) (T23,D1) (T23,D2) (T23,D3) (T23,D4) (T23,D5) (T23,D6) (T23,D7) (T23,D8) (T23,D9) (T23,D10) (T24,D1) (T24,D2) (T24,D3) (T24,D4) (T24,D5) (T24,D6) (T24,D7) (T24,D8) (T24,D9) (T24,D10) (T25,D1) (T25,D2) (T25,D3) (T25,D4) (T25,D5) (T25,D6) (T25,D7) (T25,D8) (T25,D9) (T25,D10)
;

set EDU := 
   (S1,T11) (S1,T12) (S1,T13) (S1,T14) (S1,T15) (S1,T16) (S1,T17) (S1,T18) (S2,T11) (S2,T12) (S2,T13) (S2,T14) (S2,T15) (S2,T16) (S2,T17) (S2,T18) (S3,T11) (S3,T12) (S3,T13) (S3,T14) (S3,T15) (S3,T16) (S3,T17) (S3,T18) (S4,T11) (S4,T12) (S4,T13) (S4,T14) (S4,T15) (S4,T16) (S4,T17) (S4,T18) (S5,T11) (S5,T12) (S5,T13) (S5,T14) (S5,T15) (S5,T16) (S5,T17) (S5,T18) (S6,T11) (S6,T12) (S6,T13) (S6,T14) (S6,T15) (S6,T16) (S6,T17) (S6,T18) (S7,T11) (S7,T12) (S7,T13) (S7,T14) (S7,T15) (S7,T16) (S7,T17) (S7,T18)
   (T11,T21) (T11,T22) (T11,T23) (T11,T24) (T11,T25) (T12,T21) (T12,T22) (T12,T23) (T12,T24) (T12,T25) (T13,T21) (T13,T22) (T13,T23) (T13,T24) (T13,T25) (T14,T21) (T14,T22) (T14,T23) (T14,T24) (T14,T25) (T15,T21) (T15,T22) (T15,T23) (T15,T24) (T15,T25) (T16,T21) (T16,T22) (T16,T23) (T16,T24) (T16,T25) (T17,T21) (T17,T22) (T17,T23) (T17,T24) (T17,T25) (T18,T21) (T18,T22) (T18,T23) (T18,T24) (T18,T25)
   (T21,D1) (T21,D2) (T21,D3) (T21,D4) (T21,D5) (T21,D6) (T21,D7) (T21,D8) (T21,D9) (T21,D10) (T22,D1) (T22,D2) (T22,D3) (T22,D4) (T22,D5) (T22,D6) (T22,D7) (T22,D8) (T22,D9) (T22,D10) (T23,D1) (T23,D2) (T23,D3) (T23,D4) (T23,D5) (T23,D6) (T23,D7) (T23,D8) (T23,D9) (T23,D10) (T24,D1) (T24,D2) (T24,D3) (T24,D4) (T24,D5) (T24,D6) (T24,D7) (T24,D8) (T24,D9) (T24,D10) (T25,D1) (T25,D2) (T25,D3) (T25,D4) (T25,D5) (T25,D6) (T25,D7) (T25,D8) (T25,D9) (T25,D10)
   (S1,dummy_dem) (S2,dummy_dem) (S3,dummy_dem) (S4,dummy_dem) (S5,dummy_dem) (S6,dummy_dem) (S7,dummy_dem)
   (dummy_sup,D1) (dummy_sup,D2) (dummy_sup,D3) (dummy_sup,D4) (dummy_sup,D5) (dummy_sup,D6) (dummy_sup,D7) (dummy_sup,D8) (dummy_sup,D9) (dummy_sup,D10)
;

param transp_cost := S1 T11 735 S1 T12 205 S1 T13 769 S1 T14 758 S1 T15 756 S1 T16 219 S1 T17 930 S1 T18 886 S2 T11 703 S2 T12 157 S2 T13 445 S2 T14 840 S2 T15 573 S2 T16 216 S2 T17 929 S2 T18 890 S3 T11 226 S3 T12 492 S3 T13 740 S3 T14 157 S3 T15 733 S3 T16 612 S3 T17 850 S3 T18 901 S4 T11 195 S4 T12 737 S4 T13 217 S4 T14 659 S4 T15 700 S4 T16 587 S4 T17 336 S4 T18 984 S5 T11 996 S5 T12 371 S5 T13 288 S5 T14 803 S5 T15 546 S5 T16 680 S5 T17 889 S5 T18 960 S6 T11 346 S6 T12 175 S6 T13 253 S6 T14 755 S6 T15 534 S6 T16 185 S6 T17 796 S6 T18 384 S7 T11 319 S7 T12 168 S7 T13 146 S7 T14 193 S7 T15 849 S7 T16 552 S7 T17 303 S7 T18 317 T11 T21 573 T11 T22 531 T11 T23 440 T11 T24 650 T11 T25 711 T12 T21 388 T12 T22 353 T12 T23 833 T12 T24 456 T12 T25 122 T13 T21 861 T13 T22 621 T13 T23 857 T13 T24 936 T13 T25 199 T14 T21 901 T14 T22 279 T14 T23 322 T14 T24 861 T14 T25 758 T15 T21 541 T15 T22 707 T15 T23 868 T15 T24 424 T15 T25 615 T16 T21 115 T16 T22 891 T16 T23 435 T16 T24 858 T16 T25 357 T17 T21 596 T17 T22 995 T17 T23 259 T17 T24 574 T17 T25 951 T18 T21 763 T18 T22 789 T18 T23 774 T18 T24 479 T18 T25 644 T21 D1 790 T21 D2 526 T21 D3 712 T21 D4 367 T21 D5 934 T21 D6 676 T21 D7 516 T21 D8 267 T21 D9 941 T21 D10 142 T22 D1 655 T22 D2 384 T22 D3 496 T22 D4 111 T22 D5 706 T22 D6 401 T22 D7 997 T22 D8 352 T22 D9 598 T22 D10 853 T23 D1 134 T23 D2 826 T23 D3 948 T23 D4 189 T23 D5 875 T23 D6 704 T23 D7 701 T23 D8 517 T23 D9 214 T23 D10 716 T24 D1 295 T24 D2 925 T24 D3 600 T24 D4 725 T24 D5 592 T24 D6 174 T24 D7 512 T24 D8 475 T24 D9 519 T24 D10 828 T25 D1 376 T25 D2 860 T25 D3 775 T25 D4 493 T25 D5 968 T25 D6 556 T25 D7 291 T25 D8 838 T25 D9 788 T25 D10 198;

param supply_demand (tr): S1 S2 S3 S4 S5 S6 S7 T11 T12 T13 T14 T15 T16 T17 T18 T21 T22 T23 T24 T25 D1 D2 D3 D4 D5 D6 D7 D8 D9 D10 dummy_sup dummy_dem := 
    I1 40 50 30 40 50 30 160 0 0 0 0 0 0 0 0 0 0 0 0 0 -40 -30 -80 -30 -30 -50 -80 -30 -20 -110 100 0
    I2 40 60 70 20 50 50 110 0 0 0 0 0 0 0 0 0 0 0 0 0 -20 -80 -100 -30 -20 -50 -70 -60 -60 -10 100 0
    I3 40 60 60 10 70 20 140 0 0 0 0 0 0 0 0 0 0 0 0 0 -30 -90 -70 -110 -80 -30 -20 -30 -30 -10 100 0
;

param node_capacity := S1 120 S2 170 S3 160 S4 70 S5 170 S6 100 S7 410 T11 199 T12 212 T13 184 T14 198 T15 208 T16 202 T17 207 T18 237 T21 297 T22 291 T23 313 T24 316 T25 436 D1 90 D2 200 D3 250 D4 170 D5 130 D6 130 D7 170 D8 120 D9 110 D10 130;

