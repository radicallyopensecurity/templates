## Pentest FAQ 

* What is the difference between Crystal Box and Black Box testing?
```
Basically, the difference between Crystal Box and Black Box pentesting 
is the amount of knowledge the testers have on the target environment, architecture, 
and/or applications. Block Box Testing has the least (or no) information on the targest. 
It's like the targets are inside a black box and the testers have to figure out how to 
get inside. Crystal Box Testing is when the testers have a considerable amount of 
knowledge about the target(s), like they're inside a see-through box. They can see 
exactly what's there, so it's easier for them to find vulnerabilities.

Refer to this link for more an excellent detailed description: 
https://www.vaadata.com/blog/black-grey-or-crystal-box-web-pen-testing-3-different-options/

At Radically Open Security, we generally prefer crystal-box pentesting.  Unlike real-world
attackers (who have all of the time in the world), penetration testing tends to happen within
a limited timebox.  Crystal-box pentesting allows us to make the most efficent use of the 
timebox possible, so we find the maximum number of vulnerabilities in the time allotted.  
Additionally Crystal-Box pentesting fits naturally hand-in-hand with the "Peek Over Our Shoulder"
option that we offer to our customers.
```

* What is the difference between pentesting and running Nessus?
```
Nessus Vulnerability Scanner is just one of many tools that can be used during a 
penetration test. To use Nessus on its own wouldn't provide much information, as
it checks computers and firewalls for open ports. It also does so quite visibly, 
so it's not even a good choice to use during a pentest. Nmap works much better 
for this purpose. Nevertheless, scanning for open ports is just one of many tests
to determine security vulnerabilites, regardless of the tool used.
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
