       IDENTIFICATION DIVISION.
       PROGRAM-ID. DAY8.

       ENVIRONMENT DIVISION.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT SYSIN ASSIGN TO KEYBOARD ORGANIZATION LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD SYSIN
           RECORD IS VARYING IN SIZE
           FROM 0 TO 30000 DEPENDING
           ON INPUT-LEN.
       01  INPUT-RECORD PIC X(30000).

       WORKING-STORAGE SECTION.
       01 INPUT-DATA EXTERNAL PIC X(30000).
       01 INPUT-LEN EXTERNAL PIC 9999.
       01 INPUT-PTR EXTERNAL PIC 9(6).
       01 RESULT.
         05 PART1 PIC 9(6).
         05 PART2 PIC 9(6).

       PROCEDURE DIVISION.
           OPEN INPUT SYSIN.
           READ SYSIN END-READ.

           SET INPUT-PTR TO 1.
           MOVE INPUT-RECORD TO INPUT-DATA.

           CALL "CALCULATE" USING RESULT.
           DISPLAY PART1.
           DISPLAY PART2.
           STOP RUN.

       END PROGRAM DAY8.

       IDENTIFICATION DIVISION.
       PROGRAM-ID. CALCULATE IS RECURSIVE.

       DATA DIVISION.
       LOCAL-STORAGE SECTION.
       01 TMP PIC 9(6).
       01 CHILD-COUNT PIC 999.
       01 META-COUNT PIC 999.
       01 I PIC 999.
       01 CHILD-VALUES OCCURS 0 TO 100 TIMES DEPENDING ON CHILD-COUNT.
         05 CHILD-PART1 PIC 9(6).
         05 CHILD-PART2 PIC 9(6).
      
       LINKAGE SECTION.
       01 RESULT.
         05 PART1 PIC 9(6).
         05 PART2 PIC 9(6).

       PROCEDURE DIVISION USING RESULT.
           CALL "READNUM" RETURNING CHILD-COUNT.
           CALL "READNUM" RETURNING META-COUNT.

           MOVE 0 to PART1.
           MOVE 0 TO PART2.

           MOVE 0 TO I.
           PERFORM READCHILD
           UNTIL I = CHILD-COUNT.

           MOVE 0 TO I.
           PERFORM READMETA
           UNTIL I = META-COUNT.
       GOBACK.

       READCHILD.
           CALL "CALCULATE" USING CHILD-VALUES(I).
           ADD CHILD-PART1(I) TO PART1.
           ADD 1 TO I.

       READMETA.
           CALL "READNUM" RETURNING TMP.
           ADD TMP TO PART1.

           IF CHILD-COUNT = 0 THEN
             ADD TMP TO PART2
           ELSE
             ADD CHILD-PART2(TMP - 1) TO PART2
           END-IF.

           ADD 1 TO I.

       END PROGRAM CALCULATE.

       IDENTIFICATION DIVISION.
       PROGRAM-ID. READNUM.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 RESULT PIC 9(6).
       01 INPUT-DATA EXTERNAL PIC X(30000).
       01 INPUT-LEN EXTERNAL PIC 9999.
       01 INPUT-PTR EXTERNAL PIC 9(6).

       PROCEDURE DIVISION.
           UNSTRING INPUT-DATA
           DELIMITED BY ALL SPACES
           INTO RESULT
           WITH POINTER INPUT-PTR.
           MOVE RESULT TO RETURN-CODE.
       END PROGRAM READNUM.

