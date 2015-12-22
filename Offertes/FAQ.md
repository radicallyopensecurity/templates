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

* What does ROS mean by "Peek over our Shoulder" (PooS)?
```
In accordance with our "Teach to Fish" principle, we aim to give our customers a deeper understanding 
of exactly *how* we work.  We do this by structurally inviting our customers to join our 
engagements (often pentests) as either active volunteers or passive observers.  In such a way, we
hope to demystify the pentesting process, thus promoting self-sufficiency and better enabling the 
customer to autonomously audit/monitor their own systems and software when we are not around.
```

* What is the difference between pentesting and running Nessus?
```
Pentesting is *not* the same thing as vulnerability scanning.  While we most certainly make
use of scanning tools like nmap, OpenVAS, w3af, OWASP ZAP, etc..   that is step 0.5 of the 
work that we do.  Scanning provides pentesters with a few leads, but 98% of what comes out 
of scanning tools tends to be false positives.  Scanner output thus needs to be validated by
hand, and this is a time-consuming manual process.  Additionally, there's a tremendous amount
of false negatives - vulnerabilities that the scanning tools miss.  

Pentesting is a creative manual process.  While scanning is a great introductory first step,
the work that we do during pentests is primarily by hand.  Creative exploitation cannot be 
fully automated.
```
