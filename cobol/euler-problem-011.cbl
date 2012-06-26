      * Problem 11
      *
      * 22 February 2002
      *
      * In the 20x20 grid below, four numbers along a diagonal line
      * have been marked in red.
      *
      * 08 02 22 97 38 15 00 40 00 75 04 05 07 78 52 12 50 77 91 08
      * 49 49 99 40 17 81 18 57 60 87 17 40 98 43 69 48 04 56 62 00
      * 81 49 31 73 55 79 14 29 93 71 40 67 53 88 30 03 49 13 36 65
      * 52 70 95 23 04 60 11 42 69 24 68 56 01 32 56 71 37 02 36 91
      * 22 31 16 71 51 67 63 89 41 92 36 54 22 40 40 28 66 33 13 80
      * 24 47 32 60 99 03 45 02 44 75 33 53 78 36 84 20 35 17 12 50
      * 32 98 81 28 64 23 67 10 26 38 40 67 59 54 70 66 18 38 64 70
      * 67 26 20 68 02 62 12 20 95 63 94 39 63 08 40 91 66 49 94 21
      * 24 55 58 05 66 73 99 26 97 17 78 78 96 83 14 88 34 89 63 72
      * 21 36 23 09 75 00 76 44 20 45 35 14 00 61 33 97 34 31 33 95
      * 78 17 53 28 22 75 31 67 15 94 03 80 04 62 16 14 09 53 56 92
      * 16 39 05 42 96 35 31 47 55 58 88 24 00 17 54 24 36 29 85 57
      * 86 56 00 48 35 71 89 07 05 44 44 37 44 60 21 58 51 54 17 58
      * 19 80 81 68 05 94 47 69 28 73 92 13 86 52 17 77 04 89 55 40
      * 04 52 08 83 97 35 99 16 07 97 57 32 16 26 26 79 33 27 98 66
      * 88 36 68 87 57 62 20 72 03 46 33 67 46 55 12 32 63 93 53 69
      * 04 42 16 73 38 25 39 11 24 94 72 18 08 46 29 32 40 62 76 36
      * 20 69 36 41 72 30 23 88 34 62 99 69 82 67 59 85 74 04 36 16
      * 20 73 35 29 78 31 90 01 74 31 49 71 48 86 81 16 23 57 05 54
      * 01 70 54 71 83 51 54 69 16 92 33 48 61 43 52 01 89 19 67 48
      *
      * The product of these numbers is 26 x 63 x 78 x 14 = 1788696.
      *
      * What is the greatest product of four adjacent numbers in any
      * direction (up, down, left, right, or diagonally) in the 20x20
      * grid?
      *
      * 70600674
       identification division.
       program-id. euler-problem-011.

       data division.
       working-storage section.
       01 table-source pic x(800) value
              "0802229738150040007504050778521250779108" &
              "4949994017811857608717409843694804566200" &
              "8149317355791429937140675388300349133665" &
              "5270952304601142692468560132567137023691" &
              "2231167151676389419236542240402866331380" &
              "2447326099034502447533537836842035171250" &
              "3298812864236710263840675954706618386470" &
              "6726206802621220956394396308409166499421" &
              "2455580566739926971778789683148834896372" &
              "2136230975007644204535140061339734313395" &
              "7817532822753167159403800462161409535692" &
              "1639054296353147555888240017542436298557" &
              "8656004835718907054444374460215851541758" &
              "1980816805944769287392138652177704895540" &
              "0452088397359916079757321626267933279866" &
              "8836688757622072034633674655123263935369" &
              "0442167338253911249472180846293240627636" &
              "2069364172302388346299698267598574043616" &
              "2073352978319001743149714886811623570554" &
              "0170547183515469169233486143520189196748".
       01 problem-table redefines table-source.
         02 problem-rows occurs 20 times.
           03 problem-cells             pic 99 usage display
                occurs 20 times.
       01 iteration-values.
         02 i                   pic 99 usage comp-5.
         02 y                   pic 99 usage comp-5.
         02 yy                  pic 99 usage comp-5.
         02 x                   pic 99 usage comp-5.
         02 xx                  pic 99 usage comp-5.
         02 dx                  pic s9 usage comp-5.
         02 dy                  pic s9 usage comp-5.
       01 product-values.
         02 product             pic 9(8) usage comp-5.
         02 largest-product     pic 9(8) usage comp-5
             value 0.

      * The table of directions.
       01 direction-table.
         02 direction-source.
           03 filler            pic s9 usage comp-5 value 1.
           03 filler            pic s9 usage comp-5 value 1.
           03 filler            pic s9 usage comp-5 value 1.
           03 filler            pic s9 usage comp-5 value 0.
           03 filler            pic s9 usage comp-5 value 1.
           03 filler            pic s9 usage comp-5 value 1.
           03 filler            pic s9 usage comp-5 value 1.
           03 filler            pic s9 usage comp-5 value -1.
         02 direction-values redefines direction-source.
           03 direction occurs 4 times.
             04 x-delta           pic s9 usage comp-5.
             04 y-delta           pic s9 usage comp-5.
       01 first-thing pic s9 usage display.
       01 second-thing redefines first-thing pic x.

       procedure division.

       main.

           perform try-each-direction
           display largest-product

           stop run.

       computation section.

       try-each-direction.
           perform varying i from 1 by 1 until i > 4
             move x-delta (i) to dx
             move y-delta (i) to dy
      D      display dx " " dy
             perform try-direction
           end-perform.

      * Scan the table using the specified dx and dy values to determine
      * the direction.
       try-direction.
           perform varying y from 1 by 1 until y > 20
             perform varying x from 1 by 1 until x > 20
               perform try-cell
             end-perform
           end-perform.

      * Scan the 4- numbers at the given cell, in the direction
      * specified by dx and dy
       try-cell.
           move x to xx
           move y to yy
           move 1 to product
           perform 4 times
             if xx < 1 or xx > 20 or yy < 1 or yy > 20
               exit paragraph
             end-if

             perform test-single-cell
             add dx to xx
             add dy to yy
           end-perform
           perform one-product.

      * Adjust the product by the cell at xx, yy
       test-single-cell.
           multiply problem-cells (yy, xx) by product.

      * After finding a single product, update largest if it is the
      * largest.
       one-product.
           if product > largest-product
             move product to largest-product.
