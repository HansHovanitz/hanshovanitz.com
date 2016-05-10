+++
Categories = ["Development", "GoLang"]
Description = ""
Tags = ["Development", "golang"]
date = "2016-04-14T00:34:47-07:00"
title = "Java Project: Sorting Address Intervals"

+++

### -Sorting Address Intervals-

A friend of mine applied for a `Java` job and was given a take-home programming project that involves sorting overlapping zip codes. I thought this sounded like an interesting project and would be something fun to try (without the normal restrictions that academic assignments usually have). 

<hr>

#### The Problem:

Given a command line input of address ranges like [94133,94133] [94200,94299] [94226,94399] the output should be [94133,94133] [94200,94399].
A complete description can be found **[here](https://github.com/HansHovanitz/JavaInterviewProblems)**.

<hr>

#### The Solution:

There are many ways this problem can be solved. That is part of the fun of programming! 

```java
import java.util.*;
import java.lang.*;
import java.io.*;

/*********************************************************************
* The AddressSort class reads in commandline interval ranges (this
* code was written for address ranges). It then sorts the intervals in 
* ascending order and also merges any overlapping intervals.
* --Example--
* Input: 1-3 4-7, 5-9
* Output: 1-3, 4-9 
**********************************************************************/
public class AddressSort {
	public static void main(String [] args) {
		
		ArrayList<Interval> addressInterval = new ArrayList<Interval>();
		
		if (args.length > 0)
		{
			//Create new interval objects with the command line input. 
			for (int i = 0; i < args.length; i++)
			{
				String intervalString = args[i];
				String [] tokens = intervalString.replaceAll("\\[|\\]","").split(",");
				int start = Integer.parseInt(tokens[0]);
				int end = Integer.parseInt(tokens[1]);
				Interval interval = new Interval(start, end);
				addressInterval.add(interval);
			}	
			
			//Merge overlapping intervals together and store into new ArrayList. 
			ArrayList<Interval> mergedAddress = merge(addressInterval);
			
			//Print interval output in zipcode range format. 
			for (int i = 0; i < mergedAddress.size(); i++) {
				System.out.println("[" + mergedAddress.get(i).start + "," + mergedAddress.get(i).end + "]");
			}
		}
	}
	
	/****************************************
	* Method to merge intervals 
	* @param_merge Unmerged array
	* @return Merged array
	*****************************************/
    public static ArrayList<Interval> merge(ArrayList<Interval> intervals) {

    	//Check if there are 0 or 1 elements.
        if (intervals.size() == 0) {
            return intervals;
        }
        if (intervals.size() == 1) {
            return intervals;
        }

        //Sort the intervals by the smallest start values. 
        Collections.sort(intervals, new IntervalComparator());
        
        //Starting interval. 
        Interval first = intervals.get(0);
        int start = first.start;
        int end = first.end;

        //List to store the new merged intervals. 
        ArrayList<Interval> result = new ArrayList<Interval>();
        
        //Iterate through the array and merge any overlapping intervals. 
        for (int i = 1; i < intervals.size(); i++) {
            Interval current = intervals.get(i);
            if (current.start <= end) {
                end = Math.max(current.end, end);
            } 
            else {
                result.add(new Interval(start, end));
                start = current.start;
                end = current.end;
            }
        }
        result.add(new Interval(start, end));
        
        //Return merged interval array. 
        return result;
    }
}

/****************************************
* IntervalComparator class implements 
* Java's Comparator interface. Sorts
* intervals from smallest start point to 
* the largest. 
*****************************************/
class IntervalComparator implements Comparator<Object> {
    public int compare(Object o1, Object o2) {
        Interval i1 = (Interval) o1;
        Interval i2 = (Interval) o2;
        return i1.start - i2.start;
    }
}

/****************************************
* Interval class is used to keep track 
* of start and end points of a given
* interval. 
*****************************************/ 
class Interval {
    int start;
    int end;

    //Default constructor. 
    Interval() {
        start = 0;
        end = 0;
    }

    //Constructor for start and end point. 
    Interval(int s, int e) {
        start = s;
        end = e;
    }
}
```


