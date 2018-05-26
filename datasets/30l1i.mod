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
set I := I1;
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

param transp_cost := S1 T11 560 S1 T12 790 S1 T13 674 S1 T14 963 S1 T15 842 S1 T16 340 S1 T17 663 S1 T18 195 S2 T11 999 S2 T12 833 S2 T13 584 S2 T14 506 S2 T15 330 S2 T16 848 S2 T17 754 S2 T18 270 S3 T11 640 S3 T12 135 S3 T13 624 S3 T14 259 S3 T15 938 S3 T16 798 S3 T17 342 S3 T18 185 S4 T11 895 S4 T12 677 S4 T13 781 S4 T14 656 S4 T15 673 S4 T16 745 S4 T17 895 S4 T18 127 S5 T11 719 S5 T12 655 S5 T13 439 S5 T14 897 S5 T15 430 S5 T16 739 S5 T17 605 S5 T18 447 S6 T11 572 S6 T12 330 S6 T13 289 S6 T14 324 S6 T15 484 S6 T16 476 S6 T17 382 S6 T18 732 S7 T11 727 S7 T12 844 S7 T13 358 S7 T14 458 S7 T15 809 S7 T16 555 S7 T17 510 S7 T18 748 T11 T21 417 T11 T22 776 T11 T23 324 T11 T24 918 T11 T25 333 T12 T21 783 T12 T22 763 T12 T23 926 T12 T24 473 T12 T25 771 T13 T21 707 T13 T22 571 T13 T23 332 T13 T24 791 T13 T25 212 T14 T21 929 T14 T22 596 T14 T23 541 T14 T24 663 T14 T25 367 T15 T21 609 T15 T22 906 T15 T23 485 T15 T24 486 T15 T25 212 T16 T21 712 T16 T22 724 T16 T23 180 T16 T24 798 T16 T25 212 T17 T21 101 T17 T22 741 T17 T23 319 T17 T24 665 T17 T25 954 T18 T21 835 T18 T22 324 T18 T23 484 T18 T24 502 T18 T25 737 T21 D1 229 T21 D2 152 T21 D3 783 T21 D4 829 T21 D5 771 T21 D6 809 T21 D7 515 T21 D8 346 T21 D9 935 T21 D10 538 T22 D1 302 T22 D2 283 T22 D3 222 T22 D4 500 T22 D5 866 T22 D6 393 T22 D7 379 T22 D8 936 T22 D9 983 T22 D10 709 T23 D1 297 T23 D2 610 T23 D3 851 T23 D4 243 T23 D5 708 T23 D6 300 T23 D7 223 T23 D8 286 T23 D9 425 T23 D10 563 T24 D1 448 T24 D2 870 T24 D3 759 T24 D4 863 T24 D5 502 T24 D6 445 T24 D7 610 T24 D8 246 T24 D9 247 T24 D10 963 T25 D1 810 T25 D2 919 T25 D3 588 T25 D4 739 T25 D5 650 T25 D6 437 T25 D7 971 T25 D8 740 T25 D9 878 T25 D10 572;

param supply_demand (tr): S1 S2 S3 S4 S5 S6 S7 T11 T12 T13 T14 T15 T16 T17 T18 T21 T22 T23 T24 T25 D1 D2 D3 D4 D5 D6 D7 D8 D9 D10 dummy_sup dummy_dem := 
    I1 40 50 30 40 50 30 160 0 0 0 0 0 0 0 0 0 0 0 0 0 -40 -60 -70 -20 -50 -50 -60 -40 -60 -50 100 0
;

param node_capacity := S1 40 S2 50 S3 30 S4 40 S5 50 S6 30 S7 160 T11 67 T12 62 T13 63 T14 54 T15 67 T16 72 T17 73 T18 85 T21 96 T22 94 T23 89 T24 100 T25 175 D1 40 D2 60 D3 70 D4 20 D5 50 D6 50 D7 60 D8 40 D9 60 D10 50;

