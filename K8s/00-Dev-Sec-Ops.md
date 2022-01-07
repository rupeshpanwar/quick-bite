# https://kubernetes-tutorial.schoolofdevops.com/
# References

Building Reusable DevSecOps Pipelines on a Secure Kubernetes... Steven Terrana & Michael Ducy

https://www.youtube.com/watch?v=OClSwxhsspA&ab_channel=CNCF%5BCloudNativeComputingFoundation%5D


Claranet Cyber Security - Achieving DevSecOps with Open-Source Tools

https://www.claranetcybersecurity.com/blog/2019-04-23-achieving-devsecops-open-source-tools


Accelera - What the Sec is DevSecOps?

https://accelera.com.au/what-the-sec-is-devsecops/

# Check Jenkins Version

Before moving to the next video/hands-on let us quickly check your Jenkins Version.

Throughout this course, I have used Jenkins version 2.289.1 and would recommend you to use the same version to avoid any issues.

Checking Jenkins Status -

    $ systemctl status jenkins 
    Unit jenkins.service could not be found.

If you see the above message, somehow your Jenkins installation failed.


Installing Jenkins - Run the below commands to install Jenkins ONLY if you see the above message.

    wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
    sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
    sudo apt update
    sudo apt install -y jenkins
    systemctl daemon-reload
    systemctl enable jenkins
    sudo systemctl start jenkins
    sudo usermod -a -G docker jenkins
    echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers


Checking Jenkins version -

cat /var/lib/jenkins/config.xml | grep -i version

If the version displayed is greater than 2.289.1 run the below commands to downgrade Jenkins

sudo apt install -y --allow-downgrades jenkins=2.289.1

systemctl daemon-reload

systemctl enable jenkins

sudo systemctl start jenkins



