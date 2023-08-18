Basic copy paste into a Power BI Power Query Editor for ease of use. You need to use 3 tables (so far). One calendar table, two sort (by year by month) which will help your charts month year sort.

Go into Power BI Desktop and open Transform data. Create new tables with the 3 queries below. Sort columns by numeric values and connect relationship date values to calendar. Calendar date column should have a relationship with raw data.

Date are from DateTime.LocalNow() to Date.AddYears(Date.From(DateTime.LocalNow()), -2). (3 years)

 Added fiscal year map for Jun-July
 Added fiscal year month sort
 Added fiscal year quarter
 Added fiscal year quarter sort
 Added fiscal year to years (i.e. 2020-2021)
 Added month sort