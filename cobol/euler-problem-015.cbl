      * Problem 15
      *
      * 19 April 2002
      *
      *
      * Starting in the top left corner of a 2x2 grid, there are 6
      * routes (without backtracking) to the bottom right corner.
      *
      * [p_015]
      *
      * How many routes are there through a 20x20 grid?
      *
      * 137846528820
       identification division.
       program-id. euler-problem-015.

       data division.
       working-storage section.
       01 working-values.
         02 route-counts occurs 21 times.
           03 route-count    pic 9(12) comp-5.
         02 i                pic 9(2) comp-5.

       procedure division.

       main.
           perform initialize-routes
           perform adjust-step 20 times
           display route-count (21)

           stop run.

       initialize-routes.
           perform varying i from 1 by 1 until i > 21
             move 1 to route-count (i)
           end-perform.

       adjust-step.
           perform varying i from 1 by 1 until i > 20
             add route-count (i) to route-count (i + 1)
           end-perform.

       end program euler-problem-015.
