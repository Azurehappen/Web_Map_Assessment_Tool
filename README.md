# Web_Map_Assessment_Tool
Development of J2945/A Compliant MAP Creation Tool: Map Source Assessment
Wang Hu, Kathryn Hammar, Jay Farrell (Corresponding Author: farrell@ucr.edu)
Executive Summary
Leidos is in the process of developing a J2945/A Compliant MAP Creation Tool. It will enhance the existing Map Creation tool hosted at URL: https://webapp.connectedvcs.com/isd/. These tools allow users to create map formats compliant with transportation applications by interacting with online map imagery. 
This report concludes Task Order 02 of IRIQ #P010282172, which was completed by UCR under the supervision of Leidos (Prime Contract Number: 693JJ321D000010 DO#693JJ322F00268N). The purpose of Task Order 02 is to investigate and evaluate various sources of online imagery to assess their suitability to serve as the base map within the J2945/A Compliant MAP Creation Tool. 
For the purpose of Leidos creating the J2945/A Compliant MAP Creation Tool the online imagery must:
●	come with an Application Programming Interface;
●	provide imagery that reliable shows roadway features clearly enough for users to click on key points;
●	provide geodetic (i.e., latitude and longitude) coordinates with sufficient precision to enable transportation applications; 
●	provide geodetic coordinates in or convertible to the WGS 84 (G1762) datum; and,
●	provide geodetic coordinates with reliably accuracy.
This report surveys and compares potential providers of online imagery relative to these criteria, then compares the five top candidates in Table 1. As discussed in Section 2, Google Earth, MapBox, and Microsoft Azure are selected for more detailed analysis. 
The additional analysis compares the locations reported by each tool to ground truth coordinates determined by standard survey methods. The methods are discussed in Sections 3 - 7. The results are presented and discussed quantitatively in Section 8. 
The main conclusions are: 
1.	Microsoft Azure and MapBox provide slight better absolute accuracy than Google Earth (RMS error of 0.76 versus 0.89 m).
2.	Google Earth successfully displayed all the 82 feature points, where Microsoft Azure displayed 69 and MapBox only displayed 41.

This repository includes the software used to support this task. 
