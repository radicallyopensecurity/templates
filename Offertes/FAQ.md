## Pentest FAQ 

* What is the difference between Crystal Box and Black Box testing?
```
Crystal Box vs. Black Box pentesting refers to the amount of information regarding the 
target environment, architecture, and/or applications that is initially shared by the
customer with the pentesters.  With Black Box Testing, pentesters are given no information
whatsoever about the targest(s). With Crystal Box Testing, pentesters are given all information
requested about the target(s), including source-code, access to developers, etc..

Refer to this link for an excellent description: 
https://www.vaadata.com/blog/black-grey-or-crystal-box-web-pen-testing-3-different-options/

At Radically Open Security, we generally prefer crystal-box pentesting.  Unlike real-world
attackers (who have all of the time in the world), penetration testing tends to happen within
a limited timebox.  Crystal-box pentesting allows us to make the most efficent use of the 
time allotted, thus maximizing the number of vulnerabilities we can find. Additionally 
Crystal-Box pentesting fits naturally hand-in-hand with the "Peek Over Our Shoulder"
option that we offer to our customers.
```

* What is the difference between pentesting and running Nessus?
```
Pentesting is *not* the same thing as vulnerability scanning.  While we most certainly make
use of scanning tools like nmap, OpenVAS, w3af, OWASP ZAP, etc..   that is step 0.5 of the 
work that we do.  Scanning provides pentesters with a few leads, but 98% of what comes out 
of scanning tools tends to be false positives.  Scanner output thus needs to be validated by
hand, and this is a time-consuming manual process.  Not to mention, there's also a tremendous
amount of false negatives - things that the scanning tools miss.

Pentesting is a creative manual process, and the majority of the work that we do during pentests
is by hand.
```

* What does ROS mean by "peek over the shoulder"?
```
Also referred to as the "teach to fish" principle, ROS organizes their pentesting 
services so that clients not only get a high-quality, informative report, but they also
receive a deeper understanding about their security and how to remedy/spot issues
in the future. ROS invites their customers to join the test as volunteers or pentesters. 
People with highly technical skills and knowledge are normal people who have learned 
to provide a valuable service. ROS strives to not only provide an excellent service 
but to also demystify the process, all while teaching their clients about computer 
security and safety.
```
